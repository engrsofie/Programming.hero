-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 04, 2021 at 05:30 PM
-- Server version: 10.3.27-MariaDB
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codeplanners_sms`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `current_balance` decimal(15,2) NOT NULL,
  `account_description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_status` tinyint(4) NOT NULL,
  `company_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `fk_branch_id` int(10) UNSIGNED NOT NULL,
  `fk_company_id` int(10) UNSIGNED DEFAULT 1,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`id`, `account_name`, `current_balance`, `account_description`, `account_status`, `company_name`, `created_by`, `fk_branch_id`, `fk_company_id`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Company Cash Account', 0.00, 'Party to company Account transaction only.', 1, NULL, NULL, 1, 1, NULL, '2017-09-10 01:37:21', '2017-12-14 22:15:50'),
(2, 'Bank Account', 0.00, NULL, 1, NULL, NULL, 1, 1, NULL, '2017-09-10 04:42:47', '2017-12-14 22:06:40'),
(4, 'DBBL', 5000.00, NULL, 1, NULL, NULL, 2, 1, NULL, '2018-02-07 13:37:04', '2018-02-07 13:37:04');

-- --------------------------------------------------------

--
-- Table structure for table `account_money_transfer`
--

CREATE TABLE `account_money_transfer` (
  `id` int(11) NOT NULL,
  `transfer_from` int(11) UNSIGNED NOT NULL,
  `transfer_to` int(11) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `amount` float NOT NULL,
  `fk_method_id` int(11) UNSIGNED NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `id` int(10) UNSIGNED NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `country_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `city_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `zip_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `division` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`id`, `address`, `country_name`, `city_name`, `zip_code`, `division`, `created_at`, `updated_at`) VALUES
(1, 'মুসলিমপ্লাজা (৩য় তলা), চুনারুঘাট, হবিগঞ্জ।', 'Bangladesh', 'Dhaka', '1229', 'Dhaka', '2016-08-17 13:02:42', NULL),
(29, 'dhaka bangaldesh', 'bangladesh', 'dhaka', '0000', 'dhaka', '2016-09-18 19:37:20', NULL),
(30, 'Dhaka', 'Bangladesh', 'Dhaka', '1230', 'Dhaka', '2016-10-03 14:34:11', NULL),
(31, 'Dhaka', 'bangladesh', 'dhaka', '0000', 'dhaka', '2017-03-02 12:52:06', NULL),
(32, 'Mohammadpur', 'Bangladesh', 'Dhaka', '1207', 'Dhaka', '2017-03-02 02:34:24', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bill_transaction`
--

CREATE TABLE `bill_transaction` (
  `id` int(10) UNSIGNED NOT NULL,
  `from_account` int(11) UNSIGNED NOT NULL,
  `t_date` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `to_account` int(11) UNSIGNED NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `method` int(11) UNSIGNED NOT NULL,
  `description` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) UNSIGNED NOT NULL,
  `category_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `company_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category_type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `category_status` tinyint(4) NOT NULL COMMENT '0=inactive, 1=active',
  `created_by` int(11) DEFAULT NULL COMMENT 'user table id',
  `updated_by` int(11) DEFAULT NULL COMMENT 'user table id',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `category_name`, `company_name`, `category_type`, `category_status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Deposit', NULL, 'Deposit', 1, 1, NULL, '2017-12-18 10:07:16', '0000-00-00 00:00:00'),
(2, 'Payment', NULL, 'Payment', 1, 1, NULL, '2017-12-18 10:07:38', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `client_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `mobile_no` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `client_type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `client_status` int(11) DEFAULT NULL,
  `company_name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_branch_id` int(10) UNSIGNED NOT NULL,
  `fk_company_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `client_id`, `client_name`, `mobile_no`, `address`, `email_id`, `client_type`, `client_status`, `company_name`, `fk_branch_id`, `fk_company_id`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 'client-737', 'A.T.M.Emrul Ahmed', NULL, NULL, NULL, 'supplier', 1, NULL, 2, 1, 4, NULL, '2018-02-09 19:25:52', '2018-02-10 12:36:16', NULL),
(3, 'client-896', 'A.T.M.Emrul Ahmed', '01720010035', NULL, NULL, 'supplier', 1, NULL, 2, 1, 4, NULL, '2018-02-09 19:31:04', '2018-02-10 12:37:18', NULL),
(4, 'client-67', 'EPSOA', '', '', '', 'supplier', 1, '', 2, 1, 4, NULL, '2018-02-09 19:43:56', '2018-02-09 19:43:56', NULL),
(5, 'client-321', 'M.F', '', '', '', 'supplier', 1, '', 2, 1, 4, NULL, '2018-02-10 12:03:06', '2018-02-10 12:03:06', NULL),
(6, 'client-227', 'Microlink Technology', '', '', '', 'supplier', 1, '', 2, 1, 4, NULL, '2018-02-10 12:10:02', '2018-02-10 12:10:02', NULL),
(7, 'client-671', 'Ad', '', '', '', 'supplier', 1, '', 2, 1, 4, NULL, '2018-02-10 12:54:24', '2018-02-10 12:54:24', NULL),
(8, 'client-349', 'Khorshed', '', '', '', 'supplier', 1, '', 2, 1, 4, NULL, '2018-02-10 14:16:40', '2018-02-10 14:16:40', NULL),
(9, 'client-13', 'Dehan', '', '', '', 'supplier', 1, '', 4, 1, 7, NULL, '2018-02-25 17:40:55', '2018-02-25 17:40:55', NULL),
(10, 'client-981', 'Abul Kalam Azad', '', '', '', 'supplier', 1, '', 4, 1, 7, NULL, '2018-02-25 17:45:56', '2018-02-25 17:45:56', NULL),
(11, 'client-263', 'EPOS 3', '', '', '', 'supplier', 1, '', 4, 1, 7, NULL, '2018-02-25 17:57:03', '2018-02-25 17:57:03', NULL),
(12, 'client-160', 'TADA 3', '', '', '', 'supplier', 1, '', 4, 1, 7, NULL, '2018-02-25 18:12:34', '2018-02-25 18:12:34', NULL),
(13, 'client-926', 'SIBL # 3', '', '', '', 'supplier', 1, '', 4, 1, 7, NULL, '2018-02-25 18:18:09', '2018-02-25 18:18:09', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `company_info`
--

CREATE TABLE `company_info` (
  `id` int(10) UNSIGNED NOT NULL,
  `company_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `web_address` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_phone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_icon` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fb_page_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `company_info`
--

INSERT INTO `company_info` (`id`, `company_name`, `web_address`, `company_address`, `shipping_address`, `company_email`, `company_phone`, `company_logo`, `company_icon`, `fb_page_link`, `created_at`, `updated_at`) VALUES
(1, 'Eshop', 'www.sms.codeplanners.com', 'Shop: 2/18, L-3, Eastern Plus Shopping Complex, 145, Shantinagar, Dhaka', 'Shop: 2/18, L-3, Eastern Plus Shopping Complex, 145, Shantinagar, Dhaka', 'info@sms.codeplanners.com', '01811951215', '85021020084606.png', '13021020084606.png', 'https://www.facebook.com/profile.php?id=100008270856666', NULL, '2020-10-02 14:46:06');

-- --------------------------------------------------------

--
-- Table structure for table `deposit`
--

CREATE TABLE `deposit` (
  `id` int(10) UNSIGNED NOT NULL,
  `invoice_no` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `t_date` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `ref_id` int(11) DEFAULT NULL,
  `fk_client_id` int(11) UNSIGNED NOT NULL,
  `fk_account_id` int(11) UNSIGNED NOT NULL,
  `fk_method_id` int(11) UNSIGNED NOT NULL,
  `fk_branch_id` int(11) UNSIGNED NOT NULL,
  `fk_company_id` int(11) UNSIGNED NOT NULL DEFAULT 1,
  `amount` float NOT NULL,
  `total_paid` float DEFAULT NULL,
  `created_by` int(11) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposit_cost_item`
--

CREATE TABLE `deposit_cost_item` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_deposit_id` int(10) UNSIGNED NOT NULL,
  `fk_sub_category_id` int(10) UNSIGNED NOT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_amount` float NOT NULL,
  `paid_amount` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposit_history`
--

CREATE TABLE `deposit_history` (
  `id` int(11) NOT NULL,
  `invoice_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `fk_deposit_item_id` int(11) UNSIGNED DEFAULT NULL,
  `last_due` float NOT NULL,
  `paid` float DEFAULT NULL,
  `payment_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_config`
--

CREATE TABLE `email_config` (
  `id` int(11) NOT NULL,
  `default_email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message_body` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `email_config`
--

INSERT INTO `email_config` (`id`, `default_email`, `message_body`, `created_at`, `updated_at`) VALUES
(1, 'demo@gmail.com', 'demo message', NULL, '2017-03-20 00:48:38');

-- --------------------------------------------------------

--
-- Table structure for table `employe_information`
--

CREATE TABLE `employe_information` (
  `id` int(11) NOT NULL,
  `employe_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `photo` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employe_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `employe_email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `designation` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `fk_section_id` int(11) NOT NULL,
  `fk_branch_id` int(10) UNSIGNED NOT NULL,
  `fk_company_id` int(10) UNSIGNED DEFAULT 1,
  `basic_pay` float DEFAULT NULL,
  `house_rent` float DEFAULT NULL,
  `medical_allowance` float DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `created_by` int(11) UNSIGNED NOT NULL,
  `updated_by` int(11) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `employe_information`
--

INSERT INTO `employe_information` (`id`, `employe_name`, `photo`, `employe_id`, `employe_email`, `address`, `mobile_number`, `designation`, `fk_section_id`, `fk_branch_id`, `fk_company_id`, `basic_pay`, `house_rent`, `medical_allowance`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Shahidul Islam', NULL, '001', 'shahidulfbcci@zoho.com', NULL, '8801733299993', 'CEO', 2, 2, 1, 21000, 5000, 1000, 1, 3, 3, '2018-01-23 22:35:37', '2018-02-13 14:21:33'),
(2, 'Monir Hossain Kajal', NULL, '002', NULL, NULL, '8801869977131', 'Manager', 3, 2, 1, 17000, NULL, NULL, 1, 3, 3, '2018-01-23 22:39:24', '2018-03-01 00:17:03'),
(3, 'Sabrina Eva', NULL, '003', NULL, NULL, '8801961889499', 'Manager (DEV)', 3, 2, 1, 19000, NULL, NULL, 1, 3, NULL, '2018-01-23 22:42:42', '2018-01-23 22:42:42'),
(4, 'MD. Masum Mia', NULL, '004', NULL, NULL, '8801917509234', 'Sales Representative', 1, 2, 1, 16000, NULL, NULL, 1, 3, NULL, '2018-01-23 22:51:01', '2018-01-23 22:51:01'),
(5, 'MD. Al Amin', NULL, '005', NULL, NULL, '8801942235495', 'Sales Representative', 1, 2, 1, 14000, NULL, NULL, 1, 3, 5, '2018-01-23 22:54:09', '2018-02-27 22:13:24'),
(6, 'Rubel Hossain', NULL, '006', NULL, NULL, '8801833209022', 'Sales Representative', 1, 2, 1, 8000, NULL, NULL, 1, 3, NULL, '2018-01-23 23:03:04', '2018-01-23 23:03:04'),
(8, 'Tamim Iqbal', NULL, '008', NULL, NULL, '8801790342459', 'Sales Representative', 1, 2, 1, 6000, NULL, NULL, 1, 3, NULL, '2018-01-23 23:07:17', '2018-01-23 23:07:17'),
(9, 'Raihan Gattar Ratul', NULL, '009', NULL, NULL, '8801632374735', 'Sales Representative', 1, 2, 1, 8000, NULL, NULL, 1, 3, NULL, '2018-01-23 23:09:25', '2018-01-23 23:09:25'),
(10, 'MD. Safiq mia', NULL, '010', NULL, NULL, '8801851580381', 'Sales Representative', 1, 2, 1, 9000, NULL, NULL, 1, 3, NULL, '2018-01-23 23:11:19', '2018-01-23 23:11:19'),
(11, 'Jalal Uddin', NULL, '011', NULL, NULL, '01854046518', 'Sales Representative', 1, 2, 1, 8000, NULL, NULL, 1, 4, NULL, '2018-02-09 19:12:54', '2018-02-09 19:12:54'),
(12, 'Azijul Hakim', NULL, '007', 'azijulhakim957@gmail.com', 'Dhaka', '01680683180', 'Sales Representative', 1, 4, 1, 7000, NULL, NULL, 1, 6, NULL, '2018-02-28 22:56:14', '2018-02-28 22:56:14'),
(13, 'Shakil', NULL, '012', NULL, NULL, NULL, 'Sales Representative', 1, 4, 1, 8000, NULL, NULL, 1, 6, NULL, '2018-02-28 23:09:42', '2018-02-28 23:09:42'),
(14, 'Al Amin Hossain', '2018/04/01/541010418020955.jpeg', '013', NULL, NULL, NULL, 'Sales Representative', 1, 4, 1, 14000, NULL, NULL, 1, 6, 1, '2018-02-28 23:13:13', '2018-04-01 08:09:55'),
(15, 'Sabbir Khan', '2018/04/01/726010418025701.png', '1247', 'sabbir@gmail.com', 'Dhaka', '0178946', 'Graphics Designer', 3, 2, 1, 8000, 2000, 1000, 1, 1, NULL, '2018-04-01 08:57:01', '2018-04-01 08:57:01'),
(16, 'Sabbir', '2018/04/01/314010418040746.jpg', '123456', 'sabbir@gmail.com', NULL, NULL, 'Designer', 2, 3, 1, 7000, 500, NULL, 1, 4, NULL, '2018-04-01 10:07:46', '2018-04-01 10:07:46');

-- --------------------------------------------------------

--
-- Table structure for table `employe_salary_allowance`
--

CREATE TABLE `employe_salary_allowance` (
  `id` int(11) NOT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '1=Allowance, 2=Deduction',
  `created_by` int(10) UNSIGNED NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `employe_salary_allowance`
--

INSERT INTO `employe_salary_allowance` (`id`, `title`, `type`, `created_by`, `status`, `created_at`, `updated_at`) VALUES
(2, 'Eid Bonus', 1, 1, 1, '2017-10-10 03:58:19', '2017-10-10 03:58:19'),
(3, 'Hardship Allowance', 1, 1, 1, '2017-10-10 03:58:54', '2017-10-10 03:58:54'),
(4, 'Employee Contribution to PF', 1, 1, 1, '2017-10-10 03:59:30', '2017-10-10 03:59:30'),
(5, 'Fuel/Convince Allowance', 1, 1, 1, '2017-10-10 04:00:21', '2017-10-10 04:00:21'),
(6, 'House Rent Allowance', 1, 1, 1, '2017-10-10 04:00:59', '2017-10-10 04:00:59'),
(7, 'Advance Against Salary', 2, 1, 1, '2017-10-10 04:01:22', '2017-10-10 04:01:22'),
(8, 'Advance Against PF (Local)', 2, 1, 1, '2017-10-10 04:01:53', '2017-10-10 04:01:53'),
(9, 'Advance Against PF (Dhaka)', 2, 1, 1, '2017-10-10 04:02:14', '2017-10-10 04:02:14'),
(10, 'Provident Fund', 2, 1, 1, '2017-10-10 04:02:32', '2017-10-10 04:02:32'),
(11, 'Income Tax', 2, 1, 1, '2017-10-10 04:02:58', '2017-10-10 04:02:58');

-- --------------------------------------------------------

--
-- Table structure for table `employe_salary_sheet`
--

CREATE TABLE `employe_salary_sheet` (
  `id` int(11) NOT NULL,
  `fk_employe_id` int(11) NOT NULL,
  `fk_account_id` int(11) UNSIGNED NOT NULL,
  `fk_method_id` int(11) UNSIGNED NOT NULL,
  `ref_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `basic_pay` float NOT NULL,
  `house_rent` float DEFAULT NULL,
  `medical_allowance` float DEFAULT NULL,
  `year` year(4) NOT NULL,
  `month` int(11) NOT NULL,
  `total_amount` float NOT NULL,
  `deduction` float DEFAULT NULL,
  `paid_amount` float NOT NULL,
  `date` date NOT NULL,
  `created_by` int(11) UNSIGNED NOT NULL,
  `updated_by` int(11) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `employe_salary_sheet`
--

INSERT INTO `employe_salary_sheet` (`id`, `fk_employe_id`, `fk_account_id`, `fk_method_id`, `ref_id`, `basic_pay`, `house_rent`, `medical_allowance`, `year`, `month`, `total_amount`, `deduction`, `paid_amount`, `date`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 3, NULL, 17000, NULL, NULL, 2018, 1, 17000, 0, 17000, '2018-02-02', 4, NULL, '2018-02-09 19:09:11', '2018-02-09 19:09:11'),
(2, 11, 1, 3, NULL, 8000, NULL, NULL, 2018, 1, 8000, 4250, 3750, '2018-02-02', 4, NULL, '2018-02-09 19:21:27', '2018-02-09 19:21:27'),
(3, 2, 1, 3, NULL, 16000, NULL, NULL, 2017, 7, 16000, NULL, 16000, '2018-02-14', 3, NULL, '2018-02-14 12:41:08', '2018-02-14 12:41:08'),
(4, 2, 1, 3, NULL, 16000, NULL, NULL, 2017, 8, 24000, 0, 24000, '2017-09-07', 3, NULL, '2018-02-14 12:45:09', '2018-02-14 12:45:09'),
(5, 2, 1, 3, NULL, 16000, NULL, NULL, 2017, 9, 16000, NULL, 16000, '2017-10-08', 3, NULL, '2018-02-14 12:47:33', '2018-02-14 12:47:33'),
(6, 2, 1, 3, NULL, 16000, NULL, NULL, 2017, 11, 16000, NULL, 16000, '2017-12-06', 3, NULL, '2018-02-14 12:49:47', '2018-02-14 12:49:47'),
(7, 2, 1, 3, NULL, 16000, NULL, NULL, 2017, 12, 16000, NULL, 16000, '2018-01-08', 3, NULL, '2018-02-14 12:52:12', '2018-02-14 12:52:12'),
(8, 3, 1, 3, NULL, 18000, NULL, NULL, 2017, 7, 18000, 0, 18000, '2017-08-08', 3, NULL, '2018-02-14 12:58:47', '2018-02-14 12:58:47'),
(9, 5, 1, 3, NULL, 14000, NULL, NULL, 2017, 7, 14000, 0, 14000, '2017-08-08', 3, NULL, '2018-02-14 13:01:45', '2018-02-14 13:01:45'),
(10, 3, 1, 3, NULL, 18000, NULL, NULL, 2017, 8, 27000, 0, 27000, '2017-09-05', 3, NULL, '2018-02-14 13:04:57', '2018-02-14 13:04:57'),
(11, 5, 1, 3, NULL, 14000, NULL, NULL, 2017, 8, 21000, 0, 21000, '2017-09-06', 3, NULL, '2018-02-14 13:06:39', '2018-02-14 13:06:39'),
(12, 3, 1, 3, NULL, 18000, NULL, NULL, 2017, 9, 18000, 0, 18000, '2017-10-09', 3, NULL, '2018-02-14 13:10:55', '2018-02-14 13:10:55'),
(13, 5, 1, 3, NULL, 14000, NULL, NULL, 2017, 9, 14000, 0, 14000, '2018-02-14', 3, NULL, '2018-02-14 13:11:56', '2018-02-14 13:11:56'),
(14, 2, 1, 3, NULL, 16000, NULL, NULL, 2017, 10, 16000, NULL, 16000, '2017-11-07', 3, 3, '2018-02-14 13:15:28', '2018-02-14 13:25:23'),
(15, 3, 1, 3, NULL, 18000, NULL, NULL, 2017, 10, 18000, 0, 18000, '2017-11-07', 3, NULL, '2018-02-14 13:17:36', '2018-02-14 13:17:36'),
(16, 3, 1, 3, NULL, 18000, NULL, NULL, 2017, 11, 18000, 0, 18000, '2018-02-14', 3, NULL, '2018-02-14 13:19:05', '2018-02-14 13:19:05'),
(17, 3, 1, 3, NULL, 18000, NULL, NULL, 2017, 12, 18000, 0, 18000, '2018-01-08', 3, NULL, '2018-02-14 13:21:06', '2018-02-14 13:21:06'),
(18, 3, 1, 3, NULL, 19000, NULL, NULL, 2018, 1, 19000, NULL, 19000, '2018-02-06', 3, NULL, '2018-02-14 13:22:49', '2018-02-14 13:22:49'),
(20, 10, 1, 3, NULL, 9000, NULL, NULL, 2017, 10, 9000, NULL, 9000, '2017-11-09', 3, NULL, '2018-02-17 23:11:29', '2018-02-17 23:11:29'),
(21, 10, 1, 3, NULL, 9000, NULL, NULL, 2017, 11, 9000, NULL, 9000, '2017-12-05', 3, NULL, '2018-02-17 23:13:02', '2018-02-17 23:13:02'),
(22, 10, 1, 3, NULL, 9000, NULL, NULL, 2017, 12, 9000, NULL, 9000, '2018-01-08', 3, NULL, '2018-02-17 23:14:03', '2018-02-17 23:14:03'),
(24, 12, 1, 3, NULL, 4000, NULL, NULL, 2017, 9, 4000, 0, 4000, '2017-09-30', 6, NULL, '2018-02-28 23:02:17', '2018-02-28 23:02:17'),
(25, 12, 1, 3, NULL, 6000, NULL, NULL, 2017, 10, 6000, 0, 6000, '2017-11-30', 6, NULL, '2018-02-28 23:15:01', '2018-02-28 23:15:01'),
(26, 12, 1, 3, NULL, 6000, NULL, NULL, 2017, 11, 6000, 0, 6000, '2017-10-31', 6, NULL, '2018-02-28 23:18:49', '2018-02-28 23:18:49'),
(27, 13, 1, 3, NULL, 8000, NULL, NULL, 2017, 10, 8000, NULL, 8000, '2017-10-31', 6, NULL, '2018-02-28 23:20:39', '2018-02-28 23:20:39'),
(28, 13, 1, 3, NULL, 8000, NULL, NULL, 2017, 11, 8000, NULL, 8000, '2017-11-30', 6, NULL, '2018-02-28 23:26:50', '2018-02-28 23:26:50'),
(29, 14, 1, 3, NULL, 14000, NULL, NULL, 2017, 10, 14000, NULL, 14000, '2017-10-31', 6, NULL, '2018-02-28 23:33:44', '2018-02-28 23:33:44'),
(30, 14, 1, 3, NULL, 14000, NULL, NULL, 2017, 11, 14000, NULL, 14000, '2017-11-30', 6, NULL, '2018-02-28 23:37:22', '2018-02-28 23:37:22'),
(31, 14, 1, 3, NULL, 14000, NULL, NULL, 2017, 12, 14000, NULL, 14000, '2017-12-31', 6, NULL, '2018-02-28 23:48:28', '2018-02-28 23:48:28'),
(32, 12, 1, 3, NULL, 6000, NULL, NULL, 2017, 12, 6000, 0, 6000, '2018-02-28', 6, NULL, '2018-02-28 23:49:57', '2018-02-28 23:49:57'),
(33, 13, 1, 3, NULL, 8000, NULL, NULL, 2017, 12, 8000, NULL, 8000, '2018-02-28', 6, NULL, '2018-02-28 23:51:16', '2018-02-28 23:51:16'),
(34, 14, 1, 3, NULL, 15000, NULL, NULL, 2018, 1, 15000, 0, 15000, '2018-01-31', 6, NULL, '2018-02-28 23:54:03', '2018-02-28 23:54:03'),
(35, 12, 1, 3, NULL, 7000, NULL, NULL, 2018, 1, 7000, 0, 7000, '2018-01-31', 6, NULL, '2018-02-28 23:55:22', '2018-02-28 23:55:22'),
(36, 13, 1, 3, NULL, 9000, NULL, NULL, 2018, 1, 9000, 0, 9000, '2018-01-31', 6, NULL, '2018-02-28 23:56:38', '2018-02-28 23:56:38'),
(37, 12, 1, 3, NULL, 7000, NULL, NULL, 2018, 2, 7000, NULL, 7000, '2018-02-28', 6, NULL, '2018-03-01 00:00:53', '2018-03-01 00:00:53'),
(38, 13, 1, 3, NULL, 9000, NULL, NULL, 2018, 2, 9000, 0, 9000, '2018-02-28', 6, NULL, '2018-03-01 00:14:40', '2018-03-01 00:14:40'),
(39, 14, 1, 3, NULL, 15000, NULL, NULL, 2018, 2, 15000, 0, 15000, '2018-02-28', 6, NULL, '2018-03-01 00:15:45', '2018-03-01 00:15:45'),
(40, 2, 1, 3, NULL, 17000, NULL, NULL, 2018, 2, 17000, NULL, 17000, '2018-03-04', 5, NULL, '2018-03-04 20:47:07', '2018-03-04 20:47:07'),
(41, 3, 1, 3, NULL, 19000, NULL, NULL, 2018, 2, 19000, NULL, 19000, '2018-03-04', 5, NULL, '2018-03-04 20:47:58', '2018-03-04 20:47:58'),
(42, 11, 1, 3, NULL, 8000, NULL, NULL, 2018, 2, 8000, NULL, 8000, '2018-03-04', 5, NULL, '2018-03-04 20:48:33', '2018-03-04 20:48:33');

-- --------------------------------------------------------

--
-- Table structure for table `employe_salary_sheet_extra_allowance`
--

CREATE TABLE `employe_salary_sheet_extra_allowance` (
  `id` int(11) NOT NULL,
  `fk_salary_sheet_id` int(11) NOT NULL,
  `fk_salary_allowance_id` int(11) NOT NULL,
  `value` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `employe_salary_sheet_extra_allowance`
--

INSERT INTO `employe_salary_sheet_extra_allowance` (`id`, `fk_salary_sheet_id`, `fk_salary_allowance_id`, `value`, `created_at`, `updated_at`) VALUES
(1, 1, 2, NULL, '2018-02-09 19:09:11', '2018-02-09 19:09:11'),
(2, 1, 3, NULL, '2018-02-09 19:09:11', '2018-02-09 19:09:11'),
(3, 1, 4, NULL, '2018-02-09 19:09:11', '2018-02-09 19:09:11'),
(4, 1, 5, NULL, '2018-02-09 19:09:11', '2018-02-09 19:09:11'),
(5, 1, 6, NULL, '2018-02-09 19:09:11', '2018-02-09 19:09:11'),
(6, 1, 7, NULL, '2018-02-09 19:09:11', '2018-02-09 19:09:11'),
(7, 1, 8, NULL, '2018-02-09 19:09:11', '2018-02-09 19:09:11'),
(8, 1, 9, NULL, '2018-02-09 19:09:11', '2018-02-09 19:09:11'),
(9, 1, 10, NULL, '2018-02-09 19:09:11', '2018-02-09 19:09:11'),
(10, 1, 11, NULL, '2018-02-09 19:09:11', '2018-02-09 19:09:11'),
(11, 2, 2, NULL, '2018-02-09 19:21:27', '2018-02-09 19:21:27'),
(12, 2, 3, NULL, '2018-02-09 19:21:27', '2018-02-09 19:21:27'),
(13, 2, 4, NULL, '2018-02-09 19:21:27', '2018-02-09 19:21:27'),
(14, 2, 5, NULL, '2018-02-09 19:21:27', '2018-02-09 19:21:27'),
(15, 2, 6, NULL, '2018-02-09 19:21:27', '2018-02-09 19:21:27'),
(16, 2, 7, 4250, '2018-02-09 19:21:27', '2018-02-09 19:21:27'),
(17, 2, 8, NULL, '2018-02-09 19:21:27', '2018-02-09 19:21:27'),
(18, 2, 9, NULL, '2018-02-09 19:21:27', '2018-02-09 19:21:27'),
(19, 2, 10, NULL, '2018-02-09 19:21:27', '2018-02-09 19:21:27'),
(20, 2, 11, NULL, '2018-02-09 19:21:27', '2018-02-09 19:21:27'),
(21, 3, 2, NULL, '2018-02-14 12:41:08', '2018-02-14 12:41:08'),
(22, 3, 4, NULL, '2018-02-14 12:41:08', '2018-02-14 12:41:08'),
(23, 3, 5, NULL, '2018-02-14 12:41:08', '2018-02-14 12:41:08'),
(24, 3, 6, NULL, '2018-02-14 12:41:08', '2018-02-14 12:41:08'),
(25, 3, 7, NULL, '2018-02-14 12:41:08', '2018-02-14 12:41:08'),
(26, 3, 8, NULL, '2018-02-14 12:41:08', '2018-02-14 12:41:08'),
(27, 3, 10, NULL, '2018-02-14 12:41:08', '2018-02-14 12:41:08'),
(28, 4, 2, 8000, '2018-02-14 12:45:09', '2018-02-14 12:45:09'),
(29, 4, 4, NULL, '2018-02-14 12:45:09', '2018-02-14 12:45:09'),
(30, 4, 5, NULL, '2018-02-14 12:45:09', '2018-02-14 12:45:09'),
(31, 4, 6, NULL, '2018-02-14 12:45:09', '2018-02-14 12:45:09'),
(32, 4, 7, NULL, '2018-02-14 12:45:09', '2018-02-14 12:45:09'),
(33, 4, 8, NULL, '2018-02-14 12:45:09', '2018-02-14 12:45:09'),
(34, 4, 10, NULL, '2018-02-14 12:45:09', '2018-02-14 12:45:09'),
(35, 5, 2, NULL, '2018-02-14 12:47:33', '2018-02-14 12:47:33'),
(36, 5, 4, NULL, '2018-02-14 12:47:33', '2018-02-14 12:47:33'),
(37, 5, 5, NULL, '2018-02-14 12:47:33', '2018-02-14 12:47:33'),
(38, 5, 6, NULL, '2018-02-14 12:47:33', '2018-02-14 12:47:33'),
(39, 5, 7, NULL, '2018-02-14 12:47:33', '2018-02-14 12:47:33'),
(40, 5, 8, NULL, '2018-02-14 12:47:33', '2018-02-14 12:47:33'),
(41, 5, 10, NULL, '2018-02-14 12:47:33', '2018-02-14 12:47:33'),
(42, 6, 2, NULL, '2018-02-14 12:49:47', '2018-02-14 12:49:47'),
(43, 6, 4, NULL, '2018-02-14 12:49:47', '2018-02-14 12:49:47'),
(44, 6, 5, NULL, '2018-02-14 12:49:47', '2018-02-14 12:49:47'),
(45, 6, 6, NULL, '2018-02-14 12:49:47', '2018-02-14 12:49:47'),
(46, 6, 7, NULL, '2018-02-14 12:49:47', '2018-02-14 12:49:47'),
(47, 6, 8, NULL, '2018-02-14 12:49:47', '2018-02-14 12:49:47'),
(48, 6, 10, NULL, '2018-02-14 12:49:47', '2018-02-14 12:49:47'),
(49, 7, 2, NULL, '2018-02-14 12:52:12', '2018-02-14 12:52:12'),
(50, 7, 4, NULL, '2018-02-14 12:52:12', '2018-02-14 12:52:12'),
(51, 7, 5, NULL, '2018-02-14 12:52:12', '2018-02-14 12:52:12'),
(52, 7, 6, NULL, '2018-02-14 12:52:12', '2018-02-14 12:52:12'),
(53, 7, 7, NULL, '2018-02-14 12:52:12', '2018-02-14 12:52:12'),
(54, 7, 8, NULL, '2018-02-14 12:52:12', '2018-02-14 12:52:12'),
(55, 7, 10, NULL, '2018-02-14 12:52:12', '2018-02-14 12:52:12'),
(56, 8, 2, NULL, '2018-02-14 12:58:47', '2018-02-14 12:58:47'),
(57, 8, 4, NULL, '2018-02-14 12:58:47', '2018-02-14 12:58:47'),
(58, 8, 5, NULL, '2018-02-14 12:58:47', '2018-02-14 12:58:47'),
(59, 8, 6, NULL, '2018-02-14 12:58:47', '2018-02-14 12:58:47'),
(60, 8, 7, NULL, '2018-02-14 12:58:47', '2018-02-14 12:58:47'),
(61, 8, 8, NULL, '2018-02-14 12:58:47', '2018-02-14 12:58:47'),
(62, 8, 10, NULL, '2018-02-14 12:58:47', '2018-02-14 12:58:47'),
(63, 9, 2, NULL, '2018-02-14 13:01:45', '2018-02-14 13:01:45'),
(64, 9, 4, NULL, '2018-02-14 13:01:45', '2018-02-14 13:01:45'),
(65, 9, 5, NULL, '2018-02-14 13:01:45', '2018-02-14 13:01:45'),
(66, 9, 6, NULL, '2018-02-14 13:01:45', '2018-02-14 13:01:45'),
(67, 9, 7, NULL, '2018-02-14 13:01:45', '2018-02-14 13:01:45'),
(68, 9, 8, NULL, '2018-02-14 13:01:45', '2018-02-14 13:01:45'),
(69, 9, 10, NULL, '2018-02-14 13:01:45', '2018-02-14 13:01:45'),
(70, 10, 2, 9000, '2018-02-14 13:04:57', '2018-02-14 13:04:57'),
(71, 10, 4, NULL, '2018-02-14 13:04:57', '2018-02-14 13:04:57'),
(72, 10, 5, NULL, '2018-02-14 13:04:57', '2018-02-14 13:04:57'),
(73, 10, 6, NULL, '2018-02-14 13:04:57', '2018-02-14 13:04:57'),
(74, 10, 7, NULL, '2018-02-14 13:04:57', '2018-02-14 13:04:57'),
(75, 10, 8, NULL, '2018-02-14 13:04:57', '2018-02-14 13:04:57'),
(76, 10, 10, NULL, '2018-02-14 13:04:57', '2018-02-14 13:04:57'),
(77, 11, 2, 7000, '2018-02-14 13:06:39', '2018-02-14 13:06:39'),
(78, 11, 4, NULL, '2018-02-14 13:06:39', '2018-02-14 13:06:39'),
(79, 11, 5, NULL, '2018-02-14 13:06:39', '2018-02-14 13:06:39'),
(80, 11, 6, NULL, '2018-02-14 13:06:39', '2018-02-14 13:06:39'),
(81, 11, 7, NULL, '2018-02-14 13:06:39', '2018-02-14 13:06:39'),
(82, 11, 8, NULL, '2018-02-14 13:06:39', '2018-02-14 13:06:39'),
(83, 11, 10, NULL, '2018-02-14 13:06:39', '2018-02-14 13:06:39'),
(84, 12, 2, NULL, '2018-02-14 13:10:55', '2018-02-14 13:10:55'),
(85, 12, 4, NULL, '2018-02-14 13:10:55', '2018-02-14 13:10:55'),
(86, 12, 5, NULL, '2018-02-14 13:10:55', '2018-02-14 13:10:55'),
(87, 12, 6, NULL, '2018-02-14 13:10:55', '2018-02-14 13:10:55'),
(88, 12, 7, NULL, '2018-02-14 13:10:55', '2018-02-14 13:10:55'),
(89, 12, 8, NULL, '2018-02-14 13:10:55', '2018-02-14 13:10:55'),
(90, 12, 10, NULL, '2018-02-14 13:10:55', '2018-02-14 13:10:55'),
(91, 13, 2, NULL, '2018-02-14 13:11:56', '2018-02-14 13:11:56'),
(92, 13, 4, NULL, '2018-02-14 13:11:56', '2018-02-14 13:11:56'),
(93, 13, 5, NULL, '2018-02-14 13:11:56', '2018-02-14 13:11:56'),
(94, 13, 6, NULL, '2018-02-14 13:11:56', '2018-02-14 13:11:56'),
(95, 13, 7, NULL, '2018-02-14 13:11:56', '2018-02-14 13:11:56'),
(96, 13, 8, NULL, '2018-02-14 13:11:56', '2018-02-14 13:11:56'),
(97, 13, 10, NULL, '2018-02-14 13:11:56', '2018-02-14 13:11:56'),
(98, 14, 2, NULL, '2018-02-14 13:15:28', '2018-02-14 13:25:23'),
(99, 14, 4, NULL, '2018-02-14 13:15:28', '2018-02-14 13:25:23'),
(100, 14, 5, NULL, '2018-02-14 13:15:28', '2018-02-14 13:25:23'),
(101, 14, 6, NULL, '2018-02-14 13:15:28', '2018-02-14 13:25:23'),
(102, 14, 7, NULL, '2018-02-14 13:15:28', '2018-02-14 13:25:23'),
(103, 14, 8, NULL, '2018-02-14 13:15:28', '2018-02-14 13:25:23'),
(104, 14, 10, NULL, '2018-02-14 13:15:28', '2018-02-14 13:25:23'),
(105, 15, 2, NULL, '2018-02-14 13:17:36', '2018-02-14 13:17:36'),
(106, 15, 4, NULL, '2018-02-14 13:17:36', '2018-02-14 13:17:36'),
(107, 15, 5, NULL, '2018-02-14 13:17:36', '2018-02-14 13:17:36'),
(108, 15, 6, NULL, '2018-02-14 13:17:36', '2018-02-14 13:17:36'),
(109, 15, 7, NULL, '2018-02-14 13:17:36', '2018-02-14 13:17:36'),
(110, 15, 8, NULL, '2018-02-14 13:17:36', '2018-02-14 13:17:36'),
(111, 15, 10, NULL, '2018-02-14 13:17:36', '2018-02-14 13:17:36'),
(112, 16, 2, NULL, '2018-02-14 13:19:05', '2018-02-14 13:19:05'),
(113, 16, 4, NULL, '2018-02-14 13:19:05', '2018-02-14 13:19:05'),
(114, 16, 5, NULL, '2018-02-14 13:19:05', '2018-02-14 13:19:05'),
(115, 16, 6, NULL, '2018-02-14 13:19:05', '2018-02-14 13:19:05'),
(116, 16, 7, NULL, '2018-02-14 13:19:05', '2018-02-14 13:19:05'),
(117, 16, 8, NULL, '2018-02-14 13:19:05', '2018-02-14 13:19:05'),
(118, 16, 10, NULL, '2018-02-14 13:19:05', '2018-02-14 13:19:05'),
(119, 17, 2, NULL, '2018-02-14 13:21:06', '2018-02-14 13:21:06'),
(120, 17, 4, NULL, '2018-02-14 13:21:06', '2018-02-14 13:21:06'),
(121, 17, 5, NULL, '2018-02-14 13:21:06', '2018-02-14 13:21:06'),
(122, 17, 6, NULL, '2018-02-14 13:21:06', '2018-02-14 13:21:06'),
(123, 17, 7, NULL, '2018-02-14 13:21:06', '2018-02-14 13:21:06'),
(124, 17, 8, NULL, '2018-02-14 13:21:06', '2018-02-14 13:21:06'),
(125, 17, 10, NULL, '2018-02-14 13:21:06', '2018-02-14 13:21:06'),
(126, 18, 2, NULL, '2018-02-14 13:22:49', '2018-02-14 13:22:49'),
(127, 18, 4, NULL, '2018-02-14 13:22:49', '2018-02-14 13:22:49'),
(128, 18, 5, NULL, '2018-02-14 13:22:49', '2018-02-14 13:22:49'),
(129, 18, 6, NULL, '2018-02-14 13:22:49', '2018-02-14 13:22:49'),
(130, 18, 7, NULL, '2018-02-14 13:22:49', '2018-02-14 13:22:49'),
(131, 18, 8, NULL, '2018-02-14 13:22:49', '2018-02-14 13:22:49'),
(132, 18, 10, NULL, '2018-02-14 13:22:49', '2018-02-14 13:22:49'),
(143, 20, 2, NULL, '2018-02-17 23:11:29', '2018-02-17 23:11:29'),
(144, 20, 3, NULL, '2018-02-17 23:11:29', '2018-02-17 23:11:29'),
(145, 20, 4, NULL, '2018-02-17 23:11:29', '2018-02-17 23:11:29'),
(146, 20, 5, NULL, '2018-02-17 23:11:29', '2018-02-17 23:11:29'),
(147, 20, 6, NULL, '2018-02-17 23:11:29', '2018-02-17 23:11:29'),
(148, 20, 7, NULL, '2018-02-17 23:11:29', '2018-02-17 23:11:29'),
(149, 20, 8, NULL, '2018-02-17 23:11:29', '2018-02-17 23:11:29'),
(150, 20, 9, NULL, '2018-02-17 23:11:29', '2018-02-17 23:11:29'),
(151, 20, 10, NULL, '2018-02-17 23:11:29', '2018-02-17 23:11:29'),
(152, 20, 11, NULL, '2018-02-17 23:11:29', '2018-02-17 23:11:29'),
(153, 21, 2, NULL, '2018-02-17 23:13:02', '2018-02-17 23:13:02'),
(154, 21, 3, NULL, '2018-02-17 23:13:02', '2018-02-17 23:13:02'),
(155, 21, 4, NULL, '2018-02-17 23:13:02', '2018-02-17 23:13:02'),
(156, 21, 5, NULL, '2018-02-17 23:13:02', '2018-02-17 23:13:02'),
(157, 21, 6, NULL, '2018-02-17 23:13:02', '2018-02-17 23:13:02'),
(158, 21, 7, NULL, '2018-02-17 23:13:02', '2018-02-17 23:13:02'),
(159, 21, 8, NULL, '2018-02-17 23:13:02', '2018-02-17 23:13:02'),
(160, 21, 9, NULL, '2018-02-17 23:13:02', '2018-02-17 23:13:02'),
(161, 21, 10, NULL, '2018-02-17 23:13:02', '2018-02-17 23:13:02'),
(162, 21, 11, NULL, '2018-02-17 23:13:02', '2018-02-17 23:13:02'),
(163, 22, 2, NULL, '2018-02-17 23:14:03', '2018-02-17 23:14:03'),
(164, 22, 3, NULL, '2018-02-17 23:14:03', '2018-02-17 23:14:03'),
(165, 22, 4, NULL, '2018-02-17 23:14:03', '2018-02-17 23:14:03'),
(166, 22, 5, NULL, '2018-02-17 23:14:03', '2018-02-17 23:14:03'),
(167, 22, 6, NULL, '2018-02-17 23:14:03', '2018-02-17 23:14:03'),
(168, 22, 7, NULL, '2018-02-17 23:14:03', '2018-02-17 23:14:03'),
(169, 22, 8, NULL, '2018-02-17 23:14:03', '2018-02-17 23:14:03'),
(170, 22, 9, NULL, '2018-02-17 23:14:03', '2018-02-17 23:14:03'),
(171, 22, 10, NULL, '2018-02-17 23:14:03', '2018-02-17 23:14:03'),
(172, 22, 11, NULL, '2018-02-17 23:14:03', '2018-02-17 23:14:03'),
(183, 24, 2, NULL, '2018-02-28 23:02:17', '2018-02-28 23:02:17'),
(184, 24, 3, NULL, '2018-02-28 23:02:17', '2018-02-28 23:02:17'),
(185, 24, 4, NULL, '2018-02-28 23:02:17', '2018-02-28 23:02:17'),
(186, 24, 5, NULL, '2018-02-28 23:02:17', '2018-02-28 23:02:17'),
(187, 24, 6, NULL, '2018-02-28 23:02:17', '2018-02-28 23:02:17'),
(188, 24, 7, NULL, '2018-02-28 23:02:17', '2018-02-28 23:02:17'),
(189, 24, 8, NULL, '2018-02-28 23:02:17', '2018-02-28 23:02:17'),
(190, 24, 9, NULL, '2018-02-28 23:02:17', '2018-02-28 23:02:17'),
(191, 24, 10, NULL, '2018-02-28 23:02:17', '2018-02-28 23:02:17'),
(192, 24, 11, NULL, '2018-02-28 23:02:17', '2018-02-28 23:02:17'),
(193, 25, 2, NULL, '2018-02-28 23:15:01', '2018-02-28 23:15:01'),
(194, 25, 3, NULL, '2018-02-28 23:15:01', '2018-02-28 23:15:01'),
(195, 25, 4, NULL, '2018-02-28 23:15:01', '2018-02-28 23:15:01'),
(196, 25, 5, NULL, '2018-02-28 23:15:01', '2018-02-28 23:15:01'),
(197, 25, 6, NULL, '2018-02-28 23:15:01', '2018-02-28 23:15:01'),
(198, 25, 7, NULL, '2018-02-28 23:15:01', '2018-02-28 23:15:01'),
(199, 25, 8, NULL, '2018-02-28 23:15:01', '2018-02-28 23:15:01'),
(200, 25, 9, NULL, '2018-02-28 23:15:01', '2018-02-28 23:15:01'),
(201, 25, 10, NULL, '2018-02-28 23:15:01', '2018-02-28 23:15:01'),
(202, 25, 11, NULL, '2018-02-28 23:15:01', '2018-02-28 23:15:01'),
(203, 26, 2, NULL, '2018-02-28 23:18:49', '2018-02-28 23:18:49'),
(204, 26, 3, NULL, '2018-02-28 23:18:49', '2018-02-28 23:18:49'),
(205, 26, 4, NULL, '2018-02-28 23:18:49', '2018-02-28 23:18:49'),
(206, 26, 5, NULL, '2018-02-28 23:18:49', '2018-02-28 23:18:49'),
(207, 26, 6, NULL, '2018-02-28 23:18:49', '2018-02-28 23:18:49'),
(208, 26, 7, NULL, '2018-02-28 23:18:49', '2018-02-28 23:18:49'),
(209, 26, 8, NULL, '2018-02-28 23:18:49', '2018-02-28 23:18:49'),
(210, 26, 9, NULL, '2018-02-28 23:18:49', '2018-02-28 23:18:49'),
(211, 26, 10, NULL, '2018-02-28 23:18:49', '2018-02-28 23:18:49'),
(212, 26, 11, NULL, '2018-02-28 23:18:49', '2018-02-28 23:18:49'),
(213, 27, 2, NULL, '2018-02-28 23:20:39', '2018-02-28 23:20:39'),
(214, 27, 3, NULL, '2018-02-28 23:20:39', '2018-02-28 23:20:39'),
(215, 27, 4, NULL, '2018-02-28 23:20:39', '2018-02-28 23:20:39'),
(216, 27, 5, NULL, '2018-02-28 23:20:39', '2018-02-28 23:20:39'),
(217, 27, 6, NULL, '2018-02-28 23:20:39', '2018-02-28 23:20:39'),
(218, 27, 7, NULL, '2018-02-28 23:20:39', '2018-02-28 23:20:39'),
(219, 27, 8, NULL, '2018-02-28 23:20:39', '2018-02-28 23:20:39'),
(220, 27, 9, NULL, '2018-02-28 23:20:40', '2018-02-28 23:20:40'),
(221, 27, 10, NULL, '2018-02-28 23:20:40', '2018-02-28 23:20:40'),
(222, 27, 11, NULL, '2018-02-28 23:20:40', '2018-02-28 23:20:40'),
(223, 28, 2, NULL, '2018-02-28 23:26:50', '2018-02-28 23:26:50'),
(224, 28, 3, NULL, '2018-02-28 23:26:50', '2018-02-28 23:26:50'),
(225, 28, 4, NULL, '2018-02-28 23:26:50', '2018-02-28 23:26:50'),
(226, 28, 5, NULL, '2018-02-28 23:26:50', '2018-02-28 23:26:50'),
(227, 28, 6, NULL, '2018-02-28 23:26:50', '2018-02-28 23:26:50'),
(228, 28, 7, NULL, '2018-02-28 23:26:50', '2018-02-28 23:26:50'),
(229, 28, 8, NULL, '2018-02-28 23:26:50', '2018-02-28 23:26:50'),
(230, 28, 9, NULL, '2018-02-28 23:26:50', '2018-02-28 23:26:50'),
(231, 28, 10, NULL, '2018-02-28 23:26:50', '2018-02-28 23:26:50'),
(232, 28, 11, NULL, '2018-02-28 23:26:50', '2018-02-28 23:26:50'),
(233, 29, 2, NULL, '2018-02-28 23:33:44', '2018-02-28 23:33:44'),
(234, 29, 3, NULL, '2018-02-28 23:33:44', '2018-02-28 23:33:44'),
(235, 29, 4, NULL, '2018-02-28 23:33:44', '2018-02-28 23:33:44'),
(236, 29, 5, NULL, '2018-02-28 23:33:44', '2018-02-28 23:33:44'),
(237, 29, 6, NULL, '2018-02-28 23:33:44', '2018-02-28 23:33:44'),
(238, 29, 7, NULL, '2018-02-28 23:33:44', '2018-02-28 23:33:44'),
(239, 29, 8, NULL, '2018-02-28 23:33:44', '2018-02-28 23:33:44'),
(240, 29, 9, NULL, '2018-02-28 23:33:44', '2018-02-28 23:33:44'),
(241, 29, 10, NULL, '2018-02-28 23:33:44', '2018-02-28 23:33:44'),
(242, 29, 11, NULL, '2018-02-28 23:33:44', '2018-02-28 23:33:44'),
(243, 30, 2, NULL, '2018-02-28 23:37:22', '2018-02-28 23:37:22'),
(244, 30, 3, NULL, '2018-02-28 23:37:22', '2018-02-28 23:37:22'),
(245, 30, 4, NULL, '2018-02-28 23:37:22', '2018-02-28 23:37:22'),
(246, 30, 5, NULL, '2018-02-28 23:37:22', '2018-02-28 23:37:22'),
(247, 30, 6, NULL, '2018-02-28 23:37:22', '2018-02-28 23:37:22'),
(248, 30, 7, NULL, '2018-02-28 23:37:22', '2018-02-28 23:37:22'),
(249, 30, 8, NULL, '2018-02-28 23:37:22', '2018-02-28 23:37:22'),
(250, 30, 9, NULL, '2018-02-28 23:37:22', '2018-02-28 23:37:22'),
(251, 30, 10, NULL, '2018-02-28 23:37:22', '2018-02-28 23:37:22'),
(252, 30, 11, NULL, '2018-02-28 23:37:22', '2018-02-28 23:37:22'),
(253, 31, 2, NULL, '2018-02-28 23:48:28', '2018-02-28 23:48:28'),
(254, 31, 3, NULL, '2018-02-28 23:48:28', '2018-02-28 23:48:28'),
(255, 31, 4, NULL, '2018-02-28 23:48:28', '2018-02-28 23:48:28'),
(256, 31, 5, NULL, '2018-02-28 23:48:28', '2018-02-28 23:48:28'),
(257, 31, 6, NULL, '2018-02-28 23:48:28', '2018-02-28 23:48:28'),
(258, 31, 7, NULL, '2018-02-28 23:48:28', '2018-02-28 23:48:28'),
(259, 31, 8, NULL, '2018-02-28 23:48:28', '2018-02-28 23:48:28'),
(260, 31, 9, NULL, '2018-02-28 23:48:28', '2018-02-28 23:48:28'),
(261, 31, 10, NULL, '2018-02-28 23:48:28', '2018-02-28 23:48:28'),
(262, 31, 11, NULL, '2018-02-28 23:48:28', '2018-02-28 23:48:28'),
(263, 32, 2, NULL, '2018-02-28 23:49:57', '2018-02-28 23:49:57'),
(264, 32, 3, NULL, '2018-02-28 23:49:57', '2018-02-28 23:49:57'),
(265, 32, 4, NULL, '2018-02-28 23:49:57', '2018-02-28 23:49:57'),
(266, 32, 5, NULL, '2018-02-28 23:49:57', '2018-02-28 23:49:57'),
(267, 32, 6, NULL, '2018-02-28 23:49:57', '2018-02-28 23:49:57'),
(268, 32, 7, NULL, '2018-02-28 23:49:57', '2018-02-28 23:49:57'),
(269, 32, 8, NULL, '2018-02-28 23:49:57', '2018-02-28 23:49:57'),
(270, 32, 9, NULL, '2018-02-28 23:49:57', '2018-02-28 23:49:57'),
(271, 32, 10, NULL, '2018-02-28 23:49:57', '2018-02-28 23:49:57'),
(272, 32, 11, NULL, '2018-02-28 23:49:57', '2018-02-28 23:49:57'),
(273, 33, 2, NULL, '2018-02-28 23:51:16', '2018-02-28 23:51:16'),
(274, 33, 3, NULL, '2018-02-28 23:51:16', '2018-02-28 23:51:16'),
(275, 33, 4, NULL, '2018-02-28 23:51:16', '2018-02-28 23:51:16'),
(276, 33, 5, NULL, '2018-02-28 23:51:16', '2018-02-28 23:51:16'),
(277, 33, 6, NULL, '2018-02-28 23:51:16', '2018-02-28 23:51:16'),
(278, 33, 7, NULL, '2018-02-28 23:51:16', '2018-02-28 23:51:16'),
(279, 33, 8, NULL, '2018-02-28 23:51:16', '2018-02-28 23:51:16'),
(280, 33, 9, NULL, '2018-02-28 23:51:16', '2018-02-28 23:51:16'),
(281, 33, 10, NULL, '2018-02-28 23:51:16', '2018-02-28 23:51:16'),
(282, 33, 11, NULL, '2018-02-28 23:51:16', '2018-02-28 23:51:16'),
(283, 34, 2, NULL, '2018-02-28 23:54:03', '2018-02-28 23:54:03'),
(284, 34, 3, NULL, '2018-02-28 23:54:03', '2018-02-28 23:54:03'),
(285, 34, 4, NULL, '2018-02-28 23:54:03', '2018-02-28 23:54:03'),
(286, 34, 5, NULL, '2018-02-28 23:54:03', '2018-02-28 23:54:03'),
(287, 34, 6, NULL, '2018-02-28 23:54:03', '2018-02-28 23:54:03'),
(288, 34, 7, NULL, '2018-02-28 23:54:03', '2018-02-28 23:54:03'),
(289, 34, 8, NULL, '2018-02-28 23:54:03', '2018-02-28 23:54:03'),
(290, 34, 9, NULL, '2018-02-28 23:54:03', '2018-02-28 23:54:03'),
(291, 34, 10, NULL, '2018-02-28 23:54:03', '2018-02-28 23:54:03'),
(292, 34, 11, NULL, '2018-02-28 23:54:03', '2018-02-28 23:54:03'),
(293, 35, 2, NULL, '2018-02-28 23:55:22', '2018-02-28 23:55:22'),
(294, 35, 3, NULL, '2018-02-28 23:55:22', '2018-02-28 23:55:22'),
(295, 35, 4, NULL, '2018-02-28 23:55:22', '2018-02-28 23:55:22'),
(296, 35, 5, NULL, '2018-02-28 23:55:22', '2018-02-28 23:55:22'),
(297, 35, 6, NULL, '2018-02-28 23:55:22', '2018-02-28 23:55:22'),
(298, 35, 7, NULL, '2018-02-28 23:55:22', '2018-02-28 23:55:22'),
(299, 35, 8, NULL, '2018-02-28 23:55:22', '2018-02-28 23:55:22'),
(300, 35, 9, NULL, '2018-02-28 23:55:22', '2018-02-28 23:55:22'),
(301, 35, 10, NULL, '2018-02-28 23:55:22', '2018-02-28 23:55:22'),
(302, 35, 11, NULL, '2018-02-28 23:55:22', '2018-02-28 23:55:22'),
(303, 36, 2, NULL, '2018-02-28 23:56:38', '2018-02-28 23:56:38'),
(304, 36, 3, NULL, '2018-02-28 23:56:38', '2018-02-28 23:56:38'),
(305, 36, 4, NULL, '2018-02-28 23:56:38', '2018-02-28 23:56:38'),
(306, 36, 5, NULL, '2018-02-28 23:56:38', '2018-02-28 23:56:38'),
(307, 36, 6, NULL, '2018-02-28 23:56:38', '2018-02-28 23:56:38'),
(308, 36, 7, NULL, '2018-02-28 23:56:38', '2018-02-28 23:56:38'),
(309, 36, 8, NULL, '2018-02-28 23:56:38', '2018-02-28 23:56:38'),
(310, 36, 9, NULL, '2018-02-28 23:56:38', '2018-02-28 23:56:38'),
(311, 36, 10, NULL, '2018-02-28 23:56:38', '2018-02-28 23:56:38'),
(312, 36, 11, NULL, '2018-02-28 23:56:38', '2018-02-28 23:56:38'),
(313, 37, 2, NULL, '2018-03-01 00:00:53', '2018-03-01 00:00:53'),
(314, 37, 3, NULL, '2018-03-01 00:00:53', '2018-03-01 00:00:53'),
(315, 37, 4, NULL, '2018-03-01 00:00:53', '2018-03-01 00:00:53'),
(316, 37, 5, NULL, '2018-03-01 00:00:53', '2018-03-01 00:00:53'),
(317, 37, 6, NULL, '2018-03-01 00:00:53', '2018-03-01 00:00:53'),
(318, 37, 7, NULL, '2018-03-01 00:00:53', '2018-03-01 00:00:53'),
(319, 37, 8, NULL, '2018-03-01 00:00:53', '2018-03-01 00:00:53'),
(320, 37, 9, NULL, '2018-03-01 00:00:53', '2018-03-01 00:00:53'),
(321, 37, 10, NULL, '2018-03-01 00:00:54', '2018-03-01 00:00:54'),
(322, 37, 11, NULL, '2018-03-01 00:00:54', '2018-03-01 00:00:54'),
(323, 38, 2, NULL, '2018-03-01 00:14:40', '2018-03-01 00:14:40'),
(324, 38, 3, NULL, '2018-03-01 00:14:40', '2018-03-01 00:14:40'),
(325, 38, 4, NULL, '2018-03-01 00:14:40', '2018-03-01 00:14:40'),
(326, 38, 5, NULL, '2018-03-01 00:14:40', '2018-03-01 00:14:40'),
(327, 38, 6, NULL, '2018-03-01 00:14:40', '2018-03-01 00:14:40'),
(328, 38, 7, NULL, '2018-03-01 00:14:40', '2018-03-01 00:14:40'),
(329, 38, 8, NULL, '2018-03-01 00:14:40', '2018-03-01 00:14:40'),
(330, 38, 9, NULL, '2018-03-01 00:14:40', '2018-03-01 00:14:40'),
(331, 38, 10, NULL, '2018-03-01 00:14:40', '2018-03-01 00:14:40'),
(332, 38, 11, NULL, '2018-03-01 00:14:40', '2018-03-01 00:14:40'),
(333, 39, 2, NULL, '2018-03-01 00:15:45', '2018-03-01 00:15:45'),
(334, 39, 3, NULL, '2018-03-01 00:15:45', '2018-03-01 00:15:45'),
(335, 39, 4, NULL, '2018-03-01 00:15:45', '2018-03-01 00:15:45'),
(336, 39, 5, NULL, '2018-03-01 00:15:45', '2018-03-01 00:15:45'),
(337, 39, 6, NULL, '2018-03-01 00:15:45', '2018-03-01 00:15:45'),
(338, 39, 7, NULL, '2018-03-01 00:15:45', '2018-03-01 00:15:45'),
(339, 39, 8, NULL, '2018-03-01 00:15:45', '2018-03-01 00:15:45'),
(340, 39, 9, NULL, '2018-03-01 00:15:45', '2018-03-01 00:15:45'),
(341, 39, 10, NULL, '2018-03-01 00:15:45', '2018-03-01 00:15:45'),
(342, 39, 11, NULL, '2018-03-01 00:15:45', '2018-03-01 00:15:45'),
(343, 40, 2, NULL, '2018-03-04 20:47:07', '2018-03-04 20:47:07'),
(344, 40, 3, NULL, '2018-03-04 20:47:07', '2018-03-04 20:47:07'),
(345, 40, 4, NULL, '2018-03-04 20:47:07', '2018-03-04 20:47:07'),
(346, 40, 5, NULL, '2018-03-04 20:47:07', '2018-03-04 20:47:07'),
(347, 40, 6, NULL, '2018-03-04 20:47:07', '2018-03-04 20:47:07'),
(348, 40, 7, NULL, '2018-03-04 20:47:07', '2018-03-04 20:47:07'),
(349, 40, 8, NULL, '2018-03-04 20:47:07', '2018-03-04 20:47:07'),
(350, 40, 9, NULL, '2018-03-04 20:47:07', '2018-03-04 20:47:07'),
(351, 40, 10, NULL, '2018-03-04 20:47:07', '2018-03-04 20:47:07'),
(352, 40, 11, NULL, '2018-03-04 20:47:07', '2018-03-04 20:47:07'),
(353, 41, 2, NULL, '2018-03-04 20:47:58', '2018-03-04 20:47:58'),
(354, 41, 3, NULL, '2018-03-04 20:47:58', '2018-03-04 20:47:58'),
(355, 41, 4, NULL, '2018-03-04 20:47:58', '2018-03-04 20:47:58'),
(356, 41, 5, NULL, '2018-03-04 20:47:58', '2018-03-04 20:47:58'),
(357, 41, 6, NULL, '2018-03-04 20:47:58', '2018-03-04 20:47:58'),
(358, 41, 7, NULL, '2018-03-04 20:47:58', '2018-03-04 20:47:58'),
(359, 41, 8, NULL, '2018-03-04 20:47:58', '2018-03-04 20:47:58'),
(360, 41, 9, NULL, '2018-03-04 20:47:58', '2018-03-04 20:47:58'),
(361, 41, 10, NULL, '2018-03-04 20:47:58', '2018-03-04 20:47:58'),
(362, 41, 11, NULL, '2018-03-04 20:47:58', '2018-03-04 20:47:58'),
(363, 42, 2, NULL, '2018-03-04 20:48:33', '2018-03-04 20:48:33'),
(364, 42, 3, NULL, '2018-03-04 20:48:33', '2018-03-04 20:48:33'),
(365, 42, 4, NULL, '2018-03-04 20:48:33', '2018-03-04 20:48:33'),
(366, 42, 5, NULL, '2018-03-04 20:48:33', '2018-03-04 20:48:33'),
(367, 42, 6, NULL, '2018-03-04 20:48:33', '2018-03-04 20:48:33'),
(368, 42, 7, NULL, '2018-03-04 20:48:33', '2018-03-04 20:48:33'),
(369, 42, 8, NULL, '2018-03-04 20:48:33', '2018-03-04 20:48:33'),
(370, 42, 9, NULL, '2018-03-04 20:48:33', '2018-03-04 20:48:33'),
(371, 42, 10, NULL, '2018-03-04 20:48:33', '2018-03-04 20:48:33'),
(372, 42, 11, NULL, '2018-03-04 20:48:33', '2018-03-04 20:48:33');

-- --------------------------------------------------------

--
-- Table structure for table `employe_section`
--

CREATE TABLE `employe_section` (
  `id` int(11) NOT NULL,
  `section_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `details` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `created_by` int(11) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `employe_section`
--

INSERT INTO `employe_section` (`id`, `section_name`, `details`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'sales Representative', NULL, 1, 3, '2018-01-23 22:30:46', '2018-01-23 22:30:46'),
(2, 'CEO', NULL, 1, 3, '2018-01-23 22:31:06', '2018-01-23 22:31:06'),
(3, 'Sales Manager', NULL, 1, 3, '2018-01-23 22:32:59', '2018-01-23 22:32:59');

-- --------------------------------------------------------

--
-- Table structure for table `execl`
--

CREATE TABLE `execl` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `location` varbinary(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `id` int(11) UNSIGNED NOT NULL,
  `fk_product_id` int(11) UNSIGNED NOT NULL,
  `available_qty` float NOT NULL,
  `fk_model_id` int(11) NOT NULL,
  `available_small_qty` float NOT NULL,
  `sales_per_unit` decimal(17,3) DEFAULT NULL,
  `cost_per_unit` decimal(17,3) DEFAULT NULL,
  `fk_branch_id` int(10) UNSIGNED NOT NULL,
  `fk_company_id` int(10) UNSIGNED DEFAULT 1,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`id`, `fk_product_id`, `available_qty`, `fk_model_id`, `available_small_qty`, `sales_per_unit`, `cost_per_unit`, `fk_branch_id`, `fk_company_id`, `status`, `created_at`, `updated_at`) VALUES
(31, 27, 899, 31, 0, 0.000, 140.000, 2, 1, 1, '2018-01-29 18:00:16', '2018-04-01 05:14:14'),
(32, 28, 158, 32, 0, 0.000, 1018.000, 2, 1, 1, '2018-01-30 14:11:41', '2018-03-05 17:12:09'),
(33, 28, 0, 33, 0, NULL, 1000.000, 2, 1, 1, '2018-01-30 14:11:41', '2018-02-24 17:10:49'),
(34, 28, 0, 34, 0, NULL, 1100.000, 2, 1, 1, '2018-01-30 14:29:30', '2018-02-07 17:22:45'),
(35, 28, 5, 35, 0, NULL, 1025.000, 2, 1, 1, '2018-01-30 14:29:30', '2018-02-11 15:11:02'),
(36, 28, 2, 36, 0, NULL, 600.000, 2, 1, 1, '2018-01-30 14:29:30', '2018-02-24 17:10:49'),
(37, 28, 0, 37, 0, NULL, 665.000, 2, 1, 1, '2018-01-30 14:29:30', '2018-02-12 16:20:17'),
(38, 28, 0, 38, 0, NULL, 520.000, 2, 1, 1, '2018-01-30 14:29:30', '2018-02-03 17:32:04'),
(39, 28, 0, 39, 0, NULL, 400.000, 2, 1, 1, '2018-01-30 14:29:30', '2018-02-18 22:32:18'),
(40, 30, 31, 40, 0, NULL, 500.000, 2, 1, 1, '2018-01-30 14:29:30', '2018-02-12 16:20:17'),
(41, 39, 61, 41, 0, NULL, 175.000, 2, 1, 1, '2018-01-30 14:29:30', '2018-03-05 16:32:20'),
(42, 34, 11, 42, 0, 0.000, 1400.000, 2, 1, 1, '2018-01-30 14:39:40', '2018-03-21 06:43:58'),
(43, 37, 14, 43, 0, NULL, 712.000, 2, 1, 1, '2018-01-30 14:46:42', '2018-03-05 16:29:50'),
(44, 38, 73, 44, 0, NULL, 1035.000, 2, 1, 1, '2018-01-30 14:46:42', '2018-03-05 16:12:53'),
(45, 35, 12, 45, 0, NULL, 900.000, 2, 1, 1, '2018-01-30 14:55:28', '2018-03-05 17:45:12'),
(46, 35, 0, 31, 0, NULL, 950.000, 2, 1, 1, '2018-01-30 14:55:28', '2018-02-07 15:48:19'),
(47, 49, 8, 46, 0, NULL, 2700.000, 2, 1, 1, '2018-01-30 15:20:20', '2018-02-18 23:16:17'),
(48, 49, 19, 31, 0, NULL, 1728.000, 2, 1, 1, '2018-01-30 15:43:48', '2018-02-18 21:32:25'),
(49, 31, 212, 47, 0, NULL, 317.000, 2, 1, 1, '2018-01-30 16:00:37', '2018-02-16 20:24:55'),
(50, 30, 29, 48, 0, NULL, 450.000, 2, 1, 1, '2018-01-30 16:00:37', '2018-02-09 14:43:44'),
(51, 45, 0, 49, 0, NULL, 1800.000, 2, 1, 1, '2018-01-30 16:15:30', '2018-02-07 17:22:45'),
(52, 45, 30, 50, 0, NULL, 1100.000, 2, 1, 1, '2018-01-30 16:15:30', '2018-02-18 22:39:07'),
(53, 29, 29, 51, 0, NULL, 620.000, 2, 1, 1, '2018-01-30 16:28:49', '2018-02-24 16:43:57'),
(54, 42, 9, 52, 0, NULL, 1233.000, 2, 1, 1, '2018-01-30 16:28:49', '2018-02-17 21:13:57'),
(55, 29, 0, 53, 0, NULL, 1000.000, 2, 1, 1, '2018-01-30 16:28:49', '2018-02-12 12:12:22'),
(56, 32, 46, 54, 0, NULL, 1000.000, 2, 1, 1, '2018-01-30 16:28:49', '2018-02-24 16:31:11'),
(57, 50, 0, 55, 0, NULL, 550.000, 2, 1, 1, '2018-01-30 16:36:58', '2018-02-07 17:22:45'),
(58, 50, 0, 56, 0, NULL, 300.000, 2, 1, 1, '2018-01-30 16:36:58', '2018-02-07 17:22:45'),
(59, 42, 6, 57, 0, NULL, 1127.000, 2, 1, 1, '2018-01-30 16:36:58', '2018-02-23 22:33:53'),
(60, 32, 217, 58, 0, NULL, 664.000, 2, 1, 1, '2018-01-30 16:36:58', '2018-03-05 16:48:08'),
(61, 35, 0, 59, 0, NULL, 1250.000, 2, 1, 1, '2018-01-30 16:42:36', '2018-02-12 12:12:22'),
(62, 51, 153, 60, 0, NULL, 112.000, 2, 1, 1, '2018-01-30 17:35:54', '2018-03-05 17:09:19'),
(63, 51, 107, 61, 0, 0.000, 22.000, 2, 1, 1, '2018-01-30 17:35:54', '2018-02-12 16:20:17'),
(64, 51, 12, 62, 0, 0.000, 10.000, 2, 1, 1, '2018-01-30 17:35:54', '2018-02-12 16:20:17'),
(65, 51, 0, 63, 0, 0.000, 50.000, 2, 1, 1, '2018-01-30 17:35:54', '2018-02-09 15:24:42'),
(66, 48, 751, 64, 0, NULL, 86.000, 2, 1, 1, '2018-01-30 17:35:54', '2018-03-05 16:48:08'),
(67, 27, 0, 65, 0, 0.000, 200.000, 2, 1, 1, '2018-01-30 17:35:54', '2018-02-19 23:37:29'),
(68, 27, 115, 66, 0, NULL, 300.000, 2, 1, 1, '2018-01-30 18:22:17', '2018-02-23 21:29:08'),
(69, 27, 0, 67, 0, NULL, 175.000, 2, 1, 1, '2018-01-30 18:22:17', '2018-02-17 21:13:57'),
(70, 27, 198, 68, 0, NULL, 200.000, 2, 1, 1, '2018-01-30 18:22:17', '2018-03-05 17:03:42'),
(71, 27, 15, 69, 0, NULL, 150.000, 2, 1, 1, '2018-01-30 18:22:17', '2018-03-05 16:12:53'),
(72, 27, 439, 70, 0, 0.000, 175.000, 2, 1, 1, '2018-01-30 18:22:17', '2018-03-05 16:32:20'),
(73, 27, 97, 71, 0, NULL, 250.000, 2, 1, 1, '2018-01-30 18:22:17', '2018-03-05 16:22:53'),
(74, 27, 1455, 72, 0, NULL, 90.000, 2, 1, 1, '2018-01-30 18:22:17', '2018-03-05 16:57:45'),
(75, 44, 42, 73, 0, NULL, 322.000, 2, 1, 1, '2018-01-30 18:22:17', '2018-02-23 22:33:53'),
(76, 44, 0, 74, 0, NULL, 1200.000, 2, 1, 1, '2018-01-30 18:22:17', '2018-02-12 16:20:17'),
(77, 44, 3, 75, 0, NULL, 600.000, 2, 1, 1, '2018-01-30 18:22:17', '2018-02-18 22:39:07'),
(78, 39, 611, 76, 0, NULL, 314.000, 2, 1, 1, '2018-01-30 18:22:17', '2018-03-05 16:57:45'),
(79, 43, 662, 77, 0, NULL, 410.000, 2, 1, 1, '2018-01-30 18:22:17', '2018-03-05 16:48:08'),
(80, 43, 96, 78, 0, NULL, 250.000, 2, 1, 1, '2018-01-30 18:22:17', '2018-02-10 10:40:58'),
(81, 27, 146, 79, 0, NULL, 215.000, 2, 1, 1, '2018-01-30 18:22:17', '2018-03-05 17:03:42'),
(82, 33, 33, 80, 0, NULL, 300.000, 2, 1, 1, '2018-01-30 18:41:15', '2018-03-05 16:29:50'),
(83, 40, 0, 81, 0, 0.000, 1700.000, 2, 1, 1, '2018-01-30 18:48:29', '2018-02-05 19:11:08'),
(84, 73, 0, 82, 0, 0.000, 3100.000, 2, 1, 1, '2018-01-31 12:10:55', '2018-02-11 19:58:04'),
(85, 40, 0, 83, 0, NULL, 1300.000, 2, 1, 1, '2018-01-31 12:10:55', '2018-02-11 15:47:27'),
(86, 40, 0, 37, 0, NULL, 1650.000, 2, 1, 1, '2018-01-31 12:10:55', '2018-02-09 13:11:54'),
(87, 40, 6, 45, 0, NULL, 2100.000, 2, 1, 1, '2018-01-31 12:10:55', '2018-02-12 16:20:17'),
(88, 67, 0, 84, 0, NULL, 1510.000, 2, 1, 1, '2018-01-31 12:23:34', '2018-02-18 23:36:07'),
(89, 67, 0, 85, 0, 0.000, 1900.000, 2, 1, 1, '2018-01-31 12:23:34', '2018-02-06 15:47:30'),
(90, 67, 0, 86, 0, 0.000, 2000.000, 2, 1, 1, '2018-01-31 12:23:34', '2018-02-05 19:11:08'),
(91, 67, 0, 87, 0, 0.000, 2700.000, 2, 1, 1, '2018-01-31 12:23:34', '2018-02-11 19:58:04'),
(92, 67, 0, 88, 0, 0.000, 3037.000, 2, 1, 1, '2018-01-31 12:23:34', '2018-02-12 12:12:22'),
(93, 59, 0, 89, 0, NULL, 3400.000, 2, 1, 1, '2018-01-31 12:41:25', '2018-02-05 19:11:08'),
(94, 53, 0, 90, 0, NULL, 3200.000, 2, 1, 1, '2018-01-31 12:41:25', '2018-02-09 11:31:46'),
(95, 58, 2, 91, 0, NULL, 2550.000, 2, 1, 1, '2018-01-31 12:41:25', '2018-02-06 11:06:26'),
(96, 56, 0, 92, 0, NULL, 3000.000, 2, 1, 1, '2018-01-31 12:41:25', '2018-02-12 16:20:17'),
(97, 72, 187, 93, 0, NULL, 910.000, 2, 1, 1, '2018-01-31 13:28:30', '2018-03-05 17:09:19'),
(98, 74, 2, 94, 0, NULL, 1954.000, 2, 1, 1, '2018-01-31 13:28:30', '2018-02-12 11:20:43'),
(99, 76, 133, 95, 0, NULL, 1450.000, 2, 1, 1, '2018-01-31 13:28:30', '2018-03-05 16:48:08'),
(100, 57, 19, 76, 0, NULL, 1500.000, 2, 1, 1, '2018-01-31 13:28:30', '2018-02-12 16:20:17'),
(101, 75, -34, 96, 0, NULL, 2536.000, 2, 1, 1, '2018-01-31 13:28:30', '2018-02-05 19:11:08'),
(102, 77, 0, 97, 0, NULL, 3250.000, 2, 1, 1, '2018-01-31 13:28:30', '2018-02-05 19:11:08'),
(103, 79, 0, 98, 0, NULL, 2950.000, 2, 1, 1, '2018-01-31 13:28:30', '2018-02-05 19:11:08'),
(104, 78, 0, 99, 0, NULL, 3000.000, 2, 1, 1, '2018-01-31 13:28:30', '2018-02-05 19:11:08'),
(105, 55, 0, 100, 0, NULL, 3000.000, 2, 1, 1, '2018-01-31 13:28:30', '2018-02-06 11:06:26'),
(106, 55, 0, 101, 0, NULL, 2850.000, 2, 1, 1, '2018-01-31 13:28:30', '2018-02-05 19:11:08'),
(107, 55, 1, 102, 0, NULL, 2900.000, 2, 1, 1, '2018-01-31 13:28:30', '2018-02-23 22:28:02'),
(108, 57, 3, 103, 0, NULL, 2850.000, 2, 1, 1, '2018-01-31 13:28:30', '2018-02-06 18:31:00'),
(109, 66, 0, 104, 0, NULL, 4000.000, 2, 1, 1, '2018-01-31 13:58:55', '2018-02-05 19:11:08'),
(110, 81, 6, 105, 0, NULL, 300.000, 2, 1, 1, '2018-01-31 13:58:55', '2018-02-12 16:20:17'),
(111, 82, 0, 106, 0, NULL, 500.000, 2, 1, 1, '2018-01-31 13:58:55', '2018-02-23 22:33:53'),
(112, 52, 0, 107, 0, NULL, 2600.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(113, 53, 0, 108, 0, NULL, 3150.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-06 11:06:26'),
(114, 54, 11, 109, 0, NULL, 1900.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(115, 55, 0, 110, 0, NULL, 2500.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(116, 56, 4, 111, 0, NULL, 2500.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-16 19:43:43'),
(117, 57, 7, 112, 0, NULL, 3600.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-12 16:20:17'),
(118, 53, 0, 113, 0, NULL, 3300.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(119, 58, 7, 114, 0, NULL, 2700.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-11 19:58:04'),
(120, 55, 0, 115, 0, NULL, 2700.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(121, 58, 0, 116, 0, NULL, 2750.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(122, 56, 0, 117, 0, NULL, 2800.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(123, 58, 0, 118, 0, NULL, 3550.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(124, 53, 3, 119, 0, NULL, 2500.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-23 22:28:02'),
(125, 60, 0, 120, 0, NULL, 1550.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(126, 61, 4, 121, 0, NULL, 1400.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-24 15:58:37'),
(127, 62, 0, 122, 0, NULL, 1750.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(128, 63, 0, 123, 0, NULL, 1900.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(129, 64, 0, 124, 0, NULL, 1250.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(130, 75, 16, 125, 0, NULL, 2313.000, 2, 1, 1, '2018-01-31 14:34:13', '2018-02-11 11:49:55'),
(131, 75, 1, 126, 0, NULL, 1800.000, 2, 1, 1, '2018-01-31 14:48:05', '2018-02-06 16:31:48'),
(132, 40, 0, 127, 0, NULL, 2000.000, 2, 1, 1, '2018-01-31 14:48:05', '2018-02-12 16:20:17'),
(133, 40, 0, 128, 0, NULL, 1300.000, 2, 1, 1, '2018-01-31 14:48:05', '2018-02-05 19:11:08'),
(134, 75, 22, 129, 0, NULL, 2900.000, 2, 1, 1, '2018-01-31 15:00:24', '2018-02-24 16:13:26'),
(135, 83, 0, 130, 0, NULL, 2100.000, 2, 1, 1, '2018-01-31 15:10:04', '2018-02-05 19:11:08'),
(136, 41, 3, 131, 0, NULL, 1000.000, 2, 1, 1, '2018-02-04 15:56:24', '2018-02-17 21:00:27'),
(137, 41, 2, 132, 0, NULL, 1200.000, 2, 1, 1, '2018-02-04 15:56:24', '2018-03-04 16:58:34'),
(138, 41, 3, 133, 0, NULL, 900.000, 2, 1, 1, '2018-02-04 15:56:24', '2018-02-17 21:00:27'),
(139, 41, 3, 134, 0, NULL, 1060.000, 2, 1, 1, '2018-02-04 15:56:24', '2018-02-17 21:00:27'),
(140, 41, 2, 135, 0, NULL, 1150.000, 2, 1, 1, '2018-02-04 15:56:24', '2018-02-17 21:00:27'),
(141, 84, 3, 136, 0, NULL, 712.000, 2, 1, 1, '2018-02-05 15:14:57', '2018-02-18 21:29:50'),
(142, 84, 98, 137, 0, NULL, 550.000, 2, 1, 1, '2018-02-05 15:14:57', '2018-03-05 16:48:08'),
(143, 36, 11, 138, 0, NULL, 840.000, 2, 1, 1, '2018-02-05 15:14:57', '2018-02-12 16:20:17'),
(144, 41, 9, 31, 0, NULL, 750.000, 2, 1, 1, '2018-02-05 15:14:57', '2018-02-11 11:49:55'),
(145, 85, 0, 139, 0, NULL, 130.000, 2, 1, 1, '2018-02-05 15:14:57', '2018-02-09 11:56:58'),
(146, 86, 48, 140, 0, NULL, 230.000, 2, 1, 1, '2018-02-05 15:14:57', '2018-02-24 17:10:49'),
(147, 35, 0, 141, 0, NULL, 1250.000, 2, 1, 1, '2018-02-05 15:21:31', '2018-02-12 15:43:33'),
(148, 66, 5, 142, 0, NULL, 2450.000, 2, 1, 1, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(149, 66, 0, 143, 0, NULL, 2900.000, 2, 1, 1, '2018-02-14 12:23:03', '2018-02-17 21:20:00'),
(150, 67, 10, 144, 0, NULL, 1950.000, 2, 1, 1, '2018-02-14 12:23:03', '2018-03-04 17:16:43'),
(151, 68, 0, 145, 0, NULL, 3000.000, 2, 1, 1, '2018-02-14 12:23:03', '2018-02-17 21:20:00'),
(152, 69, 4, 146, 0, NULL, 2450.000, 2, 1, 1, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(153, 70, 7, 147, 0, NULL, 1900.000, 2, 1, 1, '2018-02-14 12:23:03', '2018-02-24 17:19:25'),
(154, 70, 0, 148, 0, NULL, 2100.000, 2, 1, 1, '2018-02-14 12:23:03', '2018-02-17 21:20:00'),
(155, 70, 0, 149, 0, NULL, 2250.000, 2, 1, 1, '2018-02-14 12:23:03', '2018-03-04 17:16:43'),
(156, 69, 0, 150, 0, NULL, 2500.000, 2, 1, 1, '2018-02-14 12:23:03', '2018-02-17 21:20:00'),
(157, 66, 0, 151, 0, NULL, 3050.000, 2, 1, 1, '2018-02-14 12:23:03', '2018-02-17 21:20:00'),
(158, 66, 0, 152, 0, NULL, 2600.000, 2, 1, 1, '2018-02-14 12:23:03', '2018-02-17 21:20:00'),
(159, 71, 0, 153, 0, NULL, 2700.000, 2, 1, 1, '2018-02-14 12:23:03', '2018-02-17 21:20:00'),
(160, 55, 0, 100, 0, NULL, 3000.000, 4, 1, 1, '2018-02-17 17:28:18', '2018-02-28 22:06:48'),
(161, 55, 0, 102, 0, NULL, 2847.000, 4, 1, 1, '2018-02-17 17:28:18', '2020-10-02 14:54:49'),
(162, 53, 4, 108, 0, NULL, 3150.000, 4, 1, 1, '2018-02-17 17:28:18', '2018-03-04 21:27:23'),
(163, 53, 9, 90, 0, NULL, 3200.000, 4, 1, 1, '2018-02-17 17:28:18', '2020-10-02 14:55:43'),
(164, 58, 1, 91, 0, NULL, 2550.000, 4, 1, 1, '2018-02-17 17:28:18', '2018-03-04 00:03:18'),
(165, 44, 17, 75, 0, NULL, 471.000, 4, 1, 1, '2018-02-17 17:45:55', '2018-03-04 21:38:58'),
(166, 44, 129, 73, 0, NULL, 200.000, 4, 1, 1, '2018-02-17 17:45:55', '2018-03-04 21:38:58'),
(167, 28, 240, 32, 0, NULL, 1018.000, 4, 1, 1, '2018-02-17 17:45:55', '2018-03-04 22:00:57'),
(168, 35, 16, 59, 0, NULL, 1250.000, 4, 1, 1, '2018-02-17 17:45:55', '2018-03-04 21:38:58'),
(169, 81, 5, 154, 0, NULL, 300.000, 4, 1, 1, '2018-02-17 17:45:55', '2018-03-04 21:38:58'),
(170, 82, 1, 155, 0, NULL, 500.000, 4, 1, 1, '2018-02-17 17:45:55', '2018-02-27 00:36:55'),
(171, 86, 93, 140, 0, NULL, 200.000, 4, 1, 1, '2018-02-17 17:45:55', '2018-03-04 21:27:23'),
(172, 28, 18, 39, 0, NULL, 400.000, 4, 1, 1, '2018-02-17 17:45:55', '2018-02-28 22:47:25'),
(173, 42, 19, 57, 0, NULL, 450.000, 4, 1, 1, '2018-02-17 17:45:55', '2018-03-05 00:58:33'),
(174, 45, 63, 50, 0, NULL, 1000.000, 4, 1, 1, '2018-02-17 17:45:55', '2018-03-03 22:24:46'),
(175, 45, 0, 49, 0, NULL, 1799.000, 4, 1, 1, '2018-02-17 17:45:55', '2018-02-28 22:47:25'),
(176, 51, 6, 60, 0, NULL, 50.000, 4, 1, 1, '2018-02-17 17:45:55', '2018-03-04 21:38:58'),
(177, 51, 70, 61, 0, NULL, 18.000, 4, 1, 1, '2018-02-17 17:45:55', '2018-03-04 21:42:03'),
(178, 51, 0, 62, 0, NULL, 10.000, 4, 1, 1, '2018-02-17 17:45:55', '2018-03-03 22:24:46'),
(179, 27, 466, 70, 0, NULL, 175.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-04 22:00:57'),
(180, 39, 423, 156, 0, NULL, 262.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-04 21:38:58'),
(181, 39, 61, 41, 0, NULL, 200.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(182, 27, 1293, 31, 0, NULL, 140.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(183, 27, 474, 72, 0, NULL, 90.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(184, 43, 351, 77, 0, NULL, 606.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(185, 43, 115, 78, 0, NULL, 250.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-04 21:27:23'),
(186, 27, 86, 71, 0, NULL, 250.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-04 22:15:25'),
(187, 27, 210, 68, 0, NULL, 200.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-04 22:15:25'),
(188, 27, 370, 79, 0, NULL, 233.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(189, 33, 32, 157, 0, NULL, 300.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(190, 31, 85, 47, 0, NULL, 405.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-04 21:38:58'),
(191, 32, 322, 58, 0, NULL, 600.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(192, 32, 63, 54, 0, NULL, 1000.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-03 22:24:46'),
(193, 29, 26, 51, 0, NULL, 700.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-04 21:38:58'),
(194, 30, 75, 48, 0, NULL, 472.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(195, 48, 626, 64, 0, NULL, 54.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(196, 42, 7, 52, 0, NULL, 1500.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(197, 84, 14, 136, 0, NULL, 793.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-04 21:38:58'),
(198, 44, 2, 74, 0, NULL, 1200.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-04 21:38:58'),
(199, 84, 35, 137, 0, NULL, 737.000, 4, 1, 1, '2018-02-17 18:19:59', '2018-03-03 22:24:46'),
(200, 49, 22, 31, 0, NULL, 1613.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 00:03:18'),
(201, 49, 11, 46, 0, NULL, 2700.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-02-28 22:06:48'),
(202, 72, 417, 93, 0, NULL, 910.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-05 00:58:33'),
(203, 38, 40, 44, 0, NULL, 1223.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 00:03:18'),
(204, 66, 6, 104, 0, NULL, 4000.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:38:58'),
(205, 75, 27, 129, 0, NULL, 2900.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(206, 75, 47, 96, 0, NULL, 1726.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 00:03:18'),
(207, 83, 11, 130, 0, NULL, 2100.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 00:03:18'),
(208, 40, 7, 128, 0, NULL, 1300.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:38:58'),
(209, 40, 7, 127, 0, NULL, 2000.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:38:58'),
(210, 75, 1, 126, 0, NULL, 1800.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(211, 75, 4, 125, 0, NULL, 3750.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(212, 52, 9, 107, 0, NULL, 2600.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(213, 55, 4, 110, 0, NULL, 2500.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(214, 53, 9, 113, 0, NULL, 3300.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(215, 55, 7, 115, 0, NULL, 2700.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(216, 58, 2, 116, 0, NULL, 2750.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(217, 58, 7, 118, 0, NULL, 3550.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(218, 56, 10, 117, 0, NULL, 2800.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(219, 59, 12, 89, 0, NULL, 3200.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:38:58'),
(220, 60, 5, 120, 0, NULL, 1550.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 00:03:18'),
(221, 62, 5, 122, 0, NULL, 1750.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(222, 63, 6, 158, 0, NULL, 1900.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(223, 64, 7, 124, 0, NULL, 1250.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(224, 40, 16, 81, 0, NULL, 1650.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(225, 73, 0, 82, 0, NULL, 3100.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-02-25 00:38:04'),
(226, 40, 1, 83, 0, NULL, 1295.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:53:46'),
(227, 67, 0, 159, 0, NULL, 2000.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(228, 67, 0, 88, 0, NULL, 3050.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-02-28 22:47:25'),
(229, 67, 1, 87, 0, NULL, 2700.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-02-28 19:03:40'),
(230, 67, 6, 85, 0, NULL, 1900.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 00:03:18'),
(231, 67, 5, 84, 0, NULL, 1510.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(232, 57, 9, 103, 0, NULL, 2850.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-03 22:24:46'),
(233, 79, 7, 98, 0, NULL, 2950.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(234, 77, 2, 97, 0, NULL, 3250.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(235, 78, 2, 99, 0, NULL, 3000.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(236, 55, 6, 101, 0, NULL, 2850.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-02-28 22:06:48'),
(237, 74, 12, 94, 0, NULL, 2100.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(238, 75, 51, 95, 0, NULL, 1149.000, 4, 1, 1, '2018-02-17 18:56:45', '2018-03-04 21:38:58'),
(239, 39, 3, 76, 0, NULL, 250.000, 4, 1, 1, '2018-02-17 21:51:57', '2018-02-25 21:05:02'),
(240, 66, 11, 143, 0, NULL, 2900.000, 4, 1, 1, '2018-02-17 22:06:10', '2018-03-04 00:03:18'),
(241, 67, 8, 144, 0, NULL, 1950.000, 4, 1, 1, '2018-02-17 22:06:10', '2018-03-04 22:15:25'),
(242, 68, 5, 160, 0, NULL, 3000.000, 4, 1, 1, '2018-02-17 22:06:10', '2018-03-04 00:03:18'),
(243, 69, 5, 161, 0, NULL, 2500.000, 4, 1, 1, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(244, 70, 12, 162, 0, NULL, 2100.000, 4, 1, 1, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(245, 70, 8, 163, 0, NULL, 2250.000, 4, 1, 1, '2018-02-17 22:06:10', '2018-03-05 00:58:33'),
(246, 66, 12, 151, 0, NULL, 3050.000, 4, 1, 1, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(247, 71, 5, 164, 0, NULL, 2700.000, 4, 1, 1, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(248, 66, 6, 152, 0, NULL, 2600.000, 4, 1, 1, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(249, 81, 5, 157, 0, NULL, 120.000, 2, 1, 1, '2018-03-04 00:53:18', '2018-03-04 16:58:34'),
(251, 41, 7, 166, 0, NULL, 1200.000, 4, 1, 1, '2018-03-04 19:56:15', '2018-03-04 22:15:25'),
(252, 81, 5, 157, 0, NULL, 120.000, 4, 1, 1, '2018-03-04 22:15:25', '2018-03-04 22:15:25');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_branch`
--

CREATE TABLE `inventory_branch` (
  `id` int(10) UNSIGNED NOT NULL,
  `branch_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_branch`
--

INSERT INTO `inventory_branch` (`id`, `branch_name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Comilla Branch', 1, '2017-05-13 01:41:55', '2020-10-02 14:50:59'),
(2, 'Chattogram Branch', 1, '2017-06-02 01:51:22', '2020-10-02 14:50:32'),
(3, 'Noakhali Branch', 0, '2018-01-23 18:30:20', '2020-10-02 14:49:45'),
(4, 'Dhaka Branch', 1, '2018-02-14 13:53:39', '2020-10-02 14:49:31');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_clients`
--

CREATE TABLE `inventory_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `client_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `mobile_no` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_address1` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_address2` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `client_status` tinyint(4) DEFAULT NULL,
  `client_type` tinyint(4) NOT NULL COMMENT '0=client, 1=supplier',
  `company_name` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_company_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `fk_branch_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_clients`
--

INSERT INTO `inventory_clients` (`id`, `client_id`, `client_name`, `mobile_no`, `address`, `shipping_address1`, `shipping_address2`, `email_id`, `client_status`, `client_type`, `company_name`, `fk_company_id`, `fk_branch_id`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(60, 'client-60', 'Mahee Fabrics', NULL, '2/18', NULL, NULL, NULL, 1, 0, 'Daily Sales', 1, 2, 4, NULL, '2018-01-30 19:10:22', '2018-01-30 19:10:22', NULL),
(61, 'client-61', 'M F', '01918201201', 'Shop # 2/18 ,Level-3,Eastern Plus Shopping Complex,\r\n145, Shantinagar,Dhaka.', NULL, NULL, NULL, 1, 0, 'Cash Memo', 1, 2, 4, 4, '2018-01-30 19:15:55', '2018-02-05 15:47:25', NULL),
(64, 'client-64', 'All Amin', '01717636550', 'Borishal', NULL, NULL, NULL, 1, 0, 'Bornomala', 1, 2, 4, NULL, '2018-02-03 15:14:22', '2018-02-03 15:14:22', NULL),
(65, 'client-65', 'Shoi Shota', NULL, 'Naraongong', NULL, NULL, NULL, 1, 0, 'Shoi Shota', 1, 2, 4, 4, '2018-02-03 16:16:24', '2018-02-03 17:12:11', NULL),
(66, 'client-66', 'MR. RIPON', '01730732291', 'Basundhara City', NULL, NULL, NULL, 1, 0, 'THE LOCAL', 1, 2, 4, 4, '2018-02-03 17:07:26', '2018-02-05 15:50:12', NULL),
(68, 'client-67', 'Rehena Apa', '01920333004', 'Mirpur', NULL, NULL, NULL, 1, 0, 'Rehena Apa', 1, 2, 4, 4, '2018-02-04 10:06:04', '2018-02-05 15:49:48', NULL),
(69, 'client-69', 'Mouri', '01681795690', NULL, NULL, NULL, NULL, 1, 0, 'Hijab Is Touch', 1, 2, 4, NULL, '2018-02-04 12:12:14', '2018-02-04 12:12:14', NULL),
(71, 'client-70', 'Rafiqul Islam Mahee', NULL, 'Shop # 1/27 ,Level-2,Eastern Plus Shopping Complex,\r\n145, Shantinagar,Dhaka.', NULL, NULL, NULL, 1, 0, 'Mahee Lifestyle', 1, 2, 4, 4, '2018-02-05 15:37:43', '2018-02-05 15:48:35', NULL),
(72, 'client-72', 'Sadman Islam Dehan', NULL, 'Shop # 1/19-20 ,Level-2,\r\nEastern Plus Shopping Complex,\r\n145, Shantinagar,Dhaka.', NULL, NULL, NULL, 1, 0, 'Dehan Lifestyle', 1, 2, 4, 4, '2018-02-05 15:42:12', '2018-02-05 17:19:03', NULL),
(73, 'client-73', 'F F House', '01784662229', 'Danmondi', NULL, NULL, NULL, 1, 0, 'F F House', 1, 2, 4, NULL, '2018-02-06 14:13:06', '2018-02-06 14:13:06', NULL),
(74, 'client-74', 'M. Asaduzzaman BABU', '01712606043', 'Shop # 123(GF) Piot-17 Road-7\r\nOrchard Point, Dhanmondi.', NULL, NULL, NULL, 1, 0, 'Ayan Eyan Boutiques', 1, 2, 4, 4, '2018-02-06 14:43:04', '2018-02-09 14:28:52', NULL),
(75, 'client-75', 'MISS. MUNA', '01917251979', 'Mirpur 11', NULL, NULL, NULL, 1, 0, 'Muna Boutique', 1, 2, 4, 4, '2018-02-06 14:50:43', '2018-02-06 15:01:58', NULL),
(76, 'client-76', 'MR. Mostofa', '01742383764', 'Woari', NULL, NULL, NULL, 1, 0, 'Mostofa', 1, 2, 4, 4, '2018-02-06 15:37:02', '2018-02-06 15:49:24', NULL),
(77, 'client-77', 'Nazma Zaman', '01731802974 ,01635411445', 'Shop #151-152(1st)  Raifeal Squer, Danmondi', NULL, NULL, NULL, 1, 0, 'G & B', 1, 2, 4, 4, '2018-02-06 16:14:21', '2018-02-10 18:58:35', NULL),
(78, 'client-78', 'MR. Lokman Hossain Akash', '01713273680', 'Tangail', NULL, NULL, NULL, 1, 0, 'Lotaal', 1, 2, 4, NULL, '2018-02-06 18:39:08', '2018-02-06 18:39:08', NULL),
(79, 'client-79', 'Akter', NULL, 'Mirpur', NULL, NULL, NULL, 1, 0, 'Akter', 1, 2, 4, NULL, '2018-02-07 11:21:28', '2018-02-07 11:21:28', NULL),
(80, 'client-80', 'Imdadul Haq', NULL, 'Cox-Bazar', NULL, NULL, NULL, 1, 0, 'Imdadul', 1, 2, 4, NULL, '2018-02-07 11:44:25', '2018-02-07 11:44:25', NULL),
(81, 'client-81', 'Reshma', '01676733883', NULL, NULL, NULL, NULL, 1, 0, 'Reshma  Boutique', 1, 2, 4, NULL, '2018-02-07 12:48:32', '2018-02-07 12:48:32', NULL),
(82, 'client-82', 'mama', '01725686824', 'Jhenaidah', NULL, NULL, NULL, 1, 0, 'Three pics House', 1, 2, 4, NULL, '2018-02-07 15:43:16', '2018-02-07 15:43:16', NULL),
(83, 'client-83', 'MR. RIMON', '01760200060', 'K.S.R.Plaza, Mojid Saroni,Khulna-9000', NULL, NULL, NULL, 1, 0, 'Ladys Choice', 1, 2, 4, 4, '2018-02-09 12:04:48', '2018-02-09 14:32:59', NULL),
(84, 'client-84', 'Ima apa', NULL, 'Badda', NULL, NULL, NULL, 1, 0, 'Ima Boutique', 1, 2, 4, NULL, '2018-02-09 15:11:41', '2018-02-09 15:11:41', NULL),
(85, 'client-85', 'Salman', '01979003320', 'Younusco City Center, Chottagong', NULL, NULL, NULL, 1, 0, 'SALMAN\"S', 1, 2, 4, NULL, '2018-02-09 16:31:26', '2018-02-09 16:31:26', NULL),
(86, 'client-86', 'Tuba', '01625195479', NULL, NULL, NULL, NULL, 1, 0, 'Tuba', 1, 2, 4, NULL, '2018-02-10 11:11:26', '2018-02-10 11:11:26', NULL),
(87, 'client-87', 'Rashida', '01751797604', 'Shatarkol', NULL, NULL, NULL, 1, 0, 'Rashida', 1, 2, 4, NULL, '2018-02-13 10:58:45', '2018-02-13 10:58:45', NULL),
(88, 'client-88', 'Babul / Man Power', '01715279334', NULL, NULL, NULL, NULL, 1, 0, 'Babul / Man Power', 1, 2, 4, NULL, '2018-02-13 11:01:19', '2018-02-13 11:01:19', NULL),
(89, 'client-89', 'Monir / Asif', NULL, 'Eastern plus', NULL, NULL, NULL, 1, 0, 'Monir / Asif', 1, 2, 4, NULL, '2018-02-13 11:04:16', '2018-02-13 11:04:16', NULL),
(90, 'client-90', 'Falgoni apa', '01534896110', 'Shantinagar', NULL, NULL, NULL, 1, 0, 'Falgoni apa', 1, 2, 4, NULL, '2018-02-13 11:05:39', '2018-02-13 11:05:39', NULL),
(91, 'client-91', 'Mami / Shanta', '01700871993', 'Gouronagar', NULL, NULL, NULL, 1, 0, 'Mami / Shanta', 1, 2, 4, NULL, '2018-02-13 11:07:15', '2018-02-13 11:07:15', NULL),
(92, 'client-92', 'Shoma apa', '01819458635-01920984299', 'Naraongong', NULL, NULL, NULL, 1, 0, 'Shoma apa', 1, 2, 4, 4, '2018-02-13 11:11:51', '2018-02-13 11:14:04', NULL),
(93, 'client-93', 'Mami. Ripon', '01931351068', 'Gouronagar', NULL, NULL, NULL, 1, 0, 'Mami. Ripon', 1, 2, 4, NULL, '2018-02-13 15:25:49', '2018-02-13 15:25:49', NULL),
(94, 'client-94', 'Hamid Kaka', '01916579595', 'Goran', NULL, NULL, NULL, 1, 0, 'Hamid Kaka', 1, 2, 4, 4, '2018-02-13 15:27:38', '2018-02-14 11:55:33', NULL),
(95, 'client-95', 'Sonya, Araf', '01679234397', NULL, NULL, NULL, NULL, 1, 0, 'Sonya, Araf', 1, 2, 4, NULL, '2018-02-13 15:29:53', '2018-02-13 15:29:53', NULL),
(96, 'client-96', 'MD : Poran', '01819455330', '6-Bafwwa shopping complex. cantonment,Dhaka', NULL, NULL, NULL, 1, 0, 'Dignity', 1, 2, 4, 4, '2018-02-13 15:37:21', '2018-02-14 11:49:51', NULL),
(97, 'client-97', 'Khadija apa. Johir', '01951712376', NULL, NULL, NULL, NULL, 1, 0, 'Khadija apa. Johir', 1, 2, 4, NULL, '2018-02-13 15:38:57', '2018-02-13 15:38:57', NULL),
(98, 'client-98', 'Babul bai, Asif', '01747596370', 'Eastarn plus', NULL, NULL, NULL, 1, 0, 'Babul bai, Asif', 1, 2, 4, NULL, '2018-02-13 15:40:57', '2018-02-13 15:40:57', NULL),
(99, 'client-99', 'Shirin Apa. Ideal', NULL, 'Ideal', NULL, NULL, NULL, 1, 0, 'Shirin Apa. Ideal', 1, 2, 4, NULL, '2018-02-13 15:45:22', '2018-02-13 15:45:22', NULL),
(100, 'client-100', 'Fatema Aunty', NULL, 'Shantinagar', NULL, NULL, NULL, 1, 0, 'Fatema Aunty', 1, 2, 5, NULL, '2018-02-16 18:05:33', '2018-02-16 18:05:33', NULL),
(101, 'client-101', 'Vabi Ismail', '01714234643', 'Shantinagar', NULL, NULL, NULL, 1, 0, 'Vabi Ismail', 1, 2, 5, NULL, '2018-02-16 19:03:02', '2018-02-16 19:03:02', NULL),
(102, 'client-102', 'Shiuli apa', NULL, 'Khilgaon', NULL, NULL, NULL, 1, 0, 'Shiuli apa', 1, 2, 5, NULL, '2018-02-16 19:20:43', '2018-02-16 19:20:43', NULL),
(103, 'client-103', 'Jenifar apa', '01920720344', 'Khigaon', NULL, NULL, NULL, 1, 0, 'Jenifar apa', 1, 2, 5, NULL, '2018-02-16 19:50:59', '2018-02-16 19:50:59', NULL),
(104, 'client-104', 'Muna / Green road', '01720584427', 'Green road', NULL, NULL, NULL, 1, 0, 'Muna / Green road', 1, 2, 5, NULL, '2018-02-16 20:40:39', '2018-02-16 20:40:39', NULL),
(105, 'client-105', 'Shovan', '01712009508', 'Rangpur', NULL, NULL, NULL, 1, 0, 'Out Look', 1, 2, 3, NULL, '2018-02-17 22:50:33', '2018-02-17 22:50:33', NULL),
(106, 'client-106', 'Atiq vai / Ideal', '01976790502', 'Rampura', NULL, NULL, NULL, 1, 0, 'Atiq vai / Ideal', 1, 2, 5, NULL, '2018-02-18 21:38:21', '2018-02-18 21:38:21', NULL),
(107, 'client-107', 'Shahadat vai', '01815281520', 'Pink city', NULL, NULL, NULL, 1, 0, 'Shahadat vai', 1, 2, 5, NULL, '2018-02-18 21:52:43', '2018-02-18 21:52:43', NULL),
(108, 'client-108', 'Vabi.Jahir vai', '01913383212', 'Trimohony', NULL, NULL, NULL, 1, 0, 'Vabi.Jahir vai', 1, 2, 5, NULL, '2018-02-18 22:18:10', '2018-02-18 22:18:10', NULL),
(109, 'client-109', 'Soheli apa', '01826688227', 'Shantinagar', NULL, NULL, NULL, 1, 0, 'Soheli apa', 1, 2, 5, NULL, '2018-02-18 22:47:18', '2018-02-18 22:47:18', NULL),
(110, 'client-110', 'Muna apa. E.plus', NULL, '2/20 Estarn plus', NULL, NULL, NULL, 1, 0, 'Muna apa. E.plus', 1, 2, 5, NULL, '2018-02-18 22:54:41', '2018-02-18 22:54:41', NULL),
(111, 'client-111', 'Vabi. Bengal tower', '01703184945', 'Shantinagar', NULL, NULL, NULL, 1, 0, 'Vabi. Bengal tower', 1, 2, 5, NULL, '2018-02-18 22:59:37', '2018-02-18 22:59:37', NULL),
(112, 'client-112', 'Tuhina vabi', NULL, 'Shantinagar', NULL, NULL, NULL, 1, 0, 'Tuhina vabi', 1, 2, 5, NULL, '2018-02-18 23:02:57', '2018-02-18 23:02:57', NULL),
(113, 'client-113', 'AD: Nazrul', '01711464108', 'Goran', NULL, NULL, NULL, 1, 0, 'AD: Nazrul', 1, 2, 5, NULL, '2018-02-18 23:27:06', '2018-02-18 23:27:06', NULL),
(114, 'client-114', 'Shahnewaj apa', NULL, 'Shantinagar', NULL, NULL, NULL, 1, 0, 'Shahnewaj apa', 1, 2, 5, NULL, '2018-02-18 23:31:21', '2018-02-18 23:31:21', NULL),
(115, 'client-115', 'Miss: Nargish', '01712161969', 'Sector # 6, Uttara', NULL, NULL, NULL, 1, 0, 'Alif Fashion', 1, 2, 3, NULL, '2018-02-19 23:23:20', '2018-02-19 23:23:20', NULL),
(116, 'client-116', 'Dehan', NULL, '1/19-20 E P', NULL, NULL, NULL, 1, 0, 'D Cash Mamo', 1, 4, 7, NULL, '2018-02-25 00:07:37', '2018-02-25 00:07:37', NULL),
(117, 'client-117', 'Sadia DNCC', NULL, '74 DNCC Market, Gulshan.', NULL, NULL, NULL, 1, 0, 'Sadia', 1, 4, 7, NULL, '2018-02-25 21:07:44', '2018-02-25 21:07:44', NULL),
(118, 'client-118', 'Rayhen', NULL, NULL, NULL, NULL, NULL, 1, 0, 'Lady Bird', 1, 4, 7, NULL, '2018-02-25 23:08:15', '2018-02-25 23:08:15', NULL),
(119, 'client-119', 'Dehan', NULL, NULL, NULL, NULL, NULL, 1, 0, 'D Cash Sales', 1, 4, 7, NULL, '2018-02-26 22:58:13', '2018-02-26 22:58:13', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `inventory_item`
--

CREATE TABLE `inventory_item` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_inventory_id` int(10) UNSIGNED NOT NULL,
  `qty` float NOT NULL,
  `available_qty` float DEFAULT NULL,
  `cost_per_unit` float DEFAULT NULL,
  `sales_per_unit` float DEFAULT NULL,
  `brach_no` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'b-productID-serial-branch-company',
  `type` tinyint(4) NOT NULL DEFAULT 2 COMMENT '1=Opening, 0=Damage, 2=New Added',
  `fk_branch_id` int(11) UNSIGNED NOT NULL DEFAULT 1,
  `fk_company_id` int(11) UNSIGNED DEFAULT NULL,
  `summary` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_item`
--

INSERT INTO `inventory_item` (`id`, `fk_inventory_id`, `qty`, `available_qty`, `cost_per_unit`, `sales_per_unit`, `brach_no`, `type`, `fk_branch_id`, `fk_company_id`, `summary`, `created_at`, `updated_at`) VALUES
(33, 31, 1900, 0, 100, NULL, 'B-27-1-2-1-31', 1, 2, 1, NULL, '2018-01-29 18:00:16', '2018-02-10 15:31:43'),
(34, 32, 20, 0, 1000, NULL, 'B-28-1-2-1-32', 1, 2, 1, NULL, '2018-01-30 14:11:41', '2018-02-04 11:19:36'),
(35, 33, 3, 0, 1000, NULL, 'B-28-1-2-1-33', 1, 2, 1, NULL, '2018-01-30 14:11:41', '2018-02-03 17:32:04'),
(36, 32, 100, 0, 975, NULL, 'B-28-2-2-1-32', 1, 2, 1, NULL, '2018-01-30 14:29:30', '2018-02-06 12:45:52'),
(37, 34, 96, 0, 1100, NULL, 'B-28-1-2-1-34', 1, 2, 1, NULL, '2018-01-30 14:29:30', '2018-02-06 16:34:30'),
(38, 35, 129, 5, 1025, NULL, 'B-28-1-2-1-35', 1, 2, 1, NULL, '2018-01-30 14:29:30', '2018-02-11 15:11:02'),
(39, 36, 92, 0, 600, NULL, 'B-28-1-2-1-36', 1, 2, 1, NULL, '2018-01-30 14:29:30', '2018-02-07 13:41:32'),
(40, 37, 35, 0, 665, NULL, 'B-28-1-2-1-37', 1, 2, 1, NULL, '2018-01-30 14:29:30', '2018-02-12 16:20:17'),
(41, 38, 25, 0, 520, NULL, 'B-28-1-2-1-38', 1, 2, 1, NULL, '2018-01-30 14:29:30', '2018-02-03 17:32:04'),
(42, 39, 66, 0, 520, NULL, 'B-28-1-2-1-39', 1, 2, 1, NULL, '2018-01-30 14:29:30', '2018-02-06 17:07:18'),
(43, 40, 25, 0, 570, NULL, 'B-30-1-2-1-40', 1, 2, 1, NULL, '2018-01-30 14:29:30', '2018-02-07 13:41:32'),
(44, 41, 200, 0, 250, NULL, 'B-39-1-2-1-41', 1, 2, 1, NULL, '2018-01-30 14:29:30', '2018-02-06 15:47:30'),
(45, 42, 3, 0, 1400, NULL, 'B-34-1-2-1-42', 1, 2, 1, NULL, '2018-01-30 14:39:40', '2018-02-11 11:49:55'),
(46, 42, 6, 0, 1200, NULL, 'B-34-2-2-1-42', 1, 2, 1, NULL, '2018-01-30 14:39:40', '2018-02-11 15:47:27'),
(47, 42, 3, 0, 1250, NULL, 'B-34-3-2-1-42', 1, 2, 1, NULL, '2018-01-30 14:39:40', '2018-02-11 19:58:04'),
(48, 43, 10, 0, 700, NULL, 'B-37-1-2-1-43', 1, 2, 1, NULL, '2018-01-30 14:46:42', '2018-02-09 11:50:57'),
(49, 44, 9, 0, 900, NULL, 'B-38-1-2-1-44', 1, 2, 1, NULL, '2018-01-30 14:46:42', '2018-02-05 19:11:08'),
(50, 44, 2, 0, 930, NULL, 'B-38-2-2-1-44', 1, 2, 1, NULL, '2018-01-30 14:46:42', '2018-02-05 19:11:08'),
(51, 43, 27, 0, 720, NULL, 'B-37-2-2-1-43', 1, 2, 1, NULL, '2018-01-30 14:49:10', '2018-02-11 11:49:55'),
(52, 45, 27, 0, 1250, NULL, 'B-35-1-2-1-45', 1, 2, 1, NULL, '2018-01-30 14:55:28', '2018-02-12 16:20:17'),
(53, 46, 2, 0, 950, NULL, 'B-35-1-2-1-31', 1, 2, 1, NULL, '2018-01-30 14:55:28', '2018-02-07 15:48:19'),
(54, 47, 72, 8, 2700, NULL, 'B-49-1-2-1-46', 1, 2, 1, NULL, '2018-01-30 15:20:20', '2018-02-18 23:16:17'),
(55, 36, 20, 2, 600, NULL, 'B-28-2-2-1-36', 1, 2, 1, NULL, '2018-01-30 15:30:14', '2018-02-24 17:10:49'),
(56, 33, 78, 0, 950, NULL, 'B-28-2-2-1-33', 1, 2, 1, NULL, '2018-01-30 15:30:14', '2018-02-04 10:06:04'),
(57, 32, 320, 0, 850, NULL, 'B-28-3-2-1-32', 1, 2, 1, NULL, '2018-01-30 15:30:14', '2018-02-06 12:45:52'),
(58, 34, 50, 0, 950, NULL, 'B-28-2-2-1-34', 1, 2, 1, NULL, '2018-01-30 15:30:14', '2018-02-07 15:31:03'),
(59, 42, 9, 0, 1200, 0, 'B-34-4-2-1-42', 1, 2, 1, NULL, '2018-01-30 15:39:45', '2018-03-21 06:43:58'),
(60, 42, 5, 3, 1400, 0, 'B-34-5-2-1-42', 1, 2, 1, NULL, '2018-01-30 15:39:45', '2018-03-21 06:43:58'),
(61, 48, 32, 0, 1650, NULL, 'B-49-1-2-1-31', 1, 2, 1, NULL, '2018-01-30 15:43:48', '2018-02-05 19:11:08'),
(62, 48, 84, 8, 1600, NULL, 'B-49-2-2-1-31', 1, 2, 1, NULL, '2018-01-30 15:49:11', '2018-02-18 21:32:25'),
(63, 44, 66, 0, 1250, NULL, 'B-38-3-2-1-44', 1, 2, 1, NULL, '2018-01-30 15:49:11', '2018-02-06 16:34:30'),
(64, 44, 80, 0, 1200, NULL, 'B-38-4-2-1-44', 1, 2, 1, NULL, '2018-01-30 15:49:11', '2018-02-11 15:11:02'),
(65, 39, 100, 0, 400, NULL, 'B-28-2-2-1-39', 1, 2, 1, NULL, '2018-01-30 16:00:37', '2018-02-18 22:32:18'),
(66, 49, 179, 0, 500, NULL, 'B-31-1-2-1-47', 1, 2, 1, NULL, '2018-01-30 16:00:37', '2018-02-05 17:11:32'),
(67, 50, 122, 29, 450, NULL, 'B-30-1-2-1-48', 1, 2, 1, NULL, '2018-01-30 16:00:37', '2018-02-09 14:43:44'),
(68, 33, 100, 0, 1100, NULL, 'B-28-3-2-1-33', 1, 2, 1, NULL, '2018-01-30 16:00:37', '2018-02-05 14:25:45'),
(69, 40, 40, 31, 500, NULL, 'B-30-2-2-1-40', 1, 2, 1, NULL, '2018-01-30 16:15:30', '2018-02-12 16:20:17'),
(70, 51, 10, 0, 1800, NULL, 'B-45-1-2-1-49', 1, 2, 1, NULL, '2018-01-30 16:15:30', '2018-02-07 17:22:45'),
(71, 52, 25, 0, 1050, NULL, 'B-45-1-2-1-50', 1, 2, 1, NULL, '2018-01-30 16:15:30', '2018-02-05 17:11:32'),
(72, 33, 210, 0, 1000, NULL, 'B-28-4-2-1-33', 1, 2, 1, NULL, '2018-01-30 16:15:30', '2018-02-09 14:54:14'),
(73, 32, 300, 0, 1000, NULL, 'B-28-4-2-1-32', 1, 2, 1, NULL, '2018-01-30 16:15:30', '2018-02-07 15:48:19'),
(74, 34, 150, 0, 1100, NULL, 'B-28-3-2-1-34', 1, 2, 1, NULL, '2018-01-30 16:15:30', '2018-02-07 17:22:45'),
(75, 53, 5, 0, 750, NULL, 'B-29-1-2-1-51', 1, 2, 1, NULL, '2018-01-30 16:28:49', '2018-02-05 17:11:32'),
(76, 54, 3, 0, 900, NULL, 'B-42-1-2-1-52', 1, 2, 1, NULL, '2018-01-30 16:28:49', '2018-02-05 17:11:32'),
(77, 55, 8, 0, 1000, NULL, 'B-29-1-2-1-53', 1, 2, 1, NULL, '2018-01-30 16:28:49', '2018-02-12 12:12:22'),
(78, 56, 19, 0, 950, NULL, 'B-32-1-2-1-54', 1, 2, 1, NULL, '2018-01-30 16:28:49', '2018-02-05 17:11:32'),
(79, 57, 24, 0, 550, NULL, 'B-50-1-2-1-55', 1, 2, 1, NULL, '2018-01-30 16:36:58', '2018-02-07 17:22:45'),
(80, 58, 342, 0, 300, NULL, 'B-50-1-2-1-56', 1, 2, 1, NULL, '2018-01-30 16:36:58', '2018-02-07 17:22:45'),
(81, 53, 149, 0, 700, NULL, 'B-29-2-2-1-51', 1, 2, 1, NULL, '2018-01-30 16:36:58', '2018-02-09 14:43:44'),
(82, 59, 80, 0, 450, NULL, 'B-42-1-2-1-57', 1, 2, 1, NULL, '2018-01-30 16:36:58', '2018-02-09 15:34:39'),
(83, 56, 130, 46, 1000, NULL, 'B-32-2-2-1-54', 1, 2, 1, NULL, '2018-01-30 16:36:58', '2018-02-24 16:31:11'),
(84, 60, 547, 0, 600, NULL, 'B-32-1-2-1-58', 1, 2, 1, NULL, '2018-01-30 16:36:58', '2018-02-12 16:20:17'),
(85, 61, 42, 0, 1250, NULL, 'B-35-1-2-1-59', 1, 2, 1, NULL, '2018-01-30 16:42:36', '2018-02-12 12:12:22'),
(86, 33, 130, 0, 1000, NULL, 'B-28-5-2-1-33', 1, 2, 1, NULL, '2018-01-30 16:45:50', '2018-02-24 17:10:49'),
(87, 32, 559, 0, 900, NULL, 'B-28-5-2-1-32', 1, 2, 1, NULL, '2018-01-30 16:45:50', '2018-02-12 11:20:43'),
(88, 62, 72, 0, 50, 0, 'B-51-1-2-1-60', 1, 2, 1, NULL, '2018-01-30 17:35:54', '2018-02-06 12:45:52'),
(89, 62, 88, 0, 40, 0, 'B-51-2-2-1-60', 1, 2, 1, NULL, '2018-01-30 17:35:54', '2018-02-06 17:07:18'),
(90, 62, 112, 0, 25, 0, 'B-51-3-2-1-60', 1, 2, 1, NULL, '2018-01-30 17:35:54', '2018-02-11 11:49:55'),
(91, 63, 300, 57, 17, 0, 'B-51-1-2-1-61', 1, 2, 1, NULL, '2018-01-30 17:35:54', '2018-02-12 16:20:17'),
(92, 63, 50, 50, 22, 0, 'B-51-2-2-1-61', 1, 2, 1, NULL, '2018-01-30 17:35:54', '2018-01-30 17:42:40'),
(93, 64, 348, 12, 10, 0, 'B-51-1-2-1-62', 1, 2, 1, NULL, '2018-01-30 17:35:54', '2018-02-12 16:20:17'),
(94, 65, 16, 0, 50, 0, 'B-51-1-2-1-63', 1, 2, 1, NULL, '2018-01-30 17:35:54', '2018-02-09 15:24:42'),
(95, 66, 10, 0, 30, 0, 'B-48-1-2-1-64', 1, 2, 1, NULL, '2018-01-30 17:35:54', '2018-02-05 17:11:32'),
(96, 52, 1, 0, 1000, 0, 'B-45-2-2-1-50', 1, 2, 1, NULL, '2018-01-30 17:35:54', '2018-02-05 17:11:32'),
(97, 67, 2, 0, 200, 0, 'B-27-1-2-1-65', 1, 2, 1, NULL, '2018-01-30 17:35:54', '2018-02-19 23:37:29'),
(98, 68, 200, 115, 300, NULL, 'B-27-1-2-1-66', 1, 2, 1, NULL, '2018-01-30 18:22:17', '2018-02-23 21:29:08'),
(99, 69, 200, 0, 175, NULL, 'B-27-1-2-1-67', 1, 2, 1, NULL, '2018-01-30 18:22:17', '2018-02-17 21:13:57'),
(100, 70, 780, 198, 200, NULL, 'B-27-1-2-1-68', 1, 2, 1, NULL, '2018-01-30 18:22:17', '2018-03-05 17:03:42'),
(101, 71, 80, 15, 150, NULL, 'B-27-1-2-1-69', 1, 2, 1, NULL, '2018-01-30 18:22:17', '2018-03-05 16:12:53'),
(102, 72, 900, 0, 175, NULL, 'B-27-1-2-1-70', 1, 2, 1, NULL, '2018-01-30 18:22:17', '2018-02-10 15:31:43'),
(103, 73, 300, 97, 250, NULL, 'B-27-1-2-1-71', 1, 2, 1, NULL, '2018-01-30 18:22:17', '2018-03-05 16:22:53'),
(104, 74, 2147, 1455, 90, NULL, 'B-27-1-2-1-72', 1, 2, 1, NULL, '2018-01-30 18:22:17', '2018-03-05 16:57:45'),
(105, 75, 300, 0, 300, NULL, 'B-44-1-2-1-73', 1, 2, 1, NULL, '2018-01-30 18:22:17', '2018-02-12 12:12:22'),
(106, 76, 49, 0, 1200, NULL, 'B-44-1-2-1-74', 1, 2, 1, NULL, '2018-01-30 18:22:17', '2018-02-12 16:20:17'),
(107, 77, 140, 0, 550, NULL, 'B-44-1-2-1-75', 1, 2, 1, NULL, '2018-01-30 18:22:17', '2018-02-09 15:24:42'),
(108, 41, 120, 0, 250, NULL, 'B-39-2-2-1-41', 1, 2, 1, NULL, '2018-01-30 18:22:17', '2018-02-07 17:22:45'),
(109, 78, 350, 0, 275, NULL, 'B-39-1-2-1-76', 1, 2, 1, NULL, '2018-01-30 18:22:17', '2018-02-05 17:11:32'),
(110, 79, 520, 0, 325, NULL, 'B-43-1-2-1-77', 1, 2, 1, NULL, '2018-01-30 18:22:17', '2018-02-07 15:48:19'),
(111, 80, 390, 96, 250, NULL, 'B-43-1-2-1-78', 1, 2, 1, NULL, '2018-01-30 18:22:17', '2018-02-10 10:40:58'),
(112, 41, 200, 61, 175, NULL, 'B-39-3-2-1-41', 1, 2, 1, NULL, '2018-01-30 18:22:17', '2018-03-05 16:32:20'),
(113, 81, 540, 0, 215, NULL, 'B-27-1-2-1-79', 1, 2, 1, NULL, '2018-01-30 18:22:17', '2018-02-05 17:11:32'),
(114, 82, 241, 33, 300, NULL, 'B-33-1-2-1-80', 1, 2, 1, NULL, '2018-01-30 18:41:15', '2018-03-05 16:29:50'),
(115, 42, 8, 8, 750, NULL, 'B-34-6-2-1-42', 1, 2, 1, NULL, '2018-01-30 18:41:15', '2018-01-30 18:41:15'),
(116, 83, 40, 0, 1700, 0, 'B-40-1-2-1-81', 1, 2, 1, NULL, '2018-01-30 18:48:29', '2018-02-05 19:11:08'),
(117, 84, 10, 0, 3100, NULL, 'B-73-1-2-1-82', 1, 2, 1, NULL, '2018-01-31 12:10:55', '2018-02-06 15:00:32'),
(118, 85, 20, 0, 1250, NULL, 'B-40-1-2-1-83', 1, 2, 1, NULL, '2018-01-31 12:10:55', '2018-02-05 19:11:08'),
(119, 86, 27, 0, 1650, NULL, 'B-40-1-2-1-37', 1, 2, 1, NULL, '2018-01-31 12:10:55', '2018-02-09 13:11:54'),
(120, 87, 9, 0, 3483, NULL, 'B-40-1-2-1-45', 1, 2, 1, NULL, '2018-01-31 12:10:55', '2018-02-12 16:20:17'),
(121, 88, 45, 0, 1480, 0, 'B-67-1-2-1-84', 1, 2, 1, NULL, '2018-01-31 12:23:34', '2018-02-17 21:20:00'),
(122, 89, 22, 0, 1900, 0, 'B-67-1-2-1-85', 1, 2, 1, NULL, '2018-01-31 12:23:34', '2018-02-06 15:47:30'),
(123, 90, 8, 0, 2000, 0, 'B-67-1-2-1-86', 1, 2, 1, NULL, '2018-01-31 12:23:34', '2018-02-05 19:11:08'),
(124, 91, 8, 0, 2700, 0, 'B-67-1-2-1-87', 1, 2, 1, NULL, '2018-01-31 12:23:34', '2018-02-11 19:58:04'),
(125, 84, 10, 0, 3100, 0, 'B-73-2-2-1-82', 1, 2, 1, NULL, '2018-01-31 12:23:34', '2018-02-11 19:58:04'),
(126, 92, 8, 0, 3037, 0, 'B-67-1-2-1-88', 1, 2, 1, NULL, '2018-01-31 12:23:34', '2018-02-12 12:12:22'),
(127, 93, 11, 0, 3400, NULL, 'B-59-1-2-1-89', 1, 2, 1, NULL, '2018-01-31 12:41:25', '2018-02-05 19:11:08'),
(128, 94, 12, 0, 3200, NULL, 'B-53-1-2-1-90', 1, 2, 1, NULL, '2018-01-31 12:41:25', '2018-02-09 11:31:46'),
(129, 95, 10, 2, 2550, NULL, 'B-58-1-2-1-91', 1, 2, 1, NULL, '2018-01-31 12:41:25', '2018-02-06 11:06:26'),
(130, 96, 9, 0, 3000, NULL, 'B-56-1-2-1-92', 1, 2, 1, NULL, '2018-01-31 12:41:25', '2018-02-12 16:20:17'),
(131, 97, 159, 0, 1050, NULL, 'B-72-1-2-1-93', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-02-05 19:11:08'),
(132, 98, 26, 2, 1954, NULL, 'B-74-1-2-1-94', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-02-12 11:20:43'),
(133, 99, 140, 43, 1100, NULL, 'B-76-1-2-1-95', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-03-05 16:48:08'),
(134, 99, 36, 36, 1250, NULL, 'B-76-2-2-1-95', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(135, 99, 46, 46, 1300, NULL, 'B-76-3-2-1-95', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(136, 99, 8, 8, 1450, NULL, 'B-76-4-2-1-95', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(137, 100, 26, 19, 1500, NULL, 'B-57-1-2-1-76', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-02-12 16:20:17'),
(138, 101, 28, 0, 1700, NULL, 'B-75-1-2-1-96', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-02-05 19:11:08'),
(139, 101, 20, 0, 1800, NULL, 'B-75-2-2-1-96', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-02-05 19:11:08'),
(140, 101, 4, 0, 1400, NULL, 'B-75-3-2-1-96', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-02-05 19:11:08'),
(141, 102, 12, 0, 3250, NULL, 'B-77-1-2-1-97', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-02-05 19:11:08'),
(142, 103, 10, 0, 2950, NULL, 'B-79-1-2-1-98', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-02-05 19:11:08'),
(143, 104, 9, 0, 3000, NULL, 'B-78-1-2-1-99', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-02-05 19:11:08'),
(144, 105, 8, 0, 3000, NULL, 'B-55-1-2-1-100', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-02-06 11:06:26'),
(145, 106, 8, 0, 2850, NULL, 'B-55-1-2-1-101', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-02-05 19:11:08'),
(146, 107, 8, 0, 2850, NULL, 'B-55-1-2-1-102', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-02-05 19:11:08'),
(147, 93, 11, 0, 3000, NULL, 'B-59-2-2-1-89', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-02-05 19:11:08'),
(148, 108, 20, 3, 2850, NULL, 'B-57-1-2-1-103', 1, 2, 1, NULL, '2018-01-31 13:28:30', '2018-02-06 18:31:00'),
(149, 107, 8, 0, 3000, NULL, 'B-55-2-2-1-102', 1, 2, 1, NULL, '2018-01-31 13:49:50', '2018-02-06 11:06:26'),
(150, 85, 10, 0, 1300, NULL, 'B-40-2-2-1-83', 1, 2, 1, NULL, '2018-01-31 13:58:55', '2018-02-11 15:47:27'),
(151, 109, 7, 0, 4000, NULL, 'B-66-1-2-1-104', 1, 2, 1, NULL, '2018-01-31 13:58:55', '2018-02-05 19:11:08'),
(152, 110, 18, 6, 300, NULL, 'B-81-1-2-1-105', 1, 2, 1, NULL, '2018-01-31 13:58:55', '2018-02-12 16:20:17'),
(153, 111, 10, 0, 500, NULL, 'B-82-1-2-1-106', 1, 2, 1, NULL, '2018-01-31 13:58:55', '2018-02-23 22:33:53'),
(154, 112, 10, 0, 2600, NULL, 'B-52-1-2-1-107', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(155, 113, 12, 0, 3150, NULL, 'B-53-1-2-1-108', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-06 11:06:26'),
(156, 114, 11, 11, 1900, NULL, 'B-54-1-2-1-109', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(157, 115, 12, 0, 2500, NULL, 'B-55-1-2-1-110', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(158, 116, 6, 4, 2500, NULL, 'B-56-1-2-1-111', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-16 19:43:43'),
(159, 117, 8, 7, 3600, NULL, 'B-57-1-2-1-112', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-12 16:20:17'),
(160, 107, 8, 1, 2900, NULL, 'B-55-3-2-1-102', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-23 22:28:02'),
(161, 118, 12, 0, 3300, NULL, 'B-53-1-2-1-113', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(162, 119, 9, 7, 2700, NULL, 'B-58-1-2-1-114', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-11 19:58:04'),
(163, 120, 8, 0, 2700, NULL, 'B-55-1-2-1-115', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(164, 121, 5, 0, 2750, NULL, 'B-58-1-2-1-116', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(165, 122, 12, 0, 2800, NULL, 'B-56-1-2-1-117', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(166, 123, 8, 0, 3550, NULL, 'B-58-1-2-1-118', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(167, 124, 12, 3, 2500, NULL, 'B-53-1-2-1-119', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-23 22:28:02'),
(168, 93, 11, 0, 3400, NULL, 'B-59-3-2-1-89', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(169, 125, 7, 0, 1550, NULL, 'B-60-1-2-1-120', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(170, 126, 10, 4, 1400, NULL, 'B-61-1-2-1-121', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-24 15:58:37'),
(171, 127, 8, 0, 1750, NULL, 'B-62-1-2-1-122', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(172, 128, 8, 0, 1900, NULL, 'B-63-1-2-1-123', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(173, 129, 10, 0, 1250, NULL, 'B-64-1-2-1-124', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(174, 130, 4, 0, 3900, NULL, 'B-75-1-2-1-125', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-05 19:11:08'),
(175, 130, 2, 0, 3600, NULL, 'B-75-2-2-1-125', 1, 2, 1, NULL, '2018-01-31 14:34:13', '2018-02-11 11:49:55'),
(176, 101, 6, 0, 1750, NULL, 'B-75-4-2-1-96', 1, 2, 1, NULL, '2018-01-31 14:48:05', '2018-02-05 19:11:08'),
(177, 101, 4, 0, 1600, NULL, 'B-75-5-2-1-96', 1, 2, 1, NULL, '2018-01-31 14:48:05', '2018-02-05 19:11:08'),
(178, 101, 8, 0, 1750, NULL, 'B-75-6-2-1-96', 1, 2, 1, NULL, '2018-01-31 14:48:05', '2018-02-05 19:11:08'),
(179, 101, 5, 0, 1650, NULL, 'B-75-7-2-1-96', 1, 2, 1, NULL, '2018-01-31 14:48:05', '2018-02-05 19:11:08'),
(180, 101, 10, 0, 1250, NULL, 'B-75-8-2-1-96', 1, 2, 1, NULL, '2018-01-31 14:48:05', '2018-02-05 19:11:08'),
(181, 131, 12, 1, 1800, NULL, 'B-75-1-2-1-126', 1, 2, 1, NULL, '2018-01-31 14:48:05', '2018-02-06 16:31:48'),
(182, 132, 29, 0, 2000, NULL, 'B-40-1-2-1-127', 1, 2, 1, NULL, '2018-01-31 14:48:05', '2018-02-12 16:20:17'),
(183, 133, 24, 0, 1300, NULL, 'B-40-1-2-1-128', 1, 2, 1, NULL, '2018-01-31 14:48:05', '2018-02-05 19:11:08'),
(184, 101, 6, 0, 2450, NULL, 'B-75-9-2-1-96', 1, 2, 1, NULL, '2018-01-31 15:00:24', '2018-02-05 19:11:08'),
(185, 101, 4, 0, 2300, NULL, 'B-75-10-2-1-96', 1, 2, 1, NULL, '2018-01-31 15:00:24', '2018-02-05 19:11:08'),
(186, 101, 2, 0, 2200, NULL, 'B-75-11-2-1-96', 1, 2, 1, NULL, '2018-01-31 15:00:24', '2018-02-05 19:11:08'),
(187, 134, 56, 22, 2900, NULL, 'B-75-1-2-1-129', 1, 2, 1, NULL, '2018-01-31 15:00:24', '2018-02-24 16:13:26'),
(188, 101, 16, 0, 1900, NULL, 'B-75-12-2-1-96', 1, 2, 1, NULL, '2018-01-31 15:00:24', '2018-02-05 19:11:08'),
(189, 101, 4, 0, 1850, NULL, 'B-75-13-2-1-96', 1, 2, 1, NULL, '2018-01-31 15:00:24', '2018-02-05 19:11:08'),
(190, 101, 16, 0, 1850, NULL, 'B-75-14-2-1-96', 1, 2, 1, NULL, '2018-01-31 15:00:24', '2018-02-05 19:11:08'),
(191, 101, 4, 0, 1900, NULL, 'B-75-15-2-1-96', 1, 2, 1, NULL, '2018-01-31 15:00:24', '2018-02-05 19:11:08'),
(192, 101, 8, 0, 1700, NULL, 'B-75-16-2-1-96', 1, 2, 1, NULL, '2018-01-31 15:00:24', '2018-02-05 19:11:08'),
(193, 101, 4, 0, 1600, NULL, 'B-75-17-2-1-96', 1, 2, 1, NULL, '2018-01-31 15:00:24', '2018-02-05 19:11:08'),
(194, 97, 144, 0, 1050, NULL, 'B-72-2-2-1-93', 1, 2, 1, NULL, '2018-01-31 15:10:04', '2018-03-04 17:06:46'),
(195, 135, 12, 0, 2100, NULL, 'B-83-1-2-1-130', 1, 2, 1, NULL, '2018-01-31 15:10:04', '2018-02-05 19:11:08'),
(196, 136, 5, 3, 1000, NULL, 'B-41-1-2-1-131', 1, 2, 1, NULL, '2018-02-04 15:56:24', '2018-02-17 21:00:27'),
(197, 137, 5, 2, 1200, NULL, 'B-41-1-2-1-132', 1, 2, 1, NULL, '2018-02-04 15:56:24', '2018-03-04 16:58:34'),
(198, 138, 5, 3, 900, NULL, 'B-41-1-2-1-133', 1, 2, 1, NULL, '2018-02-04 15:56:24', '2018-02-17 21:00:27'),
(199, 139, 6, 3, 1060, NULL, 'B-41-1-2-1-134', 1, 2, 1, NULL, '2018-02-04 15:56:24', '2018-02-17 21:00:27'),
(200, 140, 5, 2, 1150, NULL, 'B-41-1-2-1-135', 1, 2, 1, NULL, '2018-02-04 15:56:24', '2018-02-17 21:00:27'),
(201, 45, 19, 10, 1450, NULL, 'B-35-2-2-1-45', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-03-05 16:48:08'),
(202, 52, 88, 0, 1488, NULL, 'B-45-3-2-1-50', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-06 12:45:52'),
(203, 101, 6, 0, 2536, NULL, 'B-75-18-2-1-96', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-05 19:11:08'),
(204, 130, 16, 16, 2313, NULL, 'B-75-3-2-1-125', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-11 11:49:55'),
(205, 141, 53, 3, 712, NULL, 'B-84-1-2-1-136', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-18 21:29:50'),
(206, 142, 228, 98, 550, NULL, 'B-84-1-2-1-137', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-03-05 16:48:08'),
(207, 62, 262, 153, 112, NULL, 'B-51-4-2-1-60', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-03-05 17:09:19'),
(208, 66, 2302, 751, 86, NULL, 'B-48-2-2-1-64', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-03-05 16:48:08'),
(209, 143, 23, 11, 840, NULL, 'B-36-1-2-1-138', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-12 16:20:17'),
(210, 48, 11, 11, 1728, NULL, 'B-49-3-2-1-31', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(211, 43, 43, 14, 712, NULL, 'B-37-3-2-1-43', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-03-05 16:29:50'),
(212, 44, 136, 73, 1035, NULL, 'B-38-5-2-1-44', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-03-05 16:12:53'),
(213, 144, 15, 9, 750, NULL, 'B-41-1-2-1-31', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-11 11:49:55'),
(214, 87, 6, 6, 2100, NULL, 'B-40-2-2-1-45', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-12 16:20:17'),
(215, 145, 23, 0, 130, NULL, 'B-85-1-2-1-139', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-09 11:56:58'),
(216, 49, 334, 212, 317, NULL, 'B-31-2-2-1-47', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-16 20:24:55'),
(217, 60, 231, 217, 664, NULL, 'B-32-2-2-1-58', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-03-05 16:48:08'),
(218, 97, 19, 0, 1350, NULL, 'B-72-3-2-1-93', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-03-04 17:06:46'),
(219, 31, 3348, 718, 160, NULL, 'B-27-2-2-1-31', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-04-01 05:14:14'),
(220, 72, 1268, 341, 226, NULL, 'B-27-2-2-1-70', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-03-05 16:32:20'),
(221, 78, 1638, 611, 314, NULL, 'B-39-2-2-1-76', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-03-05 16:57:45'),
(222, 79, 1261, 662, 410, NULL, 'B-43-2-2-1-77', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-03-05 16:48:08'),
(223, 77, 77, 3, 600, NULL, 'B-44-2-2-1-75', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-18 22:39:07'),
(224, 75, 111, 42, 322, NULL, 'B-44-2-2-1-73', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-23 22:33:53'),
(225, 53, 86, 29, 620, NULL, 'B-29-3-2-1-51', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-24 16:43:57'),
(226, 146, 159, 48, 230, NULL, 'B-86-1-2-1-140', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-24 17:10:49'),
(227, 32, 251, 148, 1120, NULL, 'B-28-6-2-1-32', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-03-05 17:12:09'),
(228, 54, 37, 9, 1233, NULL, 'B-42-2-2-1-52', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-17 21:13:57'),
(229, 59, 15, 5, 850, NULL, 'B-42-2-2-1-57', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-23 22:33:53'),
(230, 59, 1, 1, 1127, NULL, 'B-42-3-2-1-57', 1, 2, 1, NULL, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(231, 147, 7, 0, 1250, NULL, 'B-35-1-2-1-141', 1, 2, 1, NULL, '2018-02-05 15:21:31', '2018-02-12 15:43:33'),
(232, 81, 432, 146, 215, NULL, 'B-27-2-2-1-79', 1, 2, 1, NULL, '2018-02-05 15:29:07', '2018-03-05 17:03:42'),
(233, 52, 100, 30, 1100, NULL, 'B-45-4-2-1-50', 1, 2, 1, NULL, '2018-02-05 17:17:31', '2018-02-18 22:39:07'),
(234, 148, 5, 5, 2450, NULL, 'B-66-1-2-1-142', 1, 2, 1, NULL, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(235, 149, 12, 0, 2900, NULL, 'B-66-1-2-1-143', 1, 2, 1, NULL, '2018-02-14 12:23:03', '2018-02-17 21:20:00'),
(236, 150, 18, 8, 1950, NULL, 'B-67-1-2-1-144', 1, 2, 1, NULL, '2018-02-14 12:23:03', '2018-03-04 17:16:43'),
(237, 151, 6, 0, 3000, NULL, 'B-68-1-2-1-145', 1, 2, 1, NULL, '2018-02-14 12:23:03', '2018-02-17 21:20:00'),
(238, 152, 4, 4, 2450, NULL, 'B-69-1-2-1-146', 1, 2, 1, NULL, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(239, 153, 8, 7, 1900, NULL, 'B-70-1-2-1-147', 1, 2, 1, NULL, '2018-02-14 12:23:03', '2018-02-24 17:19:25'),
(240, 154, 12, 0, 2100, NULL, 'B-70-1-2-1-148', 1, 2, 1, NULL, '2018-02-14 12:23:03', '2018-02-17 21:20:00'),
(241, 155, 9, 0, 2250, NULL, 'B-70-1-2-1-149', 1, 2, 1, NULL, '2018-02-14 12:23:03', '2018-02-17 21:20:00'),
(242, 156, 5, 0, 2500, NULL, 'B-69-1-2-1-150', 1, 2, 1, NULL, '2018-02-14 12:23:03', '2018-02-17 21:20:00'),
(243, 157, 12, 0, 3050, NULL, 'B-66-1-2-1-151', 1, 2, 1, NULL, '2018-02-14 12:23:03', '2018-02-17 21:20:00'),
(244, 158, 6, 0, 2600, NULL, 'B-66-1-2-1-152', 1, 2, 1, NULL, '2018-02-14 12:23:03', '2018-02-17 21:20:00'),
(245, 159, 5, 0, 2700, NULL, 'B-71-1-2-1-153', 1, 2, 1, NULL, '2018-02-14 12:23:03', '2018-02-17 21:20:00'),
(246, 88, 9, 0, 1510, NULL, 'B-67-2-2-1-84', 1, 2, 1, NULL, '2018-02-14 12:23:03', '2018-02-18 23:36:07'),
(247, 160, 8, 0, 3000, NULL, 'B-55-1-4-1-100', 1, 4, 1, NULL, '2018-02-17 17:28:18', '2018-02-28 22:06:48'),
(248, 161, 8, 0, 2900, NULL, 'B-55-1-4-1-102', 1, 4, 1, NULL, '2018-02-17 17:28:18', '2018-03-03 22:24:46'),
(249, 162, 12, 4, 3150, NULL, 'B-53-1-4-1-108', 1, 4, 1, NULL, '2018-02-17 17:28:18', '2018-03-04 21:27:23'),
(250, 163, 11, 9, 3200, NULL, 'B-53-1-4-1-90', 1, 4, 1, NULL, '2018-02-17 17:28:18', '2020-10-02 14:55:43'),
(251, 164, 8, 1, 2550, NULL, 'B-58-1-4-1-91', 1, 4, 1, NULL, '2018-02-17 17:28:18', '2018-03-04 00:03:18'),
(252, 165, 110, 17, 471, NULL, 'B-44-1-4-1-75', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-03-04 21:38:58'),
(253, 166, 222, 121, 310, NULL, 'B-44-1-4-1-73', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-03-04 21:38:58'),
(254, 166, 8, 8, 200, NULL, 'B-44-2-4-1-73', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(255, 167, 570, 240, 1018, NULL, 'B-28-1-4-1-32', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-03-04 22:00:57'),
(256, 168, 23, 16, 1250, NULL, 'B-35-1-4-1-59', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-03-04 21:38:58'),
(257, 169, 8, 5, 300, NULL, 'B-81-1-4-1-154', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-03-04 21:38:58'),
(258, 170, 2, 1, 500, NULL, 'B-82-1-4-1-155', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-02-27 00:36:55'),
(259, 171, 103, 93, 200, NULL, 'B-86-1-4-1-140', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-03-04 21:27:23'),
(260, 172, 28, 18, 400, NULL, 'B-28-1-4-1-39', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-02-28 22:47:25'),
(261, 173, 39, 7, 514, NULL, 'B-42-1-4-1-57', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-03-05 00:58:33'),
(262, 174, 63, 2, 1100, NULL, 'B-45-1-4-1-50', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-03-03 22:24:46'),
(263, 175, 9, 0, 1799, NULL, 'B-45-1-4-1-49', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-02-28 22:47:25'),
(264, 176, 53, 0, 25, NULL, 'B-51-1-4-1-60', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-02-25 23:28:02'),
(265, 176, 41, 0, 40, NULL, 'B-51-2-4-1-60', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-02-25 23:28:02'),
(266, 176, 29, 6, 50, NULL, 'B-51-3-4-1-60', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-03-04 21:38:58'),
(267, 177, 150, 70, 18, NULL, 'B-51-1-4-1-61', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-03-04 21:42:03'),
(268, 178, 290, 0, 10, NULL, 'B-51-1-4-1-62', 1, 4, 1, NULL, '2018-02-17 17:45:55', '2018-03-03 22:24:46'),
(269, 179, 868, 583, 184, NULL, 'B-27-1-4-1-70', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-04 22:00:57'),
(270, 180, 628, 423, 262, NULL, 'B-39-1-4-1-156', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-04 21:38:58'),
(271, 181, 193, 61, 200, NULL, 'B-39-1-4-1-41', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(272, 182, 1610, 824, 110, NULL, 'B-27-1-4-1-31', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(273, 183, 520, 474, 90, NULL, 'B-27-1-4-1-72', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(274, 184, 430, 319, 335, NULL, 'B-43-1-4-1-77', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(275, 185, 171, 107, 250, NULL, 'B-43-1-4-1-78', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-04 21:27:23'),
(276, 184, 32, 32, 606, NULL, 'B-43-2-4-1-77', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(277, 182, 449, 449, 140, NULL, 'B-27-2-4-1-31', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(278, 186, 105, 38, 250, NULL, 'B-27-1-4-1-71', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-04 21:38:58'),
(279, 187, 202, 70, 200, NULL, 'B-27-1-4-1-68', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-04 21:38:58'),
(280, 188, 540, 370, 233, NULL, 'B-27-1-4-1-79', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(281, 189, 80, 32, 300, NULL, 'B-33-1-4-1-157', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(282, 190, 151, 85, 405, NULL, 'B-31-1-4-1-47', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-04 21:38:58'),
(283, 191, 380, 322, 600, NULL, 'B-32-1-4-1-58', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(284, 192, 75, 63, 1000, NULL, 'B-32-1-4-1-54', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-03 22:24:46'),
(285, 193, 113, 26, 700, NULL, 'B-29-1-4-1-51', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-04 21:38:58'),
(286, 194, 87, 75, 472, NULL, 'B-30-1-4-1-48', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(287, 195, 737, 626, 54, NULL, 'B-48-1-4-1-64', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-05 00:58:33'),
(288, 173, 5, 5, 800, NULL, 'B-42-2-4-1-57', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(289, 196, 7, 7, 1500, NULL, 'B-42-1-4-1-52', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(290, 197, 45, 14, 793, NULL, 'B-84-1-4-1-136', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-04 21:38:58'),
(291, 174, 16, 16, 1500, NULL, 'B-45-2-4-1-50', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(292, 174, 45, 45, 1000, NULL, 'B-45-3-4-1-50', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(293, 198, 23, 2, 1200, NULL, 'B-44-1-4-1-74', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-04 21:38:58'),
(294, 199, 11, 2, 550, NULL, 'B-84-1-4-1-137', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-03-03 22:24:46'),
(295, 199, 33, 33, 737, NULL, 'B-84-2-4-1-137', 1, 4, 1, NULL, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(296, 200, 58, 22, 1613, NULL, 'B-49-1-4-1-31', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 00:03:18'),
(297, 201, 14, 11, 2700, NULL, 'B-49-1-4-1-46', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-02-28 22:06:48'),
(298, 202, 184, 67, 1050, NULL, 'B-72-1-4-1-93', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-05 00:58:33'),
(299, 203, 73, 40, 1223, NULL, 'B-38-1-4-1-44', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 00:03:18'),
(300, 204, 7, 6, 4000, NULL, 'B-66-1-4-1-104', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:38:58'),
(301, 205, 27, 27, 2900, NULL, 'B-75-1-4-1-129', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(302, 206, 90, 47, 1726, NULL, 'B-75-1-4-1-96', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 00:03:18'),
(303, 207, 12, 11, 2100, NULL, 'B-83-1-4-1-130', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 00:03:18'),
(304, 208, 24, 7, 1300, NULL, 'B-40-1-4-1-128', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:38:58'),
(305, 209, 28, 7, 2000, NULL, 'B-40-1-4-1-127', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:38:58'),
(306, 210, 8, 1, 1800, NULL, 'B-75-1-4-1-126', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(307, 211, 4, 4, 3750, NULL, 'B-75-1-4-1-125', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(308, 212, 10, 9, 2600, NULL, 'B-52-1-4-1-107', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(309, 213, 12, 4, 2500, NULL, 'B-55-1-4-1-110', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(310, 214, 12, 9, 3300, NULL, 'B-53-1-4-1-113', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(311, 215, 8, 7, 2700, NULL, 'B-55-1-4-1-115', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(312, 216, 5, 2, 2750, NULL, 'B-58-1-4-1-116', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(313, 217, 8, 7, 3550, NULL, 'B-58-1-4-1-118', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(314, 218, 12, 10, 2800, NULL, 'B-56-1-4-1-117', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(315, 219, 11, 0, 3400, NULL, 'B-59-1-4-1-89', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-02-28 22:06:48'),
(316, 220, 7, 5, 1550, NULL, 'B-60-1-4-1-120', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 00:03:18'),
(317, 221, 8, 5, 1750, NULL, 'B-62-1-4-1-122', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(318, 222, 8, 6, 1900, NULL, 'B-63-1-4-1-158', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(319, 223, 10, 7, 1250, NULL, 'B-64-1-4-1-124', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(320, 224, 15, 0, 1700, NULL, 'B-40-1-4-1-81', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-02-28 22:47:25'),
(321, 225, 6, 0, 3100, NULL, 'B-73-1-4-1-82', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-02-25 00:38:04'),
(322, 226, 11, 1, 1295, NULL, 'B-40-1-4-1-83', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:53:46'),
(323, 224, 21, 16, 1650, NULL, 'B-40-2-4-1-81', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(324, 227, 8, 0, 2000, NULL, 'B-67-1-4-1-159', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(325, 228, 4, 0, 3050, NULL, 'B-67-1-4-1-88', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-02-28 22:47:25'),
(326, 229, 4, 1, 2700, NULL, 'B-67-1-4-1-87', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-02-28 19:03:40'),
(327, 230, 11, 6, 1900, NULL, 'B-67-1-4-1-85', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 00:03:18'),
(328, 231, 30, 0, 1500, NULL, 'B-67-1-4-1-84', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 00:03:18'),
(329, 232, 16, 9, 2850, NULL, 'B-57-1-4-1-103', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-03 22:24:46'),
(330, 233, 10, 7, 2950, NULL, 'B-79-1-4-1-98', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(331, 234, 12, 2, 3250, NULL, 'B-77-1-4-1-97', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(332, 235, 9, 2, 3000, NULL, 'B-78-1-4-1-99', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(333, 219, 22, 12, 3200, NULL, 'B-59-2-4-1-89', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:38:58'),
(334, 161, 8, 0, 2847, NULL, 'B-55-2-4-1-102', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2020-10-02 14:54:49'),
(335, 236, 8, 6, 2850, NULL, 'B-55-1-4-1-101', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-02-28 22:06:48'),
(336, 237, 18, 12, 2100, NULL, 'B-74-1-4-1-94', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:27:23'),
(337, 238, 99, 51, 1149, NULL, 'B-75-1-4-1-95', 1, 4, 1, NULL, '2018-02-17 18:56:45', '2018-03-04 21:38:58'),
(338, 173, 7, 7, 450, NULL, 'B-42-3-4-1-57', 1, 4, 1, NULL, '2018-02-17 21:51:57', '2018-02-17 21:51:57'),
(339, 179, 5, 5, 175, NULL, 'B-27-2-4-1-70', 1, 4, 1, NULL, '2018-02-17 21:51:57', '2018-02-17 21:51:57'),
(340, 185, 8, 8, 250, NULL, 'B-43-2-4-1-78', 1, 4, 1, NULL, '2018-02-17 21:51:57', '2018-02-17 21:51:57'),
(341, 239, 11, 3, 250, NULL, 'B-39-1-4-1-76', 1, 4, 1, NULL, '2018-02-17 21:51:57', '2018-02-25 21:05:02'),
(342, 240, 12, 11, 2900, NULL, 'B-66-1-4-1-143', 1, 4, 1, NULL, '2018-02-17 22:06:10', '2018-03-04 00:03:18'),
(343, 241, 8, 6, 1950, NULL, 'B-67-1-4-1-144', 1, 4, 1, NULL, '2018-02-17 22:06:10', '2018-02-27 00:36:55'),
(344, 242, 6, 5, 3000, NULL, 'B-68-1-4-1-160', 1, 4, 1, NULL, '2018-02-17 22:06:10', '2018-03-04 00:03:18'),
(345, 243, 5, 5, 2500, NULL, 'B-69-1-4-1-161', 1, 4, 1, NULL, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(346, 244, 12, 12, 2100, NULL, 'B-70-1-4-1-162', 1, 4, 1, NULL, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(347, 245, 9, 7, 2250, NULL, 'B-70-1-4-1-163', 1, 4, 1, NULL, '2018-02-17 22:06:10', '2018-03-05 00:58:33'),
(348, 246, 12, 12, 3050, NULL, 'B-66-1-4-1-151', 1, 4, 1, NULL, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(349, 247, 5, 5, 2700, NULL, 'B-71-1-4-1-164', 1, 4, 1, NULL, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(350, 248, 6, 6, 2600, NULL, 'B-66-1-4-1-152', 1, 4, 1, NULL, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(351, 231, 9, 5, 1510, NULL, 'B-67-2-4-1-84', 1, 4, 1, NULL, '2018-02-17 22:06:10', '2018-03-04 21:27:23'),
(352, 31, 181, 181, 140, 0, 'B-27-3-2-1-31', 1, 2, 1, '', '2018-02-28 20:21:43', '2018-02-28 20:21:43'),
(353, 150, 2, 2, 1950, NULL, 'B-67-2-2-1-144', 1, 2, 1, NULL, '2018-03-04 00:50:04', '2018-03-04 00:50:04'),
(354, 155, 1, 0, 2250, NULL, 'B-70-2-2-1-149', 1, 2, 1, NULL, '2018-03-04 00:50:04', '2018-03-04 17:16:43'),
(355, 97, 500, 187, 910, NULL, 'B-72-4-2-1-93', 1, 2, 1, NULL, '2018-03-04 00:50:04', '2018-03-05 17:09:19'),
(356, 249, 10, 5, 120, NULL, 'B-81-1-2-1-157', 1, 2, 1, NULL, '2018-03-04 00:53:18', '2018-03-04 16:58:34'),
(358, 251, 11, 6, 1062, NULL, 'B-41-1-4-1-166', 1, 4, 1, NULL, '2018-03-04 19:56:15', '2018-03-04 21:53:46'),
(359, 72, 98, 98, 175, 0, 'B-27-3-2-1-70', 1, 2, 1, '', '2018-03-04 22:00:57', '2018-03-04 22:00:57'),
(360, 32, 10, 10, 1018, 0, 'B-28-7-2-1-32', 1, 2, 1, '', '2018-03-04 22:00:57', '2018-03-04 22:00:57'),
(361, 187, 140, 140, 200, NULL, 'B-27-2-4-1-68', 1, 4, 1, 'M 7798-7799-7800', '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(362, 182, 20, 20, 140, NULL, 'B-27-3-4-1-31', 1, 4, 1, 'M 7798-7799-7800', '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(363, 186, 48, 48, 250, NULL, 'B-27-2-4-1-71', 1, 4, 1, 'M 7798-7799-7800', '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(364, 251, 1, 1, 1200, NULL, 'B-41-2-4-1-166', 1, 4, 1, 'M 7798-7799-7800', '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(365, 252, 5, 5, 120, NULL, 'B-81-1-4-1-157', 1, 4, 1, 'M 7798-7799-7800', '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(366, 202, 350, 350, 910, NULL, 'B-72-2-4-1-93', 1, 4, 1, 'M 7798-7799-7800', '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(367, 241, 2, 2, 1950, NULL, 'B-67-2-4-1-144', 1, 4, 1, 'M 7798-7799-7800', '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(368, 245, 1, 1, 2250, NULL, 'B-70-2-4-1-163', 1, 4, 1, 'M 7798-7799-7800', '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(369, 45, 2, 2, 900, NULL, 'B-35-3-2-1-45', 1, 2, 1, NULL, '2018-03-05 17:45:12', '2018-03-05 17:45:12');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_order_payment`
--

CREATE TABLE `inventory_order_payment` (
  `id` int(11) NOT NULL,
  `fk_supplier_id` int(11) UNSIGNED NOT NULL,
  `last_due` decimal(17,6) NOT NULL,
  `invoice_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `paid` decimal(17,6) DEFAULT NULL,
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1=First, 0=Others',
  `payment_date` date NOT NULL,
  `created_by` int(11) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_order_payment`
--

INSERT INTO `inventory_order_payment` (`id`, `fk_supplier_id`, `last_due`, `invoice_id`, `paid`, `type`, `payment_date`, `created_by`, `created_at`, `updated_at`) VALUES
(22, 11, 190000.000000, 'A1801291', 190000.000000, 1, '2017-07-08', 4, '2018-01-29 18:00:16', '2018-02-14 14:14:27'),
(23, 11, 23000.000000, 'A18013023', 23000.000000, 1, '2017-07-25', 4, '2018-01-30 14:11:41', '2018-02-14 14:14:27'),
(24, 11, 525370.000000, 'A18013024', 525370.000000, 1, '2017-07-31', 4, '2018-01-30 14:29:30', '2018-02-14 14:14:27'),
(25, 12, 15150.000000, 'A18013025', NULL, 1, '2017-07-17', 4, '2018-01-30 14:39:40', '2018-02-14 14:14:27'),
(26, 7, 16960.000000, 'A18013026', 16960.000000, 1, '2017-07-17', 4, '2018-01-30 14:46:42', '2018-02-14 14:14:27'),
(27, 14, 19440.000000, 'A18013027', 19440.000000, 1, '2017-07-17', 4, '2018-01-30 14:49:10', '2018-02-14 14:14:27'),
(28, 12, 35650.000000, 'A18013028', NULL, 1, '2017-07-23', 4, '2018-01-30 14:55:28', '2018-02-14 14:14:27'),
(29, 13, 194400.000000, 'A18013029', 150000.000000, 1, '2017-08-04', 4, '2018-01-30 15:20:20', '2018-02-14 14:14:27'),
(30, 11, 405600.000000, 'A18013030', 405600.000000, 1, '2017-08-10', 4, '2018-01-30 15:30:14', '2018-02-14 14:14:27'),
(31, 12, 17800.000000, 'A18013031', NULL, 1, '2017-08-16', 4, '2018-01-30 15:39:45', '2018-02-14 14:14:27'),
(32, 14, 52800.000000, 'A18013032', 52800.000000, 1, '2017-09-29', 4, '2018-01-30 15:43:48', '2018-02-14 14:14:28'),
(33, 7, 312900.000000, 'A18013033', NULL, 1, '2017-09-30', 4, '2018-01-30 15:49:11', '2018-02-14 14:14:28'),
(34, 11, 294400.000000, 'A18013034', 294400.000000, 1, '2017-10-16', 4, '2018-01-30 16:00:37', '2018-02-14 14:14:28'),
(35, 11, 739250.000000, 'A18013035', 739250.000000, 1, '2017-10-30', 4, '2018-01-30 16:15:30', '2018-02-14 14:14:28'),
(36, 10, 32500.000000, 'A18013036', 32500.000000, 1, '2017-10-22', 4, '2018-01-30 16:28:49', '2018-02-14 14:14:28'),
(37, 10, 714300.000000, 'A18013037', 714300.000000, 1, '2017-11-14', 4, '2018-01-30 16:36:58', '2018-02-14 14:14:28'),
(38, 12, 52500.000000, 'A18013038', NULL, 1, '2017-11-10', 4, '2018-01-30 16:42:36', '2018-02-14 14:14:28'),
(39, 11, 633100.000000, 'A18013039', 633100.000000, 1, '2018-01-24', 4, '2018-01-30 16:45:50', '2018-02-14 14:14:28'),
(40, 11, 22100.000000, 'A18013040', 22100.000000, 1, '2017-10-22', 4, '2018-01-30 17:35:54', '2018-02-14 14:14:28'),
(41, 11, 1458380.000000, 'A18013041', 1458380.000000, 1, '2017-12-17', 4, '2018-01-30 18:22:17', '2018-02-14 14:14:28'),
(42, 16, 78300.000000, 'A18013042', 78300.000000, 1, '2017-09-22', 4, '2018-01-30 18:41:15', '2018-02-14 14:14:28'),
(43, 17, 68000.000000, 'A18013043', NULL, 1, '2017-09-23', 4, '2018-01-30 18:48:29', '2018-02-14 14:14:29'),
(44, 17, 131897.000000, 'A18013144', 131897.000000, 1, '2017-08-18', 4, '2018-01-31 12:10:55', '2018-02-14 14:14:29'),
(45, 8, 201296.000000, 'A18013145', 201296.000000, 1, '2017-08-24', 4, '2018-01-31 12:23:34', '2018-02-14 14:14:29'),
(46, 9, 128300.000000, 'A18013146', 128300.000000, 1, '2017-10-04', 4, '2018-01-31 12:41:25', '2018-02-14 14:14:29'),
(47, 9, 871454.000000, 'A18013147', 871454.000000, 1, '2017-09-24', 4, '2018-01-31 13:28:30', '2018-02-14 14:14:29'),
(48, 17, 24000.000000, 'A18013148', 24000.000000, 1, '2017-11-22', 4, '2018-01-31 13:49:50', '2018-02-14 14:14:29'),
(49, 17, 51400.000000, 'A18013149', 51400.000000, 1, '2018-01-01', 4, '2018-01-31 13:58:55', '2018-02-14 14:14:29'),
(50, 9, 499700.000000, 'A18013150', 499700.000000, 1, '2018-01-15', 4, '2018-01-31 14:34:13', '2018-02-14 14:14:30'),
(51, 9, 162450.000000, 'A18013151', 162450.000000, 1, '2018-01-10', 4, '2018-01-31 14:48:05', '2018-02-14 14:14:30'),
(52, 8, 285700.000000, 'A18013152', 285700.000000, 1, '2018-01-15', 4, '2018-01-31 15:00:24', '2018-02-14 14:14:30'),
(53, 9, 176400.000000, 'A18013153', 176400.000000, 1, '2018-01-20', 4, '2018-01-31 15:10:04', '2018-02-14 14:14:30'),
(54, 15, 27610.000000, 'A18020454', 15500.000000, 1, '2018-01-24', 4, '2018-02-04 15:56:24', '2018-02-14 14:14:30'),
(55, 17, 3488666.000000, 'A18020555', 3488666.000000, 1, '2017-07-02', 4, '2018-02-05 15:14:57', '2018-02-14 14:14:30'),
(56, 12, 8750.000000, 'A18020556', NULL, 1, '2018-02-02', 4, '2018-02-05 15:21:31', '2018-02-14 14:14:30'),
(57, 18, 92880.000000, 'A18020557', NULL, 1, '2018-02-05', 4, '2018-02-05 15:29:07', '2018-02-14 14:14:30'),
(58, 17, 110000.000000, 'A18020558', 110000.000000, 1, '2017-10-16', 4, '2018-02-05 17:17:31', '2018-02-14 14:14:30'),
(59, 15, 12110.000000, 'A18021059', 12110.000000, 1, '2018-01-24', 4, '2018-02-10 15:22:17', '2018-02-14 14:14:30'),
(60, 8, 262390.000000, 'A18021460', 262390.000000, 1, '2018-02-13', 3, '2018-02-14 12:23:02', '2018-02-14 14:14:31'),
(61, 19, 140600.000000, '61', NULL, 1, '2017-09-09', 6, '2018-02-17 17:28:18', '2018-03-06 17:23:19'),
(62, 19, 881992.000000, '62', NULL, 1, '2017-09-10', 6, '2018-02-17 17:45:55', '2018-03-06 17:23:19'),
(63, 19, 1773543.000000, '63', NULL, 1, '2017-09-08', 6, '2018-02-17 18:19:59', '2018-03-06 17:23:19'),
(64, 19, 1706695.000000, '64', NULL, 1, '2017-09-09', 6, '2018-02-17 18:56:45', '2018-03-06 17:23:19'),
(65, 19, 8775.000000, '65', NULL, 1, '2018-02-16', 6, '2018-02-17 21:51:57', '2018-03-06 17:23:19'),
(66, 19, 205640.000000, '66', NULL, 1, '2018-02-16', 6, '2018-02-17 22:06:10', '2018-03-06 17:23:19'),
(67, 8, 461150.000000, '67', 461150.000000, 1, '2018-02-27', 5, '2018-03-04 00:50:04', '2018-03-04 00:50:04'),
(68, 17, 1200.000000, '68', 1200.000000, 1, '2018-02-23', 5, '2018-03-04 00:53:18', '2018-03-04 00:53:18'),
(70, 19, 11682.000000, '69', NULL, 1, '2018-02-04', 5, '2018-03-04 19:56:15', '2018-03-04 19:56:15'),
(71, 19, 369250.000000, '71', 135770.000000, 1, '2018-03-02', 6, '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(72, 12, 1800.000000, '72', NULL, 1, '2017-11-28', 5, '2018-03-05 17:45:12', '2018-03-05 17:45:12'),
(73, 12, 129850.000000, '18030573', 20000.000000, 0, '2017-08-09', 5, '2018-03-05 17:47:17', '2018-03-06 17:23:19'),
(74, 12, 109850.000000, '18030574', 25000.000000, 0, '2017-08-28', 5, '2018-03-05 17:48:09', '2018-03-06 17:23:19'),
(75, 12, 84850.000000, '18030575', 5000.000000, 0, '2017-10-24', 5, '2018-03-05 17:48:54', '2018-03-06 17:23:19'),
(76, 12, 79850.000000, '18030576', 3000.000000, 0, '2017-11-20', 5, '2018-03-05 17:49:33', '2018-03-06 17:23:19'),
(77, 12, 76850.000000, '18030577', 12000.000000, 0, '2017-12-13', 5, '2018-03-05 17:50:09', '2018-03-06 17:23:19'),
(78, 12, 64850.000000, '18030578', 3000.000000, 0, '2018-01-30', 5, '2018-03-05 17:50:38', '2018-03-06 17:23:19'),
(81, 12, 75332.000000, '18032179', 200.000000, 0, '2018-03-21', 1, '2018-03-21 06:40:21', '2018-03-21 06:40:21'),
(82, 13, 44400.000000, '18040182', 3525.000000, 0, '2018-04-01', 1, '2018-04-01 05:48:40', '2018-04-01 05:48:40'),
(83, 18, 92880.000000, '18040183', 100.000000, 0, '2018-04-01', 1, '2018-04-01 06:51:06', '2018-04-01 06:51:06');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_order_payment_item`
--

CREATE TABLE `inventory_order_payment_item` (
  `id` int(11) NOT NULL,
  `fk_order_id` int(11) UNSIGNED NOT NULL,
  `fk_order_payment_id` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1=First, 0=Other',
  `order_last_due` float NOT NULL,
  `order_paid` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_order_payment_item`
--

INSERT INTO `inventory_order_payment_item` (`id`, `fk_order_id`, `fk_order_payment_id`, `type`, `order_last_due`, `order_paid`, `created_at`, `updated_at`) VALUES
(1, 21, 22, 1, 190000, 190000, '2018-02-14 14:14:27', '2018-02-14 14:14:27'),
(2, 22, 23, 1, 23000, 23000, '2018-02-14 14:14:27', '2018-02-14 14:14:27'),
(3, 23, 24, 1, 525370, 525370, '2018-02-14 14:14:27', '2018-02-14 14:14:27'),
(4, 24, 25, 1, 15150, NULL, '2018-02-14 14:14:27', '2018-02-14 14:14:27'),
(5, 25, 26, 1, 16960, 16960, '2018-02-14 14:14:27', '2018-02-14 14:14:27'),
(6, 26, 27, 1, 19440, 19440, '2018-02-14 14:14:27', '2018-02-14 14:14:27'),
(7, 27, 28, 1, 35650, NULL, '2018-02-14 14:14:27', '2018-02-14 14:14:27'),
(8, 28, 29, 1, 194400, 150000, '2018-02-14 14:14:27', '2018-02-14 14:14:27'),
(9, 29, 30, 1, 405600, 405600, '2018-02-14 14:14:27', '2018-02-14 14:14:27'),
(10, 30, 31, 1, 17800, NULL, '2018-02-14 14:14:27', '2018-02-14 14:14:27'),
(11, 31, 32, 1, 52800, 52800, '2018-02-14 14:14:28', '2018-02-14 14:14:28'),
(12, 32, 33, 1, 312900, NULL, '2018-02-14 14:14:28', '2018-02-14 14:14:28'),
(13, 33, 34, 1, 294400, 294400, '2018-02-14 14:14:28', '2018-02-14 14:14:28'),
(14, 34, 35, 1, 739250, 739250, '2018-02-14 14:14:28', '2018-02-14 14:14:28'),
(15, 35, 36, 1, 32500, 32500, '2018-02-14 14:14:28', '2018-02-14 14:14:28'),
(16, 36, 37, 1, 714300, 714300, '2018-02-14 14:14:28', '2018-02-14 14:14:28'),
(17, 37, 38, 1, 52500, NULL, '2018-02-14 14:14:28', '2018-02-14 14:14:28'),
(18, 38, 39, 1, 633100, 633100, '2018-02-14 14:14:28', '2018-02-14 14:14:28'),
(19, 39, 40, 1, 22100, 22100, '2018-02-14 14:14:28', '2018-02-14 14:14:28'),
(20, 40, 41, 1, 1458380, 1458380, '2018-02-14 14:14:28', '2018-02-14 14:14:28'),
(21, 41, 42, 1, 78300, 78300, '2018-02-14 14:14:29', '2018-02-14 14:14:29'),
(22, 42, 43, 1, 68000, NULL, '2018-02-14 14:14:29', '2018-02-14 14:14:29'),
(23, 43, 44, 1, 131897, 131897, '2018-02-14 14:14:29', '2018-02-14 14:14:29'),
(24, 44, 45, 1, 201296, 201296, '2018-02-14 14:14:29', '2018-02-14 14:14:29'),
(25, 45, 46, 1, 128300, 128300, '2018-02-14 14:14:29', '2018-02-14 14:14:29'),
(26, 46, 47, 1, 871454, 871454, '2018-02-14 14:14:29', '2018-02-14 14:14:29'),
(27, 47, 48, 1, 24000, 24000, '2018-02-14 14:14:29', '2018-02-14 14:14:29'),
(28, 48, 49, 1, 51400, 51400, '2018-02-14 14:14:29', '2018-02-14 14:14:29'),
(29, 49, 50, 1, 499700, 499700, '2018-02-14 14:14:30', '2018-02-14 14:14:30'),
(30, 50, 51, 1, 162450, 162450, '2018-02-14 14:14:30', '2018-02-14 14:14:30'),
(31, 51, 52, 1, 285700, 285700, '2018-02-14 14:14:30', '2018-02-14 14:14:30'),
(32, 52, 53, 1, 176400, 176400, '2018-02-14 14:14:30', '2018-02-14 14:14:30'),
(33, 53, 54, 1, 27610, 15500, '2018-02-14 14:14:30', '2018-02-14 14:14:30'),
(34, 54, 55, 1, 3488670, 3488670, '2018-02-14 14:14:30', '2018-02-14 14:14:30'),
(35, 55, 56, 1, 8750, NULL, '2018-02-14 14:14:30', '2018-02-14 14:14:30'),
(36, 56, 57, 1, 92880, NULL, '2018-02-14 14:14:30', '2018-02-14 14:14:30'),
(37, 57, 58, 1, 110000, 110000, '2018-02-14 14:14:30', '2018-02-14 14:14:30'),
(38, 53, 59, 1, 12110, 12110, '2018-02-14 14:14:30', '2018-02-14 14:14:30'),
(39, 58, 60, 1, 262390, 262390, '2018-02-14 14:14:31', '2018-02-14 14:14:31'),
(40, 59, 61, 1, 140600, NULL, '2018-02-17 17:28:18', '2018-02-17 17:28:18'),
(41, 60, 62, 1, 881992, NULL, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(42, 61, 63, 1, 1773540, NULL, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(43, 62, 64, 1, 1706700, NULL, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(44, 63, 65, 1, 8775, NULL, '2018-02-17 21:51:57', '2018-02-17 21:51:57'),
(45, 64, 66, 1, 205640, NULL, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(46, 65, 67, 1, 461150, 461150, '2018-03-04 00:50:04', '2018-03-04 00:50:04'),
(47, 66, 68, 1, 1200, 1200, '2018-03-04 00:53:18', '2018-03-04 00:53:18'),
(49, 68, 70, 1, 11682, NULL, '2018-03-04 19:56:15', '2018-03-04 19:56:15'),
(50, 69, 71, 1, 369250, 135770, '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(51, 70, 72, 1, 1800, NULL, '2018-03-05 17:45:12', '2018-03-05 17:45:12'),
(52, 24, 73, 0, 15150, 15150, '2018-03-05 17:47:17', '2018-03-05 17:47:17'),
(53, 27, 73, 0, 35650, 4850, '2018-03-05 17:47:17', '2018-03-05 17:47:17'),
(54, 30, 73, 0, 17800, 0, '2018-03-05 17:47:17', '2018-03-05 17:47:17'),
(55, 37, 73, 0, 52500, 0, '2018-03-05 17:47:17', '2018-03-05 17:47:17'),
(56, 55, 73, 0, 8750, 0, '2018-03-05 17:47:17', '2018-03-05 17:47:17'),
(57, 27, 74, 0, 30800, 25000, '2018-03-05 17:48:09', '2018-03-05 17:48:09'),
(58, 30, 74, 0, 17800, 0, '2018-03-05 17:48:09', '2018-03-05 17:48:09'),
(59, 37, 74, 0, 52500, 0, '2018-03-05 17:48:10', '2018-03-05 17:48:10'),
(60, 55, 74, 0, 8750, 0, '2018-03-05 17:48:10', '2018-03-05 17:48:10'),
(61, 27, 75, 0, 5800, 5000, '2018-03-05 17:48:54', '2018-03-05 17:48:54'),
(62, 30, 75, 0, 17800, 0, '2018-03-05 17:48:54', '2018-03-05 17:48:54'),
(63, 37, 75, 0, 52500, 0, '2018-03-05 17:48:54', '2018-03-05 17:48:54'),
(64, 55, 75, 0, 8750, 0, '2018-03-05 17:48:54', '2018-03-05 17:48:54'),
(65, 27, 76, 0, 800, 800, '2018-03-05 17:49:33', '2018-03-05 17:49:33'),
(66, 30, 76, 0, 17800, 2200, '2018-03-05 17:49:33', '2018-03-05 17:49:33'),
(67, 37, 76, 0, 52500, 0, '2018-03-05 17:49:33', '2018-03-05 17:49:33'),
(68, 55, 76, 0, 8750, 0, '2018-03-05 17:49:33', '2018-03-05 17:49:33'),
(69, 30, 77, 0, 15600, 12000, '2018-03-05 17:50:09', '2018-03-05 17:50:09'),
(70, 37, 77, 0, 52500, 0, '2018-03-05 17:50:09', '2018-03-05 17:50:09'),
(71, 55, 77, 0, 8750, 0, '2018-03-05 17:50:09', '2018-03-05 17:50:09'),
(72, 30, 78, 0, 3600, 3000, '2018-03-05 17:50:38', '2018-03-05 17:50:38'),
(73, 37, 78, 0, 52500, 0, '2018-03-05 17:50:38', '2018-03-05 17:50:38'),
(74, 55, 78, 0, 8750, 0, '2018-03-05 17:50:38', '2018-03-05 17:50:38'),
(75, 30, 81, 0, 600, 200, '2018-03-21 06:40:21', '2018-03-21 06:40:21'),
(76, 37, 81, 0, 52500, 0, '2018-03-21 06:40:22', '2018-03-21 06:40:22'),
(77, 55, 81, 0, 8750, 0, '2018-03-21 06:40:22', '2018-03-21 06:40:22'),
(78, 68, 81, 0, 11682, 0, '2018-03-21 06:40:22', '2018-03-21 06:40:22'),
(79, 70, 81, 0, 1800, 0, '2018-03-21 06:40:22', '2018-03-21 06:40:22'),
(80, 28, 82, 0, 44400, 3525, '2018-04-01 05:48:40', '2018-04-01 05:48:40'),
(81, 56, 83, 0, 92880, 100, '2018-04-01 06:51:07', '2018-04-01 06:51:07');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_payment_history`
--

CREATE TABLE `inventory_payment_history` (
  `id` int(11) NOT NULL,
  `invoice_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `fk_account_id` int(10) UNSIGNED NOT NULL,
  `fk_client_id` int(10) UNSIGNED DEFAULT NULL,
  `fk_method_id` int(10) UNSIGNED NOT NULL,
  `fk_received_id` int(10) UNSIGNED DEFAULT NULL,
  `fk_branch_id` int(10) UNSIGNED NOT NULL,
  `fk_company_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `ref_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bank` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `summary` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_amount` float DEFAULT NULL,
  `last_due` decimal(17,6) NOT NULL,
  `paid` decimal(17,6) NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1=First,0=After',
  `payment_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_payment_history`
--

INSERT INTO `inventory_payment_history` (`id`, `invoice_id`, `created_by`, `fk_account_id`, `fk_client_id`, `fk_method_id`, `fk_received_id`, `fk_branch_id`, `fk_company_id`, `ref_id`, `bank`, `summary`, `total_amount`, `last_due`, `paid`, `type`, `payment_date`, `created_at`, `updated_at`) VALUES
(2, '1802031', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 12550, 12550.000000, 12550.000000, 1, '2017-07-09', '2018-02-03 14:29:59', '2018-02-03 14:29:59'),
(3, '1802033', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 4000, 4000.000000, 4000.000000, 1, '2017-07-12', '2018-02-03 15:09:35', '2018-02-03 15:09:35'),
(4, '1802034', 4, 1, 64, 3, 4, 2, 1, '', NULL, NULL, 20870, 20870.000000, 5000.000000, 1, '2017-07-10', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(5, '1802035', 4, 1, 66, 3, NULL, 2, 1, NULL, NULL, NULL, 286746, 286746.000000, 60000.000000, 0, '2017-08-01', '2018-02-03 19:45:39', '2018-02-03 19:45:39'),
(6, '1802046', 4, 1, 68, 3, 4, 2, 1, '', NULL, NULL, 23900, 23900.000000, 17000.000000, 1, '2017-07-02', '2018-02-04 10:06:04', '2018-02-04 10:06:04'),
(7, '1802047', 4, 1, 68, 3, NULL, 2, 1, NULL, NULL, NULL, 46550, 29550.000000, 15000.000000, 0, '2017-07-05', '2018-02-04 11:08:52', '2018-02-04 11:08:52'),
(8, '1802048', 4, 1, 66, 3, NULL, 2, 1, NULL, NULL, NULL, 444546, 384546.000000, 150000.000000, 0, '2017-08-31', '2018-02-04 11:21:31', '2018-02-04 11:21:31'),
(9, '1802049', 4, 1, 66, 3, NULL, 2, 1, NULL, NULL, NULL, 444546, 234546.000000, 82500.000000, 0, '2017-09-23', '2018-02-04 11:23:22', '2018-02-04 11:23:22'),
(10, '18020410', 4, 1, 64, 3, 4, 2, 1, '', NULL, NULL, 18050, 18050.000000, 15000.000000, 1, '2017-07-18', '2018-02-04 16:44:22', '2018-02-04 16:44:22'),
(11, '18020411', 4, 1, 64, 3, NULL, 2, 1, NULL, NULL, NULL, 38920, 18920.000000, 5000.000000, 0, '2017-09-01', '2018-02-04 16:45:47', '2018-02-04 16:45:47'),
(12, '18020412', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 16500, 16500.000000, 16500.000000, 1, '2017-07-21', '2018-02-04 17:01:14', '2018-02-04 17:01:14'),
(13, '18020413', 4, 1, 65, 3, 4, 2, 1, '', NULL, NULL, 16200, 16200.000000, 16200.000000, 1, '2017-07-21', '2018-02-04 17:04:08', '2018-02-04 17:04:08'),
(14, '18020614', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 6700, 6700.000000, 6700.000000, 1, '2017-09-19', '2018-02-06 14:15:06', '2018-02-06 14:15:06'),
(15, '18020615', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 5600, 5600.000000, 5000.000000, 1, '2017-09-22', '2018-02-06 14:17:33', '2018-02-06 14:17:33'),
(16, '18020616', 4, 1, 74, 3, 4, 2, 1, '', NULL, NULL, 16500, 16500.000000, 16500.000000, 1, '2017-09-25', '2018-02-06 14:46:29', '2018-02-06 14:46:29'),
(17, '18020617', 4, 1, 73, 3, NULL, 2, 1, NULL, NULL, NULL, 8400, 3400.000000, 3400.000000, 0, '2017-09-23', '2018-02-06 15:03:20', '2018-02-06 15:03:20'),
(18, '18020618', 4, 1, 68, 3, NULL, 2, 1, NULL, NULL, NULL, 38650, 30550.000000, 8900.000000, 0, '2017-09-15', '2018-02-06 15:07:08', '2018-02-06 15:07:08'),
(19, '18020619', 4, 1, 66, 3, NULL, 2, 1, NULL, NULL, NULL, 271150, 265396.000000, 65000.000000, 0, '2017-10-08', '2018-02-06 15:09:08', '2018-02-06 15:09:08'),
(20, '18020620', 4, 1, 72, 3, NULL, 2, 1, NULL, NULL, NULL, 4502830, 4502829.000000, 1892150.000000, 0, '2018-02-05', '2018-02-06 15:26:17', '2018-02-06 15:26:17'),
(21, '18020621', 4, 1, 76, 3, 4, 2, 1, '', NULL, NULL, 115208, 115208.000000, 115208.000000, 1, '2017-09-26', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(22, '18020622', 4, 1, 65, 3, 4, 2, 1, '', NULL, NULL, 13800, 13800.000000, 8600.000000, 1, '2017-09-29', '2018-02-06 15:57:12', '2018-02-06 15:57:12'),
(23, '18020623', 4, 1, 76, 3, 4, 2, 1, '', NULL, NULL, 13800, 13800.000000, 13800.000000, 1, '2017-09-29', '2018-02-06 15:59:50', '2018-02-06 15:59:50'),
(24, '18020624', 4, 1, 74, 3, 4, 2, 1, '', NULL, NULL, 8100, 8100.000000, 8100.000000, 1, '2017-09-29', '2018-02-06 16:01:43', '2018-02-06 16:01:43'),
(25, '18020625', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 4900, 4900.000000, 4900.000000, 1, '2017-09-30', '2018-02-06 16:07:23', '2018-02-06 16:07:23'),
(26, '18020626', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 2600, 2600.000000, 2600.000000, 1, '2017-09-30', '2018-02-06 16:09:32', '2018-02-06 16:09:32'),
(27, '18020627', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 7700, 7700.000000, 6000.000000, 1, '2017-10-03', '2018-02-06 16:31:48', '2018-02-06 16:31:48'),
(28, '18020628', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 5150, 5150.000000, 5150.000000, 1, '2017-10-04', '2018-02-06 16:37:39', '2018-02-06 16:37:39'),
(29, '18020629', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 5400, 5400.000000, 4100.000000, 1, '2017-10-04', '2018-02-06 16:40:14', '2018-02-06 16:40:14'),
(30, '18020630', 4, 1, 64, 3, 4, 2, 1, '', NULL, NULL, 2450, 2450.000000, 2450.000000, 1, '2017-10-04', '2018-02-06 16:42:20', '2018-02-06 16:42:20'),
(31, '18020631', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 1780, 1780.000000, 1780.000000, 1, '2017-10-06', '2018-02-06 16:44:57', '2018-02-06 16:44:57'),
(32, '18020632', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 900, 900.000000, 900.000000, 1, '2017-10-11', '2018-02-06 16:49:44', '2018-02-06 16:49:44'),
(33, '18020633', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 750, 750.000000, 750.000000, 1, '2017-10-14', '2018-02-06 16:52:04', '2018-02-06 16:52:04'),
(34, '18020634', 4, 1, 76, 3, 4, 2, 1, '', NULL, NULL, 5700, 5700.000000, 5700.000000, 1, '2017-10-20', '2018-02-06 16:53:58', '2018-02-06 16:53:58'),
(35, '18020635', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 11800, 11800.000000, 11800.000000, 1, '2017-10-22', '2018-02-06 16:56:09', '2018-02-06 16:56:09'),
(36, '18020636', 4, 1, 66, 3, NULL, 2, 1, NULL, NULL, NULL, 351720, 280966.000000, 90000.000000, 0, '2017-10-23', '2018-02-06 17:08:54', '2018-02-06 17:08:54'),
(37, '18020637', 4, 1, 66, 3, NULL, 2, 1, NULL, NULL, NULL, 193920, 190966.000000, 50000.000000, 0, '2017-10-29', '2018-02-06 17:09:53', '2018-02-06 17:09:53'),
(38, '18020638', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 3330, 3330.000000, 3330.000000, 1, '2017-10-27', '2018-02-06 17:12:21', '2018-02-06 17:12:21'),
(39, '18020639', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 8700, 8700.000000, 8700.000000, 1, '2017-10-30', '2018-02-06 17:14:51', '2018-02-06 17:14:51'),
(40, '18020640', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 16500, 16500.000000, 16500.000000, 1, '2017-11-01', '2018-02-06 18:06:12', '2018-02-06 18:06:12'),
(41, '18020641', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 350, 350.000000, 350.000000, 1, '2017-11-04', '2018-02-06 18:08:02', '2018-02-06 18:08:02'),
(42, '18020642', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 3950, 3950.000000, 3950.000000, 1, '2017-11-08', '2018-02-06 18:46:25', '2018-02-06 18:46:25'),
(43, '18020643', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 4120, 4120.000000, 4120.000000, 1, '2017-11-08', '2018-02-06 18:50:59', '2018-02-06 18:50:59'),
(44, '18020744', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 3400, 3400.000000, 3400.000000, 1, '2017-11-10', '2018-02-07 11:19:41', '2018-02-07 11:19:41'),
(45, '18020745', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 4200, 4200.000000, 4200.000000, 1, '2017-11-12', '2018-02-07 11:25:43', '2018-02-07 11:25:43'),
(46, '18020746', 4, 1, 68, 3, 4, 2, 1, '', NULL, NULL, 23900, 23900.000000, 15000.000000, 1, '2017-07-02', '2018-02-07 11:52:18', '2018-02-07 11:52:18'),
(47, '18020747', 4, 1, 68, 3, 4, 2, 1, '', NULL, NULL, 13450, 13450.000000, 10000.000000, 1, '2017-07-05', '2018-02-07 11:57:23', '2018-02-07 11:57:23'),
(48, '18020748', 4, 1, 71, 3, 4, 2, 1, '', NULL, NULL, 50100, 50100.000000, 43000.000000, 1, '2017-07-08', '2018-02-07 12:04:20', '2018-02-07 12:04:20'),
(49, '18020749', 4, 1, 65, 3, 4, 2, 1, '', NULL, NULL, 31500, 31500.000000, 31500.000000, 1, '2017-07-14', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(50, '18020750', 4, 1, 71, 3, 4, 2, 1, '', NULL, NULL, 42550, 42550.000000, 40500.000000, 1, '2017-07-23', '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(51, '18020751', 4, 1, 81, 3, 4, 2, 1, '', NULL, NULL, 37300, 37300.000000, 37300.000000, 1, '2017-07-23', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(52, '18020752', 4, 1, 65, 3, 4, 2, 1, '', NULL, NULL, 16000, 16000.000000, 16000.000000, 1, '2017-07-28', '2018-02-07 13:02:18', '2018-02-07 13:02:18'),
(53, '18020753', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 5600, 5600.000000, 5600.000000, 1, '2017-08-04', '2018-02-07 13:46:14', '2018-02-07 13:46:14'),
(54, '18020754', 4, 1, 65, 3, 4, 2, 1, '', NULL, NULL, 31800, 31800.000000, 31800.000000, 1, '2017-08-04', '2018-02-07 13:50:02', '2018-02-07 13:50:02'),
(55, '18020755', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 9100, 9100.000000, 9100.000000, 1, '2017-08-05', '2018-02-07 13:52:23', '2018-02-07 13:52:23'),
(56, '18020756', 4, 1, 71, 3, 4, 2, 1, '', NULL, NULL, 67800, 67800.000000, 47500.000000, 1, '2017-08-06', '2018-02-07 13:58:18', '2018-02-07 13:58:18'),
(57, '18020757', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 1460, 1460.000000, 1460.000000, 1, '2017-08-06', '2018-02-07 14:05:51', '2018-02-07 14:05:51'),
(58, '18020758', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 6280, 6280.000000, 6280.000000, 1, '2017-08-06', '2018-02-07 14:09:35', '2018-02-07 14:09:35'),
(59, '18020759', 4, 1, 81, 3, 4, 2, 1, '', NULL, NULL, 122385, 122385.000000, 122385.000000, 1, '2017-08-07', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(60, '18020760', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 8100, 8100.000000, 8100.000000, 1, '2017-08-07', '2018-02-07 14:32:39', '2018-02-07 14:32:39'),
(61, '18020761', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 24000, 24000.000000, 24000.000000, 1, '2017-08-07', '2018-02-07 14:34:13', '2018-02-07 14:34:13'),
(62, '18020762', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 3700, 3700.000000, 3700.000000, 1, '2017-08-09', '2018-02-07 14:36:39', '2018-02-07 14:36:39'),
(63, '18020763', 4, 1, 76, 3, 4, 2, 1, '', NULL, NULL, 18825, 18825.000000, 18825.000000, 1, '2017-08-09', '2018-02-07 14:40:47', '2018-02-07 14:40:47'),
(64, '18020764', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 16485, 16485.000000, 16485.000000, 1, '2017-08-11', '2018-02-07 14:46:45', '2018-02-07 14:46:45'),
(65, '18020765', 4, 1, 74, 3, 4, 2, 1, '', NULL, NULL, 13700, 13700.000000, 13700.000000, 1, '2017-08-12', '2018-02-07 14:51:36', '2018-02-07 14:51:36'),
(66, '18020766', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 30200, 30200.000000, 30200.000000, 1, '2017-08-12', '2018-02-07 14:56:31', '2018-02-07 14:56:31'),
(67, '18020767', 4, 1, 77, 3, 4, 2, 1, '', NULL, NULL, 52930, 52930.000000, 37000.000000, 1, '2017-08-18', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(68, '18020768', 4, 1, 82, 3, 4, 2, 1, '', NULL, NULL, 61100, 61100.000000, 61100.000000, 1, '2017-08-18', '2018-02-07 15:48:19', '2018-02-07 15:48:19'),
(69, '18020769', 4, 1, 71, 3, NULL, 2, 1, NULL, NULL, NULL, 227450, 96450.000000, 46000.000000, 0, '2017-08-23', '2018-02-07 15:57:24', '2018-02-07 15:57:24'),
(70, '18020770', 4, 1, 74, 3, 4, 2, 1, '', NULL, NULL, 25500, 25500.000000, 25500.000000, 1, '2017-08-20', '2018-02-07 16:05:03', '2018-02-07 16:05:03'),
(71, '18020771', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 27300, 27300.000000, 27300.000000, 1, '2017-08-21', '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(72, '18020772', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 9150, 9150.000000, 9150.000000, 1, '2017-08-23', '2018-02-07 16:16:02', '2018-02-07 16:16:02'),
(73, '18020773', 4, 1, 71, 3, NULL, 2, 1, NULL, NULL, NULL, 130460, 62110.000000, 62000.000000, 0, '2017-09-01', '2018-02-07 16:29:58', '2018-02-07 16:29:58'),
(74, '18020774', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 5300, 5300.000000, 5300.000000, 1, '2017-08-26', '2018-02-07 16:31:55', '2018-02-07 16:31:55'),
(75, '18020775', 4, 1, 64, 3, 4, 2, 1, '', NULL, NULL, 5950, 5950.000000, 5950.000000, 1, '2017-08-26', '2018-02-07 16:34:49', '2018-02-07 16:34:49'),
(76, '18020776', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 5200, 5200.000000, 5200.000000, 1, '2017-08-28', '2018-02-07 16:36:47', '2018-02-07 16:36:47'),
(77, '18020777', 4, 1, 68, 3, 4, 2, 1, '', NULL, NULL, 8300, 8300.000000, 8300.000000, 1, '2017-08-28', '2018-02-07 16:39:18', '2018-02-07 16:39:18'),
(78, '18020778', 4, 1, 68, 3, 4, 2, 1, '', NULL, NULL, 6300, 6300.000000, 6300.000000, 1, '2017-09-08', '2018-02-07 16:41:46', '2018-02-07 16:41:46'),
(79, '18020779', 4, 1, 64, 3, 4, 2, 1, '', NULL, NULL, 24800, 24800.000000, 24100.000000, 1, '2017-09-10', '2018-02-07 16:49:25', '2018-02-07 16:49:25'),
(80, '18020780', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 29000, 29000.000000, 29000.000000, 1, '2017-09-11', '2018-02-07 16:51:49', '2018-02-07 16:51:49'),
(81, '18020781', 4, 1, 74, 3, 4, 2, 1, '', NULL, NULL, 22000, 22000.000000, 22000.000000, 1, '2017-09-12', '2018-02-07 16:54:25', '2018-02-07 16:54:25'),
(82, '18020782', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 16600, 16600.000000, 16600.000000, 1, '2017-09-13', '2018-02-07 16:56:47', '2018-02-07 16:56:47'),
(83, '18020783', 4, 1, 82, 3, 4, 2, 1, '', NULL, NULL, 16900, 16900.000000, 16900.000000, 1, '2017-09-13', '2018-02-07 17:00:31', '2018-02-07 17:00:31'),
(84, '18020784', 4, 1, 71, 3, 4, 2, 1, '', NULL, NULL, 485281, 485281.000000, 4000.000000, 1, '2018-02-07', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(85, '18020785', 4, 1, 71, 3, NULL, 2, 1, NULL, NULL, NULL, 487681, 481391.000000, 135668.000000, 0, '2018-02-07', '2018-02-07 19:22:32', '2018-02-07 19:22:32'),
(86, '18020786', 4, 1, 60, 3, NULL, 2, 1, NULL, NULL, NULL, 110000, 110000.000000, 110000.000000, 0, '2018-02-07', '2018-02-07 19:26:49', '2018-02-07 19:26:49'),
(87, '18020787', 4, 1, 61, 3, NULL, 2, 1, NULL, NULL, NULL, 13100, 3000.000000, 3000.000000, 0, '2018-02-07', '2018-02-07 19:28:33', '2018-02-07 19:28:33'),
(88, '18020788', 4, 1, 65, 3, NULL, 2, 1, NULL, NULL, NULL, 13800, 5200.000000, 5200.000000, 0, '2018-02-07', '2018-02-07 19:30:06', '2018-02-07 19:30:06'),
(89, '18020989', 4, 1, 83, 3, 4, 2, 1, '', NULL, NULL, 33000, 33000.000000, 33000.000000, 1, '2017-11-14', '2018-02-09 12:08:25', '2018-02-09 12:08:25'),
(90, '18020990', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 5900, 5900.000000, 5900.000000, 1, '2017-11-19', '2018-02-09 12:58:37', '2018-02-09 12:58:37'),
(91, '18020991', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 3180, 3180.000000, 3180.000000, 1, '2017-11-22', '2018-02-09 13:01:34', '2018-02-09 13:01:34'),
(92, '18020992', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 750, 750.000000, 750.000000, 1, '2017-11-27', '2018-02-09 13:38:04', '2018-02-09 13:38:04'),
(93, '18020993', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 3600, 3600.000000, 3600.000000, 1, '2017-12-02', '2018-02-09 13:44:20', '2018-02-09 13:44:20'),
(94, '18020994', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 3080, 3080.000000, 3080.000000, 1, '2017-12-02', '2018-02-09 14:08:24', '2018-02-09 14:08:24'),
(95, '18020995', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 1870, 1870.000000, 1870.000000, 1, '2017-12-04', '2018-02-09 14:10:30', '2018-02-09 14:10:30'),
(96, '18020996', 4, 1, 74, 3, 4, 2, 1, '', NULL, NULL, 20500, 20500.000000, 20500.000000, 1, '2017-12-08', '2018-02-09 14:24:09', '2018-02-09 14:24:09'),
(97, '18020997', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 8960, 8960.000000, 8960.000000, 1, '2017-12-08', '2018-02-09 14:35:03', '2018-02-09 14:35:03'),
(98, '18020998', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 6700, 6700.000000, 6700.000000, 1, '2017-12-08', '2018-02-09 14:36:52', '2018-02-09 14:36:52'),
(99, '18020999', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 34300, 34300.000000, 34300.000000, 1, '2017-12-09', '2018-02-09 14:43:44', '2018-02-09 14:43:44'),
(100, '180209100', 4, 1, 83, 3, 4, 2, 1, '', NULL, NULL, 4900, 4900.000000, 4900.000000, 1, '2017-12-09', '2018-02-09 14:45:41', '2018-02-09 14:45:41'),
(101, '180209101', 4, 1, 83, 3, 4, 2, 1, '', NULL, NULL, 35500, 35500.000000, 35500.000000, 1, '2017-12-13', '2018-02-09 14:48:50', '2018-02-09 14:48:50'),
(102, '180209102', 4, 1, 64, 3, 4, 2, 1, '', NULL, NULL, 8450, 8450.000000, 8450.000000, 1, '2017-12-13', '2018-02-09 14:50:58', '2018-02-09 14:50:58'),
(103, '180209103', 4, 1, 74, 3, 4, 2, 1, '', NULL, NULL, 12300, 12300.000000, 12300.000000, 1, '2017-12-18', '2018-02-09 14:54:14', '2018-02-09 14:54:14'),
(104, '180209104', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 28225, 28225.000000, 28225.000000, 1, '2017-12-18', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(105, '180209105', 4, 1, 74, 3, 4, 2, 1, '', NULL, NULL, 8200, 8200.000000, 8200.000000, 1, '2017-12-23', '2018-02-09 15:07:25', '2018-02-09 15:07:25'),
(106, '180209106', 4, 1, 80, 3, 4, 2, 1, '', NULL, NULL, 15000, 15000.000000, 15000.000000, 1, '2017-12-24', '2018-02-09 15:09:42', '2018-02-09 15:09:42'),
(107, '180209107', 4, 1, 84, 3, 4, 2, 1, '', NULL, NULL, 11000, 11000.000000, 11000.000000, 1, '2017-12-24', '2018-02-09 15:13:17', '2018-02-09 15:13:17'),
(108, '180209108', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 7900, 7900.000000, 7900.000000, 1, '2017-12-31', '2018-02-09 15:39:17', '2018-02-09 15:39:17'),
(109, '180209109', 4, 1, 81, 3, 4, 2, 1, '', NULL, NULL, 33500, 33500.000000, 33500.000000, 1, '2018-01-06', '2018-02-09 16:01:25', '2018-02-09 16:01:25'),
(110, '180209110', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 3900, 3900.000000, 3900.000000, 1, '2018-01-21', '2018-02-09 16:26:28', '2018-02-09 16:26:28'),
(111, '180209111', 4, 1, 85, 3, 4, 2, 1, '', NULL, NULL, 19900, 19900.000000, 19900.000000, 1, '2018-01-27', '2018-02-09 16:41:08', '2018-02-09 16:41:08'),
(112, '180209112', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 6800, 6800.000000, 6800.000000, 1, '2017-12-27', '2018-02-09 16:43:02', '2018-02-09 16:43:02'),
(113, '180209113', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 16000, 16000.000000, 16000.000000, 1, '2018-01-31', '2018-02-09 16:47:49', '2018-02-09 16:47:49'),
(114, '180209114', 4, 1, 83, 3, 4, 2, 1, '', NULL, NULL, 20175, 20175.000000, 20175.000000, 1, '2018-01-31', '2018-02-09 16:50:37', '2018-02-09 16:50:37'),
(115, '180209115', 4, 1, 61, 3, 4, 2, 1, '', NULL, NULL, 26600, 26600.000000, 26600.000000, 1, '2018-02-02', '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(116, '180209116', 4, 1, 77, 3, NULL, 2, 1, NULL, NULL, NULL, 481790, 444790.000000, 248090.000000, 0, '2018-02-04', '2018-02-09 17:07:54', '2018-02-09 17:07:54'),
(117, '180209117', 4, 1, 66, 3, NULL, 2, 1, NULL, NULL, NULL, 553520, 500566.000000, 262006.000000, 0, '2018-02-09', '2018-02-09 17:14:48', '2018-02-09 17:14:48'),
(118, '180209118', 4, 1, 74, 3, 4, 2, 1, '', NULL, NULL, 19600, 19600.000000, 19600.000000, 1, '2018-02-07', '2018-02-09 17:17:10', '2018-02-09 17:17:10'),
(119, '180209119', 4, 1, 73, 3, 4, 2, 1, '', NULL, NULL, 17400, 17400.000000, 15000.000000, 1, '2018-02-07', '2018-02-09 17:22:06', '2018-02-09 17:22:06'),
(120, '180210120', 4, 1, 86, 3, 4, 2, 1, '', NULL, NULL, 850, 850.000000, 850.000000, 1, '2017-10-08', '2018-02-10 11:15:17', '2018-02-10 11:15:17'),
(121, '180210121', 4, 1, 86, 3, NULL, 2, 1, NULL, NULL, NULL, 27600, 27600.000000, 27600.000000, 0, '2017-11-10', '2018-02-10 11:33:07', '2018-02-10 11:33:07'),
(122, '180211122', 4, 1, 69, 3, NULL, 2, 1, NULL, NULL, NULL, 65390, 65390.000000, 2500.000000, 0, '2017-11-25', '2018-02-11 10:13:11', '2018-02-11 10:13:11'),
(123, '180211123', 4, 1, 69, 3, NULL, 2, 1, NULL, NULL, NULL, 65390, 62890.000000, 6000.000000, 0, '2018-01-16', '2018-02-11 10:14:34', '2018-02-11 10:14:34'),
(124, '180211124', 4, 1, 69, 3, NULL, 2, 1, NULL, NULL, NULL, 65390, 56890.000000, 16000.000000, 0, '2017-08-25', '2018-02-11 10:16:24', '2018-02-11 10:16:24'),
(125, '180211125', 4, 1, 73, 3, NULL, 2, 1, NULL, NULL, NULL, 17400, 2400.000000, 2400.000000, 0, '2018-02-10', '2018-02-11 10:18:15', '2018-02-11 10:18:15'),
(126, '180211126', 4, 1, 61, 3, NULL, 2, 1, NULL, NULL, NULL, 1840, 1840.000000, 1840.000000, 0, '2017-12-30', '2018-02-11 10:30:27', '2018-02-11 10:30:27'),
(127, '180211127', 4, 1, 79, 3, 4, 2, 1, '', NULL, NULL, 28350, 28350.000000, 5000.000000, 1, '2018-02-11', '2018-02-11 10:48:37', '2018-02-11 10:48:37'),
(128, '180211128', 4, 1, 79, 3, NULL, 2, 1, NULL, NULL, NULL, 50100, 45100.000000, 16000.000000, 0, '2017-08-26', '2018-02-11 10:50:38', '2018-02-11 10:50:38'),
(129, '180211129', 4, 1, 79, 3, NULL, 2, 1, NULL, NULL, NULL, 42750, 29100.000000, 10000.000000, 0, '2017-11-11', '2018-02-11 10:53:02', '2018-02-11 10:53:02'),
(130, '180211130', 4, 1, 79, 3, NULL, 2, 1, NULL, NULL, NULL, 47050, 37800.000000, 16000.000000, 0, '2018-02-11', '2018-02-11 11:11:42', '2018-02-11 11:11:42'),
(131, '180211131', 4, 1, 60, 3, 4, 2, 1, '', NULL, NULL, 286994, 286994.000000, 286994.000000, 1, '2017-07-31', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(132, '180211132', 3, 1, 60, 3, 3, 2, 1, '', NULL, NULL, 440126, 440126.000000, 440126.000000, 1, '2017-08-31', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(133, '180211133', 3, 1, 60, 3, 3, 2, 1, '', NULL, NULL, 166884, 166884.000000, 166884.000000, 1, '2017-09-30', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(134, '180211134', 3, 1, 60, 3, 3, 2, 1, '', NULL, NULL, 290966, 290966.000000, 290966.000000, 1, '2017-10-31', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(135, '180212135', 3, 1, 60, 3, 3, 2, 1, '', NULL, NULL, 331573, 331573.000000, 331573.000000, 1, '2017-12-31', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(136, '180212136', 3, 1, 60, 3, NULL, 2, 1, NULL, NULL, NULL, 184366, 184366.000000, 184366.000000, 0, '2017-11-30', '2018-02-12 12:15:04', '2018-02-12 12:15:04'),
(137, '180212137', 3, 1, 60, 3, 3, 2, 1, '', NULL, NULL, 54733, 54733.000000, 54733.000000, 1, '2018-02-11', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(138, '180212138', 3, 1, 60, 3, 3, 2, 1, '', NULL, NULL, 288016, 288016.000000, 288016.000000, 1, '2018-01-31', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(139, '180212139', 3, 1, 72, 3, NULL, 2, 1, NULL, NULL, NULL, 2729290, 2610679.000000, 26500.000000, 0, '2018-02-07', '2018-02-12 16:37:23', '2018-02-12 16:37:23'),
(140, '180212140', 3, 1, 72, 3, NULL, 2, 1, NULL, NULL, NULL, 2729290, 2584179.000000, 29000.000000, 0, '2018-02-10', '2018-02-12 16:38:13', '2018-02-12 16:38:13'),
(141, '180212141', 3, 1, 71, 3, NULL, 2, 1, NULL, NULL, NULL, 485281, 345723.000000, 7500.000000, 0, '2018-02-10', '2018-02-12 16:41:05', '2018-02-12 16:41:05'),
(142, '180212142', 3, 1, 71, 3, NULL, 2, 1, NULL, NULL, NULL, 485281, 338223.000000, 6000.000000, 0, '2018-02-11', '2018-02-12 16:41:44', '2018-02-12 16:41:44'),
(143, '180216143', 5, 1, 101, 3, NULL, 2, 1, NULL, NULL, NULL, 1500, 1500.000000, 1500.000000, 0, '2018-02-16', '2018-02-16 19:06:38', '2018-02-16 19:06:38'),
(144, '180216144', 5, 1, 102, 3, 5, 2, 1, '', NULL, NULL, 5100, 5100.000000, 1100.000000, 1, '2018-02-16', '2018-02-16 19:43:43', '2018-02-16 19:43:43'),
(145, '180216145', 5, 1, 103, 3, 5, 2, 1, '', NULL, NULL, 12500, 6100.000000, 600.000000, 1, '2018-02-16', '2018-02-16 20:10:51', '2018-02-16 20:10:51'),
(146, '180216146', 5, 1, 103, 3, NULL, 2, 1, NULL, NULL, NULL, 31470, 30870.000000, 3000.000000, 0, '2017-11-12', '2018-02-16 20:28:34', '2018-02-16 20:28:34'),
(147, '180216147', 5, 1, 103, 3, NULL, 2, 1, NULL, NULL, NULL, 31470, 27870.000000, 4000.000000, 0, '2017-11-23', '2018-02-16 20:30:14', '2018-02-16 20:30:14'),
(148, '180217148', 3, 1, 76, 3, 3, 2, 1, '', NULL, NULL, 12000, 12000.000000, 12000.000000, 1, '2018-02-17', '2018-02-17 22:39:51', '2018-02-17 22:39:51'),
(149, '180217149', 3, 1, 77, 3, 3, 2, 1, '', NULL, NULL, 206390, 9690.000000, 9500.000000, 1, '2018-02-17', '2018-02-17 22:48:02', '2018-02-17 22:48:02'),
(150, '180217150', 3, 1, 105, 3, 3, 2, 1, '', NULL, NULL, 9400, 9400.000000, 9400.000000, 1, '2018-02-17', '2018-02-17 22:53:28', '2018-02-17 22:53:28'),
(151, '180217151', 3, 1, 73, 3, 3, 2, 1, '', NULL, NULL, 2420, 2420.000000, 2420.000000, 1, '2018-02-17', '2018-02-17 22:55:57', '2018-02-17 22:55:57'),
(152, '180217152', 3, 1, 61, 3, 3, 2, 1, '', NULL, NULL, 6800, 6800.000000, 6800.000000, 1, '2018-02-17', '2018-02-17 22:58:51', '2018-02-17 22:58:51'),
(153, '180218153', 5, 1, 103, 3, 5, 2, 1, '', NULL, NULL, 36470, 12600.000000, 4000.000000, 1, '2018-02-13', '2018-02-18 21:17:59', '2018-02-18 21:17:59'),
(154, '180218154', 5, 1, 103, 3, 5, 2, 1, '', NULL, NULL, 32820, 350.000000, 3000.000000, 1, '2018-02-17', '2018-02-18 21:19:26', '2018-02-18 21:19:26'),
(155, '180218155', 5, 1, 104, 3, 5, 2, 1, '', NULL, NULL, 4950, 2850.000000, 2500.000000, 1, '2017-08-14', '2018-02-18 21:29:50', '2018-02-18 21:29:50'),
(156, '180218156', 5, 1, 104, 3, 5, 2, 1, '', NULL, NULL, 10100, 7650.000000, 4000.000000, 1, '2017-10-27', '2018-02-18 21:32:25', '2018-02-18 21:32:25'),
(157, '180218157', 5, 1, 108, 3, 5, 2, 1, '', NULL, NULL, 14900, 2000.000000, 5000.000000, 1, '2017-07-30', '2018-02-18 22:32:18', '2018-02-18 22:32:18'),
(158, '180218158', 5, 1, 108, 3, NULL, 2, 1, NULL, NULL, NULL, 12900, 9900.000000, 5000.000000, 0, '2017-12-05', '2018-02-18 22:33:09', '2018-02-18 22:33:09'),
(159, '180218159', 5, 1, 112, 3, NULL, 2, 1, NULL, NULL, NULL, 13400, 13400.000000, 2000.000000, 0, '2017-07-07', '2018-02-18 23:20:09', '2018-02-18 23:20:09'),
(160, '180218160', 5, 1, 112, 3, NULL, 2, 1, NULL, NULL, NULL, 13400, 11400.000000, 2000.000000, 0, '2017-07-25', '2018-02-18 23:21:19', '2018-02-18 23:21:19'),
(161, '180218161', 5, 1, 112, 3, NULL, 2, 1, NULL, NULL, NULL, 10300, 9400.000000, 1000.000000, 0, '2017-10-17', '2018-02-18 23:22:05', '2018-02-18 23:22:05'),
(162, '180218162', 5, 1, 112, 3, NULL, 2, 1, NULL, NULL, NULL, 8700, 8400.000000, 3000.000000, 0, '2018-01-08', '2018-02-18 23:22:52', '2018-02-18 23:22:52'),
(163, '180218163', 5, 1, 114, 3, 5, 2, 1, '', NULL, NULL, 4200, 1900.000000, 1000.000000, 1, '2017-10-10', '2018-02-18 23:36:07', '2018-02-18 23:36:07'),
(164, '180219164', 3, 1, 115, 3, 3, 2, 1, '', NULL, NULL, 25800, 25800.000000, 25800.000000, 1, '2018-02-19', '2018-02-19 23:30:26', '2018-02-19 23:30:26'),
(165, '180219165', 3, 1, 74, 3, 3, 2, 1, '', NULL, NULL, 2760, 2760.000000, 2760.000000, 1, '2018-02-19', '2018-02-19 23:34:56', '2018-02-19 23:34:56'),
(166, '180219166', 3, 1, 73, 3, 3, 2, 1, '', NULL, NULL, 1340, 1340.000000, 1340.000000, 1, '2018-02-19', '2018-02-19 23:37:29', '2018-02-19 23:37:29'),
(167, '180223167', 3, 1, 81, 3, 3, 2, 1, '', NULL, NULL, 27000, 27000.000000, 27000.000000, 1, '2018-02-19', '2018-02-23 21:29:08', '2018-02-23 21:29:08'),
(168, '180223168', 3, 1, 61, 3, 3, 2, 1, '', NULL, NULL, 9200, 9200.000000, 9200.000000, 1, '2018-02-20', '2018-02-23 21:35:39', '2018-02-23 21:35:39'),
(169, '180223169', 3, 1, 75, 3, 3, 2, 1, '', NULL, NULL, 133890, 4000.000000, 20000.000000, 1, '2017-12-12', '2018-02-23 22:25:06', '2018-02-23 22:25:06'),
(170, '180223170', 3, 1, 75, 3, 3, 2, 1, '', NULL, NULL, 178690, 21400.000000, 30000.000000, 1, '2018-02-02', '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(171, '180223171', 3, 1, 75, 3, NULL, 2, 1, 'adjast bl', NULL, NULL, 150140, 148690.000000, 60220.000000, 0, '2018-02-20', '2018-02-23 22:35:18', '2018-02-23 22:35:18'),
(172, '180223172', 3, 1, 71, 3, NULL, 2, 1, NULL, NULL, NULL, 489881, 336823.000000, 11500.000000, 0, '2018-02-14', '2018-02-23 23:00:21', '2018-02-23 23:00:21'),
(173, '180223173', 3, 1, 71, 3, NULL, 2, 1, NULL, NULL, NULL, 489881, 325323.000000, 9000.000000, 0, '2018-02-17', '2018-02-23 23:01:29', '2018-02-23 23:01:29'),
(174, '180223174', 3, 1, 71, 3, NULL, 2, 1, NULL, NULL, NULL, 489881, 316323.000000, 4000.000000, 0, '2018-02-23', '2018-02-23 23:02:36', '2018-02-23 23:02:36'),
(175, '180223175', 3, 1, 71, 3, NULL, 2, 1, NULL, NULL, NULL, 489881, 312323.000000, 14000.000000, 0, '2018-02-23', '2018-02-23 23:03:56', '2018-02-23 23:03:56'),
(176, '180223176', 3, 1, 72, 3, NULL, 2, 1, NULL, NULL, NULL, 2955380, 2781274.000000, 30000.000000, 0, '2018-02-12', '2018-02-23 23:07:24', '2018-02-23 23:07:24'),
(177, '180223177', 3, 1, 72, 3, NULL, 2, 1, NULL, NULL, NULL, 2955380, 2751274.000000, 9000.000000, 0, '2018-02-13', '2018-02-23 23:08:02', '2018-02-23 23:08:02'),
(178, '180223178', 3, 1, 72, 3, NULL, 2, 1, NULL, NULL, NULL, 2955380, 2742274.000000, 9000.000000, 0, '2018-02-14', '2018-02-23 23:08:42', '2018-02-23 23:08:42'),
(179, '180223179', 3, 1, 72, 3, NULL, 2, 1, NULL, NULL, NULL, 2955380, 2733274.000000, 30000.000000, 0, '2018-02-17', '2018-02-23 23:09:51', '2018-02-23 23:09:51'),
(180, '180223180', 3, 1, 72, 3, NULL, 2, 1, NULL, NULL, NULL, 2955380, 2703274.000000, 11000.000000, 0, '2018-02-18', '2018-02-23 23:10:35', '2018-02-23 23:10:35'),
(181, '180223181', 3, 1, 72, 3, NULL, 2, 1, NULL, NULL, NULL, 2955380, 2692274.000000, 10000.000000, 0, '2018-02-20', '2018-02-23 23:11:39', '2018-02-23 23:11:39'),
(182, '180224182', 5, 1, 60, 3, 5, 2, 1, '', NULL, NULL, 12700, 2350.000000, 12700.000000, 1, '2018-02-13', '2018-02-24 15:58:37', '2018-02-24 15:58:37'),
(183, '180224183', 5, 1, 60, 3, 5, 2, 1, '', NULL, NULL, 16610, 16610.000000, 16610.000000, 1, '2018-02-14', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(184, '180224184', 5, 1, 60, 3, 5, 2, 1, '', NULL, NULL, 5950, 5950.000000, 5950.000000, 1, '2018-02-16', '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(185, '180224185', 5, 1, 60, 3, 5, 2, 1, '', NULL, NULL, 15100, 15100.000000, 15100.000000, 1, '2018-02-17', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(186, '180224186', 5, 1, 60, 3, 5, 2, 1, '', NULL, NULL, 4550, 4550.000000, 4550.000000, 1, '2018-02-18', '2018-02-24 16:34:23', '2018-02-24 16:34:23'),
(187, '180224187', 5, 1, 60, 3, 5, 2, 1, '', NULL, NULL, 6469, 6469.000000, 6469.000000, 1, '2018-02-19', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(188, '180224188', 5, 1, 60, 3, 5, 2, 1, '', NULL, NULL, 20198, 20198.000000, 20198.000000, 1, '2018-02-20', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(189, '180224189', 5, 1, 60, 3, 5, 2, 1, '', NULL, NULL, 7502, 7502.000000, 7502.000000, 1, '2018-02-23', '2018-02-24 17:19:25', '2018-02-24 17:19:25'),
(190, '180224190', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 3850, 3850.000000, 3850.000000, 1, '2017-09-27', '2018-02-25 00:16:54', '2018-02-25 00:16:54'),
(191, '180224191', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 58700, 58700.000000, 58700.000000, 1, '2017-09-15', '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(192, '180224192', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 29500, 29500.000000, 29500.000000, 1, '2017-09-19', '2018-02-25 00:34:55', '2018-02-25 00:34:55'),
(193, '180224193', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 19800, 19800.000000, 19800.000000, 1, '2017-09-19', '2018-02-25 00:38:04', '2018-02-25 00:38:04'),
(194, '180224194', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 14050, 14050.000000, 14050.000000, 1, '2017-09-22', '2018-02-25 00:46:56', '2018-02-25 00:46:56'),
(195, '180224195', 7, 1, 73, 3, 7, 4, 1, '', NULL, NULL, 7850, 7850.000000, 7850.000000, 1, '2017-09-30', '2018-02-25 00:54:36', '2018-02-25 00:54:36'),
(196, '180224196', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 14000, 14000.000000, 14000.000000, 1, '2017-09-30', '2018-02-25 01:05:44', '2018-02-25 01:05:44'),
(197, '180225197', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 7300, 7300.000000, 7300.000000, 1, '2017-10-07', '2018-02-25 18:52:33', '2018-02-25 18:52:33'),
(198, '180225198', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 17000, 17000.000000, 17000.000000, 1, '2017-10-07', '2018-02-25 18:59:13', '2018-02-25 18:59:13'),
(199, '180225199', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 21900, 21900.000000, 21900.000000, 1, '2017-10-16', '2018-02-25 19:02:44', '2018-02-25 19:02:44'),
(200, '180225200', 7, 1, 76, 3, 7, 4, 1, '', NULL, NULL, 28700, 28700.000000, 28700.000000, 1, '2017-10-20', '2018-02-25 19:08:08', '2018-02-25 19:08:08'),
(201, '180225201', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 29500, 29500.000000, 29500.000000, 1, '2017-11-03', '2018-02-25 19:14:46', '2018-02-25 19:14:46'),
(202, '180225202', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 37340, 37340.000000, 37340.000000, 1, '2017-11-03', '2018-02-25 19:19:58', '2018-02-25 19:19:58'),
(203, '180225203', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 10600, 10600.000000, 10600.000000, 1, '2017-11-05', '2018-02-25 19:22:56', '2018-02-25 19:22:56'),
(204, '180225204', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 10000, 10000.000000, 10000.000000, 1, '2017-11-06', '2018-02-25 19:27:12', '2018-02-25 19:27:12'),
(205, '180225205', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 8000, 8000.000000, 8000.000000, 1, '2017-11-08', '2018-02-25 19:46:47', '2018-02-25 19:46:47'),
(206, '180225206', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 800, 800.000000, 800.000000, 1, '2017-11-08', '2018-02-25 19:49:55', '2018-02-25 19:49:55'),
(207, '180225207', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 19200, 19200.000000, 19200.000000, 1, '2017-11-10', '2018-02-25 19:54:16', '2018-02-25 19:54:16'),
(208, '180225208', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 25600, 25600.000000, 25600.000000, 1, '2017-11-15', '2018-02-25 20:02:35', '2018-02-25 20:02:35'),
(209, '180225209', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 11660, 11660.000000, 11660.000000, 1, '2017-11-17', '2018-02-25 20:05:47', '2018-02-25 20:05:47'),
(210, '180225210', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 18000, 9300.000000, 18000.000000, 1, '2017-11-18', '2018-02-25 20:14:40', '2018-02-25 20:14:40'),
(211, '180225211', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 13700, 13700.000000, 13700.000000, 1, '2017-11-20', '2018-02-25 20:21:01', '2018-02-25 20:21:01'),
(212, '180225212', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 13000, 13000.000000, 13000.000000, 1, '2017-11-24', '2018-02-25 20:52:12', '2018-02-25 20:52:12'),
(213, '180225213', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 10600, 10600.000000, 10600.000000, 1, '2017-11-26', '2018-02-25 20:57:01', '2018-02-25 20:57:01'),
(214, '180225214', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 6250, 6250.000000, 6250.000000, 1, '2017-11-29', '2018-02-25 20:58:37', '2018-02-25 20:58:37'),
(215, '180225215', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 11800, 11800.000000, 11800.000000, 1, '2017-12-01', '2018-02-25 21:01:25', '2018-02-25 21:01:25'),
(216, '180225216', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 7300, 7300.000000, 7300.000000, 1, '2017-12-05', '2018-02-25 21:05:02', '2018-02-25 21:05:02'),
(217, '180225217', 7, 1, 117, 3, 7, 4, 1, '', NULL, NULL, 16600, 16600.000000, 16600.000000, 1, '2017-12-05', '2018-02-25 21:10:47', '2018-02-25 21:10:47'),
(218, '180225218', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 9000, 9000.000000, 9000.000000, 1, '2017-12-08', '2018-02-25 21:16:55', '2018-02-25 21:16:55'),
(219, '180225219', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 11800, 11800.000000, 11800.000000, 1, '2017-12-11', '2018-02-25 21:22:00', '2018-02-25 21:22:00'),
(220, '180225220', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 12250, 12250.000000, 12250.000000, 1, '2017-12-15', '2018-02-25 21:24:59', '2018-02-25 21:24:59'),
(221, '180225221', 7, 1, 86, 3, 7, 4, 1, '', NULL, NULL, 1600, 1600.000000, 1600.000000, 1, '2017-12-17', '2018-02-25 21:27:39', '2018-02-25 21:27:39'),
(222, '180225222', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 1400, 1400.000000, 1400.000000, 1, '2017-12-18', '2018-02-25 21:29:40', '2018-02-25 21:29:40'),
(223, '180225223', 7, 1, 117, 3, 7, 4, 1, '', NULL, NULL, 20500, 20500.000000, 20500.000000, 1, '2017-12-19', '2018-02-25 21:32:15', '2018-02-25 21:32:15'),
(224, '180225224', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 11600, 11600.000000, 11600.000000, 1, '2017-12-20', '2018-02-25 21:35:05', '2018-02-25 21:35:05'),
(225, '180225225', 7, 1, 117, 3, 7, 4, 1, '', NULL, NULL, 31000, 31000.000000, 31000.000000, 1, '2017-12-22', '2018-02-25 21:40:10', '2018-02-25 21:40:10'),
(226, '180225226', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 7380, 7380.000000, 7380.000000, 1, '2017-12-29', '2018-02-25 21:44:04', '2018-02-25 21:44:04'),
(227, '180225227', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 6900, 6900.000000, 6900.000000, 1, '2018-01-01', '2018-02-25 21:48:34', '2018-02-25 21:48:34'),
(228, '180225228', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 4380, 4380.000000, 4380.000000, 1, '2018-01-01', '2018-02-25 22:16:13', '2018-02-25 22:16:13'),
(229, '180225229', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 6100, 6100.000000, 6100.000000, 1, '2018-01-03', '2018-02-25 22:19:46', '2018-02-25 22:19:46'),
(230, '180225230', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 12640, 12640.000000, 12640.000000, 1, '2018-01-03', '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(231, '180225231', 7, 1, 117, 3, 7, 4, 1, '', NULL, NULL, 46400, 46400.000000, 46400.000000, 1, '2018-01-05', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(232, '180225232', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 5000, 5000.000000, 5000.000000, 1, '2018-01-10', '2018-02-25 22:42:39', '2018-02-25 22:42:39'),
(233, '180225233', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 4800, 4800.000000, 4800.000000, 1, '2018-01-13', '2018-02-25 22:45:19', '2018-02-25 22:45:19'),
(234, '180225234', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 13800, 13800.000000, 13800.000000, 1, '2018-01-14', '2018-02-25 22:53:29', '2018-02-25 22:53:29'),
(235, '180225235', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 4200, 4200.000000, 4200.000000, 1, '2018-01-14', '2018-02-25 22:56:28', '2018-02-25 22:56:28'),
(236, '180225236', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 27700, 27700.000000, 27700.000000, 1, '2018-01-16', '2018-02-25 23:05:25', '2018-02-25 23:05:25'),
(237, '180225237', 7, 1, 118, 3, 7, 4, 1, '', NULL, NULL, 63620, 9850.000000, 63620.000000, 1, '2018-01-22', '2018-02-25 23:28:02', '2018-02-25 23:28:02'),
(238, '180225238', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 4370, 4370.000000, 4370.000000, 1, '2018-01-22', '2018-02-25 23:34:09', '2018-02-25 23:34:09'),
(239, '180226239', 7, 1, 119, 3, 7, 4, 1, '', NULL, NULL, 46273, 46273.000000, 46273.000000, 1, '2017-09-30', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(240, '180226240', 7, 1, 119, 3, NULL, 4, 1, NULL, NULL, NULL, 211908, 211908.000000, 211908.000000, 0, '2018-01-31', '2018-02-26 23:43:21', '2018-02-26 23:43:21'),
(241, '180226241', 7, 1, 119, 3, 7, 4, 1, '', NULL, NULL, 95091, 95091.000000, 95091.000000, 1, '2018-01-31', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(242, '180226242', 7, 1, 119, 3, 7, 4, 1, '', NULL, NULL, 144048, 144048.000000, 144048.000000, 1, '2018-01-31', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(243, '180226243', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 11485, 11485.000000, 11485.000000, 1, '2018-01-22', '2018-02-27 01:21:11', '2018-02-27 01:21:11'),
(244, '180226244', 7, 1, 116, 3, 7, 4, 1, '', NULL, NULL, 18200, 18200.000000, 18200.000000, 1, '2018-01-23', '2018-02-27 01:26:28', '2018-02-27 01:26:28'),
(245, '180226245', 7, 1, 117, 3, 7, 4, 1, '', NULL, NULL, 64000, 64000.000000, 64000.000000, 1, '2018-01-24', '2018-02-27 01:30:53', '2018-02-27 01:30:53'),
(246, '180228246', 5, 1, 116, 3, 5, 4, 1, '', NULL, NULL, 29050, 29050.000000, 29050.000000, 1, '2018-01-24', '2018-02-28 18:47:13', '2018-02-28 18:47:13'),
(247, '180228247', 5, 1, 85, 3, 5, 4, 1, '', NULL, NULL, 8400, 8400.000000, 8400.000000, 1, '2018-01-27', '2018-02-28 18:51:12', '2018-02-28 18:51:12'),
(248, '180228248', 5, 1, 116, 3, 5, 4, 1, '', NULL, NULL, 3950, 3950.000000, 3950.000000, 1, '2018-01-27', '2018-02-28 18:56:18', '2018-02-28 18:56:18'),
(249, '180228249', 5, 1, 116, 3, 5, 4, 1, '', NULL, NULL, 33600, 33600.000000, 33600.000000, 1, '2018-01-31', '2018-02-28 19:00:36', '2018-02-28 19:00:36'),
(250, '180228250', 5, 1, 116, 3, 5, 4, 1, '', NULL, NULL, 11000, 11000.000000, 11000.000000, 1, '2018-01-31', '2018-02-28 19:03:40', '2018-02-28 19:03:40'),
(251, '180228251', 5, 1, 116, 3, 5, 4, 1, '', NULL, NULL, 16800, 16800.000000, 16800.000000, 1, '2018-01-31', '2018-02-28 19:06:03', '2018-02-28 19:06:03'),
(252, '180228252', 5, 1, 116, 3, 5, 4, 1, '', NULL, NULL, 11050, 11050.000000, 11050.000000, 1, '2018-02-06', '2018-02-28 19:11:58', '2018-02-28 19:11:58'),
(253, '180228253', 5, 1, 73, 3, 5, 4, 1, '', NULL, NULL, 7400, 3400.000000, 3400.000000, 1, '2018-02-10', '2018-02-28 19:15:18', '2018-02-28 19:15:18'),
(254, '180228254', 5, 1, 116, 3, 5, 4, 1, '', NULL, NULL, 13600, 13600.000000, 13600.000000, 1, '2018-02-12', '2018-02-28 19:17:07', '2018-02-28 19:17:07'),
(255, '180228255', 5, 1, 116, 3, 5, 4, 1, '', NULL, NULL, 4800, 4800.000000, 4800.000000, 1, '2018-02-13', '2018-02-28 19:18:29', '2018-02-28 19:18:29'),
(256, '180228256', 5, 1, 85, 3, 5, 4, 1, '', NULL, NULL, 9500, 9500.000000, 9500.000000, 1, '2018-02-16', '2018-02-28 19:21:00', '2018-02-28 19:21:00'),
(257, '180228257', 5, 1, 117, 3, 5, 4, 1, '', NULL, NULL, 19620, 19620.000000, 19620.000000, 1, '2018-02-23', '2018-02-28 19:25:05', '2018-02-28 19:25:05'),
(258, '180228258', 5, 1, 116, 3, 5, 4, 1, '', NULL, NULL, 4650, 4650.000000, 4650.000000, 1, '2018-02-24', '2018-02-28 19:27:53', '2018-02-28 19:27:53'),
(259, '180228259', 5, 1, 119, 3, 5, 4, 1, '', NULL, NULL, 213283, 213283.000000, 213283.000000, 1, '2017-10-31', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(260, '180228260', 5, 1, 116, 3, 5, 4, 1, '', NULL, NULL, 199201, 199201.000000, 199201.000000, 1, '2017-11-30', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(261, '180303261', 6, 1, 119, 3, 6, 4, 1, '', NULL, NULL, 445524, 445524.000000, 445524.000000, 1, '2017-12-31', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(262, '180303262', 6, 1, 119, 3, NULL, 4, 1, NULL, NULL, NULL, 232422, 232422.000000, 232422.000000, 0, '2018-02-28', '2018-03-04 00:04:43', '2018-03-04 00:04:43'),
(263, '180303263', 6, 1, 116, 3, 6, 4, 1, '', NULL, NULL, 5150, 5150.000000, 5150.000000, 1, '2018-02-28', '2018-03-04 01:04:33', '2018-03-04 01:04:33'),
(264, '180303264', 6, 1, 116, 3, 6, 4, 1, '', NULL, NULL, 6500, 6500.000000, 6500.000000, 1, '2018-02-28', '2018-03-04 01:07:46', '2018-03-04 01:07:46'),
(265, '180304265', 5, 1, 72, 3, 5, 2, 1, '', NULL, NULL, 2726870, 44600.000000, 12500.000000, 1, '2018-02-19', '2018-03-04 16:58:34', '2018-03-04 16:58:34'),
(266, '180304266', 5, 1, 72, 3, NULL, 2, 1, NULL, NULL, NULL, 3172880, 2887274.000000, 10000.000000, 0, '2018-02-25', '2018-03-04 17:08:06', '2018-03-04 17:08:06'),
(267, '180304267', 5, 1, 72, 3, NULL, 2, 1, NULL, NULL, NULL, 3172880, 2877274.000000, 7400.000000, 0, '2018-02-25', '2018-03-04 17:09:17', '2018-03-04 17:09:17'),
(268, '180304268', 5, 1, 72, 3, NULL, 2, 1, NULL, NULL, NULL, 3172880, 2869874.000000, 18000.000000, 0, '2018-02-26', '2018-03-04 17:10:26', '2018-03-04 17:10:26'),
(269, '180304269', 5, 1, 72, 3, 5, 2, 1, '', NULL, NULL, 3003620, 151750.000000, 35200.000000, 1, '2018-02-28', '2018-03-04 17:16:43', '2018-03-04 17:16:43'),
(270, '180304270', 6, 1, 119, 3, 6, 4, 1, '', NULL, NULL, 1425, 1425.000000, 1425.000000, 1, '2018-01-31', '2018-03-04 21:42:03', '2018-03-04 21:42:03'),
(271, '180304271', 6, 1, 116, 3, 6, 4, 1, '', NULL, NULL, 12950, 12950.000000, 12950.000000, 1, '2018-02-24', '2018-03-04 21:53:46', '2018-03-04 21:53:46'),
(272, '180304272', 5, 1, 72, 3, NULL, 2, 1, NULL, NULL, NULL, 3324630, 2968424.000000, 52670.000000, 0, '2018-03-04', '2018-03-04 23:00:22', '2018-03-04 23:00:22'),
(273, '180304273', 6, 1, 116, 3, 6, 4, 1, '', NULL, NULL, 25980, 25980.000000, 25980.000000, 1, '2018-03-02', '2018-03-05 00:38:14', '2018-03-05 00:38:14'),
(274, '180304274', 6, 1, 119, 3, 6, 4, 1, '', NULL, NULL, 16952, 16952.000000, 16952.000000, 1, '2018-03-03', '2018-03-05 00:56:07', '2018-03-05 00:56:07'),
(275, '180305275', 5, 1, 60, 3, 5, 2, 1, '', NULL, NULL, 5860, 5860.000000, 5860.000000, 1, '2018-02-24', '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(276, '180305276', 5, 1, 60, 3, 5, 2, 1, '', NULL, NULL, 5429, 5429.000000, 5429.000000, 1, '2018-02-25', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(277, '180305277', 5, 1, 60, 3, 5, 2, 1, '', NULL, NULL, 8382, 8382.000000, 8382.000000, 1, '2018-02-26', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(278, '180305278', 5, 1, 60, 3, 5, 2, 1, '', NULL, NULL, 2200, 2200.000000, 2200.000000, 1, '2018-02-27', '2018-03-05 16:32:20', '2018-03-05 16:32:20'),
(279, '180305279', 5, 1, 60, 3, 5, 2, 1, '', NULL, NULL, 9197, 9197.000000, 9197.000000, 1, '2018-02-28', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(280, '180305280', 5, 1, 61, 3, 5, 2, 1, '', NULL, NULL, 7250, 7250.000000, 7250.000000, 1, '2018-02-24', '2018-03-05 16:57:45', '2018-03-05 16:57:45'),
(281, '180305281', 5, 1, 73, 3, 5, 2, 1, '', NULL, NULL, 6620, 2620.000000, 6620.000000, 1, '2018-02-26', '2018-03-05 17:03:42', '2018-03-05 17:03:42'),
(282, '180305282', 5, 1, 61, 3, 5, 2, 1, '', NULL, NULL, 8900, 8900.000000, 8900.000000, 1, '2018-02-28', '2018-03-05 17:09:19', '2018-03-05 17:09:19'),
(283, '180305283', 5, 1, 105, 3, 5, 2, 1, '', NULL, NULL, 6300, 6300.000000, 6300.000000, 1, '2018-02-28', '2018-03-05 17:12:09', '2018-03-05 17:12:09'),
(284, '180401284', 1, 1, 114, 3, NULL, 2, 1, '4546', NULL, NULL, 4200, 3200.000000, 2000.000000, 0, '2018-04-01', '2018-04-01 05:12:03', '2018-04-01 05:12:03'),
(285, '180401285', 1, 1, 114, 3, 1, 2, 1, NULL, NULL, NULL, 3600, 1200.000000, 100.000000, 0, '2018-04-01', '2018-04-01 05:45:23', '2018-04-01 05:45:23'),
(286, '201002286', 1, 1, 79, 3, 1, 4, 1, '', NULL, NULL, 22300, 500.000000, 20000.000000, 1, '2020-10-02', '2020-10-02 14:57:36', '2020-10-02 14:57:36');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_payment_history_item`
--

CREATE TABLE `inventory_payment_history_item` (
  `id` int(11) NOT NULL,
  `fk_payment_id` int(11) NOT NULL,
  `fk_sales_id` int(11) UNSIGNED NOT NULL,
  `sales_paid` decimal(17,6) NOT NULL,
  `type` tinyint(4) DEFAULT 0 COMMENT '1=First,0=Payment',
  `sales_last_due` decimal(17,6) NOT NULL DEFAULT 0.000000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_payment_history_item`
--

INSERT INTO `inventory_payment_history_item` (`id`, `fk_payment_id`, `fk_sales_id`, `sales_paid`, `type`, `sales_last_due`, `created_at`, `updated_at`) VALUES
(2, 2, 23, 12550.000000, 1, 12550.000000, '2018-02-03 14:29:59', '2018-02-03 14:29:59'),
(3, 3, 24, 4000.000000, 1, 4000.000000, '2018-02-03 15:09:35', '2018-02-03 15:09:35'),
(4, 4, 25, 5000.000000, 1, 20870.000000, '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(5, 5, 26, 60000.000000, 0, 223800.000000, '2018-02-03 19:45:39', '2018-02-03 19:45:39'),
(6, 5, 31, 0.000000, 0, 62946.000000, '2018-02-03 19:45:39', '2018-02-03 19:45:39'),
(7, 6, 32, 17000.000000, 1, 23900.000000, '2018-02-04 10:06:04', '2018-02-04 10:06:04'),
(8, 7, 32, 6900.000000, 0, 6900.000000, '2018-02-04 11:08:52', '2018-02-04 11:08:52'),
(9, 7, 33, 8100.000000, 0, 9200.000000, '2018-02-04 11:08:52', '2018-02-04 11:08:52'),
(10, 7, 34, 0.000000, 0, 13450.000000, '2018-02-04 11:08:52', '2018-02-04 11:08:52'),
(11, 8, 26, 150000.000000, 0, 163800.000000, '2018-02-04 11:21:31', '2018-02-04 11:21:31'),
(12, 8, 31, 0.000000, 0, 62946.000000, '2018-02-04 11:21:31', '2018-02-04 11:21:31'),
(13, 8, 35, 0.000000, 0, 157800.000000, '2018-02-04 11:21:31', '2018-02-04 11:21:31'),
(14, 9, 26, 13800.000000, 0, 13800.000000, '2018-02-04 11:23:22', '2018-02-04 11:23:22'),
(15, 9, 31, 62946.000000, 0, 62946.000000, '2018-02-04 11:23:22', '2018-02-04 11:23:22'),
(16, 9, 35, 5754.000000, 0, 157800.000000, '2018-02-04 11:23:22', '2018-02-04 11:23:22'),
(17, 10, 46, 15000.000000, 1, 18050.000000, '2018-02-04 16:44:22', '2018-02-04 16:44:22'),
(18, 11, 25, 5000.000000, 0, 15870.000000, '2018-02-04 16:45:47', '2018-02-04 16:45:47'),
(19, 11, 46, 0.000000, 0, 3050.000000, '2018-02-04 16:45:47', '2018-02-04 16:45:47'),
(20, 12, 48, 16500.000000, 1, 16500.000000, '2018-02-04 17:01:14', '2018-02-04 17:01:14'),
(21, 13, 49, 16200.000000, 1, 16200.000000, '2018-02-04 17:04:08', '2018-02-04 17:04:08'),
(22, 14, 58, 6700.000000, 1, 6700.000000, '2018-02-06 14:15:06', '2018-02-06 14:15:06'),
(23, 15, 59, 5000.000000, 1, 5600.000000, '2018-02-06 14:17:33', '2018-02-06 14:17:33'),
(24, 16, 62, 16500.000000, 1, 16500.000000, '2018-02-06 14:46:29', '2018-02-06 14:46:29'),
(25, 17, 59, 600.000000, 0, 600.000000, '2018-02-06 15:03:20', '2018-02-06 15:03:20'),
(26, 17, 60, 2800.000000, 0, 2800.000000, '2018-02-06 15:03:20', '2018-02-06 15:03:20'),
(27, 18, 33, 1100.000000, 0, 1100.000000, '2018-02-06 15:07:08', '2018-02-06 15:07:08'),
(28, 18, 34, 7800.000000, 0, 13450.000000, '2018-02-06 15:07:08', '2018-02-06 15:07:08'),
(29, 18, 51, 0.000000, 0, 10400.000000, '2018-02-06 15:07:08', '2018-02-06 15:07:08'),
(30, 18, 57, 0.000000, 0, 5600.000000, '2018-02-06 15:07:08', '2018-02-06 15:07:08'),
(31, 19, 35, 65000.000000, 0, 152046.000000, '2018-02-06 15:09:08', '2018-02-06 15:09:08'),
(32, 19, 36, 0.000000, 0, 87000.000000, '2018-02-06 15:09:08', '2018-02-06 15:09:08'),
(33, 19, 61, 0.000000, 0, 26350.000000, '2018-02-06 15:09:08', '2018-02-06 15:09:08'),
(34, 20, 53, 1773543.000000, 0, 1773543.000000, '2018-02-06 15:26:17', '2018-02-06 15:26:17'),
(35, 20, 54, 118607.000000, 0, 1706695.000000, '2018-02-06 15:26:17', '2018-02-06 15:26:17'),
(36, 20, 55, 0.000000, 0, 140600.000000, '2018-02-06 15:26:17', '2018-02-06 15:26:17'),
(37, 20, 56, 0.000000, 0, 881991.000000, '2018-02-06 15:26:17', '2018-02-06 15:26:17'),
(38, 21, 64, 115208.000000, 1, 115208.000000, '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(39, 22, 65, 8600.000000, 1, 13800.000000, '2018-02-06 15:57:12', '2018-02-06 15:57:12'),
(40, 23, 66, 13800.000000, 1, 13800.000000, '2018-02-06 15:59:50', '2018-02-06 15:59:50'),
(41, 24, 67, 8100.000000, 1, 8100.000000, '2018-02-06 16:01:43', '2018-02-06 16:01:43'),
(42, 25, 68, 4900.000000, 1, 4900.000000, '2018-02-06 16:07:23', '2018-02-06 16:07:23'),
(43, 26, 69, 2600.000000, 1, 2600.000000, '2018-02-06 16:09:32', '2018-02-06 16:09:32'),
(44, 27, 71, 6000.000000, 1, 7700.000000, '2018-02-06 16:31:48', '2018-02-06 16:31:48'),
(45, 28, 73, 5150.000000, 1, 5150.000000, '2018-02-06 16:37:39', '2018-02-06 16:37:39'),
(46, 29, 74, 4100.000000, 1, 5400.000000, '2018-02-06 16:40:14', '2018-02-06 16:40:14'),
(47, 30, 75, 2450.000000, 1, 2450.000000, '2018-02-06 16:42:20', '2018-02-06 16:42:20'),
(48, 31, 76, 1780.000000, 1, 1780.000000, '2018-02-06 16:44:57', '2018-02-06 16:44:57'),
(49, 32, 77, 900.000000, 1, 900.000000, '2018-02-06 16:49:44', '2018-02-06 16:49:44'),
(50, 33, 78, 750.000000, 1, 750.000000, '2018-02-06 16:52:04', '2018-02-06 16:52:04'),
(51, 34, 79, 5700.000000, 1, 5700.000000, '2018-02-06 16:53:58', '2018-02-06 16:53:58'),
(52, 35, 80, 11800.000000, 1, 11800.000000, '2018-02-06 16:56:09', '2018-02-06 16:56:09'),
(53, 36, 35, 87046.000000, 0, 87046.000000, '2018-02-06 17:08:54', '2018-02-06 17:08:54'),
(54, 36, 36, 2954.000000, 0, 87000.000000, '2018-02-06 17:08:54', '2018-02-06 17:08:54'),
(55, 36, 61, 0.000000, 0, 26350.000000, '2018-02-06 17:08:54', '2018-02-06 17:08:54'),
(56, 36, 81, 0.000000, 0, 80570.000000, '2018-02-06 17:08:54', '2018-02-06 17:08:54'),
(57, 37, 36, 50000.000000, 0, 84046.000000, '2018-02-06 17:09:53', '2018-02-06 17:09:53'),
(58, 37, 61, 0.000000, 0, 26350.000000, '2018-02-06 17:09:53', '2018-02-06 17:09:53'),
(59, 37, 81, 0.000000, 0, 80570.000000, '2018-02-06 17:09:53', '2018-02-06 17:09:53'),
(60, 38, 82, 3330.000000, 1, 3330.000000, '2018-02-06 17:12:21', '2018-02-06 17:12:21'),
(61, 39, 83, 8700.000000, 1, 8700.000000, '2018-02-06 17:14:51', '2018-02-06 17:14:51'),
(62, 40, 85, 16500.000000, 1, 16500.000000, '2018-02-06 18:06:12', '2018-02-06 18:06:12'),
(63, 41, 86, 350.000000, 1, 350.000000, '2018-02-06 18:08:02', '2018-02-06 18:08:02'),
(64, 42, 89, 3950.000000, 1, 3950.000000, '2018-02-06 18:46:25', '2018-02-06 18:46:25'),
(65, 43, 90, 4120.000000, 1, 4120.000000, '2018-02-06 18:50:59', '2018-02-06 18:50:59'),
(66, 44, 91, 3400.000000, 1, 3400.000000, '2018-02-07 11:19:41', '2018-02-07 11:19:41'),
(67, 45, 92, 4200.000000, 1, 4200.000000, '2018-02-07 11:25:43', '2018-02-07 11:25:43'),
(68, 46, 93, 15000.000000, 1, 23900.000000, '2018-02-07 11:52:18', '2018-02-07 11:52:18'),
(69, 47, 94, 10000.000000, 1, 13450.000000, '2018-02-07 11:57:23', '2018-02-07 11:57:23'),
(70, 48, 95, 43000.000000, 1, 50100.000000, '2018-02-07 12:04:20', '2018-02-07 12:04:20'),
(71, 49, 96, 31500.000000, 1, 31500.000000, '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(72, 50, 97, 40500.000000, 1, 42550.000000, '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(73, 51, 98, 37300.000000, 1, 37300.000000, '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(74, 52, 99, 16000.000000, 1, 16000.000000, '2018-02-07 13:02:18', '2018-02-07 13:02:18'),
(75, 53, 103, 5600.000000, 1, 5600.000000, '2018-02-07 13:46:14', '2018-02-07 13:46:14'),
(76, 54, 104, 31800.000000, 1, 31800.000000, '2018-02-07 13:50:02', '2018-02-07 13:50:02'),
(77, 55, 105, 9100.000000, 1, 9100.000000, '2018-02-07 13:52:23', '2018-02-07 13:52:23'),
(78, 56, 106, 47500.000000, 1, 67800.000000, '2018-02-07 13:58:18', '2018-02-07 13:58:18'),
(79, 57, 107, 1460.000000, 1, 1460.000000, '2018-02-07 14:05:51', '2018-02-07 14:05:51'),
(80, 58, 108, 6280.000000, 1, 6280.000000, '2018-02-07 14:09:35', '2018-02-07 14:09:35'),
(81, 59, 109, 122385.000000, 1, 122385.000000, '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(82, 60, 110, 8100.000000, 1, 8100.000000, '2018-02-07 14:32:39', '2018-02-07 14:32:39'),
(83, 61, 111, 24000.000000, 1, 24000.000000, '2018-02-07 14:34:13', '2018-02-07 14:34:13'),
(84, 62, 112, 3700.000000, 1, 3700.000000, '2018-02-07 14:36:39', '2018-02-07 14:36:39'),
(85, 63, 113, 18825.000000, 1, 18825.000000, '2018-02-07 14:40:47', '2018-02-07 14:40:47'),
(86, 64, 114, 16485.000000, 1, 16485.000000, '2018-02-07 14:46:45', '2018-02-07 14:46:45'),
(87, 65, 115, 13700.000000, 1, 13700.000000, '2018-02-07 14:51:36', '2018-02-07 14:51:36'),
(88, 66, 116, 30200.000000, 1, 30200.000000, '2018-02-07 14:56:31', '2018-02-07 14:56:31'),
(89, 67, 117, 37000.000000, 1, 52930.000000, '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(90, 68, 119, 61100.000000, 1, 61100.000000, '2018-02-07 15:48:19', '2018-02-07 15:48:19'),
(91, 69, 95, 7100.000000, 0, 7100.000000, '2018-02-07 15:57:24', '2018-02-07 15:57:24'),
(92, 69, 97, 2050.000000, 0, 2050.000000, '2018-02-07 15:57:24', '2018-02-07 15:57:24'),
(93, 69, 100, 16000.000000, 0, 16000.000000, '2018-02-07 15:57:24', '2018-02-07 15:57:24'),
(94, 69, 101, 20850.000000, 0, 29850.000000, '2018-02-07 15:57:24', '2018-02-07 15:57:24'),
(95, 69, 106, 0.000000, 0, 20300.000000, '2018-02-07 15:57:24', '2018-02-07 15:57:24'),
(96, 69, 120, 0.000000, 0, 21150.000000, '2018-02-07 15:57:24', '2018-02-07 15:57:24'),
(97, 70, 121, 25500.000000, 1, 25500.000000, '2018-02-07 16:05:03', '2018-02-07 16:05:03'),
(98, 71, 122, 27300.000000, 1, 27300.000000, '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(99, 72, 123, 9150.000000, 1, 9150.000000, '2018-02-07 16:16:02', '2018-02-07 16:16:02'),
(100, 73, 101, 9000.000000, 0, 9000.000000, '2018-02-07 16:29:58', '2018-02-07 16:29:58'),
(101, 73, 106, 20300.000000, 0, 20300.000000, '2018-02-07 16:29:58', '2018-02-07 16:29:58'),
(102, 73, 120, 21150.000000, 0, 21150.000000, '2018-02-07 16:29:58', '2018-02-07 16:29:58'),
(103, 73, 124, 9260.000000, 0, 9260.000000, '2018-02-07 16:29:58', '2018-02-07 16:29:58'),
(104, 73, 125, 2290.000000, 0, 2400.000000, '2018-02-07 16:29:58', '2018-02-07 16:29:58'),
(105, 74, 126, 5300.000000, 1, 5300.000000, '2018-02-07 16:31:55', '2018-02-07 16:31:55'),
(106, 75, 127, 5950.000000, 1, 5950.000000, '2018-02-07 16:34:49', '2018-02-07 16:34:49'),
(107, 76, 128, 5200.000000, 1, 5200.000000, '2018-02-07 16:36:47', '2018-02-07 16:36:47'),
(108, 77, 129, 8300.000000, 1, 8300.000000, '2018-02-07 16:39:18', '2018-02-07 16:39:18'),
(109, 78, 130, 6300.000000, 1, 6300.000000, '2018-02-07 16:41:46', '2018-02-07 16:41:46'),
(110, 79, 131, 24100.000000, 1, 24800.000000, '2018-02-07 16:49:25', '2018-02-07 16:49:25'),
(111, 80, 132, 29000.000000, 1, 29000.000000, '2018-02-07 16:51:49', '2018-02-07 16:51:49'),
(112, 81, 133, 22000.000000, 1, 22000.000000, '2018-02-07 16:54:25', '2018-02-07 16:54:25'),
(113, 82, 134, 16600.000000, 1, 16600.000000, '2018-02-07 16:56:47', '2018-02-07 16:56:47'),
(114, 83, 135, 16900.000000, 1, 16900.000000, '2018-02-07 17:00:31', '2018-02-07 17:00:31'),
(115, 84, 136, 4000.000000, 1, 485281.000000, '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(116, 85, 125, 110.000000, 0, 110.000000, '2018-02-07 19:22:32', '2018-02-07 19:22:32'),
(117, 85, 136, 135558.000000, 0, 481281.000000, '2018-02-07 19:22:32', '2018-02-07 19:22:32'),
(118, 86, 52, 110000.000000, 0, 110000.000000, '2018-02-07 19:26:49', '2018-02-07 19:26:49'),
(119, 87, 71, 1700.000000, 0, 1700.000000, '2018-02-07 19:28:33', '2018-02-07 19:28:33'),
(120, 87, 74, 1300.000000, 0, 1300.000000, '2018-02-07 19:28:33', '2018-02-07 19:28:33'),
(121, 88, 65, 5200.000000, 0, 5200.000000, '2018-02-07 19:30:06', '2018-02-07 19:30:06'),
(122, 89, 146, 33000.000000, 1, 33000.000000, '2018-02-09 12:08:25', '2018-02-09 12:08:25'),
(123, 90, 148, 5900.000000, 1, 5900.000000, '2018-02-09 12:58:37', '2018-02-09 12:58:37'),
(124, 91, 149, 3180.000000, 1, 3180.000000, '2018-02-09 13:01:34', '2018-02-09 13:01:34'),
(125, 92, 151, 750.000000, 1, 750.000000, '2018-02-09 13:38:04', '2018-02-09 13:38:04'),
(126, 93, 153, 3600.000000, 1, 3600.000000, '2018-02-09 13:44:20', '2018-02-09 13:44:20'),
(127, 94, 154, 3080.000000, 1, 3080.000000, '2018-02-09 14:08:24', '2018-02-09 14:08:24'),
(128, 95, 155, 1870.000000, 1, 1870.000000, '2018-02-09 14:10:30', '2018-02-09 14:10:30'),
(129, 96, 157, 20500.000000, 1, 20500.000000, '2018-02-09 14:24:09', '2018-02-09 14:24:09'),
(130, 97, 158, 8960.000000, 1, 8960.000000, '2018-02-09 14:35:03', '2018-02-09 14:35:03'),
(131, 98, 159, 6700.000000, 1, 6700.000000, '2018-02-09 14:36:52', '2018-02-09 14:36:52'),
(132, 99, 160, 34300.000000, 1, 34300.000000, '2018-02-09 14:43:44', '2018-02-09 14:43:44'),
(133, 100, 161, 4900.000000, 1, 4900.000000, '2018-02-09 14:45:41', '2018-02-09 14:45:41'),
(134, 101, 162, 35500.000000, 1, 35500.000000, '2018-02-09 14:48:50', '2018-02-09 14:48:50'),
(135, 102, 163, 8450.000000, 1, 8450.000000, '2018-02-09 14:50:58', '2018-02-09 14:50:58'),
(136, 103, 164, 12300.000000, 1, 12300.000000, '2018-02-09 14:54:14', '2018-02-09 14:54:14'),
(137, 104, 165, 28225.000000, 1, 28225.000000, '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(138, 105, 166, 8200.000000, 1, 8200.000000, '2018-02-09 15:07:25', '2018-02-09 15:07:25'),
(139, 106, 167, 15000.000000, 1, 15000.000000, '2018-02-09 15:09:42', '2018-02-09 15:09:42'),
(140, 107, 168, 11000.000000, 1, 11000.000000, '2018-02-09 15:13:17', '2018-02-09 15:13:17'),
(141, 108, 171, 7900.000000, 1, 7900.000000, '2018-02-09 15:39:17', '2018-02-09 15:39:17'),
(142, 109, 173, 33500.000000, 1, 33500.000000, '2018-02-09 16:01:25', '2018-02-09 16:01:25'),
(143, 110, 176, 3900.000000, 1, 3900.000000, '2018-02-09 16:26:28', '2018-02-09 16:26:28'),
(144, 111, 177, 19900.000000, 1, 19900.000000, '2018-02-09 16:41:08', '2018-02-09 16:41:08'),
(145, 112, 178, 6800.000000, 1, 6800.000000, '2018-02-09 16:43:02', '2018-02-09 16:43:02'),
(146, 113, 179, 16000.000000, 1, 16000.000000, '2018-02-09 16:47:49', '2018-02-09 16:47:49'),
(147, 114, 180, 20175.000000, 1, 20175.000000, '2018-02-09 16:50:37', '2018-02-09 16:50:37'),
(148, 115, 181, 26600.000000, 1, 26600.000000, '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(149, 116, 70, 47360.000000, 0, 47360.000000, '2018-02-09 17:07:54', '2018-02-09 17:07:54'),
(150, 116, 72, 7650.000000, 0, 7650.000000, '2018-02-09 17:07:54', '2018-02-09 17:07:54'),
(151, 116, 87, 106100.000000, 0, 106100.000000, '2018-02-09 17:07:54', '2018-02-09 17:07:54'),
(152, 116, 117, 15930.000000, 0, 15930.000000, '2018-02-09 17:07:54', '2018-02-09 17:07:54'),
(153, 116, 150, 59570.000000, 0, 59570.000000, '2018-02-09 17:07:54', '2018-02-09 17:07:54'),
(154, 116, 156, 11480.000000, 0, 25610.000000, '2018-02-09 17:07:54', '2018-02-09 17:07:54'),
(155, 116, 169, 0.000000, 0, 62690.000000, '2018-02-09 17:07:54', '2018-02-09 17:07:54'),
(156, 116, 170, 0.000000, 0, 44620.000000, '2018-02-09 17:07:54', '2018-02-09 17:07:54'),
(157, 116, 174, 0.000000, 0, 22040.000000, '2018-02-09 17:07:54', '2018-02-09 17:07:54'),
(158, 116, 175, 0.000000, 0, 15920.000000, '2018-02-09 17:07:54', '2018-02-09 17:07:54'),
(159, 116, 182, 0.000000, 0, 37300.000000, '2018-02-09 17:07:54', '2018-02-09 17:07:54'),
(160, 117, 36, 34046.000000, 0, 34046.000000, '2018-02-09 17:14:48', '2018-02-09 17:14:48'),
(161, 117, 61, 26350.000000, 0, 26350.000000, '2018-02-09 17:14:48', '2018-02-09 17:14:48'),
(162, 117, 81, 80570.000000, 0, 80570.000000, '2018-02-09 17:14:48', '2018-02-09 17:14:48'),
(163, 117, 84, 121040.000000, 0, 186000.000000, '2018-02-09 17:14:48', '2018-02-09 17:14:48'),
(164, 117, 147, 0.000000, 0, 34500.000000, '2018-02-09 17:14:48', '2018-02-09 17:14:48'),
(165, 117, 172, 0.000000, 0, 42480.000000, '2018-02-09 17:14:48', '2018-02-09 17:14:48'),
(166, 117, 183, 0.000000, 0, 96620.000000, '2018-02-09 17:14:48', '2018-02-09 17:14:48'),
(167, 118, 184, 19600.000000, 1, 19600.000000, '2018-02-09 17:17:10', '2018-02-09 17:17:10'),
(168, 119, 185, 15000.000000, 1, 17400.000000, '2018-02-09 17:22:06', '2018-02-09 17:22:06'),
(169, 120, 190, 850.000000, 1, 850.000000, '2018-02-10 11:15:17', '2018-02-10 11:15:17'),
(170, 121, 191, 27600.000000, 0, 27600.000000, '2018-02-10 11:33:07', '2018-02-10 11:33:07'),
(171, 122, 37, 2500.000000, 0, 33590.000000, '2018-02-11 10:13:11', '2018-02-11 10:13:11'),
(172, 122, 45, 0.000000, 0, 1400.000000, '2018-02-11 10:13:11', '2018-02-11 10:13:11'),
(173, 122, 47, 0.000000, 0, 2260.000000, '2018-02-11 10:13:11', '2018-02-11 10:13:11'),
(174, 122, 50, 0.000000, 0, 1040.000000, '2018-02-11 10:13:11', '2018-02-11 10:13:11'),
(175, 122, 186, 0.000000, 0, 3480.000000, '2018-02-11 10:13:11', '2018-02-11 10:13:11'),
(176, 122, 187, 0.000000, 0, 19930.000000, '2018-02-11 10:13:11', '2018-02-11 10:13:11'),
(177, 122, 188, 0.000000, 0, 1400.000000, '2018-02-11 10:13:11', '2018-02-11 10:13:11'),
(178, 122, 189, 0.000000, 0, 2290.000000, '2018-02-11 10:13:11', '2018-02-11 10:13:11'),
(179, 123, 37, 6000.000000, 0, 31090.000000, '2018-02-11 10:14:34', '2018-02-11 10:14:34'),
(180, 123, 45, 0.000000, 0, 1400.000000, '2018-02-11 10:14:34', '2018-02-11 10:14:34'),
(181, 123, 47, 0.000000, 0, 2260.000000, '2018-02-11 10:14:34', '2018-02-11 10:14:34'),
(182, 123, 50, 0.000000, 0, 1040.000000, '2018-02-11 10:14:34', '2018-02-11 10:14:34'),
(183, 123, 186, 0.000000, 0, 3480.000000, '2018-02-11 10:14:34', '2018-02-11 10:14:34'),
(184, 123, 187, 0.000000, 0, 19930.000000, '2018-02-11 10:14:34', '2018-02-11 10:14:34'),
(185, 123, 188, 0.000000, 0, 1400.000000, '2018-02-11 10:14:34', '2018-02-11 10:14:34'),
(186, 123, 189, 0.000000, 0, 2290.000000, '2018-02-11 10:14:34', '2018-02-11 10:14:34'),
(187, 124, 37, 16000.000000, 0, 25090.000000, '2018-02-11 10:16:24', '2018-02-11 10:16:24'),
(188, 124, 45, 0.000000, 0, 1400.000000, '2018-02-11 10:16:24', '2018-02-11 10:16:24'),
(189, 124, 47, 0.000000, 0, 2260.000000, '2018-02-11 10:16:24', '2018-02-11 10:16:24'),
(190, 124, 50, 0.000000, 0, 1040.000000, '2018-02-11 10:16:24', '2018-02-11 10:16:24'),
(191, 124, 186, 0.000000, 0, 3480.000000, '2018-02-11 10:16:24', '2018-02-11 10:16:24'),
(192, 124, 187, 0.000000, 0, 19930.000000, '2018-02-11 10:16:24', '2018-02-11 10:16:24'),
(193, 124, 188, 0.000000, 0, 1400.000000, '2018-02-11 10:16:24', '2018-02-11 10:16:24'),
(194, 124, 189, 0.000000, 0, 2290.000000, '2018-02-11 10:16:24', '2018-02-11 10:16:24'),
(195, 125, 185, 2400.000000, 0, 2400.000000, '2018-02-11 10:18:15', '2018-02-11 10:18:15'),
(196, 126, 145, 1840.000000, 0, 1840.000000, '2018-02-11 10:30:27', '2018-02-11 10:30:27'),
(197, 127, 193, 5000.000000, 1, 28350.000000, '2018-02-11 10:48:37', '2018-02-11 10:48:37'),
(198, 128, 152, 7350.000000, 0, 7350.000000, '2018-02-11 10:50:38', '2018-02-11 10:50:38'),
(199, 128, 192, 8650.000000, 0, 14400.000000, '2018-02-11 10:50:38', '2018-02-11 10:50:38'),
(200, 128, 193, 0.000000, 0, 23350.000000, '2018-02-11 10:50:38', '2018-02-11 10:50:38'),
(201, 129, 192, 5750.000000, 0, 5750.000000, '2018-02-11 10:53:02', '2018-02-11 10:53:02'),
(202, 129, 193, 4250.000000, 0, 23350.000000, '2018-02-11 10:53:02', '2018-02-11 10:53:02'),
(203, 130, 193, 16000.000000, 0, 19100.000000, '2018-02-11 11:11:42', '2018-02-11 11:11:42'),
(204, 130, 194, 0.000000, 0, 18700.000000, '2018-02-11 11:11:42', '2018-02-11 11:11:42'),
(205, 131, 195, 286994.000000, 1, 286994.000000, '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(206, 132, 196, 440126.000000, 1, 440126.000000, '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(207, 133, 197, 166884.000000, 1, 166884.000000, '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(208, 134, 198, 290966.000000, 1, 290966.000000, '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(209, 135, 200, 331573.000000, 1, 331573.000000, '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(210, 136, 199, 184366.000000, 0, 184366.000000, '2018-02-12 12:15:04', '2018-02-12 12:15:04'),
(211, 137, 201, 54733.000000, 1, 54733.000000, '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(212, 138, 202, 288016.000000, 1, 288016.000000, '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(213, 139, 54, 26500.000000, 0, 1588088.000000, '2018-02-12 16:37:23', '2018-02-12 16:37:23'),
(214, 139, 55, 0.000000, 0, 140600.000000, '2018-02-12 16:37:23', '2018-02-12 16:37:23'),
(215, 139, 56, 0.000000, 0, 881991.000000, '2018-02-12 16:37:23', '2018-02-12 16:37:23'),
(216, 140, 54, 29000.000000, 0, 1561588.000000, '2018-02-12 16:38:13', '2018-02-12 16:38:13'),
(217, 140, 55, 0.000000, 0, 140600.000000, '2018-02-12 16:38:13', '2018-02-12 16:38:13'),
(218, 140, 56, 0.000000, 0, 881991.000000, '2018-02-12 16:38:13', '2018-02-12 16:38:13'),
(219, 141, 136, 7500.000000, 0, 345723.000000, '2018-02-12 16:41:05', '2018-02-12 16:41:05'),
(220, 142, 136, 6000.000000, 0, 338223.000000, '2018-02-12 16:41:44', '2018-02-12 16:41:44'),
(221, 143, 218, 1500.000000, 0, 1500.000000, '2018-02-16 19:06:38', '2018-02-16 19:06:38'),
(222, 144, 219, 1100.000000, 1, 5100.000000, '2018-02-16 19:43:43', '2018-02-16 19:43:43'),
(223, 145, 221, 600.000000, 1, 6100.000000, '2018-02-16 20:10:51', '2018-02-16 20:10:51'),
(224, 146, 220, 3000.000000, 0, 6400.000000, '2018-02-16 20:28:34', '2018-02-16 20:28:34'),
(225, 146, 221, 0.000000, 0, 5500.000000, '2018-02-16 20:28:34', '2018-02-16 20:28:34'),
(226, 146, 222, 0.000000, 0, 9600.000000, '2018-02-16 20:28:34', '2018-02-16 20:28:34'),
(227, 146, 223, 0.000000, 0, 9170.000000, '2018-02-16 20:28:34', '2018-02-16 20:28:34'),
(228, 146, 224, 0.000000, 0, 200.000000, '2018-02-16 20:28:34', '2018-02-16 20:28:34'),
(229, 147, 220, 3400.000000, 0, 3400.000000, '2018-02-16 20:30:14', '2018-02-16 20:30:14'),
(230, 147, 221, 600.000000, 0, 5500.000000, '2018-02-16 20:30:14', '2018-02-16 20:30:14'),
(231, 147, 222, 0.000000, 0, 9600.000000, '2018-02-16 20:30:14', '2018-02-16 20:30:14'),
(232, 147, 223, 0.000000, 0, 9170.000000, '2018-02-16 20:30:14', '2018-02-16 20:30:14'),
(233, 147, 224, 0.000000, 0, 200.000000, '2018-02-16 20:30:14', '2018-02-16 20:30:14'),
(234, 148, 229, 12000.000000, 1, 12000.000000, '2018-02-17 22:39:51', '2018-02-17 22:39:51'),
(235, 149, 230, 9500.000000, 1, 9690.000000, '2018-02-17 22:48:02', '2018-02-17 22:48:02'),
(236, 150, 231, 9400.000000, 1, 9400.000000, '2018-02-17 22:53:28', '2018-02-17 22:53:28'),
(237, 151, 232, 2420.000000, 1, 2420.000000, '2018-02-17 22:55:57', '2018-02-17 22:55:57'),
(238, 152, 233, 6800.000000, 1, 6800.000000, '2018-02-17 22:58:51', '2018-02-17 22:58:51'),
(239, 153, 234, 4000.000000, 1, 12600.000000, '2018-02-18 21:17:59', '2018-02-18 21:17:59'),
(240, 154, 235, 350.000000, 1, 350.000000, '2018-02-18 21:19:26', '2018-02-18 21:19:26'),
(241, 154, 221, 2650.000000, 0, 4900.000000, '2018-02-18 21:19:26', '2018-02-18 21:19:26'),
(242, 154, 222, 0.000000, 0, 9600.000000, '2018-02-18 21:19:26', '2018-02-18 21:19:26'),
(243, 154, 223, 0.000000, 0, 9170.000000, '2018-02-18 21:19:26', '2018-02-18 21:19:26'),
(244, 154, 224, 0.000000, 0, 200.000000, '2018-02-18 21:19:26', '2018-02-18 21:19:26'),
(245, 154, 234, 0.000000, 0, 8600.000000, '2018-02-18 21:19:26', '2018-02-18 21:19:26'),
(246, 155, 236, 2500.000000, 1, 2850.000000, '2018-02-18 21:29:50', '2018-02-18 21:29:50'),
(247, 156, 237, 4000.000000, 1, 7650.000000, '2018-02-18 21:32:25', '2018-02-18 21:32:25'),
(248, 157, 242, 2000.000000, 1, 2000.000000, '2018-02-18 22:32:18', '2018-02-18 22:32:18'),
(249, 157, 241, 3000.000000, 0, 12900.000000, '2018-02-18 22:32:18', '2018-02-18 22:32:18'),
(250, 158, 241, 5000.000000, 0, 9900.000000, '2018-02-18 22:33:09', '2018-02-18 22:33:09'),
(251, 159, 248, 2000.000000, 0, 3100.000000, '2018-02-18 23:20:09', '2018-02-18 23:20:09'),
(252, 159, 249, 0.000000, 0, 1600.000000, '2018-02-18 23:20:09', '2018-02-18 23:20:09'),
(253, 159, 250, 0.000000, 0, 5800.000000, '2018-02-18 23:20:09', '2018-02-18 23:20:09'),
(254, 159, 251, 0.000000, 0, 300.000000, '2018-02-18 23:20:09', '2018-02-18 23:20:09'),
(255, 159, 252, 0.000000, 0, 2600.000000, '2018-02-18 23:20:09', '2018-02-18 23:20:09'),
(256, 160, 248, 1100.000000, 0, 1100.000000, '2018-02-18 23:21:19', '2018-02-18 23:21:19'),
(257, 160, 249, 900.000000, 0, 1600.000000, '2018-02-18 23:21:19', '2018-02-18 23:21:19'),
(258, 160, 250, 0.000000, 0, 5800.000000, '2018-02-18 23:21:19', '2018-02-18 23:21:19'),
(259, 160, 251, 0.000000, 0, 300.000000, '2018-02-18 23:21:19', '2018-02-18 23:21:19'),
(260, 160, 252, 0.000000, 0, 2600.000000, '2018-02-18 23:21:19', '2018-02-18 23:21:19'),
(261, 161, 249, 700.000000, 0, 700.000000, '2018-02-18 23:22:05', '2018-02-18 23:22:05'),
(262, 161, 250, 300.000000, 0, 5800.000000, '2018-02-18 23:22:05', '2018-02-18 23:22:05'),
(263, 161, 251, 0.000000, 0, 300.000000, '2018-02-18 23:22:05', '2018-02-18 23:22:05'),
(264, 161, 252, 0.000000, 0, 2600.000000, '2018-02-18 23:22:05', '2018-02-18 23:22:05'),
(265, 162, 250, 3000.000000, 0, 5500.000000, '2018-02-18 23:22:52', '2018-02-18 23:22:52'),
(266, 162, 251, 0.000000, 0, 300.000000, '2018-02-18 23:22:52', '2018-02-18 23:22:52'),
(267, 162, 252, 0.000000, 0, 2600.000000, '2018-02-18 23:22:52', '2018-02-18 23:22:52'),
(268, 163, 256, 1000.000000, 1, 1900.000000, '2018-02-18 23:36:07', '2018-02-18 23:36:07'),
(269, 164, 257, 25800.000000, 1, 25800.000000, '2018-02-19 23:30:26', '2018-02-19 23:30:26'),
(270, 165, 258, 2760.000000, 1, 2760.000000, '2018-02-19 23:34:56', '2018-02-19 23:34:56'),
(271, 166, 259, 1340.000000, 1, 1340.000000, '2018-02-19 23:37:29', '2018-02-19 23:37:29'),
(272, 167, 261, 27000.000000, 1, 27000.000000, '2018-02-23 21:29:08', '2018-02-23 21:29:08'),
(273, 168, 262, 9200.000000, 1, 9200.000000, '2018-02-23 21:35:39', '2018-02-23 21:35:39'),
(274, 169, 263, 4000.000000, 1, 4000.000000, '2018-02-23 22:25:06', '2018-02-23 22:25:06'),
(275, 169, 63, 16000.000000, 0, 23150.000000, '2018-02-23 22:25:06', '2018-02-23 22:25:06'),
(276, 169, 137, 0.000000, 0, 8760.000000, '2018-02-23 22:25:06', '2018-02-23 22:25:06'),
(277, 169, 138, 0.000000, 0, 17480.000000, '2018-02-23 22:25:06', '2018-02-23 22:25:06'),
(278, 169, 139, 0.000000, 0, 38950.000000, '2018-02-23 22:25:06', '2018-02-23 22:25:06'),
(279, 169, 140, 0.000000, 0, 16550.000000, '2018-02-23 22:25:06', '2018-02-23 22:25:06'),
(280, 169, 141, 0.000000, 0, 2600.000000, '2018-02-23 22:25:06', '2018-02-23 22:25:06'),
(281, 169, 142, 0.000000, 0, 5600.000000, '2018-02-23 22:25:06', '2018-02-23 22:25:06'),
(282, 169, 143, 0.000000, 0, 4500.000000, '2018-02-23 22:25:06', '2018-02-23 22:25:06'),
(283, 169, 144, 0.000000, 0, 12300.000000, '2018-02-23 22:25:06', '2018-02-23 22:25:06'),
(284, 170, 265, 21400.000000, 1, 21400.000000, '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(285, 170, 63, 7150.000000, 0, 7150.000000, '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(286, 170, 137, 1450.000000, 0, 8760.000000, '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(287, 170, 138, 0.000000, 0, 17480.000000, '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(288, 170, 139, 0.000000, 0, 38950.000000, '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(289, 170, 140, 0.000000, 0, 16550.000000, '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(290, 170, 141, 0.000000, 0, 2600.000000, '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(291, 170, 142, 0.000000, 0, 5600.000000, '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(292, 170, 143, 0.000000, 0, 4500.000000, '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(293, 170, 144, 0.000000, 0, 12300.000000, '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(294, 170, 264, 0.000000, 0, 43400.000000, '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(295, 171, 137, 7310.000000, 0, 7310.000000, '2018-02-23 22:35:18', '2018-02-23 22:35:18'),
(296, 171, 138, 17480.000000, 0, 17480.000000, '2018-02-23 22:35:18', '2018-02-23 22:35:18'),
(297, 171, 139, 35430.000000, 0, 38950.000000, '2018-02-23 22:35:18', '2018-02-23 22:35:18'),
(298, 171, 140, 0.000000, 0, 16550.000000, '2018-02-23 22:35:18', '2018-02-23 22:35:18'),
(299, 171, 141, 0.000000, 0, 2600.000000, '2018-02-23 22:35:18', '2018-02-23 22:35:18'),
(300, 171, 142, 0.000000, 0, 5600.000000, '2018-02-23 22:35:18', '2018-02-23 22:35:18'),
(301, 171, 143, 0.000000, 0, 4500.000000, '2018-02-23 22:35:18', '2018-02-23 22:35:18'),
(302, 171, 144, 0.000000, 0, 12300.000000, '2018-02-23 22:35:18', '2018-02-23 22:35:18'),
(303, 171, 264, 0.000000, 0, 43400.000000, '2018-02-23 22:35:18', '2018-02-23 22:35:18'),
(304, 172, 136, 11500.000000, 0, 332223.000000, '2018-02-23 23:00:21', '2018-02-23 23:00:21'),
(305, 172, 266, 0.000000, 0, 4000.000000, '2018-02-23 23:00:21', '2018-02-23 23:00:21'),
(306, 172, 267, 0.000000, 0, 600.000000, '2018-02-23 23:00:21', '2018-02-23 23:00:21'),
(307, 173, 136, 9000.000000, 0, 320723.000000, '2018-02-23 23:01:29', '2018-02-23 23:01:29'),
(308, 173, 266, 0.000000, 0, 4000.000000, '2018-02-23 23:01:29', '2018-02-23 23:01:29'),
(309, 173, 267, 0.000000, 0, 600.000000, '2018-02-23 23:01:29', '2018-02-23 23:01:29'),
(310, 174, 136, 4000.000000, 0, 311723.000000, '2018-02-23 23:02:36', '2018-02-23 23:02:36'),
(311, 174, 266, 0.000000, 0, 4000.000000, '2018-02-23 23:02:36', '2018-02-23 23:02:36'),
(312, 174, 267, 0.000000, 0, 600.000000, '2018-02-23 23:02:36', '2018-02-23 23:02:36'),
(313, 175, 136, 14000.000000, 0, 307723.000000, '2018-02-23 23:03:56', '2018-02-23 23:03:56'),
(314, 175, 266, 0.000000, 0, 4000.000000, '2018-02-23 23:03:56', '2018-02-23 23:03:56'),
(315, 175, 267, 0.000000, 0, 600.000000, '2018-02-23 23:03:56', '2018-02-23 23:03:56'),
(316, 176, 54, 30000.000000, 0, 1532588.000000, '2018-02-23 23:07:24', '2018-02-23 23:07:24'),
(317, 176, 55, 0.000000, 0, 140600.000000, '2018-02-23 23:07:24', '2018-02-23 23:07:24'),
(318, 176, 56, 0.000000, 0, 881991.000000, '2018-02-23 23:07:24', '2018-02-23 23:07:24'),
(319, 176, 226, 0.000000, 0, 11680.000000, '2018-02-23 23:07:24', '2018-02-23 23:07:24'),
(320, 176, 227, 0.000000, 0, 8775.000000, '2018-02-23 23:07:24', '2018-02-23 23:07:24'),
(321, 176, 228, 0.000000, 0, 205640.000000, '2018-02-23 23:07:24', '2018-02-23 23:07:24'),
(322, 177, 54, 9000.000000, 0, 1502588.000000, '2018-02-23 23:08:02', '2018-02-23 23:08:02'),
(323, 177, 55, 0.000000, 0, 140600.000000, '2018-02-23 23:08:02', '2018-02-23 23:08:02'),
(324, 177, 56, 0.000000, 0, 881991.000000, '2018-02-23 23:08:02', '2018-02-23 23:08:02'),
(325, 177, 226, 0.000000, 0, 11680.000000, '2018-02-23 23:08:02', '2018-02-23 23:08:02'),
(326, 177, 227, 0.000000, 0, 8775.000000, '2018-02-23 23:08:02', '2018-02-23 23:08:02'),
(327, 177, 228, 0.000000, 0, 205640.000000, '2018-02-23 23:08:02', '2018-02-23 23:08:02'),
(328, 178, 54, 9000.000000, 0, 1493588.000000, '2018-02-23 23:08:42', '2018-02-23 23:08:42'),
(329, 178, 55, 0.000000, 0, 140600.000000, '2018-02-23 23:08:42', '2018-02-23 23:08:42'),
(330, 178, 56, 0.000000, 0, 881991.000000, '2018-02-23 23:08:42', '2018-02-23 23:08:42'),
(331, 178, 226, 0.000000, 0, 11680.000000, '2018-02-23 23:08:42', '2018-02-23 23:08:42'),
(332, 178, 227, 0.000000, 0, 8775.000000, '2018-02-23 23:08:42', '2018-02-23 23:08:42'),
(333, 178, 228, 0.000000, 0, 205640.000000, '2018-02-23 23:08:42', '2018-02-23 23:08:42'),
(334, 179, 54, 30000.000000, 0, 1484588.000000, '2018-02-23 23:09:51', '2018-02-23 23:09:51'),
(335, 179, 55, 0.000000, 0, 140600.000000, '2018-02-23 23:09:51', '2018-02-23 23:09:51'),
(336, 179, 56, 0.000000, 0, 881991.000000, '2018-02-23 23:09:51', '2018-02-23 23:09:51'),
(337, 179, 226, 0.000000, 0, 11680.000000, '2018-02-23 23:09:51', '2018-02-23 23:09:51'),
(338, 179, 227, 0.000000, 0, 8775.000000, '2018-02-23 23:09:51', '2018-02-23 23:09:51'),
(339, 179, 228, 0.000000, 0, 205640.000000, '2018-02-23 23:09:51', '2018-02-23 23:09:51'),
(340, 180, 54, 11000.000000, 0, 1454588.000000, '2018-02-23 23:10:35', '2018-02-23 23:10:35'),
(341, 180, 55, 0.000000, 0, 140600.000000, '2018-02-23 23:10:35', '2018-02-23 23:10:35'),
(342, 180, 56, 0.000000, 0, 881991.000000, '2018-02-23 23:10:35', '2018-02-23 23:10:35'),
(343, 180, 226, 0.000000, 0, 11680.000000, '2018-02-23 23:10:35', '2018-02-23 23:10:35'),
(344, 180, 227, 0.000000, 0, 8775.000000, '2018-02-23 23:10:35', '2018-02-23 23:10:35'),
(345, 180, 228, 0.000000, 0, 205640.000000, '2018-02-23 23:10:35', '2018-02-23 23:10:35'),
(346, 181, 54, 10000.000000, 0, 1443588.000000, '2018-02-23 23:11:39', '2018-02-23 23:11:39'),
(347, 181, 55, 0.000000, 0, 140600.000000, '2018-02-23 23:11:39', '2018-02-23 23:11:39'),
(348, 181, 56, 0.000000, 0, 881991.000000, '2018-02-23 23:11:39', '2018-02-23 23:11:39'),
(349, 181, 226, 0.000000, 0, 11680.000000, '2018-02-23 23:11:39', '2018-02-23 23:11:39'),
(350, 181, 227, 0.000000, 0, 8775.000000, '2018-02-23 23:11:39', '2018-02-23 23:11:39'),
(351, 181, 228, 0.000000, 0, 205640.000000, '2018-02-23 23:11:39', '2018-02-23 23:11:39'),
(352, 182, 268, 2350.000000, 1, 2350.000000, '2018-02-24 15:58:37', '2018-02-24 15:58:37'),
(353, 182, 260, 10350.000000, 0, 10350.000000, '2018-02-24 15:58:37', '2018-02-24 15:58:37'),
(354, 183, 269, 16610.000000, 1, 16610.000000, '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(355, 184, 270, 5950.000000, 1, 5950.000000, '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(356, 185, 271, 15100.000000, 1, 15100.000000, '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(357, 186, 272, 4550.000000, 1, 4550.000000, '2018-02-24 16:34:23', '2018-02-24 16:34:23'),
(358, 187, 273, 6469.000000, 1, 6469.000000, '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(359, 188, 274, 20198.000000, 1, 20198.000000, '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(360, 189, 275, 7502.000000, 1, 7502.000000, '2018-02-24 17:19:25', '2018-02-24 17:19:25'),
(361, 190, 276, 3850.000000, 1, 3850.000000, '2018-02-25 00:16:54', '2018-02-25 00:16:54'),
(362, 191, 277, 58700.000000, 1, 58700.000000, '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(363, 192, 278, 29500.000000, 1, 29500.000000, '2018-02-25 00:34:55', '2018-02-25 00:34:55'),
(364, 193, 279, 19800.000000, 1, 19800.000000, '2018-02-25 00:38:04', '2018-02-25 00:38:04'),
(365, 194, 280, 14050.000000, 1, 14050.000000, '2018-02-25 00:46:56', '2018-02-25 00:46:56'),
(366, 195, 281, 7850.000000, 1, 7850.000000, '2018-02-25 00:54:36', '2018-02-25 00:54:36'),
(367, 196, 282, 14000.000000, 1, 14000.000000, '2018-02-25 01:05:44', '2018-02-25 01:05:44'),
(368, 197, 283, 7300.000000, 1, 7300.000000, '2018-02-25 18:52:33', '2018-02-25 18:52:33'),
(369, 198, 284, 17000.000000, 1, 17000.000000, '2018-02-25 18:59:13', '2018-02-25 18:59:13'),
(370, 199, 285, 21900.000000, 1, 21900.000000, '2018-02-25 19:02:44', '2018-02-25 19:02:44'),
(371, 200, 286, 28700.000000, 1, 28700.000000, '2018-02-25 19:08:08', '2018-02-25 19:08:08'),
(372, 201, 287, 29500.000000, 1, 29500.000000, '2018-02-25 19:14:46', '2018-02-25 19:14:46'),
(373, 202, 288, 37340.000000, 1, 37340.000000, '2018-02-25 19:19:58', '2018-02-25 19:19:58'),
(374, 203, 289, 10600.000000, 1, 10600.000000, '2018-02-25 19:22:56', '2018-02-25 19:22:56'),
(375, 204, 291, 10000.000000, 1, 10000.000000, '2018-02-25 19:27:12', '2018-02-25 19:27:12'),
(376, 205, 292, 8000.000000, 1, 8000.000000, '2018-02-25 19:46:47', '2018-02-25 19:46:47'),
(377, 206, 293, 800.000000, 1, 800.000000, '2018-02-25 19:49:55', '2018-02-25 19:49:55'),
(378, 207, 294, 19200.000000, 1, 19200.000000, '2018-02-25 19:54:16', '2018-02-25 19:54:16'),
(379, 208, 295, 25600.000000, 1, 25600.000000, '2018-02-25 20:02:35', '2018-02-25 20:02:35'),
(380, 209, 296, 11660.000000, 1, 11660.000000, '2018-02-25 20:05:47', '2018-02-25 20:05:47'),
(381, 210, 298, 9300.000000, 1, 9300.000000, '2018-02-25 20:14:40', '2018-02-25 20:14:40'),
(382, 210, 297, 8700.000000, 0, 8700.000000, '2018-02-25 20:14:40', '2018-02-25 20:14:40'),
(383, 211, 299, 13700.000000, 1, 13700.000000, '2018-02-25 20:21:01', '2018-02-25 20:21:01'),
(384, 212, 300, 13000.000000, 1, 13000.000000, '2018-02-25 20:52:12', '2018-02-25 20:52:12'),
(385, 213, 301, 10600.000000, 1, 10600.000000, '2018-02-25 20:57:01', '2018-02-25 20:57:01'),
(386, 214, 302, 6250.000000, 1, 6250.000000, '2018-02-25 20:58:37', '2018-02-25 20:58:37'),
(387, 215, 303, 11800.000000, 1, 11800.000000, '2018-02-25 21:01:25', '2018-02-25 21:01:25'),
(388, 216, 304, 7300.000000, 1, 7300.000000, '2018-02-25 21:05:02', '2018-02-25 21:05:02'),
(389, 217, 305, 16600.000000, 1, 16600.000000, '2018-02-25 21:10:47', '2018-02-25 21:10:47'),
(390, 218, 306, 9000.000000, 1, 9000.000000, '2018-02-25 21:16:55', '2018-02-25 21:16:55'),
(391, 219, 307, 11800.000000, 1, 11800.000000, '2018-02-25 21:22:00', '2018-02-25 21:22:00'),
(392, 220, 308, 12250.000000, 1, 12250.000000, '2018-02-25 21:24:59', '2018-02-25 21:24:59'),
(393, 221, 309, 1600.000000, 1, 1600.000000, '2018-02-25 21:27:39', '2018-02-25 21:27:39'),
(394, 222, 310, 1400.000000, 1, 1400.000000, '2018-02-25 21:29:40', '2018-02-25 21:29:40'),
(395, 223, 311, 20500.000000, 1, 20500.000000, '2018-02-25 21:32:15', '2018-02-25 21:32:15'),
(396, 224, 312, 11600.000000, 1, 11600.000000, '2018-02-25 21:35:05', '2018-02-25 21:35:05'),
(397, 225, 313, 31000.000000, 1, 31000.000000, '2018-02-25 21:40:10', '2018-02-25 21:40:10'),
(398, 226, 314, 7380.000000, 1, 7380.000000, '2018-02-25 21:44:04', '2018-02-25 21:44:04'),
(399, 227, 315, 6900.000000, 1, 6900.000000, '2018-02-25 21:48:34', '2018-02-25 21:48:34'),
(400, 228, 316, 4380.000000, 1, 4380.000000, '2018-02-25 22:16:13', '2018-02-25 22:16:13'),
(401, 229, 317, 6100.000000, 1, 6100.000000, '2018-02-25 22:19:46', '2018-02-25 22:19:46'),
(402, 230, 318, 12640.000000, 1, 12640.000000, '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(403, 231, 319, 46400.000000, 1, 46400.000000, '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(404, 232, 320, 5000.000000, 1, 5000.000000, '2018-02-25 22:42:39', '2018-02-25 22:42:39'),
(405, 233, 321, 4800.000000, 1, 4800.000000, '2018-02-25 22:45:19', '2018-02-25 22:45:19'),
(406, 234, 322, 13800.000000, 1, 13800.000000, '2018-02-25 22:53:29', '2018-02-25 22:53:29'),
(407, 235, 323, 4200.000000, 1, 4200.000000, '2018-02-25 22:56:28', '2018-02-25 22:56:28'),
(408, 236, 324, 27700.000000, 1, 27700.000000, '2018-02-25 23:05:25', '2018-02-25 23:05:25'),
(409, 237, 326, 9850.000000, 1, 9850.000000, '2018-02-25 23:28:02', '2018-02-25 23:28:02'),
(410, 237, 325, 53770.000000, 0, 53770.000000, '2018-02-25 23:28:02', '2018-02-25 23:28:02'),
(411, 238, 327, 4370.000000, 1, 4370.000000, '2018-02-25 23:34:09', '2018-02-25 23:34:09'),
(412, 239, 328, 46273.000000, 1, 46273.000000, '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(413, 240, 329, 211908.000000, 0, 211908.000000, '2018-02-26 23:43:21', '2018-02-26 23:43:21'),
(414, 241, 330, 95091.000000, 1, 95091.000000, '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(415, 242, 331, 144048.000000, 1, 144048.000000, '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(416, 243, 332, 11485.000000, 1, 11485.000000, '2018-02-27 01:21:11', '2018-02-27 01:21:11'),
(417, 244, 333, 18200.000000, 1, 18200.000000, '2018-02-27 01:26:28', '2018-02-27 01:26:28'),
(418, 245, 334, 64000.000000, 1, 64000.000000, '2018-02-27 01:30:53', '2018-02-27 01:30:53'),
(419, 246, 335, 29050.000000, 1, 29050.000000, '2018-02-28 18:47:13', '2018-02-28 18:47:13'),
(420, 247, 336, 8400.000000, 1, 8400.000000, '2018-02-28 18:51:12', '2018-02-28 18:51:12'),
(421, 248, 337, 3950.000000, 1, 3950.000000, '2018-02-28 18:56:18', '2018-02-28 18:56:18'),
(422, 249, 338, 33600.000000, 1, 33600.000000, '2018-02-28 19:00:36', '2018-02-28 19:00:36'),
(423, 250, 339, 11000.000000, 1, 11000.000000, '2018-02-28 19:03:40', '2018-02-28 19:03:40'),
(424, 251, 340, 16800.000000, 1, 16800.000000, '2018-02-28 19:06:03', '2018-02-28 19:06:03'),
(425, 252, 341, 11050.000000, 1, 11050.000000, '2018-02-28 19:11:58', '2018-02-28 19:11:58'),
(426, 253, 342, 3400.000000, 1, 3400.000000, '2018-02-28 19:15:18', '2018-02-28 19:15:18'),
(427, 254, 343, 13600.000000, 1, 13600.000000, '2018-02-28 19:17:07', '2018-02-28 19:17:07'),
(428, 255, 344, 4800.000000, 1, 4800.000000, '2018-02-28 19:18:29', '2018-02-28 19:18:29'),
(429, 256, 345, 9500.000000, 1, 9500.000000, '2018-02-28 19:21:00', '2018-02-28 19:21:00'),
(430, 257, 346, 19620.000000, 1, 19620.000000, '2018-02-28 19:25:05', '2018-02-28 19:25:05'),
(431, 258, 347, 4650.000000, 1, 4650.000000, '2018-02-28 19:27:53', '2018-02-28 19:27:53'),
(432, 259, 348, 213283.000000, 1, 213283.000000, '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(433, 260, 349, 199201.000000, 1, 199201.000000, '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(434, 261, 350, 445524.000000, 1, 445524.000000, '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(435, 262, 351, 232422.000000, 0, 232422.000000, '2018-03-04 00:04:43', '2018-03-04 00:04:43'),
(436, 263, 352, 5150.000000, 1, 5150.000000, '2018-03-04 01:04:33', '2018-03-04 01:04:33'),
(437, 264, 353, 6500.000000, 1, 6500.000000, '2018-03-04 01:07:46', '2018-03-04 01:07:46'),
(438, 265, 354, 12500.000000, 1, 44600.000000, '2018-03-04 16:58:34', '2018-03-04 16:58:34'),
(439, 266, 54, 10000.000000, 0, 1433588.000000, '2018-03-04 17:08:06', '2018-03-04 17:08:06'),
(440, 266, 55, 0.000000, 0, 140600.000000, '2018-03-04 17:08:06', '2018-03-04 17:08:06'),
(441, 266, 56, 0.000000, 0, 881991.000000, '2018-03-04 17:08:06', '2018-03-04 17:08:06'),
(442, 266, 226, 0.000000, 0, 11680.000000, '2018-03-04 17:08:06', '2018-03-04 17:08:06'),
(443, 266, 227, 0.000000, 0, 8775.000000, '2018-03-04 17:08:06', '2018-03-04 17:08:06'),
(444, 266, 228, 0.000000, 0, 205640.000000, '2018-03-04 17:08:06', '2018-03-04 17:08:06'),
(445, 266, 354, 0.000000, 0, 32100.000000, '2018-03-04 17:08:06', '2018-03-04 17:08:06'),
(446, 266, 355, 0.000000, 0, 172900.000000, '2018-03-04 17:08:06', '2018-03-04 17:08:06'),
(447, 267, 54, 7400.000000, 0, 1423588.000000, '2018-03-04 17:09:17', '2018-03-04 17:09:17'),
(448, 267, 55, 0.000000, 0, 140600.000000, '2018-03-04 17:09:17', '2018-03-04 17:09:17'),
(449, 267, 56, 0.000000, 0, 881991.000000, '2018-03-04 17:09:17', '2018-03-04 17:09:17'),
(450, 267, 226, 0.000000, 0, 11680.000000, '2018-03-04 17:09:17', '2018-03-04 17:09:17'),
(451, 267, 227, 0.000000, 0, 8775.000000, '2018-03-04 17:09:17', '2018-03-04 17:09:17'),
(452, 267, 228, 0.000000, 0, 205640.000000, '2018-03-04 17:09:17', '2018-03-04 17:09:17'),
(453, 267, 354, 0.000000, 0, 32100.000000, '2018-03-04 17:09:17', '2018-03-04 17:09:17'),
(454, 267, 355, 0.000000, 0, 172900.000000, '2018-03-04 17:09:17', '2018-03-04 17:09:17'),
(455, 268, 54, 18000.000000, 0, 1416188.000000, '2018-03-04 17:10:26', '2018-03-04 17:10:26'),
(456, 268, 55, 0.000000, 0, 140600.000000, '2018-03-04 17:10:26', '2018-03-04 17:10:26'),
(457, 268, 56, 0.000000, 0, 881991.000000, '2018-03-04 17:10:26', '2018-03-04 17:10:26'),
(458, 268, 226, 0.000000, 0, 11680.000000, '2018-03-04 17:10:26', '2018-03-04 17:10:26'),
(459, 268, 227, 0.000000, 0, 8775.000000, '2018-03-04 17:10:26', '2018-03-04 17:10:26'),
(460, 268, 228, 0.000000, 0, 205640.000000, '2018-03-04 17:10:26', '2018-03-04 17:10:26'),
(461, 268, 354, 0.000000, 0, 32100.000000, '2018-03-04 17:10:26', '2018-03-04 17:10:26'),
(462, 268, 355, 0.000000, 0, 172900.000000, '2018-03-04 17:10:26', '2018-03-04 17:10:26'),
(463, 269, 356, 35200.000000, 1, 151750.000000, '2018-03-04 17:16:43', '2018-03-04 17:16:43'),
(464, 270, 357, 1425.000000, 1, 1425.000000, '2018-03-04 21:42:03', '2018-03-04 21:42:03'),
(465, 271, 358, 12950.000000, 1, 12950.000000, '2018-03-04 21:53:46', '2018-03-04 21:53:46'),
(466, 272, 54, 52670.000000, 0, 1398188.000000, '2018-03-04 23:00:22', '2018-03-04 23:00:22'),
(467, 272, 55, 0.000000, 0, 140600.000000, '2018-03-04 23:00:22', '2018-03-04 23:00:22'),
(468, 272, 56, 0.000000, 0, 881991.000000, '2018-03-04 23:00:22', '2018-03-04 23:00:22'),
(469, 272, 226, 0.000000, 0, 11680.000000, '2018-03-04 23:00:22', '2018-03-04 23:00:22'),
(470, 272, 227, 0.000000, 0, 8775.000000, '2018-03-04 23:00:22', '2018-03-04 23:00:22'),
(471, 272, 228, 0.000000, 0, 205640.000000, '2018-03-04 23:00:22', '2018-03-04 23:00:22'),
(472, 272, 354, 0.000000, 0, 32100.000000, '2018-03-04 23:00:22', '2018-03-04 23:00:22'),
(473, 272, 355, 0.000000, 0, 172900.000000, '2018-03-04 23:00:22', '2018-03-04 23:00:22'),
(474, 272, 356, 0.000000, 0, 116550.000000, '2018-03-04 23:00:22', '2018-03-04 23:00:22'),
(475, 273, 359, 25980.000000, 1, 25980.000000, '2018-03-05 00:38:14', '2018-03-05 00:38:14'),
(476, 274, 360, 16952.000000, 1, 16952.000000, '2018-03-05 00:56:07', '2018-03-05 00:56:07'),
(477, 275, 361, 5860.000000, 1, 5860.000000, '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(478, 276, 362, 5429.000000, 1, 5429.000000, '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(479, 277, 363, 8382.000000, 1, 8382.000000, '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(480, 278, 364, 2200.000000, 1, 2200.000000, '2018-03-05 16:32:20', '2018-03-05 16:32:20'),
(481, 279, 365, 9197.000000, 1, 9197.000000, '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(482, 280, 366, 7250.000000, 1, 7250.000000, '2018-03-05 16:57:45', '2018-03-05 16:57:45'),
(483, 281, 367, 2620.000000, 1, 2620.000000, '2018-03-05 17:03:42', '2018-03-05 17:03:42'),
(484, 281, 290, 4000.000000, 0, 4000.000000, '2018-03-05 17:03:42', '2018-03-05 17:03:42'),
(485, 282, 368, 8900.000000, 1, 8900.000000, '2018-03-05 17:09:19', '2018-03-05 17:09:19'),
(486, 283, 369, 6300.000000, 1, 6300.000000, '2018-03-05 17:12:09', '2018-03-05 17:12:09'),
(487, 284, 254, 600.000000, 0, 600.000000, '2018-04-01 05:12:03', '2018-04-01 05:12:03'),
(488, 284, 255, 1400.000000, 0, 1700.000000, '2018-04-01 05:12:03', '2018-04-01 05:12:03'),
(489, 284, 256, 0.000000, 0, 900.000000, '2018-04-01 05:12:03', '2018-04-01 05:12:03'),
(490, 285, 255, 100.000000, 0, 300.000000, '2018-04-01 05:45:23', '2018-04-01 05:45:23'),
(491, 285, 256, 0.000000, 0, 900.000000, '2018-04-01 05:45:23', '2018-04-01 05:45:23'),
(492, 286, 373, 500.000000, 1, 500.000000, '2020-10-02 14:57:36', '2020-10-02 14:57:36'),
(493, 286, 193, 3100.000000, 0, 3100.000000, '2020-10-02 14:57:36', '2020-10-02 14:57:36'),
(494, 286, 194, 16400.000000, 0, 18700.000000, '2020-10-02 14:57:36', '2020-10-02 14:57:36');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_product`
--

CREATE TABLE `inventory_product` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `fk_category_id` int(11) UNSIGNED NOT NULL,
  `fk_brand_id` int(11) UNSIGNED DEFAULT NULL,
  `fk_small_unit_id` int(11) UNSIGNED DEFAULT NULL,
  `product_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `specification` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `barcode` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0=sales, 1=services',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0=pending, 1=success',
  `stock_limitation` tinyint(4) DEFAULT 0,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_product`
--

INSERT INTO `inventory_product` (`id`, `product_name`, `fk_category_id`, `fk_brand_id`, `fk_small_unit_id`, `product_id`, `specification`, `barcode`, `type`, `status`, `stock_limitation`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(27, 'Scarf Cotton', 3, NULL, 1, 'p-376', NULL, NULL, 0, 1, 0, 4, '2018-01-29 16:37:42', NULL, '2018-01-29 17:29:45'),
(28, 'C Tops', 3, NULL, 1, 'p-351', NULL, NULL, 0, 1, 0, 4, '2018-01-29 16:44:20', NULL, '2018-01-29 16:44:20'),
(29, 'Skirt Thai', 5, NULL, 1, 'p-451', NULL, NULL, 0, 1, 0, 4, '2018-01-29 16:45:05', NULL, '2018-01-29 16:45:05'),
(30, 'Skirt China', 3, NULL, 1, 'p-918', NULL, NULL, 0, 1, 0, 4, '2018-01-29 16:46:03', NULL, '2018-01-29 16:46:03'),
(31, 'Plazo China', 3, NULL, 1, 'p-390', NULL, NULL, 0, 1, 0, 4, '2018-01-29 16:48:03', NULL, '2018-01-29 16:48:03'),
(32, 'Plazo Thai', 5, NULL, 1, 'p-286', NULL, NULL, 0, 1, 0, 4, '2018-01-29 16:48:55', NULL, '2018-01-29 16:48:55'),
(33, 'Plazo BD', 6, NULL, 1, 'p-364', NULL, NULL, 0, 1, 0, 4, '2018-01-29 16:50:06', NULL, '2018-01-29 16:50:06'),
(34, 'Burqa', 6, NULL, 1, 'p-656', NULL, NULL, 0, 1, 0, 4, '2018-01-29 17:03:56', NULL, '2018-01-29 17:05:18'),
(35, 'Abaya', 6, NULL, 1, 'p-322', NULL, NULL, 0, 1, 0, 4, '2018-01-29 17:06:19', NULL, '2018-01-29 17:06:19'),
(36, 'Lawn cotton', 4, NULL, 1, 'p-295', NULL, NULL, 0, 1, 0, 4, '2018-01-29 17:11:53', NULL, '2018-01-29 17:11:53'),
(37, 'Lawn Chiffon', 4, NULL, 1, 'p-512', NULL, NULL, 0, 1, 0, 4, '2018-01-29 17:14:11', NULL, '2018-01-29 17:14:11'),
(38, 'Swiss Cotton', 4, NULL, 1, 'p-687', NULL, NULL, 0, 1, 0, 4, '2018-01-29 17:16:59', NULL, '2018-01-29 17:16:59'),
(39, 'Scarf Silk', 3, NULL, 1, 'p-627', NULL, NULL, 0, 1, 0, 4, '2018-01-29 17:30:48', NULL, '2018-01-29 17:30:48'),
(40, 'One Pic IN', 2, NULL, 1, 'p-705', NULL, NULL, 0, 1, 0, 4, '2018-01-29 17:34:37', NULL, '2018-01-31 14:01:03'),
(41, 'One Pic BD', 6, NULL, 1, 'p-570', NULL, NULL, 0, 1, 0, 4, '2018-01-30 13:56:00', NULL, '2018-01-30 13:56:00'),
(42, 'Tops Thai', 5, NULL, 1, 'p-36', NULL, NULL, 0, 1, 0, 4, '2018-01-30 13:57:14', NULL, '2018-01-30 13:57:14'),
(43, 'Scarf Zori', 3, NULL, 1, 'p-129', NULL, NULL, 0, 1, 0, 4, '2018-01-30 14:00:29', NULL, '2018-01-30 14:00:29'),
(44, 'Shal', 3, NULL, 1, 'p-472', NULL, NULL, 0, 1, 0, 4, '2018-01-30 14:01:51', NULL, '2018-01-30 14:01:51'),
(45, 'Sweater China', 3, NULL, 1, 'p-310', NULL, NULL, 0, 1, 0, 4, '2018-01-30 14:02:43', NULL, '2018-01-30 14:02:43'),
(47, 'Sweater Thai', 5, NULL, 1, 'p-4', NULL, NULL, 0, 1, 0, 4, '2018-01-30 14:04:10', NULL, '2018-01-30 14:04:10'),
(48, 'Inner', 3, NULL, 1, 'p-42', NULL, NULL, 0, 1, 0, 4, '2018-01-30 14:06:36', NULL, '2018-01-30 14:06:36'),
(49, 'Firdous', 4, NULL, 1, 'p-600', NULL, NULL, 0, 1, 0, 4, '2018-01-30 15:01:11', NULL, '2018-01-30 15:01:11'),
(50, 'Thai Shoes', 5, NULL, 1, 'p-788', NULL, NULL, 0, 1, 0, 4, '2018-01-30 16:20:16', NULL, '2018-01-30 16:20:16'),
(51, 'Imitation', 3, NULL, 1, 'p-298', NULL, NULL, 0, 1, 0, 4, '2018-01-30 17:17:14', NULL, '2018-01-30 17:17:14'),
(52, 'Vipul', 2, NULL, 1, 'p-223', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:23:16', NULL, '2018-01-31 11:23:16'),
(53, 'Esta', 2, NULL, 1, 'p-671', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:23:37', NULL, '2018-01-31 11:23:37'),
(54, 'LT Fabrics', 2, NULL, 1, 'p-836', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:24:22', NULL, '2018-01-31 11:24:22'),
(55, 'Vivek', 2, NULL, 1, 'p-98', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:24:56', NULL, '2018-01-31 11:24:56'),
(56, 'Omtex', 2, NULL, 1, 'p-501', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:26:11', NULL, '2018-01-31 11:26:11'),
(57, 'Rakhi', 2, NULL, 1, 'p-804', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:26:47', NULL, '2018-01-31 11:26:47'),
(58, 'Varsha', 2, NULL, 1, 'p-825', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:27:29', NULL, '2018-01-31 11:27:29'),
(59, 'Heer', 2, NULL, 1, 'p-306', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:28:36', NULL, '2018-01-31 11:28:36'),
(60, 'Adore', 2, NULL, 1, 'p-41', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:29:08', NULL, '2018-01-31 11:29:08'),
(61, 'Sadhana', 2, NULL, 1, 'p-186', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:30:52', NULL, '2018-01-31 11:30:52'),
(62, 'Reverence', 2, NULL, 1, 'p-278', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:32:18', NULL, '2018-01-31 11:32:18'),
(63, 'Sandhya', 2, NULL, 1, 'p-806', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:33:28', NULL, '2018-01-31 11:33:28'),
(64, 'Ishika Lavisha', 2, NULL, 1, 'p-440', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:34:20', NULL, '2018-01-31 11:34:20'),
(65, 'Raaga', 2, NULL, 1, 'p-592', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:34:41', NULL, '2018-01-31 11:34:41'),
(66, 'Zubeda', 2, NULL, 1, 'p-149', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:36:19', NULL, '2018-01-31 11:37:29'),
(67, 'Vinay', 2, NULL, 1, 'p-910', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:40:43', NULL, '2018-01-31 11:44:25'),
(68, 'Fiona', 2, NULL, 1, 'p-243', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:41:29', NULL, '2018-01-31 11:41:29'),
(69, 'Avon', 2, NULL, 1, 'p-558', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:42:13', NULL, '2018-01-31 11:42:13'),
(70, 'Nine is Fine', 2, NULL, 1, 'p-490', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:42:55', NULL, '2018-01-31 11:42:55'),
(71, 'Zisa', 2, NULL, 1, 'p-966', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:43:27', NULL, '2018-01-31 11:43:27'),
(72, 'Mama', 2, NULL, 1, 'p-117', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:45:51', NULL, '2018-01-31 11:45:51'),
(73, 'Jinaam', 2, NULL, 1, 'p-539', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:47:56', NULL, '2018-01-31 11:47:56'),
(74, 'Vishal', 2, NULL, 1, 'p-326', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:49:04', NULL, '2018-01-31 11:49:04'),
(75, 'Indian Boutique', 2, NULL, 1, 'p-775', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:51:04', NULL, '2018-01-31 11:51:04'),
(76, 'P D Print', 2, NULL, 1, 'p-633', NULL, NULL, 0, 1, 0, 4, '2018-01-31 11:51:48', NULL, '2018-01-31 11:52:15'),
(77, 'Sajjan', 2, NULL, 1, 'p-596', NULL, NULL, 0, 1, 0, 4, '2018-01-31 13:17:03', NULL, '2018-01-31 13:17:03'),
(78, 'Ganga', 2, NULL, 1, 'p-914', NULL, NULL, 0, 1, 0, 4, '2018-01-31 13:17:28', NULL, '2018-01-31 13:17:28'),
(79, 'Ekta', 2, NULL, 1, 'p-127', NULL, NULL, 0, 1, 0, 4, '2018-01-31 13:19:18', NULL, '2018-01-31 13:19:18'),
(80, 'Leggings', 2, NULL, 1, 'p-759', NULL, NULL, 0, 1, 0, 4, '2018-01-31 13:52:18', NULL, '2018-01-31 13:52:18'),
(81, 'Leggings', 2, NULL, 1, 'p-544', NULL, NULL, 0, 1, 0, 4, '2018-01-31 13:52:18', NULL, '2018-01-31 13:52:18'),
(82, 'Plazu In', 2, NULL, 1, 'p-983', NULL, NULL, 0, 1, 0, 4, '2018-01-31 13:53:15', NULL, '2018-01-31 13:53:15'),
(83, 'Ragga', 2, NULL, 1, 'p-116', NULL, NULL, 0, 1, 0, 4, '2018-01-31 15:08:37', NULL, '2018-01-31 15:08:37'),
(84, 'Coti', 3, NULL, 1, 'p-789', NULL, NULL, 0, 1, 0, 4, '2018-02-05 14:37:17', NULL, '2018-02-05 14:37:17'),
(85, 'Orna', 2, NULL, 1, 'p-301', NULL, NULL, 0, 1, 0, 4, '2018-02-05 14:51:25', NULL, '2018-02-05 14:51:25'),
(86, 'Ten Tops', 5, NULL, 1, 'p-989', NULL, NULL, 0, 1, 0, 4, '2018-02-05 15:08:03', NULL, '2018-02-05 15:08:03'),
(87, 'Hanger', 3, NULL, 1, 'p-754', NULL, NULL, 0, 1, 0, 4, '2018-02-09 15:15:43', NULL, '2018-02-09 15:15:43'),
(88, 'Fair&lovely', 6, NULL, 1, 'p-246', NULL, NULL, 0, 1, 0, 1, '2020-10-09 08:42:24', NULL, '2020-10-09 08:42:24');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_product_add`
--

CREATE TABLE `inventory_product_add` (
  `id` int(10) UNSIGNED NOT NULL,
  `inventory_order_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `challan_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `summery` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `total_amount` decimal(17,6) NOT NULL,
  `total_paid` decimal(17,6) DEFAULT 0.000000,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `fk_supplier_id` int(11) UNSIGNED NOT NULL,
  `created_by` int(11) UNSIGNED NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_product_add`
--

INSERT INTO `inventory_product_add` (`id`, `inventory_order_id`, `challan_id`, `summery`, `date`, `total_amount`, `total_paid`, `status`, `fk_supplier_id`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(21, 'A1801291', 'A1801291', NULL, '2017-07-08', 190000.000000, 190000.000000, 1, 11, 4, NULL, '2018-01-29 18:00:16', '2018-01-29 18:00:16'),
(22, 'A18013023', 'A18013022', NULL, '2017-07-25', 23000.000000, 23000.000000, 1, 11, 4, NULL, '2018-01-30 14:11:41', '2018-01-30 14:11:41'),
(23, 'A18013024', 'A18013023', NULL, '2017-07-31', 525370.000000, 525370.000000, 1, 11, 4, NULL, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(24, 'A18013025', 'A18013024', NULL, '2017-07-17', 15150.000000, 15150.000000, 1, 12, 4, NULL, '2018-01-30 14:39:40', '2018-03-05 17:47:17'),
(25, 'A18013026', 'A18013025', NULL, '2017-07-17', 16960.000000, 16960.000000, 1, 7, 4, NULL, '2018-01-30 14:46:42', '2018-01-30 14:46:42'),
(26, 'A18013027', 'A18013026', NULL, '2017-07-17', 19440.000000, 19440.000000, 1, 14, 4, NULL, '2018-01-30 14:49:10', '2018-01-30 14:49:10'),
(27, 'A18013028', 'A18013027', NULL, '2017-07-23', 35650.000000, 35650.000000, 1, 12, 4, NULL, '2018-01-30 14:55:28', '2018-03-05 17:49:33'),
(28, 'A18013029', 'A18013028', NULL, '2017-08-04', 194400.000000, 153525.000000, 1, 13, 4, NULL, '2018-01-30 15:20:20', '2018-04-01 05:48:40'),
(29, 'A18013030', 'A18013029', NULL, '2017-08-10', 405600.000000, 405600.000000, 1, 11, 4, NULL, '2018-01-30 15:30:14', '2018-01-30 15:30:14'),
(30, 'A18013031', 'A18013030', NULL, '2017-08-16', 17800.000000, 17600.000000, 1, 12, 4, NULL, '2018-01-30 15:39:45', '2018-03-21 06:43:58'),
(31, 'A18013032', 'A18013031', NULL, '2017-09-29', 52800.000000, 52800.000000, 1, 14, 4, NULL, '2018-01-30 15:43:48', '2018-01-30 15:43:48'),
(32, 'A18013033', 'A18013032', NULL, '2017-09-30', 312900.000000, 0.000000, 1, 7, 4, NULL, '2018-01-30 15:49:11', '2018-01-30 15:49:11'),
(33, 'A18013034', 'A18013033', NULL, '2017-10-16', 294400.000000, 294400.000000, 1, 11, 4, NULL, '2018-01-30 16:00:37', '2018-01-30 16:00:37'),
(34, 'A18013035', 'A18013034', NULL, '2017-10-30', 739250.000000, 739250.000000, 1, 11, 4, NULL, '2018-01-30 16:15:30', '2018-01-30 16:15:30'),
(35, 'A18013036', 'A18013035', NULL, '2017-10-22', 32500.000000, 32500.000000, 1, 10, 4, NULL, '2018-01-30 16:28:49', '2018-01-30 16:28:49'),
(36, 'A18013037', 'A18013036', NULL, '2017-11-14', 714300.000000, 714300.000000, 1, 10, 4, NULL, '2018-01-30 16:36:58', '2018-01-30 16:36:58'),
(37, 'A18013038', 'A18013037', NULL, '2017-11-10', 52500.000000, 0.000000, 1, 12, 4, NULL, '2018-01-30 16:42:36', '2018-03-21 06:40:22'),
(38, 'A18013039', 'A18013038', NULL, '2018-01-24', 633100.000000, 633100.000000, 1, 11, 4, NULL, '2018-01-30 16:45:50', '2018-01-30 16:45:50'),
(39, 'A18013040', 'A18013039', NULL, '2017-10-22', 22100.000000, 22100.000000, 1, 11, 4, NULL, '2018-01-30 17:35:54', '2018-01-30 17:42:40'),
(40, 'A18013041', 'A18013040', NULL, '2017-12-17', 1458380.000000, 1458380.000000, 1, 11, 4, NULL, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(41, 'A18013042', 'A18013041', NULL, '2017-09-22', 78300.000000, 78300.000000, 1, 16, 4, NULL, '2018-01-30 18:41:15', '2018-01-30 18:41:15'),
(42, 'A18013043', 'A18013042', NULL, '2017-09-23', 68000.000000, 68000.000000, 1, 17, 4, NULL, '2018-01-30 18:48:29', '2018-01-30 18:50:04'),
(43, 'A18013144', 'A18013143', NULL, '2017-08-18', 131897.000000, 131897.000000, 1, 17, 4, NULL, '2018-01-31 12:10:55', '2018-01-31 12:10:55'),
(44, 'A18013145', 'A18013144', NULL, '2017-09-24', 201296.000000, 201296.000000, 1, 8, 4, NULL, '2018-01-31 12:23:34', '2018-01-31 12:37:40'),
(45, 'A18013146', 'A18013145', NULL, '2017-10-04', 128300.000000, 128300.000000, 1, 9, 4, NULL, '2018-01-31 12:41:25', '2018-01-31 12:41:25'),
(46, 'A18013147', 'A18013146', NULL, '2017-09-24', 871454.000000, 871454.000000, 1, 9, 4, NULL, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(47, 'A18013148', 'A18013147', NULL, '2017-11-22', 24000.000000, 24000.000000, 1, 17, 4, NULL, '2018-01-31 13:49:50', '2018-01-31 13:49:50'),
(48, 'A18013149', 'A18013148', NULL, '2018-01-01', 51400.000000, 51400.000000, 1, 17, 4, NULL, '2018-01-31 13:58:55', '2018-01-31 13:58:55'),
(49, 'A18013150', 'A18013149', NULL, '2018-01-15', 499700.000000, 499700.000000, 1, 9, 4, NULL, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(50, 'A18013151', 'A18013150', NULL, '2018-01-10', 162450.000000, 162450.000000, 1, 9, 4, NULL, '2018-01-31 14:48:05', '2018-01-31 14:48:05'),
(51, 'A18013152', 'A18013151', NULL, '2018-01-15', 285700.000000, 285700.000000, 1, 8, 4, NULL, '2018-01-31 15:00:24', '2018-01-31 15:00:24'),
(52, 'A18013153', 'A18013152', NULL, '2018-01-20', 176400.000000, 176400.000000, 1, 9, 4, NULL, '2018-01-31 15:10:04', '2018-01-31 15:10:04'),
(53, 'A18020454', 'A18020453', NULL, '2018-01-24', 27610.000000, 27610.000000, 1, 15, 4, NULL, '2018-02-04 15:56:24', '2018-02-10 15:22:17'),
(54, 'A18020555', 'A18020554', NULL, '2017-07-02', 3488666.000000, 3488666.000000, 1, 17, 4, NULL, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(55, 'A18020556', 'A18020555', NULL, '2018-02-02', 8750.000000, 0.000000, 1, 12, 4, NULL, '2018-02-05 15:21:31', '2018-03-21 06:40:22'),
(56, 'A18020557', 'A18020556', NULL, '2018-02-05', 92880.000000, 100.000000, 1, 18, 4, NULL, '2018-02-05 15:29:07', '2018-04-01 06:51:06'),
(57, 'A18020558', 'A18020557', NULL, '2017-10-16', 110000.000000, 110000.000000, 1, 17, 4, NULL, '2018-02-05 17:17:31', '2018-02-05 17:17:31'),
(58, 'A18021460', 'A18021458', NULL, '2018-02-13', 262390.000000, 262390.000000, 1, 8, 3, NULL, '2018-02-14 12:23:02', '2018-02-14 12:23:02'),
(59, '61', '59', NULL, '2017-09-09', 140600.000000, 0.000000, 1, 19, 6, NULL, '2018-02-17 17:28:18', '2018-02-17 17:28:18'),
(60, '62', '60', NULL, '2017-09-10', 881992.000000, 0.000000, 1, 19, 6, NULL, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(61, '63', '61', NULL, '2017-09-08', 1773543.000000, 0.000000, 1, 19, 6, NULL, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(62, '64', '62', NULL, '2017-09-09', 1706695.000000, 0.000000, 1, 19, 6, NULL, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(63, '65', '63', NULL, '2018-02-16', 8775.000000, 0.000000, 1, 19, 6, NULL, '2018-02-17 21:51:57', '2018-02-17 21:51:57'),
(64, '66', '64', NULL, '2018-02-16', 205640.000000, 0.000000, 1, 19, 6, NULL, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(65, 'A18030365', 'A18030365', NULL, '2018-02-27', 461150.000000, 461150.000000, 1, 8, 5, NULL, '2018-03-04 00:50:04', '2018-03-04 00:50:04'),
(66, 'A18030366', 'A18030366', NULL, '2018-02-23', 1200.000000, 1200.000000, 1, 17, 5, NULL, '2018-03-04 00:53:18', '2018-03-04 00:53:18'),
(68, 'A18030467', 'A18030467', NULL, '2018-02-04', 11682.000000, 0.000000, 1, 19, 5, NULL, '2018-03-04 19:56:15', '2018-03-21 06:40:22'),
(69, 'A18030469', 'A18030469', NULL, '2018-03-02', 369250.000000, 135770.000000, 1, 19, 6, NULL, '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(70, 'A18030570', 'A18030570', NULL, '2017-11-28', 1800.000000, 0.000000, 1, 12, 5, NULL, '2018-03-05 17:45:12', '2018-03-21 06:40:22');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_product_add_item`
--

CREATE TABLE `inventory_product_add_item` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_product_add_id` int(10) UNSIGNED NOT NULL,
  `fk_product_id` int(10) UNSIGNED NOT NULL,
  `fk_model_id` int(10) NOT NULL DEFAULT 1,
  `fk_inventory_id` int(10) UNSIGNED NOT NULL,
  `fk_branch_id` int(10) UNSIGNED NOT NULL,
  `qty` float NOT NULL DEFAULT 0,
  `cost_per_unit` decimal(17,6) DEFAULT NULL,
  `sales_per_unit` decimal(17,6) DEFAULT NULL,
  `payable_amount` decimal(17,6) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_product_add_item`
--

INSERT INTO `inventory_product_add_item` (`id`, `fk_product_add_id`, `fk_product_id`, `fk_model_id`, `fk_inventory_id`, `fk_branch_id`, `qty`, `cost_per_unit`, `sales_per_unit`, `payable_amount`, `created_at`, `updated_at`) VALUES
(33, 21, 27, 31, 33, 2, 1900, 100.000000, NULL, 190000.000000, '2018-01-29 18:00:16', '2018-01-29 18:00:16'),
(34, 22, 28, 32, 34, 2, 20, 1000.000000, NULL, 20000.000000, '2018-01-30 14:11:41', '2018-01-30 14:11:41'),
(35, 22, 28, 33, 35, 2, 3, 1000.000000, NULL, 3000.000000, '2018-01-30 14:11:41', '2018-01-30 14:11:41'),
(36, 23, 28, 32, 36, 2, 100, 975.000000, NULL, 97500.000000, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(37, 23, 28, 34, 37, 2, 96, 1100.000000, NULL, 105600.000000, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(38, 23, 28, 35, 38, 2, 129, 1025.000000, NULL, 132225.000000, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(39, 23, 28, 36, 39, 2, 92, 600.000000, NULL, 55200.000000, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(40, 23, 28, 37, 40, 2, 35, 665.000000, NULL, 23275.000000, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(41, 23, 28, 38, 41, 2, 25, 520.000000, NULL, 13000.000000, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(42, 23, 28, 39, 42, 2, 66, 520.000000, NULL, 34320.000000, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(43, 23, 30, 40, 43, 2, 25, 570.000000, NULL, 14250.000000, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(44, 23, 39, 41, 44, 2, 200, 250.000000, NULL, 50000.000000, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(45, 24, 34, 42, 45, 2, 3, 1400.000000, NULL, 4200.000000, '2018-01-30 14:39:40', '2018-01-30 14:39:40'),
(46, 24, 34, 42, 46, 2, 6, 1200.000000, NULL, 7200.000000, '2018-01-30 14:39:40', '2018-01-30 14:39:40'),
(47, 24, 34, 42, 47, 2, 3, 1250.000000, NULL, 3750.000000, '2018-01-30 14:39:40', '2018-01-30 14:39:40'),
(48, 25, 37, 43, 48, 2, 10, 700.000000, NULL, 7000.000000, '2018-01-30 14:46:42', '2018-01-30 14:46:42'),
(49, 25, 38, 44, 49, 2, 9, 900.000000, NULL, 8100.000000, '2018-01-30 14:46:42', '2018-01-30 14:46:42'),
(50, 25, 38, 44, 50, 2, 2, 930.000000, NULL, 1860.000000, '2018-01-30 14:46:42', '2018-01-30 14:46:42'),
(51, 26, 37, 43, 51, 2, 27, 720.000000, NULL, 19440.000000, '2018-01-30 14:49:10', '2018-01-30 14:49:10'),
(52, 27, 35, 45, 52, 2, 27, 1250.000000, NULL, 33750.000000, '2018-01-30 14:55:28', '2018-01-30 14:55:28'),
(53, 27, 35, 31, 53, 2, 2, 950.000000, NULL, 1900.000000, '2018-01-30 14:55:28', '2018-01-30 14:55:28'),
(54, 28, 49, 46, 54, 2, 72, 2700.000000, NULL, 194400.000000, '2018-01-30 15:20:20', '2018-01-30 15:20:20'),
(55, 29, 28, 36, 55, 2, 20, 600.000000, NULL, 12000.000000, '2018-01-30 15:30:14', '2018-01-30 15:30:14'),
(56, 29, 28, 33, 56, 2, 78, 950.000000, NULL, 74100.000000, '2018-01-30 15:30:14', '2018-01-30 15:30:14'),
(57, 29, 28, 32, 57, 2, 320, 850.000000, NULL, 272000.000000, '2018-01-30 15:30:14', '2018-01-30 15:30:14'),
(58, 29, 28, 34, 58, 2, 50, 950.000000, NULL, 47500.000000, '2018-01-30 15:30:14', '2018-01-30 15:30:14'),
(59, 30, 34, 42, 59, 2, 9, 1200.000000, 0.000000, 10800.000000, '2018-01-30 15:39:45', '2018-03-21 06:43:58'),
(60, 30, 34, 42, 60, 2, 5, 1400.000000, 0.000000, 7000.000000, '2018-01-30 15:39:45', '2018-03-21 06:43:58'),
(61, 31, 49, 31, 61, 2, 32, 1650.000000, NULL, 52800.000000, '2018-01-30 15:43:48', '2018-01-30 15:43:48'),
(62, 32, 49, 31, 62, 2, 84, 1600.000000, NULL, 134400.000000, '2018-01-30 15:49:11', '2018-01-30 15:49:11'),
(63, 32, 38, 44, 63, 2, 66, 1250.000000, NULL, 82500.000000, '2018-01-30 15:49:11', '2018-01-30 15:49:11'),
(64, 32, 38, 44, 64, 2, 80, 1200.000000, NULL, 96000.000000, '2018-01-30 15:49:11', '2018-01-30 15:49:11'),
(65, 33, 28, 39, 65, 2, 100, 400.000000, NULL, 40000.000000, '2018-01-30 16:00:37', '2018-01-30 16:00:37'),
(66, 33, 31, 47, 66, 2, 179, 500.000000, NULL, 89500.000000, '2018-01-30 16:00:37', '2018-01-30 16:00:37'),
(67, 33, 30, 48, 67, 2, 122, 450.000000, NULL, 54900.000000, '2018-01-30 16:00:37', '2018-01-30 16:00:37'),
(68, 33, 28, 33, 68, 2, 100, 1100.000000, NULL, 110000.000000, '2018-01-30 16:00:37', '2018-01-30 16:00:37'),
(69, 34, 30, 40, 69, 2, 40, 500.000000, NULL, 20000.000000, '2018-01-30 16:15:30', '2018-01-30 16:15:30'),
(70, 34, 45, 49, 70, 2, 10, 1800.000000, NULL, 18000.000000, '2018-01-30 16:15:30', '2018-01-30 16:15:30'),
(71, 34, 45, 50, 71, 2, 25, 1050.000000, NULL, 26250.000000, '2018-01-30 16:15:30', '2018-01-30 16:15:30'),
(72, 34, 28, 33, 72, 2, 210, 1000.000000, NULL, 210000.000000, '2018-01-30 16:15:30', '2018-01-30 16:15:30'),
(73, 34, 28, 32, 73, 2, 300, 1000.000000, NULL, 300000.000000, '2018-01-30 16:15:30', '2018-01-30 16:15:30'),
(74, 34, 28, 34, 74, 2, 150, 1100.000000, NULL, 165000.000000, '2018-01-30 16:15:30', '2018-01-30 16:15:30'),
(75, 35, 29, 51, 75, 2, 5, 750.000000, NULL, 3750.000000, '2018-01-30 16:28:49', '2018-01-30 16:28:49'),
(76, 35, 42, 52, 76, 2, 3, 900.000000, NULL, 2700.000000, '2018-01-30 16:28:49', '2018-01-30 16:28:49'),
(77, 35, 29, 53, 77, 2, 8, 1000.000000, NULL, 8000.000000, '2018-01-30 16:28:49', '2018-01-30 16:28:49'),
(78, 35, 32, 54, 78, 2, 19, 950.000000, NULL, 18050.000000, '2018-01-30 16:28:49', '2018-01-30 16:28:49'),
(79, 36, 50, 55, 79, 2, 24, 550.000000, NULL, 13200.000000, '2018-01-30 16:36:58', '2018-01-30 16:36:58'),
(80, 36, 50, 56, 80, 2, 342, 300.000000, NULL, 102600.000000, '2018-01-30 16:36:58', '2018-01-30 16:36:58'),
(81, 36, 29, 51, 81, 2, 149, 700.000000, NULL, 104300.000000, '2018-01-30 16:36:58', '2018-01-30 16:36:58'),
(82, 36, 42, 57, 82, 2, 80, 450.000000, NULL, 36000.000000, '2018-01-30 16:36:58', '2018-01-30 16:36:58'),
(83, 36, 32, 54, 83, 2, 130, 1000.000000, NULL, 130000.000000, '2018-01-30 16:36:58', '2018-01-30 16:36:58'),
(84, 36, 32, 58, 84, 2, 547, 600.000000, NULL, 328200.000000, '2018-01-30 16:36:58', '2018-01-30 16:36:58'),
(85, 37, 35, 59, 85, 2, 42, 1250.000000, NULL, 52500.000000, '2018-01-30 16:42:36', '2018-01-30 16:42:36'),
(86, 38, 28, 33, 86, 2, 130, 1000.000000, NULL, 130000.000000, '2018-01-30 16:45:50', '2018-01-30 16:45:50'),
(87, 38, 28, 32, 87, 2, 559, 900.000000, NULL, 503100.000000, '2018-01-30 16:45:50', '2018-01-30 16:45:50'),
(88, 39, 51, 60, 88, 2, 72, 50.000000, 0.000000, 3600.000000, '2018-01-30 17:35:54', '2018-01-30 17:42:40'),
(89, 39, 51, 60, 89, 2, 88, 40.000000, 0.000000, 3520.000000, '2018-01-30 17:35:54', '2018-01-30 17:42:40'),
(90, 39, 51, 60, 90, 2, 112, 25.000000, 0.000000, 2800.000000, '2018-01-30 17:35:54', '2018-01-30 17:42:40'),
(91, 39, 51, 61, 91, 2, 300, 17.000000, 0.000000, 5100.000000, '2018-01-30 17:35:54', '2018-01-30 17:42:40'),
(92, 39, 51, 61, 92, 2, 50, 22.000000, 0.000000, 1100.000000, '2018-01-30 17:35:54', '2018-01-30 17:42:40'),
(93, 39, 51, 62, 93, 2, 348, 10.000000, 0.000000, 3480.000000, '2018-01-30 17:35:54', '2018-01-30 17:42:40'),
(94, 39, 51, 63, 94, 2, 16, 50.000000, 0.000000, 800.000000, '2018-01-30 17:35:54', '2018-01-30 17:42:40'),
(95, 39, 48, 64, 95, 2, 10, 30.000000, 0.000000, 300.000000, '2018-01-30 17:35:54', '2018-01-30 17:42:40'),
(96, 39, 45, 50, 96, 2, 1, 1000.000000, 0.000000, 1000.000000, '2018-01-30 17:35:54', '2018-01-30 17:42:40'),
(97, 39, 27, 65, 97, 2, 2, 200.000000, 0.000000, 400.000000, '2018-01-30 17:35:54', '2018-01-30 17:42:40'),
(98, 40, 27, 66, 98, 2, 200, 300.000000, NULL, 60000.000000, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(99, 40, 27, 67, 99, 2, 200, 175.000000, NULL, 35000.000000, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(100, 40, 27, 68, 100, 2, 780, 200.000000, NULL, 156000.000000, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(101, 40, 27, 69, 101, 2, 80, 150.000000, NULL, 12000.000000, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(102, 40, 27, 70, 102, 2, 900, 175.000000, NULL, 157500.000000, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(103, 40, 27, 71, 103, 2, 300, 250.000000, NULL, 75000.000000, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(104, 40, 27, 72, 104, 2, 2147, 90.000000, NULL, 193230.000000, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(105, 40, 44, 73, 105, 2, 300, 300.000000, NULL, 90000.000000, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(106, 40, 44, 74, 106, 2, 49, 1200.000000, NULL, 58800.000000, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(107, 40, 44, 75, 107, 2, 140, 550.000000, NULL, 77000.000000, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(108, 40, 39, 41, 108, 2, 120, 250.000000, NULL, 30000.000000, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(109, 40, 39, 76, 109, 2, 350, 275.000000, NULL, 96250.000000, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(110, 40, 43, 77, 110, 2, 520, 325.000000, NULL, 169000.000000, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(111, 40, 43, 78, 111, 2, 390, 250.000000, NULL, 97500.000000, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(112, 40, 39, 41, 112, 2, 200, 175.000000, NULL, 35000.000000, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(113, 40, 27, 79, 113, 2, 540, 215.000000, NULL, 116100.000000, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(114, 41, 33, 80, 114, 2, 241, 300.000000, NULL, 72300.000000, '2018-01-30 18:41:15', '2018-01-30 18:41:15'),
(115, 41, 34, 42, 115, 2, 8, 750.000000, NULL, 6000.000000, '2018-01-30 18:41:15', '2018-01-30 18:41:15'),
(116, 42, 40, 81, 116, 2, 40, 1700.000000, 0.000000, 68000.000000, '2018-01-30 18:48:29', '2018-01-30 18:50:04'),
(117, 43, 73, 82, 117, 2, 10, 3100.000000, NULL, 31000.000000, '2018-01-31 12:10:55', '2018-01-31 12:10:55'),
(118, 43, 40, 83, 118, 2, 20, 1250.000000, NULL, 25000.000000, '2018-01-31 12:10:55', '2018-01-31 12:10:55'),
(119, 43, 40, 37, 119, 2, 27, 1650.000000, NULL, 44550.000000, '2018-01-31 12:10:55', '2018-01-31 12:10:55'),
(120, 43, 40, 45, 120, 2, 9, 3483.000000, NULL, 31347.000000, '2018-01-31 12:10:55', '2018-01-31 12:10:55'),
(121, 44, 67, 84, 121, 2, 45, 1480.000000, 0.000000, 66600.000000, '2018-01-31 12:23:34', '2018-01-31 12:37:40'),
(122, 44, 67, 85, 122, 2, 22, 1900.000000, 0.000000, 41800.000000, '2018-01-31 12:23:34', '2018-01-31 12:37:40'),
(123, 44, 67, 86, 123, 2, 8, 2000.000000, 0.000000, 16000.000000, '2018-01-31 12:23:34', '2018-01-31 12:37:40'),
(124, 44, 67, 87, 124, 2, 8, 2700.000000, 0.000000, 21600.000000, '2018-01-31 12:23:34', '2018-01-31 12:37:40'),
(125, 44, 73, 82, 125, 2, 10, 3100.000000, 0.000000, 31000.000000, '2018-01-31 12:23:34', '2018-01-31 12:37:40'),
(126, 44, 67, 88, 126, 2, 8, 3037.000000, 0.000000, 24296.000000, '2018-01-31 12:23:34', '2018-01-31 12:37:40'),
(127, 45, 59, 89, 127, 2, 11, 3400.000000, NULL, 37400.000000, '2018-01-31 12:41:25', '2018-01-31 12:41:25'),
(128, 45, 53, 90, 128, 2, 12, 3200.000000, NULL, 38400.000000, '2018-01-31 12:41:25', '2018-01-31 12:41:25'),
(129, 45, 58, 91, 129, 2, 10, 2550.000000, NULL, 25500.000000, '2018-01-31 12:41:25', '2018-01-31 12:41:25'),
(130, 45, 56, 92, 130, 2, 9, 3000.000000, NULL, 27000.000000, '2018-01-31 12:41:25', '2018-01-31 12:41:25'),
(131, 46, 72, 93, 131, 2, 159, 1050.000000, NULL, 166950.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(132, 46, 74, 94, 132, 2, 26, 1954.000000, NULL, 50804.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(133, 46, 76, 95, 133, 2, 140, 1100.000000, NULL, 154000.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(134, 46, 76, 95, 134, 2, 36, 1250.000000, NULL, 45000.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(135, 46, 76, 95, 135, 2, 46, 1300.000000, NULL, 59800.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(136, 46, 76, 95, 136, 2, 8, 1450.000000, NULL, 11600.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(137, 46, 57, 76, 137, 2, 26, 1500.000000, NULL, 39000.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(138, 46, 75, 96, 138, 2, 28, 1700.000000, NULL, 47600.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(139, 46, 75, 96, 139, 2, 20, 1800.000000, NULL, 36000.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(140, 46, 75, 96, 140, 2, 4, 1400.000000, NULL, 5600.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(141, 46, 77, 97, 141, 2, 12, 3250.000000, NULL, 39000.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(142, 46, 79, 98, 142, 2, 10, 2950.000000, NULL, 29500.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(143, 46, 78, 99, 143, 2, 9, 3000.000000, NULL, 27000.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(144, 46, 55, 100, 144, 2, 8, 3000.000000, NULL, 24000.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(145, 46, 55, 101, 145, 2, 8, 2850.000000, NULL, 22800.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(146, 46, 55, 102, 146, 2, 8, 2850.000000, NULL, 22800.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(147, 46, 59, 89, 147, 2, 11, 3000.000000, NULL, 33000.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(148, 46, 57, 103, 148, 2, 20, 2850.000000, NULL, 57000.000000, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(149, 47, 55, 102, 149, 2, 8, 3000.000000, NULL, 24000.000000, '2018-01-31 13:49:50', '2018-01-31 13:49:50'),
(150, 48, 40, 83, 150, 2, 10, 1300.000000, NULL, 13000.000000, '2018-01-31 13:58:55', '2018-01-31 13:58:55'),
(151, 48, 66, 104, 151, 2, 7, 4000.000000, NULL, 28000.000000, '2018-01-31 13:58:55', '2018-01-31 13:58:55'),
(152, 48, 81, 105, 152, 2, 18, 300.000000, NULL, 5400.000000, '2018-01-31 13:58:55', '2018-01-31 13:58:55'),
(153, 48, 82, 106, 153, 2, 10, 500.000000, NULL, 5000.000000, '2018-01-31 13:58:55', '2018-01-31 13:58:55'),
(154, 49, 52, 107, 154, 2, 10, 2600.000000, NULL, 26000.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(155, 49, 53, 108, 155, 2, 12, 3150.000000, NULL, 37800.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(156, 49, 54, 109, 156, 2, 11, 1900.000000, NULL, 20900.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(157, 49, 55, 110, 157, 2, 12, 2500.000000, NULL, 30000.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(158, 49, 56, 111, 158, 2, 6, 2500.000000, NULL, 15000.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(159, 49, 57, 112, 159, 2, 8, 3600.000000, NULL, 28800.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(160, 49, 55, 102, 160, 2, 8, 2900.000000, NULL, 23200.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(161, 49, 53, 113, 161, 2, 12, 3300.000000, NULL, 39600.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(162, 49, 58, 114, 162, 2, 9, 2700.000000, NULL, 24300.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(163, 49, 55, 115, 163, 2, 8, 2700.000000, NULL, 21600.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(164, 49, 58, 116, 164, 2, 5, 2750.000000, NULL, 13750.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(165, 49, 56, 117, 165, 2, 12, 2800.000000, NULL, 33600.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(166, 49, 58, 118, 166, 2, 8, 3550.000000, NULL, 28400.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(167, 49, 53, 119, 167, 2, 12, 2500.000000, NULL, 30000.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(168, 49, 59, 89, 168, 2, 11, 3400.000000, NULL, 37400.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(169, 49, 60, 120, 169, 2, 7, 1550.000000, NULL, 10850.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(170, 49, 61, 121, 170, 2, 10, 1400.000000, NULL, 14000.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(171, 49, 62, 122, 171, 2, 8, 1750.000000, NULL, 14000.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(172, 49, 63, 123, 172, 2, 8, 1900.000000, NULL, 15200.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(173, 49, 64, 124, 173, 2, 10, 1250.000000, NULL, 12500.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(174, 49, 75, 125, 174, 2, 4, 3900.000000, NULL, 15600.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(175, 49, 75, 125, 175, 2, 2, 3600.000000, NULL, 7200.000000, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(176, 50, 75, 96, 176, 2, 6, 1750.000000, NULL, 10500.000000, '2018-01-31 14:48:05', '2018-01-31 14:48:05'),
(177, 50, 75, 96, 177, 2, 4, 1600.000000, NULL, 6400.000000, '2018-01-31 14:48:05', '2018-01-31 14:48:05'),
(178, 50, 75, 96, 178, 2, 8, 1750.000000, NULL, 14000.000000, '2018-01-31 14:48:05', '2018-01-31 14:48:05'),
(179, 50, 75, 96, 179, 2, 5, 1650.000000, NULL, 8250.000000, '2018-01-31 14:48:05', '2018-01-31 14:48:05'),
(180, 50, 75, 96, 180, 2, 10, 1250.000000, NULL, 12500.000000, '2018-01-31 14:48:05', '2018-01-31 14:48:05'),
(181, 50, 75, 126, 181, 2, 12, 1800.000000, NULL, 21600.000000, '2018-01-31 14:48:05', '2018-01-31 14:48:05'),
(182, 50, 40, 127, 182, 2, 29, 2000.000000, NULL, 58000.000000, '2018-01-31 14:48:05', '2018-01-31 14:48:05'),
(183, 50, 40, 128, 183, 2, 24, 1300.000000, NULL, 31200.000000, '2018-01-31 14:48:05', '2018-01-31 14:48:05'),
(184, 51, 75, 96, 184, 2, 6, 2450.000000, NULL, 14700.000000, '2018-01-31 15:00:24', '2018-01-31 15:00:24'),
(185, 51, 75, 96, 185, 2, 4, 2300.000000, NULL, 9200.000000, '2018-01-31 15:00:24', '2018-01-31 15:00:24'),
(186, 51, 75, 96, 186, 2, 2, 2200.000000, NULL, 4400.000000, '2018-01-31 15:00:24', '2018-01-31 15:00:24'),
(187, 51, 75, 129, 187, 2, 56, 2900.000000, NULL, 162400.000000, '2018-01-31 15:00:24', '2018-01-31 15:00:24'),
(188, 51, 75, 96, 188, 2, 16, 1900.000000, NULL, 30400.000000, '2018-01-31 15:00:24', '2018-01-31 15:00:24'),
(189, 51, 75, 96, 189, 2, 4, 1850.000000, NULL, 7400.000000, '2018-01-31 15:00:24', '2018-01-31 15:00:24'),
(190, 51, 75, 96, 190, 2, 16, 1850.000000, NULL, 29600.000000, '2018-01-31 15:00:24', '2018-01-31 15:00:24'),
(191, 51, 75, 96, 191, 2, 4, 1900.000000, NULL, 7600.000000, '2018-01-31 15:00:24', '2018-01-31 15:00:24'),
(192, 51, 75, 96, 192, 2, 8, 1700.000000, NULL, 13600.000000, '2018-01-31 15:00:24', '2018-01-31 15:00:24'),
(193, 51, 75, 96, 193, 2, 4, 1600.000000, NULL, 6400.000000, '2018-01-31 15:00:24', '2018-01-31 15:00:24'),
(194, 52, 72, 93, 194, 2, 144, 1050.000000, NULL, 151200.000000, '2018-01-31 15:10:04', '2018-01-31 15:10:04'),
(195, 52, 83, 130, 195, 2, 12, 2100.000000, NULL, 25200.000000, '2018-01-31 15:10:04', '2018-01-31 15:10:04'),
(196, 53, 41, 131, 196, 2, 5, 1000.000000, NULL, 5000.000000, '2018-02-04 15:56:24', '2018-02-04 15:56:24'),
(197, 53, 41, 132, 197, 2, 5, 1200.000000, NULL, 6000.000000, '2018-02-04 15:56:24', '2018-02-04 15:56:24'),
(198, 53, 41, 133, 198, 2, 5, 900.000000, NULL, 4500.000000, '2018-02-04 15:56:24', '2018-02-04 15:56:24'),
(199, 53, 41, 134, 199, 2, 6, 1060.000000, NULL, 6360.000000, '2018-02-04 15:56:24', '2018-02-04 15:56:24'),
(200, 53, 41, 135, 200, 2, 5, 1150.000000, NULL, 5750.000000, '2018-02-04 15:56:24', '2018-02-04 15:56:24'),
(201, 54, 35, 45, 201, 2, 19, 1450.000000, NULL, 27550.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(202, 54, 45, 50, 202, 2, 88, 1488.000000, NULL, 130944.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(203, 54, 75, 96, 203, 2, 6, 2536.000000, NULL, 15216.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(204, 54, 75, 125, 204, 2, 16, 2313.000000, NULL, 37008.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(205, 54, 84, 136, 205, 2, 53, 712.000000, NULL, 37736.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(206, 54, 84, 137, 206, 2, 228, 550.000000, NULL, 125400.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(207, 54, 51, 60, 207, 2, 262, 112.000000, NULL, 29344.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(208, 54, 48, 64, 208, 2, 2302, 86.000000, NULL, 197972.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(209, 54, 36, 138, 209, 2, 23, 840.000000, NULL, 19320.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(210, 54, 49, 31, 210, 2, 11, 1728.000000, NULL, 19008.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(211, 54, 37, 43, 211, 2, 43, 712.000000, NULL, 30616.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(212, 54, 38, 44, 212, 2, 136, 1035.000000, NULL, 140760.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(213, 54, 41, 31, 213, 2, 15, 750.000000, NULL, 11250.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(214, 54, 40, 45, 214, 2, 6, 2100.000000, NULL, 12600.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(215, 54, 85, 139, 215, 2, 23, 130.000000, NULL, 2990.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(216, 54, 31, 47, 216, 2, 334, 317.000000, NULL, 105878.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(217, 54, 32, 58, 217, 2, 231, 664.000000, NULL, 153384.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(218, 54, 72, 93, 218, 2, 19, 1350.000000, NULL, 25650.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(219, 54, 27, 31, 219, 2, 3348, 160.000000, NULL, 535680.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(220, 54, 27, 70, 220, 2, 1268, 226.000000, NULL, 286568.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(221, 54, 39, 76, 221, 2, 1638, 314.000000, NULL, 514332.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(222, 54, 43, 77, 222, 2, 1261, 410.000000, NULL, 517010.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(223, 54, 44, 75, 223, 2, 77, 600.000000, NULL, 46200.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(224, 54, 44, 73, 224, 2, 111, 322.000000, NULL, 35742.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(225, 54, 29, 51, 225, 2, 86, 620.000000, NULL, 53320.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(226, 54, 86, 140, 226, 2, 159, 230.000000, NULL, 36570.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(227, 54, 28, 32, 227, 2, 251, 1120.000000, NULL, 281120.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(228, 54, 42, 52, 228, 2, 37, 1233.000000, NULL, 45621.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(229, 54, 42, 57, 229, 2, 15, 850.000000, NULL, 12750.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(230, 54, 42, 57, 230, 2, 1, 1127.000000, NULL, 1127.000000, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(231, 55, 35, 141, 231, 2, 7, 1250.000000, NULL, 8750.000000, '2018-02-05 15:21:31', '2018-02-05 15:21:31'),
(232, 56, 27, 79, 232, 2, 432, 215.000000, NULL, 92880.000000, '2018-02-05 15:29:07', '2018-02-05 15:29:07'),
(233, 57, 45, 50, 233, 2, 100, 1100.000000, NULL, 110000.000000, '2018-02-05 17:17:31', '2018-02-05 17:17:31'),
(234, 58, 66, 142, 234, 2, 5, 2450.000000, NULL, 12250.000000, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(235, 58, 66, 143, 235, 2, 12, 2900.000000, NULL, 34800.000000, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(236, 58, 67, 144, 236, 2, 18, 1950.000000, NULL, 35100.000000, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(237, 58, 68, 145, 237, 2, 6, 3000.000000, NULL, 18000.000000, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(238, 58, 69, 146, 238, 2, 4, 2450.000000, NULL, 9800.000000, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(239, 58, 70, 147, 239, 2, 8, 1900.000000, NULL, 15200.000000, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(240, 58, 70, 148, 240, 2, 12, 2100.000000, NULL, 25200.000000, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(241, 58, 70, 149, 241, 2, 9, 2250.000000, NULL, 20250.000000, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(242, 58, 69, 150, 242, 2, 5, 2500.000000, NULL, 12500.000000, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(243, 58, 66, 151, 243, 2, 12, 3050.000000, NULL, 36600.000000, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(244, 58, 66, 152, 244, 2, 6, 2600.000000, NULL, 15600.000000, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(245, 58, 71, 153, 245, 2, 5, 2700.000000, NULL, 13500.000000, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(246, 58, 67, 84, 246, 2, 9, 1510.000000, NULL, 13590.000000, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(247, 59, 55, 100, 247, 4, 8, 3000.000000, NULL, 24000.000000, '2018-02-17 17:28:18', '2018-02-17 17:28:18'),
(248, 59, 55, 102, 248, 4, 8, 2900.000000, NULL, 23200.000000, '2018-02-17 17:28:18', '2018-02-17 17:28:18'),
(249, 59, 53, 108, 249, 4, 12, 3150.000000, NULL, 37800.000000, '2018-02-17 17:28:18', '2018-02-17 17:28:18'),
(250, 59, 53, 90, 250, 4, 11, 3200.000000, NULL, 35200.000000, '2018-02-17 17:28:18', '2018-02-17 17:28:18'),
(251, 59, 58, 91, 251, 4, 8, 2550.000000, NULL, 20400.000000, '2018-02-17 17:28:18', '2018-02-17 17:28:18'),
(252, 60, 44, 75, 252, 4, 110, 471.000000, NULL, 51810.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(253, 60, 44, 73, 253, 4, 222, 310.000000, NULL, 68820.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(254, 60, 44, 73, 254, 4, 8, 200.000000, NULL, 1600.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(255, 60, 28, 32, 255, 4, 570, 1018.000000, NULL, 580260.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(256, 60, 35, 59, 256, 4, 23, 1250.000000, NULL, 28750.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(257, 60, 81, 154, 257, 4, 8, 300.000000, NULL, 2400.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(258, 60, 82, 155, 258, 4, 2, 500.000000, NULL, 1000.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(259, 60, 86, 140, 259, 4, 103, 200.000000, NULL, 20600.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(260, 60, 28, 39, 260, 4, 28, 400.000000, NULL, 11200.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(261, 60, 42, 57, 261, 4, 39, 514.000000, NULL, 20046.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(262, 60, 45, 50, 262, 4, 63, 1100.000000, NULL, 69300.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(263, 60, 45, 49, 263, 4, 9, 1799.000000, NULL, 16191.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(264, 60, 51, 60, 264, 4, 53, 25.000000, NULL, 1325.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(265, 60, 51, 60, 265, 4, 41, 40.000000, NULL, 1640.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(266, 60, 51, 60, 266, 4, 29, 50.000000, NULL, 1450.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(267, 60, 51, 61, 267, 4, 150, 18.000000, NULL, 2700.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(268, 60, 51, 62, 268, 4, 290, 10.000000, NULL, 2900.000000, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(269, 61, 27, 70, 269, 4, 868, 184.000000, NULL, 159712.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(270, 61, 39, 156, 270, 4, 628, 262.000000, NULL, 164536.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(271, 61, 39, 41, 271, 4, 193, 200.000000, NULL, 38600.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(272, 61, 27, 31, 272, 4, 1610, 110.000000, NULL, 177100.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(273, 61, 27, 72, 273, 4, 520, 90.000000, NULL, 46800.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(274, 61, 43, 77, 274, 4, 430, 335.000000, NULL, 144050.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(275, 61, 43, 78, 275, 4, 171, 250.000000, NULL, 42750.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(276, 61, 43, 77, 276, 4, 32, 606.000000, NULL, 19392.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(277, 61, 27, 31, 277, 4, 449, 140.000000, NULL, 62860.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(278, 61, 27, 71, 278, 4, 105, 250.000000, NULL, 26250.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(279, 61, 27, 68, 279, 4, 202, 200.000000, NULL, 40400.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(280, 61, 27, 79, 280, 4, 540, 233.000000, NULL, 125820.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(281, 61, 33, 157, 281, 4, 80, 300.000000, NULL, 24000.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(282, 61, 31, 47, 282, 4, 151, 405.000000, NULL, 61155.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(283, 61, 32, 58, 283, 4, 380, 600.000000, NULL, 228000.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(284, 61, 32, 54, 284, 4, 75, 1000.000000, NULL, 75000.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(285, 61, 29, 51, 285, 4, 113, 700.000000, NULL, 79100.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(286, 61, 30, 48, 286, 4, 87, 472.000000, NULL, 41064.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(287, 61, 48, 64, 287, 4, 737, 54.000000, NULL, 39798.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(288, 61, 42, 57, 288, 4, 5, 800.000000, NULL, 4000.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(289, 61, 42, 52, 289, 4, 7, 1500.000000, NULL, 10500.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(290, 61, 84, 136, 290, 4, 45, 793.000000, NULL, 35685.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(291, 61, 45, 50, 291, 4, 16, 1500.000000, NULL, 24000.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(292, 61, 45, 50, 292, 4, 45, 1000.000000, NULL, 45000.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(293, 61, 44, 74, 293, 4, 23, 1200.000000, NULL, 27600.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(294, 61, 84, 137, 294, 4, 11, 550.000000, NULL, 6050.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(295, 61, 84, 137, 295, 4, 33, 737.000000, NULL, 24321.000000, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(296, 62, 49, 31, 296, 4, 58, 1613.000000, NULL, 93554.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(297, 62, 49, 46, 297, 4, 14, 2700.000000, NULL, 37800.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(298, 62, 72, 93, 298, 4, 184, 1050.000000, NULL, 193200.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(299, 62, 38, 44, 299, 4, 73, 1223.000000, NULL, 89279.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(300, 62, 66, 104, 300, 4, 7, 4000.000000, NULL, 28000.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(301, 62, 75, 129, 301, 4, 27, 2900.000000, NULL, 78300.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(302, 62, 75, 96, 302, 4, 90, 1726.000000, NULL, 155340.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(303, 62, 83, 130, 303, 4, 12, 2100.000000, NULL, 25200.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(304, 62, 40, 128, 304, 4, 24, 1300.000000, NULL, 31200.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(305, 62, 40, 127, 305, 4, 28, 2000.000000, NULL, 56000.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(306, 62, 75, 126, 306, 4, 8, 1800.000000, NULL, 14400.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(307, 62, 75, 125, 307, 4, 4, 3750.000000, NULL, 15000.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(308, 62, 52, 107, 308, 4, 10, 2600.000000, NULL, 26000.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(309, 62, 55, 110, 309, 4, 12, 2500.000000, NULL, 30000.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(310, 62, 53, 113, 310, 4, 12, 3300.000000, NULL, 39600.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(311, 62, 55, 115, 311, 4, 8, 2700.000000, NULL, 21600.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(312, 62, 58, 116, 312, 4, 5, 2750.000000, NULL, 13750.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(313, 62, 58, 118, 313, 4, 8, 3550.000000, NULL, 28400.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(314, 62, 56, 117, 314, 4, 12, 2800.000000, NULL, 33600.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(315, 62, 59, 89, 315, 4, 11, 3400.000000, NULL, 37400.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(316, 62, 60, 120, 316, 4, 7, 1550.000000, NULL, 10850.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(317, 62, 62, 122, 317, 4, 8, 1750.000000, NULL, 14000.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(318, 62, 63, 158, 318, 4, 8, 1900.000000, NULL, 15200.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(319, 62, 64, 124, 319, 4, 10, 1250.000000, NULL, 12500.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(320, 62, 40, 81, 320, 4, 15, 1700.000000, NULL, 25500.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(321, 62, 73, 82, 321, 4, 6, 3100.000000, NULL, 18600.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(322, 62, 40, 83, 322, 4, 11, 1295.000000, NULL, 14245.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(323, 62, 40, 81, 323, 4, 21, 1650.000000, NULL, 34650.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(324, 62, 67, 159, 324, 4, 8, 2000.000000, NULL, 16000.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(325, 62, 67, 88, 325, 4, 4, 3050.000000, NULL, 12200.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(326, 62, 67, 87, 326, 4, 4, 2700.000000, NULL, 10800.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(327, 62, 67, 85, 327, 4, 11, 1900.000000, NULL, 20900.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(328, 62, 67, 84, 328, 4, 30, 1500.000000, NULL, 45000.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(329, 62, 57, 103, 329, 4, 16, 2850.000000, NULL, 45600.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(330, 62, 79, 98, 330, 4, 10, 2950.000000, NULL, 29500.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(331, 62, 77, 97, 331, 4, 12, 3250.000000, NULL, 39000.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(332, 62, 78, 99, 332, 4, 9, 3000.000000, NULL, 27000.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(333, 62, 59, 89, 333, 4, 22, 3200.000000, NULL, 70400.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(334, 62, 55, 102, 334, 4, 8, 2847.000000, NULL, 22776.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(335, 62, 55, 101, 335, 4, 8, 2850.000000, NULL, 22800.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(336, 62, 74, 94, 336, 4, 18, 2100.000000, NULL, 37800.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(337, 62, 75, 95, 337, 4, 99, 1149.000000, NULL, 113751.000000, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(338, 63, 42, 57, 338, 4, 7, 450.000000, NULL, 3150.000000, '2018-02-17 21:51:57', '2018-02-17 21:51:57'),
(339, 63, 27, 70, 339, 4, 5, 175.000000, NULL, 875.000000, '2018-02-17 21:51:57', '2018-02-17 21:51:57'),
(340, 63, 43, 78, 340, 4, 8, 250.000000, NULL, 2000.000000, '2018-02-17 21:51:57', '2018-02-17 21:51:57'),
(341, 63, 39, 76, 341, 4, 11, 250.000000, NULL, 2750.000000, '2018-02-17 21:51:57', '2018-02-17 21:51:57'),
(342, 64, 66, 143, 342, 4, 12, 2900.000000, NULL, 34800.000000, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(343, 64, 67, 144, 343, 4, 8, 1950.000000, NULL, 15600.000000, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(344, 64, 68, 160, 344, 4, 6, 3000.000000, NULL, 18000.000000, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(345, 64, 69, 161, 345, 4, 5, 2500.000000, NULL, 12500.000000, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(346, 64, 70, 162, 346, 4, 12, 2100.000000, NULL, 25200.000000, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(347, 64, 70, 163, 347, 4, 9, 2250.000000, NULL, 20250.000000, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(348, 64, 66, 151, 348, 4, 12, 3050.000000, NULL, 36600.000000, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(349, 64, 71, 164, 349, 4, 5, 2700.000000, NULL, 13500.000000, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(350, 64, 66, 152, 350, 4, 6, 2600.000000, NULL, 15600.000000, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(351, 64, 67, 84, 351, 4, 9, 1510.000000, NULL, 13590.000000, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(352, 65, 67, 144, 353, 2, 2, 1950.000000, NULL, 3900.000000, '2018-03-04 00:50:04', '2018-03-04 00:50:04'),
(353, 65, 70, 149, 354, 2, 1, 2250.000000, NULL, 2250.000000, '2018-03-04 00:50:04', '2018-03-04 00:50:04'),
(354, 65, 72, 93, 355, 2, 500, 910.000000, NULL, 455000.000000, '2018-03-04 00:50:04', '2018-03-04 00:50:04'),
(355, 66, 81, 157, 356, 2, 10, 120.000000, NULL, 1200.000000, '2018-03-04 00:53:18', '2018-03-04 00:53:18'),
(357, 68, 41, 166, 358, 4, 11, 1062.000000, NULL, 11682.000000, '2018-03-04 19:56:15', '2018-03-04 19:56:15'),
(358, 69, 27, 68, 361, 4, 140, 200.000000, NULL, 28000.000000, '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(359, 69, 27, 31, 362, 4, 20, 140.000000, NULL, 2800.000000, '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(360, 69, 27, 71, 363, 4, 48, 250.000000, NULL, 12000.000000, '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(361, 69, 41, 166, 364, 4, 1, 1200.000000, NULL, 1200.000000, '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(362, 69, 81, 157, 365, 4, 5, 120.000000, NULL, 600.000000, '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(363, 69, 72, 93, 366, 4, 350, 910.000000, NULL, 318500.000000, '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(364, 69, 67, 144, 367, 4, 2, 1950.000000, NULL, 3900.000000, '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(365, 69, 70, 163, 368, 4, 1, 2250.000000, NULL, 2250.000000, '2018-03-04 22:15:25', '2018-03-04 22:15:25'),
(366, 70, 35, 45, 369, 2, 2, 900.000000, NULL, 1800.000000, '2018-03-05 17:45:12', '2018-03-05 17:45:12');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_product_model`
--

CREATE TABLE `inventory_product_model` (
  `id` int(11) NOT NULL,
  `fk_product_id` int(11) UNSIGNED NOT NULL COMMENT 'Foreign Key Not Needed',
  `model_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_product_model`
--

INSERT INTO `inventory_product_model` (`id`, `fk_product_id`, `model_name`, `status`, `created_at`, `updated_at`) VALUES
(31, 27, 'print', 1, '2018-01-29 18:00:16', '2018-01-29 18:00:16'),
(32, 28, '3 part', 1, '2018-01-30 14:11:41', '2018-01-30 14:11:41'),
(33, 28, 'J-tops', 1, '2018-01-30 14:11:41', '2018-01-30 14:11:41'),
(34, 28, '4 part', 1, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(35, 28, 'J-Short', 1, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(36, 28, 'C-Small', 1, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(37, 28, 'AM', 1, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(38, 28, 'Ganzi', 1, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(39, 28, 'Lilen', 1, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(40, 30, 'SK-WC', 1, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(41, 39, 'Silk-1c', 1, '2018-01-30 14:29:30', '2018-01-30 14:29:30'),
(42, 34, 'Belbet', 1, '2018-01-30 14:39:40', '2018-01-30 14:39:40'),
(43, 37, 'al-karam', 1, '2018-01-30 14:46:42', '2018-01-30 14:46:42'),
(44, 38, 'swpk', 1, '2018-01-30 14:46:42', '2018-01-30 14:46:42'),
(45, 35, 'Ston', 1, '2018-01-30 14:55:28', '2018-01-30 14:55:28'),
(46, 49, 'Korian-Am', 1, '2018-01-30 15:20:20', '2018-01-30 15:20:20'),
(47, 31, 'pants', 1, '2018-01-30 16:00:37', '2018-01-30 16:00:37'),
(48, 30, 'SK-Am', 1, '2018-01-30 16:00:37', '2018-01-30 16:00:37'),
(49, 45, 'KOT', 1, '2018-01-30 16:15:30', '2018-01-30 16:15:30'),
(50, 45, 'S1', 1, '2018-01-30 16:15:30', '2018-01-30 16:15:30'),
(51, 29, 'Black', 1, '2018-01-30 16:28:49', '2018-01-30 16:28:49'),
(52, 42, 'L-print', 1, '2018-01-30 16:28:49', '2018-01-30 16:28:49'),
(53, 29, 'Georget', 1, '2018-01-30 16:28:49', '2018-01-30 16:28:49'),
(54, 32, 'Long', 1, '2018-01-30 16:28:49', '2018-01-30 16:28:49'),
(55, 50, 'Kito', 1, '2018-01-30 16:36:58', '2018-01-30 16:36:58'),
(56, 50, 'Baby', 1, '2018-01-30 16:36:58', '2018-01-30 16:36:58'),
(57, 42, 'Ganzi Print', 1, '2018-01-30 16:36:58', '2018-01-30 16:36:58'),
(58, 32, 'T-Plazo', 1, '2018-01-30 16:36:58', '2018-01-30 16:36:58'),
(59, 35, 'Abaya', 1, '2018-01-30 16:42:36', '2018-01-30 16:42:36'),
(60, 51, 'H/pin', 1, '2018-01-30 17:35:54', '2018-01-30 17:35:54'),
(61, 51, 'F/ring', 1, '2018-01-30 17:35:54', '2018-01-30 17:35:54'),
(62, 51, 'Y/ring', 1, '2018-01-30 17:35:54', '2018-01-30 17:35:54'),
(63, 51, 'H/band', 1, '2018-01-30 17:35:54', '2018-01-30 17:35:54'),
(64, 48, 'c-band', 1, '2018-01-30 17:35:54', '2018-01-30 17:35:54'),
(65, 27, 'H&M Print', 1, '2018-01-30 17:35:54', '2018-01-30 17:35:54'),
(66, 27, 'poshmina', 1, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(67, 27, 'golap am', 1, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(68, 27, 'cotton ston', 1, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(69, 27, 'simar', 1, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(70, 27, 'golap print', 1, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(71, 27, 'simar ston', 1, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(72, 27, 'h&m', 1, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(73, 44, 'coppy h', 1, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(74, 44, 'coppy am', 1, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(75, 44, 'coppy', 1, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(76, 39, 'silk print', 1, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(77, 43, 'zori d', 1, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(78, 43, 'zori s', 1, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(79, 27, 'parti h', 1, '2018-01-30 18:22:17', '2018-01-30 18:22:17'),
(80, 33, 'bdl', 1, '2018-01-30 18:41:15', '2018-01-30 18:41:15'),
(81, 40, 'J boutique', 1, '2018-01-30 18:48:29', '2018-01-30 18:48:29'),
(82, 73, 'Zeenat', 1, '2018-01-31 12:10:55', '2018-01-31 12:10:55'),
(83, 40, 'Tumba', 1, '2018-01-31 12:10:55', '2018-01-31 12:10:55'),
(84, 67, 'jasmina', 1, '2018-01-31 12:23:34', '2018-01-31 12:23:34'),
(85, 67, 'silkina 10', 1, '2018-01-31 12:23:34', '2018-01-31 12:23:34'),
(86, 67, 'brasso 8', 1, '2018-01-31 12:23:34', '2018-01-31 12:23:34'),
(87, 67, 'galaxy', 1, '2018-01-31 12:23:34', '2018-01-31 12:23:34'),
(88, 67, 'maharani', 1, '2018-01-31 12:23:34', '2018-01-31 12:23:34'),
(89, 59, 'heer', 1, '2018-01-31 12:41:25', '2018-01-31 12:41:25'),
(90, 53, 'esta', 1, '2018-01-31 12:41:25', '2018-01-31 12:41:25'),
(91, 58, 'varsha', 1, '2018-01-31 12:41:25', '2018-01-31 12:41:25'),
(92, 56, 'omtex', 1, '2018-01-31 12:41:25', '2018-01-31 12:41:25'),
(93, 72, 'mama', 1, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(94, 74, 'vishal', 1, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(95, 76, 'pd', 1, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(96, 75, 'boutique', 1, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(97, 77, 'sajjan', 1, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(98, 79, 'ekta', 1, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(99, 78, 'ganga', 1, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(100, 55, 'flower', 1, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(101, 55, 'sabina', 1, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(102, 55, 'mahee', 1, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(103, 57, 'rakhi', 1, '2018-01-31 13:28:30', '2018-01-31 13:28:30'),
(104, 66, 'push', 1, '2018-01-31 13:58:55', '2018-01-31 13:58:55'),
(105, 81, 'leggings', 1, '2018-01-31 13:58:55', '2018-01-31 13:58:55'),
(106, 82, 'plazu', 1, '2018-01-31 13:58:55', '2018-01-31 13:58:55'),
(107, 52, 'silk(7601-10)', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(108, 53, 'hiranya', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(109, 54, 'lt silkina', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(110, 55, 'kangona 2', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(111, 56, '1595-1600', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(112, 57, '4401-4408', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(113, 53, 'flora', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(114, 58, '3121-3129', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(115, 55, '4701-4708', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(116, 58, '3111-3115', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(117, 56, '1521-1526', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(118, 58, '3061-3068', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(119, 53, 'jewel', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(120, 60, 'adore', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(121, 61, 'sadhana', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(122, 62, 'reverence', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(123, 63, 'sandya', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(124, 64, 'ishika', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(125, 75, 'jorjet', 1, '2018-01-31 14:34:13', '2018-01-31 14:34:13'),
(126, 75, 'katan', 1, '2018-01-31 14:48:05', '2018-01-31 14:48:05'),
(127, 40, 'lt long', 1, '2018-01-31 14:48:05', '2018-01-31 14:48:05'),
(128, 40, 'lt short', 1, '2018-01-31 14:48:05', '2018-01-31 14:48:05'),
(129, 75, 'mf digital', 1, '2018-01-31 15:00:24', '2018-01-31 15:00:24'),
(130, 83, 'ragga silk', 1, '2018-01-31 15:10:04', '2018-01-31 15:10:04'),
(131, 41, 'A-151', 1, '2018-02-04 15:56:24', '2018-02-04 15:56:24'),
(132, 41, 'A-155', 1, '2018-02-04 15:56:24', '2018-02-04 15:56:24'),
(133, 41, 'A-157', 1, '2018-02-04 15:56:24', '2018-02-04 15:56:24'),
(134, 41, 'A-7', 1, '2018-02-04 15:56:24', '2018-02-04 15:56:24'),
(135, 41, 'A-166', 1, '2018-02-04 15:56:24', '2018-02-04 15:56:24'),
(136, 84, 'thai', 1, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(137, 84, 'china', 1, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(138, 36, 'star', 1, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(139, 85, 'in', 1, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(140, 86, 'ten tops', 1, '2018-02-05 15:14:57', '2018-02-05 15:14:57'),
(141, 35, 'Stone', 1, '2018-02-05 15:21:31', '2018-02-05 15:21:31'),
(142, 66, 'star collection', 1, '2018-02-14 12:23:02', '2018-02-14 12:23:02'),
(143, 66, 'smily beauty', 1, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(144, 67, 'silkina 11', 1, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(145, 68, 'ayesha t 18', 1, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(146, 69, 'breeze', 1, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(147, 70, '9f vol-20', 1, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(148, 70, '9f vol-26', 1, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(149, 70, '9f vol-24', 1, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(150, 69, 'vol - 5', 1, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(151, 66, 'fashion', 1, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(152, 66, 'z galaxy', 1, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(153, 71, 'zisa- 44', 1, '2018-02-14 12:23:03', '2018-02-14 12:23:03'),
(154, 81, 'leggins', 1, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(155, 82, 'plazo in', 1, '2018-02-17 17:45:55', '2018-02-17 17:45:55'),
(156, 39, 'sillk print', 1, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(157, 33, 'bd', 1, '2018-02-17 18:19:59', '2018-02-17 18:19:59'),
(158, 63, 'sandhya', 1, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(159, 67, 'brasso-8', 1, '2018-02-17 18:56:45', '2018-02-17 18:56:45'),
(160, 68, 'aayesha 18', 1, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(161, 69, 'A vol 5', 1, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(162, 70, 'N vol 26', 1, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(163, 70, 'N vol 24', 1, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(164, 71, 'zisa 44', 1, '2018-02-17 22:06:10', '2018-02-17 22:06:10'),
(165, 69, 'Tees123', 1, '2018-03-04 18:44:21', '2018-03-04 18:44:21'),
(166, 41, 'bd 1', 1, '2018-03-04 19:56:15', '2018-03-04 19:56:15');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_product_order`
--

CREATE TABLE `inventory_product_order` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_supplier_id` int(10) UNSIGNED NOT NULL,
  `inventory_order_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `opening_date` date NOT NULL,
  `lc_no` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `fk_account_id` int(10) UNSIGNED NOT NULL,
  `fk_method_id` int(10) UNSIGNED NOT NULL,
  `summery` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `order_date` date NOT NULL,
  `total_amount` decimal(17,6) NOT NULL,
  `total_price_with_expenses` decimal(17,6) NOT NULL,
  `other_expenses` decimal(17,6) NOT NULL,
  `total_paid` decimal(17,6) DEFAULT 0.000000,
  `status` tinyint(1) DEFAULT 1,
  `shipping_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_product_order_challan`
--

CREATE TABLE `inventory_product_order_challan` (
  `id` int(11) NOT NULL,
  `fk_order_id` int(11) UNSIGNED NOT NULL,
  `challan_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `total_amount` decimal(17,6) NOT NULL,
  `received_date` date NOT NULL,
  `created_by` int(11) UNSIGNED NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_product_order_challan_item`
--

CREATE TABLE `inventory_product_order_challan_item` (
  `id` int(11) NOT NULL,
  `fk_order_challan_id` int(10) NOT NULL,
  `fk_order_item_id` int(10) UNSIGNED NOT NULL,
  `qty` float NOT NULL DEFAULT 0,
  `batch_no` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cost_amount` float NOT NULL DEFAULT 0,
  `free_of_cost` float UNSIGNED NOT NULL DEFAULT 0,
  `payable_amount` decimal(17,6) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_product_order_expenses_list`
--

CREATE TABLE `inventory_product_order_expenses_list` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_product_order_expenses_list`
--

INSERT INTO `inventory_product_order_expenses_list` (`id`, `title`, `status`, `created_at`, `updated_at`) VALUES
(2, 'Shipping cost', 1, '2017-10-12 05:53:15', '2017-10-12 05:53:15'),
(3, 'Worker Expense ', 1, '2017-10-12 05:55:12', '2017-10-12 05:55:12'),
(4, 'Transport Bill ', 1, '2017-10-12 05:55:30', '2017-10-12 05:55:30');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_product_order_item`
--

CREATE TABLE `inventory_product_order_item` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_product_order_id` int(10) UNSIGNED NOT NULL,
  `fk_product_id` int(10) UNSIGNED NOT NULL,
  `qty` float NOT NULL DEFAULT 0,
  `free_of_cost` float DEFAULT 0,
  `cost_per_unit` decimal(17,6) NOT NULL,
  `foreign_amount` decimal(17,6) NOT NULL,
  `currency_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `bdt_rates` decimal(17,6) NOT NULL,
  `sales_per_unit` decimal(17,6) NOT NULL,
  `other_expense` decimal(17,6) NOT NULL,
  `payable_amount` decimal(17,6) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_product_order_other_expenses`
--

CREATE TABLE `inventory_product_order_other_expenses` (
  `id` int(11) NOT NULL,
  `other_expense_title` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `fk_order_id` int(11) UNSIGNED NOT NULL,
  `other_expense` float NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_product_return`
--

CREATE TABLE `inventory_product_return` (
  `id` int(11) NOT NULL,
  `fk_sales_id` int(11) NOT NULL,
  `total_amount` float NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_product_sales`
--

CREATE TABLE `inventory_product_sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_client_id` int(10) UNSIGNED DEFAULT NULL,
  `invoice_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `order_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `summary` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_address` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` date NOT NULL,
  `shipping_date` date NOT NULL,
  `total_amount` decimal(17,6) NOT NULL,
  `paid_amount` decimal(17,6) NOT NULL,
  `prev_amount` decimal(17,6) DEFAULT NULL,
  `prev_paid` decimal(17,6) DEFAULT NULL,
  `discount` decimal(17,6) DEFAULT NULL,
  `transport_bill` float DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '0=Opening Due, else = Sales',
  `sales_type` tinyint(4) NOT NULL DEFAULT 0,
  `created_by` int(10) UNSIGNED NOT NULL,
  `fk_user_id` int(10) UNSIGNED DEFAULT NULL,
  `fk_branch_id` int(10) UNSIGNED NOT NULL,
  `fk_company_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_product_sales`
--

INSERT INTO `inventory_product_sales` (`id`, `fk_client_id`, `invoice_id`, `order_id`, `summary`, `shipping_address`, `date`, `shipping_date`, `total_amount`, `paid_amount`, `prev_amount`, `prev_paid`, `discount`, `transport_bill`, `type`, `sales_type`, `created_by`, `fk_user_id`, `fk_branch_id`, `fk_company_id`, `created_at`, `updated_at`) VALUES
(23, 61, '1802031', 'M 7584', '', '', '2017-07-09', '0000-00-00', 12550.000000, 12550.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-03 14:29:59', '2018-02-03 14:29:59'),
(24, 61, '1802033', 'M 7588', '', '', '2017-07-12', '0000-00-00', 4000.000000, 4000.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-03 15:09:35', '2018-02-03 15:09:35'),
(25, 64, '1802034', 'M 7585', '', '', '2017-07-10', '0000-00-00', 20870.000000, 10000.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-03 15:28:38', '2018-02-04 16:45:47'),
(26, 66, '1802035', 'M 7602', '', '', '2017-08-01', '0000-00-00', 223800.000000, 223800.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-03 17:32:04', '2018-02-04 11:23:22'),
(31, 66, 'opening-due-66', NULL, 'M 7574', NULL, '2017-06-25', '0000-00-00', 62946.000000, 62946.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-03 19:39:25', '2018-02-04 11:23:22'),
(32, 68, '1802046', 'M 7581', '', '', '2017-07-02', '0000-00-00', 23900.000000, 23900.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-04 10:06:04', '2018-02-04 11:08:52'),
(33, 68, 'opening-due-68', NULL, 'M 7570', NULL, '2017-06-22', '0000-00-00', 9200.000000, 9200.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-04 10:08:35', '2018-02-06 15:07:08'),
(34, 68, '1802047', 'M 7582', '', '', '2017-07-05', '0000-00-00', 13450.000000, 7800.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-04 11:07:09', '2018-02-06 15:07:08'),
(35, 66, '1802048', 'M 7623', '', '', '2017-08-14', '0000-00-00', 157800.000000, 157800.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-04 11:19:36', '2018-02-06 17:08:54'),
(36, 66, '18020410', 'M 7705', '', '', '2017-09-23', '0000-00-00', 87000.000000, 87000.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-04 11:35:41', '2018-02-09 17:14:48'),
(37, 69, 'opening-due-69', NULL, 'M 7573', NULL, '2017-07-11', '0000-00-00', 33590.000000, 24500.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-04 12:14:35', '2018-02-11 10:16:24'),
(45, 69, '18020438', 'M 7587', '', '', '2017-07-12', '0000-00-00', 1400.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-04 16:36:24', '2018-02-11 10:16:24'),
(46, 64, '18020446', 'M 7590', '', '', '2017-07-18', '0000-00-00', 18050.000000, 15000.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-04 16:44:22', '2018-02-04 16:45:47'),
(47, 69, '18020447', 'M 7591', '', NULL, '2017-07-19', '0000-00-00', 2260.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-04 16:50:08', '2018-02-11 10:16:24'),
(48, 61, '18020448', 'M 7592', '', '', '2017-07-21', '0000-00-00', 16500.000000, 16500.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-04 17:01:14', '2018-02-04 17:01:14'),
(49, 65, '18020449', 'M 7593', '', '', '2017-07-21', '0000-00-00', 16200.000000, 16200.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-04 17:04:08', '2018-02-04 17:04:08'),
(50, 69, '18020450', 'M 7594', '', '', '2017-07-22', '0000-00-00', 1040.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-04 17:06:46', '2018-02-11 10:16:24'),
(51, 68, '18020451', 'M 7597', '', '', '2017-07-28', '0000-00-00', 10400.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-04 17:35:40', '2018-02-06 15:07:08'),
(52, 60, '18020552', NULL, '', '', '2018-02-05', '0000-00-00', 110000.000000, 110000.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-05 14:25:45', '2018-02-07 19:26:49'),
(53, 72, '18020553', 'M 7751-7792', '', '', '2017-09-08', '0000-00-00', 1773543.000000, 1773543.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-05 17:11:32', '2018-02-06 15:26:17'),
(54, 72, '18020554', 'M 7751-7792', '', '', '2017-09-09', '0000-00-00', 1706695.000000, 361177.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-05 19:11:08', '2018-03-04 23:00:22'),
(55, 72, '18020655', 'M 7751-7792', '', '', '2017-09-09', '0000-00-00', 140600.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 11:06:26', '2018-03-04 23:00:22'),
(56, 72, '18020656', 'm 7551-7592', '', '', '2017-09-10', '0000-00-00', 881991.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 12:45:52', '2018-03-04 23:00:22'),
(57, 68, '18020657', 'M 7701', '', '', '2017-09-15', '0000-00-00', 5600.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 14:10:38', '2018-02-06 15:07:08'),
(58, 73, '18020658', 'M 7702', '', '', '2017-09-19', '0000-00-00', 6700.000000, 6700.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 14:15:06', '2018-02-06 14:15:06'),
(59, 73, '18020659', 'M 7703', '', '', '2017-09-22', '0000-00-00', 5600.000000, 5600.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 14:17:32', '2018-02-06 15:03:20'),
(60, 73, '18020660', 'M 7704', '', '', '2017-09-23', '0000-00-00', 2800.000000, 2800.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 14:20:00', '2018-02-06 15:03:20'),
(61, 66, '18020661', 'M 7723', '', '', '2017-10-08', '0000-00-00', 26350.000000, 26350.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 14:36:11', '2018-02-09 17:14:48'),
(62, 74, '18020662', 'M 7706', '', '', '2017-09-25', '0000-00-00', 16500.000000, 16500.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 14:46:29', '2018-02-06 14:46:29'),
(63, 75, '18020663', 'M 7707', '', '', '2017-09-26', '0000-00-00', 23150.000000, 23150.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 15:00:31', '2018-02-23 22:33:53'),
(64, 76, '18020664', 'M 7708', '', '', '2017-09-26', '0000-00-00', 115208.000000, 115208.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(65, 65, '18020665', 'M 7709', '', '', '2017-09-29', '0000-00-00', 13800.000000, 13800.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 15:57:12', '2018-02-07 19:30:06'),
(66, 76, '18020666', 'M 7710', '', '', '2017-09-29', '0000-00-00', 13800.000000, 13800.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 15:59:50', '2018-02-06 15:59:50'),
(67, 74, '18020667', 'M 7711', '', '', '2017-09-29', '0000-00-00', 8100.000000, 8100.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 16:01:43', '2018-02-06 16:01:43'),
(68, 73, '18020668', 'M 7712', '', '', '2017-09-30', '0000-00-00', 4900.000000, 4900.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 16:07:23', '2018-02-06 16:07:23'),
(69, 61, '18020669', 'M 7713', '', '', '2017-09-30', '0000-00-00', 2600.000000, 2600.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 16:09:32', '2018-02-06 16:09:32'),
(70, 77, '18020670', 'M 7714', '', '', '2017-10-03', '0000-00-00', 47360.000000, 47360.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 16:25:10', '2018-02-09 17:07:54'),
(71, 61, '18020671', 'M 7715', '', '', '2017-10-03', '0000-00-00', 7700.000000, 7700.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 16:31:48', '2018-02-07 19:28:33'),
(72, 77, '18020672', 'M 7717', '', '', '2017-10-03', '0000-00-00', 7650.000000, 7650.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 16:34:30', '2018-02-09 17:07:54'),
(73, 61, '18020673', 'M7716', '', '', '2017-10-04', '0000-00-00', 5150.000000, 5150.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 16:37:39', '2018-02-06 16:37:39'),
(74, 61, '18020674', 'M 7718', '', '', '2017-10-04', '0000-00-00', 5400.000000, 5400.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 16:40:14', '2018-02-07 19:28:33'),
(75, 64, '18020675', 'M 7719', '', '', '2017-10-04', '0000-00-00', 2450.000000, 2450.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 16:42:20', '2018-02-06 16:42:20'),
(76, 61, '18020676', 'M 7720', '', '', '2017-10-06', '0000-00-00', 1780.000000, 1780.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 16:44:57', '2018-02-06 16:44:57'),
(77, 61, '18020677', 'M 7724', '', '', '2017-10-11', '0000-00-00', 900.000000, 900.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 16:49:44', '2018-02-06 16:49:44'),
(78, 73, '18020678', 'M 7725', '', '', '2017-10-14', '0000-00-00', 750.000000, 750.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 16:52:04', '2018-02-06 16:52:04'),
(79, 76, '18020679', 'M 7726', '', '', '2017-10-20', '0000-00-00', 5700.000000, 5700.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 16:53:58', '2018-02-06 16:53:58'),
(80, 61, '18020680', 'M 7727', '', '', '2017-10-22', '0000-00-00', 11800.000000, 11800.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 16:56:09', '2018-02-06 16:56:09'),
(81, 66, '18020681', NULL, '', '', '2017-10-23', '0000-00-00', 80570.000000, 80570.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 17:07:18', '2018-02-09 17:14:48'),
(82, 73, '18020682', 'M 7730', '', '', '2017-10-27', '0000-00-00', 3330.000000, 3330.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 17:12:21', '2018-02-06 17:12:21'),
(83, 61, '18020683', 'M 7731', '', '', '2017-10-30', '0000-00-00', 8700.000000, 8700.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 17:14:51', '2018-02-06 17:14:51'),
(84, 66, '18020684', 'M 7732', '', '', '2017-10-30', '0000-00-00', 186000.000000, 121040.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 17:19:15', '2018-02-09 17:14:48'),
(85, 61, '18020685', 'M 7735', '', '', '2017-11-01', '0000-00-00', 16500.000000, 16500.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 18:06:12', '2018-02-06 18:06:12'),
(86, 61, '18020686', 'M 7736', '', '', '2017-11-04', '0000-00-00', 350.000000, 350.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 18:08:02', '2018-02-06 18:08:02'),
(87, 77, '18020687', 'M 7738-7739', '', '', '2017-11-07', '0000-00-00', 106100.000000, 106100.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 18:31:00', '2018-02-09 17:07:54'),
(88, 78, '18020688', 'M 7741', '', '', '2017-11-07', '0000-00-00', 78300.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 18:42:49', '2018-02-06 18:42:49'),
(89, 61, '18020689', 'M 7742', '', '', '2017-11-08', '0000-00-00', 3950.000000, 3950.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 18:46:25', '2018-02-06 18:46:25'),
(90, 73, '18020690', 'M 7743', '', '', '2017-11-08', '0000-00-00', 4120.000000, 4120.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-06 18:50:59', '2018-02-06 18:50:59'),
(91, 61, '18020791', 'M 7745', '', '', '2017-11-10', '0000-00-00', 3400.000000, 3400.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 11:19:41', '2018-02-07 11:19:41'),
(92, 61, '18020792', 'M 7750', '', '', '2017-11-12', '0000-00-00', 4200.000000, 4200.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 11:25:43', '2018-02-07 11:25:43'),
(93, 68, '18020793', 'M 7581', '', NULL, '2017-07-02', '0000-00-00', 0.000000, 15000.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 11:52:18', '2018-02-07 15:17:57'),
(94, 68, '18020794', 'M 7582', '', NULL, '2017-07-05', '0000-00-00', 0.000000, 10000.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 11:57:23', '2018-02-07 15:18:54'),
(95, 71, '18020795', 'M 7583', '', '', '2017-07-08', '0000-00-00', 50100.000000, 50100.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 12:04:20', '2018-02-07 15:57:24'),
(96, 65, '18020796', 'M 7589', '', '', '2017-07-14', '0000-00-00', 31500.000000, 31500.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(97, 71, '18020797', 'M 7595', '', '', '2017-07-23', '0000-00-00', 42550.000000, 42550.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 12:42:37', '2018-02-07 15:57:24'),
(98, 81, '18020798', 'M 7596', '', '', '2017-07-23', '0000-00-00', 37300.000000, 37300.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(99, 65, '18020799', 'M 7598', '', '', '2017-07-28', '0000-00-00', 16000.000000, 16000.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 13:02:18', '2018-02-07 13:02:18'),
(100, 71, '180207100', 'M 7600', '', NULL, '2017-07-30', '0000-00-00', 16000.000000, 16000.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 13:05:44', '2018-02-07 15:57:24'),
(101, 71, '180207101', 'M 7601', '', '', '2017-07-31', '0000-00-00', 29850.000000, 29850.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 13:41:32', '2018-02-07 16:29:58'),
(102, 68, '180207102', 'M 7603', '', '', '2017-08-02', '0000-00-00', 3780.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 13:44:23', '2018-02-07 13:44:23'),
(103, 61, '180207103', 'M 7604', '', '', '2017-08-04', '0000-00-00', 5600.000000, 5600.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 13:46:14', '2018-02-07 13:46:14'),
(104, 65, '180207104', 'M 7605', '', '', '2017-08-04', '0000-00-00', 31800.000000, 31800.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 13:50:02', '2018-02-07 13:50:02'),
(105, 73, '180207105', 'M 7606', '', '', '2017-08-05', '0000-00-00', 9100.000000, 9100.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 13:52:23', '2018-02-07 13:52:23'),
(106, 71, '180207106', 'M 7607', '', '', '2017-08-06', '0000-00-00', 67800.000000, 67800.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 13:58:18', '2018-02-07 16:29:58'),
(107, 61, '180207107', 'M 7609', '', '', '2017-08-06', '0000-00-00', 1460.000000, 1460.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 14:05:51', '2018-02-07 14:05:51'),
(108, 73, '180207108', 'M 7610', '', '', '2017-08-06', '0000-00-00', 6280.000000, 6280.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 14:09:35', '2018-02-07 14:09:35'),
(109, 81, '180207109', 'M 7611-7612', '', '', '2017-08-07', '0000-00-00', 122385.000000, 122385.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(110, 73, '180207110', 'M 7613', '', '', '2017-08-07', '0000-00-00', 8100.000000, 8100.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 14:32:39', '2018-02-07 14:32:39'),
(111, 61, '180207111', 'M 7614', '', '', '2017-08-07', '0000-00-00', 24000.000000, 24000.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 14:34:13', '2018-02-07 14:34:13'),
(112, 61, '180207112', 'M 7615', '', '', '2017-08-09', '0000-00-00', 3700.000000, 3700.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 14:36:39', '2018-02-07 14:36:39'),
(113, 76, '180207113', 'M 7616', '', '', '2017-08-09', '0000-00-00', 18825.000000, 18825.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 14:40:47', '2018-02-07 14:40:47'),
(114, 61, '180207114', 'M 7618', '', '', '2017-08-11', '0000-00-00', 16485.000000, 16485.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 14:46:45', '2018-02-07 14:46:45'),
(115, 74, '180207115', 'M7619', '', '', '2017-08-12', '0000-00-00', 13700.000000, 13700.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 14:51:36', '2018-02-07 14:51:36'),
(116, 61, '180207116', 'M 7620', '', '', '2017-08-12', '0000-00-00', 30200.000000, 30200.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 14:56:31', '2018-02-07 14:56:31'),
(117, 77, '180207117', 'M 7624', '', '', '2017-08-18', '0000-00-00', 52930.000000, 52930.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 15:06:47', '2018-02-09 17:07:54'),
(118, 78, '180207118', 'M 7625', '', '', '2017-08-18', '0000-00-00', 37200.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 15:31:03', '2018-02-07 15:31:03'),
(119, 82, '180207119', 'M 7626', '', '', '2017-08-18', '0000-00-00', 61100.000000, 61100.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 15:48:19', '2018-02-07 15:48:19'),
(120, 71, '180207120', 'M 7627', '', '', '2017-08-18', '0000-00-00', 21150.000000, 21150.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 15:55:27', '2018-02-07 16:29:58'),
(121, 74, '180207121', 'M 7630', '', '', '2017-08-20', '0000-00-00', 25500.000000, 25500.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 16:05:03', '2018-02-07 16:05:03'),
(122, 73, '180207122', 'M 7632', '', '', '2017-08-21', '0000-00-00', 27300.000000, 27300.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(123, 73, '180207123', 'M 7633', '', '', '2017-08-23', '0000-00-00', 9150.000000, 9150.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 16:16:02', '2018-02-07 16:16:02'),
(124, 71, '180207124', 'M 7634', '', '', '2017-08-25', '0000-00-00', 9260.000000, 9260.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 16:24:07', '2018-02-07 16:29:58'),
(125, 71, '180207125', 'M 7643', '', '', '2017-09-09', '0000-00-00', 2400.000000, 2400.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 16:27:27', '2018-02-07 19:22:32'),
(126, 73, '180207126', 'M 7635', '', '', '2017-08-26', '0000-00-00', 5300.000000, 5300.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 16:31:55', '2018-02-07 16:31:55'),
(127, 64, '180207127', 'M 7636', '', '', '2017-08-26', '0000-00-00', 5950.000000, 5950.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 16:34:49', '2018-02-07 16:34:49'),
(128, 73, '180207128', 'M 7638', '', '', '2017-08-28', '0000-00-00', 5200.000000, 5200.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 16:36:47', '2018-02-07 16:36:47'),
(129, 68, '180207129', 'M 7639', '', '', '2017-08-28', '0000-00-00', 8300.000000, 8300.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 16:39:18', '2018-02-07 16:39:18'),
(130, 68, '180207130', 'M 7642', '', '', '2017-09-08', '0000-00-00', 6300.000000, 6300.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 16:41:46', '2018-02-07 16:41:46'),
(131, 64, '180207131', 'M 7645', '', '', '2017-09-10', '0000-00-00', 24800.000000, 24100.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 16:49:25', '2018-02-07 16:49:25'),
(132, 73, '180207132', 'M 7647', '', '', '2017-09-11', '0000-00-00', 29000.000000, 29000.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 16:51:49', '2018-02-07 16:51:49'),
(133, 74, '180207133', 'M 7648', '', '', '2017-09-12', '0000-00-00', 22000.000000, 22000.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 16:54:25', '2018-02-07 16:54:25'),
(134, 73, '180207134', 'M 7649', '', '', '2017-09-13', '0000-00-00', 16600.000000, 16600.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 16:56:47', '2018-02-07 16:56:47'),
(135, 82, '180207135', 'M 7650', '', '', '2017-09-13', '0000-00-00', 16900.000000, 16900.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 17:00:31', '2018-02-07 17:00:31'),
(136, 71, '180207136', 'M 7801-7818', '', '', '2018-02-07', '0000-00-00', 485281.000000, 191558.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-07 17:22:45', '2018-02-23 23:03:56'),
(137, 75, '180209137', 'M 7599', '', '', '2017-07-29', '0000-00-00', 8760.000000, 8760.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 10:50:51', '2018-02-23 22:35:18'),
(138, 75, '180209138', 'M 7617', '', NULL, '2017-08-09', '0000-00-00', 17480.000000, 17480.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 11:05:36', '2018-02-23 22:35:18'),
(139, 75, '180209139', 'M 7721', '', '', '2017-10-07', '0000-00-00', 38950.000000, 35430.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 11:15:20', '2018-02-23 22:35:18'),
(140, 75, '180209140', 'M 7728', '', '', '2017-10-23', '0000-00-00', 16550.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 11:31:46', '2018-02-23 22:35:18'),
(141, 75, '180209141', 'M 7733', '', '', '2017-10-31', '0000-00-00', 2600.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 11:33:44', '2018-02-23 22:35:18'),
(142, 75, '180209142', 'M 7737', '', '', '2017-11-05', '0000-00-00', 5600.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 11:38:31', '2018-02-23 22:35:18'),
(143, 75, '180209143', 'M 7747', '', '', '2017-11-11', '0000-00-00', 4500.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 11:41:52', '2018-02-23 22:35:18'),
(144, 75, '180209144', 'M 7869', '', '', '2017-12-09', '0000-00-00', 12300.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 11:55:29', '2018-02-23 22:35:18'),
(145, 61, '180209145', 'M 7860', '', '', '2017-12-01', '0000-00-00', 1840.000000, 1840.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 11:56:58', '2018-02-11 10:30:27'),
(146, 83, '180209146', 'M 7852', '', '', '2017-11-14', '0000-00-00', 33000.000000, 33000.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 12:08:25', '2018-02-09 12:08:25'),
(147, 66, '180209147', 'M 7855', '', '', '2017-11-18', '0000-00-00', 34500.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 12:11:57', '2018-02-09 17:14:48'),
(148, 61, '180209148', 'M 7856', '', '', '2017-11-19', '0000-00-00', 5900.000000, 5900.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 12:58:37', '2018-02-09 12:58:37'),
(149, 73, '180209149', 'M 7857', '', '', '2017-11-22', '0000-00-00', 3180.000000, 3180.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 13:01:34', '2018-02-09 13:01:34'),
(150, 77, '180209150', 'M 7858', '', '', '2017-11-24', '0000-00-00', 59570.000000, 59570.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 13:11:54', '2018-02-09 17:07:54'),
(151, 73, '180209151', 'M 7859', '', '', '2017-11-27', '0000-00-00', 750.000000, 750.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 13:38:04', '2018-02-09 13:38:04'),
(152, 79, '180209152', 'M 7861', '', '', '2017-12-02', '0000-00-00', 7350.000000, 7350.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 13:42:18', '2018-02-11 10:50:38'),
(153, 61, '180209153', 'M 7862', '', '', '2017-12-02', '0000-00-00', 3600.000000, 3600.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 13:44:20', '2018-02-09 13:44:20'),
(154, 73, '180209154', 'M 7863', '', '', '2017-12-02', '0000-00-00', 3080.000000, 3080.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 14:08:24', '2018-02-09 14:08:24'),
(155, 73, '180209155', 'M 7864', '', '', '2017-12-04', '0000-00-00', 1870.000000, 1870.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 14:10:30', '2018-02-09 14:10:30'),
(156, 77, '180209156', 'M 7865', '', '', '2017-12-05', '0000-00-00', 25610.000000, 11480.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 14:16:40', '2018-02-09 17:07:54'),
(157, 74, '180209157', 'M 7866', '', '', '2017-12-08', '0000-00-00', 20500.000000, 20500.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 14:24:09', '2018-02-09 14:24:09'),
(158, 61, '180209158', 'M 7867', '', '', '2017-12-08', '0000-00-00', 8960.000000, 8960.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 14:35:03', '2018-02-09 14:35:03'),
(159, 73, '180209159', 'M 7878', '', '', '2017-12-08', '0000-00-00', 6700.000000, 6700.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 14:36:52', '2018-02-09 14:36:52'),
(160, 61, '180209160', 'M 7870', '', '', '2017-12-09', '0000-00-00', 34300.000000, 34300.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 14:43:44', '2018-02-09 14:43:44'),
(161, 83, '180209161', 'M 7871', '', '', '2017-12-09', '0000-00-00', 4900.000000, 4900.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 14:45:41', '2018-02-09 14:45:41'),
(162, 83, '180209162', 'M 7874', '', '', '2017-12-13', '0000-00-00', 35500.000000, 35500.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 14:48:50', '2018-02-09 14:48:50'),
(163, 64, '180209163', 'M 7875', '', '', '2017-12-13', '0000-00-00', 8450.000000, 8450.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 14:50:58', '2018-02-09 14:50:58'),
(164, 74, '180209164', 'M 7876', '', '', '2017-12-18', '0000-00-00', 12300.000000, 12300.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 14:54:14', '2018-02-09 14:54:14'),
(165, 61, '180209165', 'M 7877', '', '', '2017-12-18', '0000-00-00', 28225.000000, 28225.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(166, 74, '180209166', 'M 7877 a', '', '', '2017-12-23', '0000-00-00', 8200.000000, 8200.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 15:07:25', '2018-02-09 15:07:25'),
(167, 80, '180209167', 'M 7878', '', '', '2017-12-24', '0000-00-00', 15000.000000, 15000.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 15:09:42', '2018-02-09 15:09:42'),
(168, 84, '180209168', 'M 7879', '', '', '2017-12-24', '0000-00-00', 11000.000000, 11000.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 15:13:17', '2018-02-09 15:13:17'),
(169, 77, '180209169', 'M 7880', '', '', '2017-12-26', '0000-00-00', 62690.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 15:24:42', '2018-02-09 17:07:54'),
(170, 77, '180209170', 'M 7881', '', '', '2017-12-31', '0000-00-00', 44620.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 15:34:39', '2018-02-09 17:07:54'),
(171, 61, '180209171', 'M 7882', '', '', '2017-12-31', '0000-00-00', 7900.000000, 7900.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 15:39:17', '2018-02-09 15:39:17'),
(172, 66, '180209172', 'M 7883', '', '', '2017-12-31', '0000-00-00', 42480.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 15:56:54', '2018-02-09 17:14:48'),
(173, 81, '180209173', 'M 7884', '', '', '2018-01-06', '0000-00-00', 33500.000000, 33500.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 16:01:25', '2018-02-09 16:01:25'),
(174, 77, '180209174', 'M 7887', '', '', '2018-01-14', '0000-00-00', 22040.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 16:07:02', '2018-02-09 17:07:54'),
(175, 77, '180209175', 'M 7888', '', '', '2018-01-15', '0000-00-00', 15920.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 16:23:25', '2018-02-09 17:07:54'),
(176, 61, '180209176', 'M 7889', '', '', '2018-01-21', '0000-00-00', 3900.000000, 3900.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 16:26:28', '2018-02-09 16:26:28'),
(177, 85, '180209177', 'M 7890', '', '', '2018-01-27', '0000-00-00', 19900.000000, 19900.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 16:41:08', '2018-02-09 16:41:08'),
(178, 61, '180209178', 'M 7891', '', '', '2017-12-27', '0000-00-00', 6800.000000, 6800.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 16:43:02', '2018-02-09 16:43:02'),
(179, 61, '180209179', 'M 7892', '', '', '2018-01-31', '0000-00-00', 16000.000000, 16000.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 16:47:49', '2018-02-09 16:47:49'),
(180, 83, '180209180', 'M 7893', '', '', '2018-01-31', '0000-00-00', 20175.000000, 20175.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 16:50:37', '2018-02-09 16:50:37'),
(181, 61, '180209181', 'M 7894', '', '', '2018-02-02', '0000-00-00', 26600.000000, 26600.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(182, 77, '180209182', 'M 7895', '', '', '2018-02-02', '0000-00-00', 37300.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 17:03:06', '2018-02-09 17:07:54'),
(183, 66, '180209183', 'M 7897', '', '', '2018-02-04', '0000-00-00', 96620.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 17:12:48', '2018-02-09 17:14:48'),
(184, 74, '180209184', 'M 7898', '', '', '2018-02-07', '0000-00-00', 19600.000000, 19600.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 17:17:10', '2018-02-09 17:17:10'),
(185, 73, '180209185', 'M 7899', '', '', '2018-02-07', '0000-00-00', 17400.000000, 17400.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-09 17:22:06', '2018-02-11 10:18:15'),
(186, 69, '180210186', 'M 7608', '', '', '2017-08-06', '0000-00-00', 3480.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-10 10:24:30', '2018-02-11 10:16:24'),
(187, 69, '180210187', 'M 7622', '', '', '2017-08-14', '0000-00-00', 19930.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-10 10:40:58', '2018-02-11 10:16:24'),
(188, 69, '180210188', 'M 7640', '', '', '2017-08-28', '0000-00-00', 1400.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-10 10:44:26', '2018-02-11 10:16:24'),
(189, 69, '180210189', 'M 7740', '', '', '2017-11-07', '0000-00-00', 2290.000000, 0.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-10 10:48:32', '2018-02-11 10:16:24'),
(190, 86, '180210190', 'M 7722', '', '', '2017-10-08', '0000-00-00', 850.000000, 850.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-10 11:15:17', '2018-02-10 11:15:17'),
(191, 86, '180210191', 'M 7744,7748', '', '', '2017-11-10', '0000-00-00', 27600.000000, 27600.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-10 11:31:46', '2018-02-10 11:33:07'),
(192, 79, 'opening-due-79', NULL, 'M 7536', NULL, '2017-08-01', '0000-00-00', 14400.000000, 14400.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-11 10:36:21', '2018-02-11 10:53:02'),
(193, 79, '180211193', 'M 7621', '', '', '2018-02-11', '0000-00-00', 28350.000000, 28350.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-11 10:48:37', '2020-10-02 14:57:36'),
(194, 79, '180211194', 'M 7746', '', '', '2017-11-11', '0000-00-00', 18700.000000, 16400.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-11 11:06:51', '2020-10-02 14:57:36'),
(195, 60, '180211195', '1-31/07/17', '', '', '2017-07-31', '0000-00-00', 286994.000000, 286994.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 4, 4, 2, 1, '2018-02-11 11:49:54', '2018-02-11 11:49:54'),
(196, 60, '180211196', '1-31/08/17', '', '', '2017-08-31', '0000-00-00', 440126.000000, 440126.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 3, 3, 2, 1, '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(197, 60, '180211197', '1-30/10/17', '', '', '2017-09-30', '0000-00-00', 166884.000000, 166884.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 3, 3, 2, 1, '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(198, 60, '180211198', '1-31/10/17', '', '', '2017-10-31', '0000-00-00', 290966.000000, 290966.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 3, 3, 2, 1, '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(199, 60, '180212199', '1-30/11/17', '', '', '2017-11-30', '0000-00-00', 184366.000000, 184366.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 3, 3, 2, 1, '2018-02-12 11:20:43', '2018-02-12 12:15:04'),
(200, 60, '180212200', '1-31/12/17', '', '', '2017-12-31', '0000-00-00', 331573.000000, 331573.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 3, 3, 2, 1, '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(201, 60, '180212201', '1-11/02/18', '', '', '2018-02-11', '0000-00-00', 54733.000000, 54733.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 3, 3, 2, 1, '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(202, 60, '180212202', '1-31/01/18', '', '', '2018-01-31', '0000-00-00', 288016.000000, 288016.000000, 0.000000, 0.000000, NULL, 0, NULL, 1, 3, 3, 2, 1, '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(203, 87, 'opening-due-87', NULL, 'Retail Deu', NULL, '2017-06-04', '0000-00-00', 2800.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-14 10:23:34', '2018-02-14 10:23:34'),
(204, 88, 'opening-due-88', NULL, 'Retail Deu', NULL, '2016-11-09', '0000-00-00', 4200.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-14 11:08:19', '2018-02-14 11:08:19'),
(205, 89, 'opening-due-89', NULL, 'Retail Deu', NULL, '2017-01-15', '0000-00-00', 800.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-14 11:10:02', '2018-02-14 11:10:02'),
(206, 90, 'opening-due-90', NULL, 'Retail', NULL, '2017-01-15', '0000-00-00', 3420.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-14 11:24:46', '2018-02-14 11:24:46'),
(207, 92, 'opening-due-92', NULL, 'Retail', NULL, '2017-06-11', '0000-00-00', 29450.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-14 11:27:34', '2018-02-14 11:27:34'),
(208, 91, 'opening-due-91', NULL, 'Retail', NULL, '2017-09-05', '0000-00-00', 3650.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-14 11:29:13', '2018-02-14 11:29:13'),
(209, 93, 'opening-due-93', NULL, 'Retail', NULL, '2018-01-17', '0000-00-00', 950.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-14 11:30:28', '2018-02-14 11:30:28'),
(210, 95, 'opening-due-95', NULL, 'Retail', NULL, '2016-08-28', '0000-00-00', 5000.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-14 11:32:34', '2018-02-14 11:32:34'),
(211, 94, 'opening-due-94', NULL, 'Retail', NULL, '2016-04-22', '0000-00-00', 6200.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-14 11:34:27', '2018-02-14 11:34:27'),
(212, 98, 'opening-due-98', NULL, 'Retail', NULL, '2016-11-16', '0000-00-00', 16505.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-14 11:35:52', '2018-02-14 11:35:52'),
(213, 97, 'opening-due-97', NULL, 'Retail', NULL, '2016-10-03', '0000-00-00', 4200.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-14 11:37:14', '2018-02-14 11:37:14'),
(214, 96, 'opening-due-96', NULL, NULL, NULL, '2015-08-21', '0000-00-00', 89260.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-14 11:52:06', '2018-02-14 11:52:06'),
(215, 99, 'opening-due-99', NULL, NULL, NULL, '2015-12-06', '0000-00-00', 14200.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 4, NULL, 2, 1, '2018-02-14 11:53:21', '2018-02-14 11:53:21'),
(216, 100, 'opening-due-100', NULL, 'Retail. Dehan er 12100', NULL, '2018-01-20', '0000-00-00', 12100.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 5, NULL, 2, 1, '2018-02-16 18:09:59', '2018-02-16 18:09:59'),
(217, 100, '217', NULL, '', '', '2018-02-16', '0000-00-00', 1500.000000, 0.000000, 12100.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-16 18:12:56', '2018-02-16 18:12:56'),
(218, 101, '218', '18-12-2017', '', '', '2018-02-16', '0000-00-00', 1500.000000, 1500.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-16 19:05:21', '2018-02-16 19:06:38'),
(219, 102, '219', '6-01-2018', '', '', '2018-02-16', '0000-00-00', 5100.000000, 1100.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-16 19:43:43', '2018-02-16 19:43:43'),
(220, 103, 'opening-due-103', NULL, 'Retail', NULL, '2017-07-01', '0000-00-00', 6800.000000, 6400.000000, NULL, NULL, NULL, NULL, 0, 0, 5, NULL, 2, 1, '2018-02-16 20:06:13', '2018-02-18 21:21:06'),
(221, 103, '221', '10-07-2017', '', '', '2018-02-16', '0000-00-00', 6100.000000, 3850.000000, 6400.000000, 0.000000, 40.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-16 20:10:51', '2018-02-18 21:19:26'),
(222, 103, '222', '23-08-2018', '', '', '2018-02-16', '0000-00-00', 9600.000000, 0.000000, 11900.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-16 20:17:48', '2018-02-18 21:19:26'),
(223, 103, '223', '23-12-2017', '', '', '2018-02-16', '0000-00-00', 9170.000000, 0.000000, 21500.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-16 20:24:55', '2018-02-18 21:19:26'),
(224, 103, '224', '24-12-2017', '', '', '2018-02-16', '0000-00-00', 200.000000, 0.000000, 30670.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-16 20:27:23', '2018-02-18 21:19:26'),
(225, 104, 'opening-due-104', NULL, 'Retail', NULL, '2017-08-01', '0000-00-00', 2100.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 5, NULL, 2, 1, '2018-02-16 20:42:13', '2018-02-16 20:42:13'),
(226, 72, '226', 'M 7791,04-02-2018', '', '', '2018-02-17', '0000-00-00', 11680.000000, 0.000000, 2555179.000000, 0.000000, 0.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-17 21:00:27', '2018-03-04 23:00:22'),
(227, 72, '227', 'M 7795,16-02-2018', '', '', '2018-02-17', '0000-00-00', 8775.000000, 0.000000, 2566859.000000, 0.000000, 0.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-17 21:13:57', '2018-03-04 23:00:22'),
(228, 72, '228', 'M 7796,16-02-2018', '', '', '2018-02-17', '0000-00-00', 205640.000000, 0.000000, 2575634.000000, 0.000000, 0.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-17 21:20:00', '2018-03-04 23:00:22'),
(229, 76, '229', 'M 7900- 9/2/18', '', '', '2018-02-17', '0000-00-00', 12000.000000, 12000.000000, 0.000000, 0.000000, 160.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-17 22:39:51', '2018-02-17 22:39:51'),
(230, 77, '230', 'M 7051,/ 10-2-18', '', '', '2018-02-17', '0000-00-00', 9690.000000, 9500.000000, 196700.000000, 0.000000, 200.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-17 22:48:02', '2018-02-17 22:48:02'),
(231, 105, '231', 'M 7052/ 10-2-18', '', '', '2018-02-17', '0000-00-00', 9400.000000, 9400.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-17 22:53:28', '2018-02-17 22:53:28'),
(232, 73, '232', 'M 7053/ 12-2-18', '', '', '2018-02-17', '0000-00-00', 2420.000000, 2420.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-17 22:55:57', '2018-02-17 22:55:57'),
(233, 61, '233', 'M 7054/ 14-2-18', '', '', '2018-02-17', '0000-00-00', 6800.000000, 6800.000000, 0.000000, 0.000000, 100.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-17 22:58:51', '2018-02-17 22:58:51'),
(234, 103, '234', NULL, '', '', '2018-02-13', '0000-00-00', 12600.000000, 4000.000000, 23870.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-18 21:17:59', '2018-02-18 21:19:26'),
(235, 103, '235', NULL, '', '', '2018-02-17', '0000-00-00', 350.000000, 350.000000, 32470.000000, 2650.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-18 21:19:26', '2018-02-18 21:19:26'),
(236, 104, '236', NULL, '', '', '2017-08-14', '0000-00-00', 2850.000000, 2500.000000, 2100.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-18 21:29:50', '2018-02-18 21:29:50'),
(237, 104, '237', NULL, '', '', '2017-10-27', '0000-00-00', 7650.000000, 4000.000000, 2450.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-18 21:32:25', '2018-02-18 21:32:25'),
(238, 106, '238', NULL, '', '', '2017-07-30', '0000-00-00', 11500.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-18 21:39:58', '2018-02-18 21:39:58'),
(239, 107, '239', NULL, '', NULL, '2017-08-13', '0000-00-00', 10700.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-18 22:06:32', '2018-02-18 22:12:32'),
(240, 107, 'opening-due-107', NULL, 'Dehan babod', NULL, '2018-02-18', '0000-00-00', 15200.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 5, NULL, 2, 1, '2018-02-18 22:08:41', '2018-02-18 22:08:41'),
(241, 108, 'opening-due-108', NULL, 'Retail', NULL, '2017-07-30', '0000-00-00', 12900.000000, 8000.000000, NULL, NULL, NULL, NULL, 0, 0, 5, NULL, 2, 1, '2018-02-18 22:24:51', '2018-02-18 22:33:09'),
(242, 108, '242', NULL, '', '', '2017-07-30', '0000-00-00', 2000.000000, 2000.000000, 12900.000000, 3000.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-18 22:32:18', '2018-02-18 22:32:18'),
(243, 108, '243', NULL, '', '', '2017-12-05', '0000-00-00', 11250.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-18 22:39:07', '2018-02-18 22:39:07'),
(244, 108, '244', NULL, '', '', '2017-12-05', '0000-00-00', 150.000000, 0.000000, 16150.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-18 22:42:00', '2018-02-18 22:42:00'),
(245, 109, 'opening-due-109', NULL, 'Retail', NULL, '2017-07-01', '0000-00-00', 22100.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 5, NULL, 2, 1, '2018-02-18 22:48:45', '2018-02-18 22:48:45'),
(246, 110, 'opening-due-110', NULL, 'Retail', NULL, '2018-01-17', '0000-00-00', 6700.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 5, NULL, 2, 1, '2018-02-18 22:56:28', '2018-02-18 22:56:28'),
(247, 111, 'opening-due-111', NULL, 'Retail', NULL, '2018-01-17', '0000-00-00', 5600.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 5, NULL, 2, 1, '2018-02-18 23:00:41', '2018-02-18 23:00:41'),
(248, 112, 'opening-due-112', NULL, 'Retail', NULL, '2017-07-05', '0000-00-00', 3100.000000, 3100.000000, NULL, NULL, NULL, NULL, 0, 0, 5, NULL, 2, 1, '2018-02-18 23:05:48', '2018-02-18 23:21:19'),
(249, 112, '249', NULL, '', '', '2017-07-05', '0000-00-00', 1600.000000, 1600.000000, 3100.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-18 23:13:45', '2018-02-18 23:22:05'),
(250, 112, '250', NULL, '', '', '2017-08-23', '0000-00-00', 5800.000000, 3300.000000, 4700.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-18 23:16:17', '2018-02-18 23:22:52'),
(251, 112, '251', NULL, '', '', '2018-01-22', '0000-00-00', 300.000000, 0.000000, 10500.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-18 23:18:20', '2018-02-18 23:22:52'),
(252, 112, '252', NULL, '', '', '2018-02-13', '0000-00-00', 2600.000000, 0.000000, 10800.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-18 23:19:28', '2018-02-18 23:22:52'),
(253, 113, 'opening-due-113', NULL, 'Retail', NULL, '2017-07-01', '0000-00-00', 3183.000000, 0.000000, NULL, NULL, NULL, NULL, 0, 0, 5, NULL, 2, 1, '2018-02-18 23:28:16', '2018-02-18 23:28:16'),
(254, 114, 'opening-due-114', NULL, 'Retail', NULL, '2017-09-11', '0000-00-00', 600.000000, 600.000000, NULL, NULL, NULL, NULL, 0, 0, 5, NULL, 2, 1, '2018-02-18 23:33:00', '2018-04-01 05:12:03'),
(255, 114, '255', NULL, '', '', '2017-09-11', '0000-00-00', 1700.000000, 1500.000000, 600.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-18 23:34:43', '2018-04-01 05:45:23'),
(256, 114, '256', NULL, '', '', '2017-10-10', '0000-00-00', 1900.000000, 1000.000000, 2300.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-18 23:36:07', '2018-04-01 05:45:23'),
(257, 115, '257', 'M 7058', '', '', '2018-02-19', '0000-00-00', 25800.000000, 25800.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-19 23:30:26', '2018-02-19 23:30:26'),
(258, 74, '258', 'M 7059', '', '', '2018-02-19', '0000-00-00', 2760.000000, 2760.000000, 0.000000, 0.000000, 40.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-19 23:34:56', '2018-02-19 23:34:56'),
(259, 73, '259', 'M 7060', '', '', '2018-02-19', '0000-00-00', 1340.000000, 1340.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-19 23:37:29', '2018-02-19 23:37:29'),
(260, 60, '260', NULL, '', '', '2018-02-12', '0000-00-00', 10350.000000, 10350.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-20 17:03:39', '2018-02-24 15:58:37'),
(261, 81, '261', 'M 7057', '', '', '2018-02-19', '0000-00-00', 27000.000000, 27000.000000, 0.000000, 0.000000, 90.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-23 21:29:08', '2018-02-23 21:29:08'),
(262, 61, '262', 'M 7061', '', '', '2018-02-20', '0000-00-00', 9200.000000, 9200.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-23 21:35:39', '2018-02-23 21:35:39'),
(263, 75, '263', 'M 7873', '', '', '2017-12-12', '0000-00-00', 4000.000000, 4000.000000, 129890.000000, 16000.000000, 0.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-23 22:25:06', '2018-02-23 22:25:06'),
(264, 75, '264', 'M 7886', '', '', '2018-01-12', '0000-00-00', 43400.000000, 0.000000, 113890.000000, 0.000000, 0.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-23 22:28:02', '2018-02-23 22:35:18'),
(265, 75, '265', 'M 7896', '', '', '2018-02-02', '0000-00-00', 21400.000000, 21400.000000, 157290.000000, 8600.000000, 0.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(266, 71, '266', 'M 7819', '', '', '2018-02-10', '0000-00-00', 4000.000000, 0.000000, 332223.000000, 0.000000, 0.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-23 22:46:58', '2018-02-23 23:03:56'),
(267, 71, '267', 'M 7820', '', '', '2018-02-17', '0000-00-00', 600.000000, 0.000000, 336223.000000, 0.000000, 0.000000, 0, NULL, 1, 3, 3, 2, 1, '2018-02-23 22:50:12', '2018-02-23 23:03:56'),
(268, 60, '268', NULL, '', '', '2018-02-13', '0000-00-00', 2350.000000, 2350.000000, 10350.000000, 10350.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-24 15:58:37', '2018-02-24 15:58:37'),
(269, 60, '269', NULL, '', '', '2018-02-14', '0000-00-00', 16610.000000, 16610.000000, 0.000000, 0.000000, 3.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(270, 60, '270', NULL, '', '', '2018-02-16', '0000-00-00', 5950.000000, 5950.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(271, 60, '271', NULL, '', '', '2018-02-17', '0000-00-00', 15100.000000, 15100.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(272, 60, '272', NULL, '', '', '2018-02-18', '0000-00-00', 4550.000000, 4550.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-24 16:34:23', '2018-02-24 16:34:23'),
(273, 60, '273', NULL, '', '', '2018-02-19', '0000-00-00', 6469.000000, 6469.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(274, 60, '274', NULL, '', '', '2018-02-20', '0000-00-00', 20198.000000, 20198.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(275, 60, '275', NULL, '', '', '2018-02-23', '0000-00-00', 7502.000000, 7502.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-02-24 17:19:25', '2018-02-24 17:19:25'),
(276, 116, '276', 'M 7655', '', '', '2017-09-27', '0000-00-00', 3850.000000, 3850.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 00:16:54', '2018-02-25 00:16:54'),
(277, 116, '277', 'M 7651', '', '', '2017-09-15', '0000-00-00', 58700.000000, 58700.000000, 0.000000, 0.000000, 200.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(278, 116, '278', 'M 7652', '', '', '2017-09-19', '0000-00-00', 29500.000000, 29500.000000, 0.000000, 0.000000, 200.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 00:34:55', '2018-02-25 00:34:55'),
(279, 116, '279', 'M 7653', '', '', '2017-09-19', '0000-00-00', 19800.000000, 19800.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 00:38:04', '2018-02-25 00:38:04'),
(280, 116, '280', 'M 7654', '', '', '2017-09-22', '0000-00-00', 14050.000000, 14050.000000, 0.000000, 0.000000, 20.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 00:46:56', '2018-02-25 00:46:56'),
(281, 73, '281', 'M 7656', '', '', '2017-09-30', '0000-00-00', 7850.000000, 7850.000000, 0.000000, 0.000000, 20.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 00:54:36', '2018-02-25 00:54:36'),
(282, 116, '282', 'M 7657', '', '', '2017-09-30', '0000-00-00', 14000.000000, 14000.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 01:05:44', '2018-02-25 01:05:44'),
(283, 116, '283', 'M 7658', '', '', '2017-10-07', '0000-00-00', 7300.000000, 7300.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 18:52:33', '2018-02-25 18:52:33'),
(284, 116, '284', 'M 7659', '', '', '2017-10-07', '0000-00-00', 17000.000000, 17000.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 18:59:13', '2018-02-25 18:59:13'),
(285, 116, '285', 'M 7660', '', '', '2017-10-16', '0000-00-00', 21900.000000, 21900.000000, 0.000000, 0.000000, 50.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 19:02:44', '2018-02-25 19:02:44'),
(286, 76, '286', 'M 7661', '', '', '2017-10-20', '0000-00-00', 28700.000000, 28700.000000, 0.000000, 0.000000, 50.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 19:08:08', '2018-02-25 19:08:08'),
(287, 116, '287', 'M 7663', '', '', '2017-11-03', '0000-00-00', 29500.000000, 29500.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 19:14:46', '2018-02-25 19:14:46'),
(288, 116, '288', 'M 7664', '', '', '2017-11-03', '0000-00-00', 37340.000000, 37340.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 19:19:58', '2018-02-25 19:19:58'),
(289, 116, '289', 'M 7667', '', '', '2017-11-05', '0000-00-00', 10600.000000, 10600.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 19:22:56', '2018-02-25 19:22:56'),
(290, 73, '290', 'M 7668', '', '', '2017-11-06', '0000-00-00', 4000.000000, 4000.000000, 0.000000, 0.000000, 60.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 19:25:18', '2018-03-05 17:03:42'),
(291, 116, '291', 'M 7669', '', '', '2017-11-06', '0000-00-00', 10000.000000, 10000.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 19:27:12', '2018-02-25 19:27:12'),
(292, 116, '292', 'M 7670', '', '', '2017-11-08', '0000-00-00', 8000.000000, 8000.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 19:46:47', '2018-02-25 19:46:47'),
(293, 116, '293', 'M 7671', '', '', '2017-11-08', '0000-00-00', 800.000000, 800.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 19:49:55', '2018-02-25 19:49:55');
INSERT INTO `inventory_product_sales` (`id`, `fk_client_id`, `invoice_id`, `order_id`, `summary`, `shipping_address`, `date`, `shipping_date`, `total_amount`, `paid_amount`, `prev_amount`, `prev_paid`, `discount`, `transport_bill`, `type`, `sales_type`, `created_by`, `fk_user_id`, `fk_branch_id`, `fk_company_id`, `created_at`, `updated_at`) VALUES
(294, 116, '294', 'M 7672', '', '', '2017-11-10', '0000-00-00', 19200.000000, 19200.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 19:54:16', '2018-02-25 19:54:16'),
(295, 116, '295', 'M 7674', '', '', '2017-11-15', '0000-00-00', 25600.000000, 25600.000000, 0.000000, 0.000000, 20.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 20:02:35', '2018-02-25 20:02:35'),
(296, 116, '296', 'M 7675', '', '', '2017-11-17', '0000-00-00', 11660.000000, 11660.000000, 0.000000, 0.000000, 240.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 20:05:47', '2018-02-25 20:05:47'),
(297, 116, '297', 'M 7676', '', '', '2017-11-18', '0000-00-00', 8700.000000, 8700.000000, 0.000000, 0.000000, 20.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 20:10:56', '2018-02-25 20:14:40'),
(298, 116, '298', 'M 7677', '', '', '2017-11-18', '0000-00-00', 9300.000000, 9300.000000, 8700.000000, 8700.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 20:14:40', '2018-02-25 20:14:40'),
(299, 116, '299', 'M 7678', '', '', '2017-11-20', '0000-00-00', 13700.000000, 13700.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 20:21:01', '2018-02-25 20:21:01'),
(300, 116, '300', 'M 7679', '', '', '2017-11-24', '0000-00-00', 13000.000000, 13000.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 20:52:12', '2018-02-25 20:52:12'),
(301, 116, '301', 'M 7680', '', '', '2017-11-26', '0000-00-00', 10600.000000, 10600.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 20:57:01', '2018-02-25 20:57:01'),
(302, 116, '302', 'M 7681', '', '', '2017-11-29', '0000-00-00', 6250.000000, 6250.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 20:58:37', '2018-02-25 20:58:37'),
(303, 116, '303', 'M 7682', '', '', '2017-12-01', '0000-00-00', 11800.000000, 11800.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 21:01:25', '2018-02-25 21:01:25'),
(304, 116, '304', 'M 7683', '', '', '2017-12-05', '0000-00-00', 7300.000000, 7300.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 21:05:02', '2018-02-25 21:05:02'),
(305, 117, '305', 'M 7684', '', '', '2017-12-05', '0000-00-00', 16600.000000, 16600.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 21:10:47', '2018-02-25 21:10:47'),
(306, 116, '306', 'M 7685', '', '', '2017-12-08', '0000-00-00', 9000.000000, 9000.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 21:16:55', '2018-02-25 21:16:55'),
(307, 116, '307', 'M 7686', '', '', '2017-12-11', '0000-00-00', 11800.000000, 11800.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 21:22:00', '2018-02-25 21:22:00'),
(308, 116, '308', 'M 7687', '', '', '2017-12-15', '0000-00-00', 12250.000000, 12250.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 21:24:59', '2018-02-25 21:24:59'),
(309, 86, '309', 'M 7688', '', '', '2017-12-17', '0000-00-00', 1600.000000, 1600.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 21:27:39', '2018-02-25 21:27:39'),
(310, 116, '310', 'M 7689', '', '', '2017-12-18', '0000-00-00', 1400.000000, 1400.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 21:29:40', '2018-02-25 21:29:40'),
(311, 117, '311', 'M 7690', '', '', '2017-12-19', '0000-00-00', 20500.000000, 20500.000000, 0.000000, 0.000000, 50.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 21:32:15', '2018-02-25 21:32:15'),
(312, 116, '312', 'M 7691', '', '', '2017-12-20', '0000-00-00', 11600.000000, 11600.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 21:35:05', '2018-02-25 21:35:05'),
(313, 117, '313', 'M 7692', '', '', '2017-12-22', '0000-00-00', 31000.000000, 31000.000000, 0.000000, 0.000000, 100.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 21:40:10', '2018-02-25 21:40:10'),
(314, 116, '314', 'M 7693', '', '', '2017-12-29', '0000-00-00', 7380.000000, 7380.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 21:44:03', '2018-02-25 21:44:03'),
(315, 116, '315', 'M 7694', '', '', '2018-01-01', '0000-00-00', 6900.000000, 6900.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 21:48:34', '2018-02-25 21:48:34'),
(316, 116, '316', 'M 7695', '', '', '2018-01-01', '0000-00-00', 4380.000000, 4380.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 22:16:13', '2018-02-25 22:16:13'),
(317, 116, '317', 'M 7696', '', '', '2018-01-03', '0000-00-00', 6100.000000, 6100.000000, 0.000000, 0.000000, 150.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 22:19:46', '2018-02-25 22:19:46'),
(318, 116, '318', 'M 7697', '', '', '2018-01-03', '0000-00-00', 12640.000000, 12640.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(319, 117, '319', 'M 7698', '', '', '2018-01-05', '0000-00-00', 46400.000000, 46400.000000, 0.000000, 0.000000, 30.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(320, 116, '320', 'M 7700', '', '', '2018-01-10', '0000-00-00', 5000.000000, 5000.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 22:42:39', '2018-02-25 22:42:39'),
(321, 116, '321', 'M 7453', '', '', '2018-01-13', '0000-00-00', 4800.000000, 4800.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 22:45:19', '2018-02-25 22:45:19'),
(322, 116, '322', 'M 7455', '', '', '2018-01-14', '0000-00-00', 13800.000000, 13800.000000, 0.000000, 0.000000, 10.000000, 0, NULL, 0, 7, 7, 4, 1, '2018-02-25 22:53:29', '2018-02-25 22:53:29'),
(323, 116, '323', 'M 7457', '', '', '2018-01-14', '0000-00-00', 4200.000000, 4200.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 22:56:28', '2018-02-25 22:56:28'),
(324, 116, '324', 'M 7457', '', '', '2018-01-16', '0000-00-00', 27700.000000, 27700.000000, 0.000000, 0.000000, 30.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 23:05:24', '2018-02-25 23:05:24'),
(325, 118, '325', 'M 7458', '', '', '2018-01-22', '0000-00-00', 53770.000000, 53770.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 0, 7, 7, 4, 1, '2018-02-25 23:19:40', '2018-02-25 23:28:02'),
(326, 118, '326', 'M 7459', '', '', '2018-01-22', '0000-00-00', 9850.000000, 9850.000000, 53770.000000, 53770.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 23:28:02', '2018-02-25 23:28:02'),
(327, 116, '327', 'M 7461', '', '', '2018-01-22', '0000-00-00', 4370.000000, 4370.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-25 23:34:09', '2018-02-25 23:34:09'),
(328, 119, '328', '1-30/09/17', '', '', '2017-09-30', '0000-00-00', 46273.000000, 46273.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(329, 119, '329', '1-31/01/2018', '', '', '2018-01-31', '0000-00-00', 211908.000000, 211908.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 0, 7, 7, 4, 1, '2018-02-26 23:40:43', '2018-02-26 23:43:21'),
(330, 119, '330', '1-31/01/2018', '', '', '2018-01-31', '0000-00-00', 95091.000000, 95091.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(331, 119, '331', '1-31/01/2018', '', '', '2018-01-31', '0000-00-00', 144048.000000, 144048.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 0, 7, 7, 4, 1, '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(332, 116, '332', 'M 7462', '', '', '2018-01-22', '0000-00-00', 11485.000000, 11485.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-27 01:21:11', '2018-02-27 01:21:11'),
(333, 116, '333', 'M 7464', '', '', '2018-01-23', '0000-00-00', 18200.000000, 18200.000000, 0.000000, 0.000000, 1.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-27 01:26:27', '2018-02-27 01:26:27'),
(334, 117, '334', 'M 7465', '', '', '2018-01-24', '0000-00-00', 64000.000000, 64000.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 7, 7, 4, 1, '2018-02-27 01:30:52', '2018-02-27 01:30:52'),
(335, 116, '335', 'M 7466', '', '', '2018-01-24', '0000-00-00', 29050.000000, 29050.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 4, 1, '2018-02-28 18:47:13', '2018-02-28 18:47:13'),
(336, 85, '336', 'M 7467', '', '', '2018-01-27', '0000-00-00', 8400.000000, 8400.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 4, 1, '2018-02-28 18:51:12', '2018-02-28 18:51:12'),
(337, 116, '337', 'M 7468', '', '', '2018-01-27', '0000-00-00', 3950.000000, 3950.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 4, 1, '2018-02-28 18:56:18', '2018-02-28 18:56:18'),
(338, 116, '338', 'M 7469', '', '', '2018-01-31', '0000-00-00', 33600.000000, 33600.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 4, 1, '2018-02-28 19:00:36', '2018-02-28 19:00:36'),
(339, 116, '339', 'M 7470', '', '', '2018-01-31', '0000-00-00', 11000.000000, 11000.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 4, 1, '2018-02-28 19:03:40', '2018-02-28 19:03:40'),
(340, 116, '340', 'M 7471', '', '', '2018-01-31', '0000-00-00', 16800.000000, 16800.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 4, 1, '2018-02-28 19:06:03', '2018-02-28 19:06:03'),
(341, 116, '341', 'M 7473', '', '', '2018-02-06', '0000-00-00', 11050.000000, 11050.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 4, 1, '2018-02-28 19:11:58', '2018-02-28 19:11:58'),
(342, 73, '342', 'M 7474', '', '', '2018-02-10', '0000-00-00', 3400.000000, 3400.000000, 4000.000000, 0.000000, 80.000000, 0, NULL, 1, 5, 5, 4, 1, '2018-02-28 19:15:18', '2018-02-28 19:15:18'),
(343, 116, '343', 'M 7475', '', '', '2018-02-12', '0000-00-00', 13600.000000, 13600.000000, 0.000000, 0.000000, 100.000000, 0, NULL, 1, 5, 5, 4, 1, '2018-02-28 19:17:07', '2018-02-28 19:17:07'),
(344, 116, '344', 'M 7477', '', '', '2018-02-13', '0000-00-00', 4800.000000, 4800.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 4, 1, '2018-02-28 19:18:29', '2018-02-28 19:18:29'),
(345, 85, '345', 'M 7478', '', '', '2018-02-16', '0000-00-00', 9500.000000, 9500.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 4, 1, '2018-02-28 19:21:00', '2018-02-28 19:21:00'),
(346, 117, '346', 'M 7479', '', '', '2018-02-23', '0000-00-00', 19620.000000, 19620.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 4, 1, '2018-02-28 19:25:04', '2018-02-28 19:25:04'),
(347, 116, '347', 'M 7480', '', '', '2018-02-24', '0000-00-00', 4650.000000, 4650.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 4, 1, '2018-02-28 19:27:53', '2018-02-28 19:27:53'),
(348, 119, '348', '1-31/10/2017', '', '', '2017-10-31', '0000-00-00', 213283.000000, 213283.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 4, 1, '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(349, 116, '349', '1-30/11/2017', '', '', '2017-11-30', '0000-00-00', 199201.000000, 199201.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 4, 1, '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(350, 119, '350', '1-31/12/2017', '', '', '2017-12-31', '0000-00-00', 445524.000000, 445524.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 6, 6, 4, 1, '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(351, 119, '351', '1-28/02/2018', '', '', '2018-02-28', '0000-00-00', 232422.000000, 232422.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 6, 6, 4, 1, '2018-03-04 00:03:18', '2018-03-04 00:04:43'),
(352, 116, '352', 'M 7482', '', '', '2018-02-28', '0000-00-00', 5150.000000, 5150.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 6, 6, 4, 1, '2018-03-04 01:04:33', '2018-03-04 01:04:33'),
(353, 116, '353', 'M 7483', '', '', '2018-02-28', '0000-00-00', 6500.000000, 6500.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 6, 6, 4, 1, '2018-03-04 01:07:46', '2018-03-04 01:07:46'),
(354, 72, '354', 'M 7798', '', '', '2018-02-19', '0000-00-00', 44600.000000, 12500.000000, 2682274.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-03-04 16:58:34', '2018-03-04 23:00:22'),
(355, 72, '355', 'M 7799', '', '', '2018-02-27', '0000-00-00', 172900.000000, 0.000000, 2714374.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-03-04 17:06:46', '2018-03-04 23:00:22'),
(356, 72, '356', 'M 7800', '', '', '2018-02-28', '0000-00-00', 151750.000000, 35200.000000, 2851874.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-03-04 17:16:43', '2018-03-04 23:00:22'),
(357, 119, '357', NULL, '', '', '2018-01-31', '0000-00-00', 1425.000000, 1425.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 6, 6, 4, 1, '2018-03-04 21:42:03', '2018-03-04 21:42:03'),
(358, 116, '358', 'M 7481', '', '', '2018-02-24', '0000-00-00', 12950.000000, 12950.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 6, 6, 4, 1, '2018-03-04 21:53:46', '2018-03-04 21:53:46'),
(359, 116, '359', 'M 7485', '', '', '2018-03-02', '0000-00-00', 25980.000000, 25980.000000, 0.000000, 0.000000, 10.000000, 0, NULL, 1, 6, 6, 4, 1, '2018-03-05 00:38:14', '2018-03-05 00:38:14'),
(360, 119, '360', '02-03/03/18', '', '', '2018-03-03', '0000-00-00', 16952.000000, 16952.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 0, 6, 6, 4, 1, '2018-03-05 00:56:07', '2018-03-05 00:56:07'),
(361, 60, '361', NULL, '', '', '2018-02-24', '0000-00-00', 5860.000000, 5860.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(362, 60, '362', NULL, '', '', '2018-02-25', '0000-00-00', 5429.000000, 5429.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(363, 60, '363', NULL, '', '', '2018-02-26', '0000-00-00', 8382.000000, 8382.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(364, 60, '364', NULL, '', '', '2018-02-27', '0000-00-00', 2200.000000, 2200.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-03-05 16:32:20', '2018-03-05 16:32:20'),
(365, 60, '365', NULL, '', '', '2018-02-28', '0000-00-00', 9197.000000, 9197.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(366, 61, '366', 'M 7062', '', '', '2018-02-24', '0000-00-00', 7250.000000, 7250.000000, 0.000000, 0.000000, 20.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-03-05 16:57:45', '2018-03-05 16:57:45'),
(367, 73, '367', 'M 7065', '', '', '2018-02-26', '0000-00-00', 2620.000000, 2620.000000, 4000.000000, 4000.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-03-05 17:03:42', '2018-03-05 17:03:42'),
(368, 61, '368', 'M 7067', '', '', '2018-02-28', '0000-00-00', 8900.000000, 8900.000000, 0.000000, 0.000000, 0.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-03-05 17:09:19', '2018-03-05 17:09:19'),
(369, 105, '369', 'M 7066', '', '', '2018-02-28', '0000-00-00', 6300.000000, 6300.000000, 0.000000, 0.000000, 400.000000, 0, NULL, 1, 5, 5, 2, 1, '2018-03-05 17:12:09', '2018-03-05 17:12:09'),
(370, 113, '370', NULL, '', '', '2018-04-01', '0000-00-00', 150.000000, 0.000000, 3183.000000, 0.000000, 0.000000, 0, NULL, 1, 1, 1, 2, 1, '2018-04-01 05:14:13', '2018-04-01 05:14:13'),
(371, 106, '371', NULL, '', '', '2020-10-02', '0000-00-00', 3000.000000, 0.000000, 11500.000000, 0.000000, 0.000000, 0, NULL, 1, 1, 1, 4, 1, '2020-10-02 14:54:49', '2020-10-02 14:54:49'),
(372, 113, '372', NULL, '', '', '2020-10-02', '0000-00-00', 4000.000000, 0.000000, 3333.000000, 0.000000, 0.000000, 0, NULL, 1, 1, 1, 4, 1, '2020-10-02 14:55:43', '2020-10-02 14:55:43'),
(373, 79, '373', '4567', '', '', '2020-10-02', '0000-00-00', 500.000000, 500.000000, 21800.000000, 19500.000000, 0.000000, 0, NULL, 0, 1, 1, 4, 1, '2020-10-02 14:57:36', '2020-10-02 14:57:36');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_product_sales_item`
--

CREATE TABLE `inventory_product_sales_item` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_sales_id` int(10) UNSIGNED NOT NULL,
  `fk_product_id` int(10) UNSIGNED NOT NULL,
  `fk_model_id` int(10) NOT NULL,
  `product_price_amount` decimal(17,6) NOT NULL,
  `sales_qty` float NOT NULL,
  `small_qty` float DEFAULT NULL,
  `product_wise_discount` float DEFAULT 0,
  `product_paid_amount` decimal(17,6) NOT NULL,
  `inventory_item_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_product_sales_item`
--

INSERT INTO `inventory_product_sales_item` (`id`, `fk_sales_id`, `fk_product_id`, `fk_model_id`, `product_price_amount`, `sales_qty`, `small_qty`, `product_wise_discount`, `product_paid_amount`, `inventory_item_id`, `created_at`, `updated_at`) VALUES
(30, 23, 28, 32, 1350.000000, 5, 0, NULL, 6750.000000, '{\"34\":\"5\"}', '2018-02-03 14:29:59', '2018-02-03 14:29:59'),
(31, 23, 28, 34, 1450.000000, 4, 0, NULL, 5800.000000, '{\"37\":\"4\"}', '2018-02-03 14:29:59', '2018-02-03 14:29:59'),
(32, 24, 28, 33, 2000.000000, 1, 0, NULL, 2000.000000, '{\"35\":\"1\"}', '2018-02-03 15:09:35', '2018-02-03 15:09:35'),
(33, 24, 28, 37, 1000.000000, 2, 0, NULL, 2000.000000, '{\"40\":\"2\"}', '2018-02-03 15:09:35', '2018-02-03 15:09:35'),
(34, 25, 27, 72, 110.000000, 15, 0, NULL, 1650.000000, '{\"104\":\"15\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(35, 25, 27, 31, 110.000000, 48, 0, NULL, 5280.000000, '{\"33\":\"48\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(36, 25, 27, 70, 220.000000, 16, 0, NULL, 3520.000000, '{\"102\":\"16\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(37, 25, 27, 31, 300.000000, 5, 0, NULL, 1500.000000, '{\"33\":\"5\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(38, 25, 27, 69, 180.000000, 7, 0, NULL, 1260.000000, '{\"101\":\"7\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(39, 25, 27, 68, 250.000000, 5, 0, NULL, 1250.000000, '{\"100\":\"5\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(40, 25, 27, 68, 300.000000, 5, 0, NULL, 1500.000000, '{\"100\":\"5\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(41, 25, 43, 78, 300.000000, 3, 0, NULL, 900.000000, '{\"111\":\"3\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(42, 25, 27, 31, 180.000000, 2, 0, NULL, 360.000000, '{\"33\":\"2\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(43, 25, 28, 34, 1250.000000, 2, 0, NULL, 2500.000000, '{\"37\":\"2\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(44, 25, 28, 32, 1150.000000, 1, 0, NULL, 1150.000000, '{\"34\":\"1\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(45, 26, 28, 38, 700.000000, 25, 0, NULL, 17500.000000, '{\"41\":\"25\"}', '2018-02-03 17:32:04', '2018-02-03 17:32:04'),
(46, 26, 28, 33, 1500.000000, 75, 0, NULL, 112500.000000, '{\"35\":\"2\",\"56\":73}', '2018-02-03 17:32:04', '2018-02-03 17:32:04'),
(47, 26, 30, 40, 800.000000, 12, 0, NULL, 9600.000000, '{\"43\":\"12\"}', '2018-02-03 17:32:04', '2018-02-03 17:32:04'),
(48, 26, 31, 47, 400.000000, 30, 0, NULL, 12000.000000, '{\"66\":\"30\"}', '2018-02-03 17:32:04', '2018-02-03 17:32:04'),
(49, 26, 28, 35, 1000.000000, 12, 0, NULL, 12000.000000, '{\"38\":\"12\"}', '2018-02-03 17:32:04', '2018-02-03 17:32:04'),
(50, 26, 28, 36, 800.000000, 59, 0, NULL, 47200.000000, '{\"39\":\"59\"}', '2018-02-03 17:32:04', '2018-02-03 17:32:04'),
(51, 26, 28, 36, 1000.000000, 13, 0, NULL, 13000.000000, '{\"39\":\"13\"}', '2018-02-03 17:32:04', '2018-02-03 17:32:04'),
(52, 32, 39, 76, 400.000000, 15, 0, NULL, 6000.000000, '{\"109\":\"15\"}', '2018-02-04 10:06:04', '2018-02-04 10:06:04'),
(53, 32, 28, 32, 1300.000000, 5, 0, NULL, 6500.000000, '{\"34\":\"5\"}', '2018-02-04 10:06:04', '2018-02-04 10:06:04'),
(54, 32, 28, 34, 1400.000000, 1, 0, NULL, 1400.000000, '{\"37\":\"1\"}', '2018-02-04 10:06:04', '2018-02-04 10:06:04'),
(55, 32, 28, 33, 2000.000000, 5, 0, NULL, 10000.000000, '{\"56\":\"5\",\"68\":0}', '2018-02-04 10:06:04', '2018-02-04 10:06:04'),
(56, 34, 28, 32, 1300.000000, 2, 0, NULL, 2600.000000, '{\"34\":\"2\"}', '2018-02-04 11:07:09', '2018-02-04 11:07:09'),
(57, 34, 28, 34, 1400.000000, 2, 0, NULL, 2800.000000, '{\"37\":\"2\"}', '2018-02-04 11:07:09', '2018-02-04 11:07:09'),
(58, 34, 39, 76, 400.000000, 19, 0, NULL, 7600.000000, '{\"109\":\"19\"}', '2018-02-04 11:07:09', '2018-02-04 11:07:09'),
(59, 34, 43, 77, 450.000000, 1, 0, NULL, 450.000000, '{\"110\":\"1\"}', '2018-02-04 11:07:09', '2018-02-04 11:07:09'),
(60, 35, 28, 32, 1300.000000, 70, 0, NULL, 91000.000000, '{\"34\":\"7\",\"36\":63}', '2018-02-04 11:19:36', '2018-02-04 11:19:36'),
(61, 35, 28, 34, 1400.000000, 10, 0, NULL, 14000.000000, '{\"37\":\"10\"}', '2018-02-04 11:19:36', '2018-02-04 11:19:36'),
(62, 35, 28, 35, 1400.000000, 32, 0, NULL, 44800.000000, '{\"38\":\"32\"}', '2018-02-04 11:19:36', '2018-02-04 11:19:36'),
(63, 35, 28, 36, 800.000000, 10, 0, NULL, 8000.000000, '{\"39\":\"10\"}', '2018-02-04 11:19:36', '2018-02-04 11:19:36'),
(64, 36, 33, 80, 350.000000, 22, 0, NULL, 7700.000000, '{\"114\":\"22\"}', '2018-02-04 11:35:41', '2018-02-04 11:35:41'),
(65, 36, 28, 34, 1500.000000, 6, 0, NULL, 9000.000000, '{\"37\":\"6\"}', '2018-02-04 11:35:41', '2018-02-04 11:35:41'),
(66, 36, 28, 32, 1300.000000, 17, 0, NULL, 22100.000000, '{\"36\":\"17\"}', '2018-02-04 11:35:41', '2018-02-04 11:35:41'),
(67, 36, 40, 83, 1400.000000, 10, 0, NULL, 14000.000000, '{\"118\":\"10\"}', '2018-02-04 11:35:41', '2018-02-04 11:35:41'),
(68, 36, 40, 37, 2000.000000, 12, 0, NULL, 24000.000000, '{\"119\":\"12\"}', '2018-02-04 11:35:41', '2018-02-04 11:35:41'),
(69, 36, 40, 81, 1800.000000, 5, 0, NULL, 9000.000000, '{\"116\":\"5\"}', '2018-02-04 11:35:41', '2018-02-04 11:35:41'),
(70, 36, 27, 31, 120.000000, 10, 0, NULL, 1200.000000, '{\"33\":\"10\"}', '2018-02-04 11:35:41', '2018-02-04 11:35:41'),
(72, 45, 27, 71, 350.000000, 4, 0, NULL, 1400.000000, '{\"103\":\"4\"}', '2018-02-04 16:36:24', '2018-02-04 16:36:24'),
(73, 46, 28, 32, 1150.000000, 7, 0, NULL, 8050.000000, '{\"36\":\"7\"}', '2018-02-04 16:44:22', '2018-02-04 16:44:22'),
(74, 46, 28, 34, 1250.000000, 8, 0, NULL, 10000.000000, '{\"37\":\"8\"}', '2018-02-04 16:44:22', '2018-02-04 16:44:22'),
(75, 47, 27, 70, 270.000000, 3, 0, NULL, 810.000000, '{\"102\":\"3\",\"220\":0}', '2018-02-04 16:50:08', '2018-02-10 15:31:43'),
(76, 47, 27, 31, 130.000000, 10, 0, NULL, 1300.000000, '{\"33\":\"10\",\"219\":0}', '2018-02-04 16:50:08', '2018-02-10 15:31:43'),
(77, 47, 27, 31, 150.000000, 1, 0, NULL, 150.000000, '{\"33\":\"1\",\"219\":0}', '2018-02-04 16:50:08', '2018-02-10 15:31:43'),
(78, 48, 28, 32, 1350.000000, 4, 0, NULL, 5400.000000, '{\"36\":\"4\"}', '2018-02-04 17:01:14', '2018-02-04 17:01:14'),
(79, 48, 28, 34, 1450.000000, 6, 0, 40, 8460.000000, '{\"37\":\"6\"}', '2018-02-04 17:01:14', '2018-02-04 17:01:14'),
(80, 48, 27, 72, 120.000000, 22, 0, NULL, 2640.000000, '{\"104\":\"22\"}', '2018-02-04 17:01:14', '2018-02-04 17:01:14'),
(81, 49, 28, 32, 1300.000000, 5, 0, 20, 6400.000000, '{\"36\":\"5\"}', '2018-02-04 17:04:08', '2018-02-04 17:04:08'),
(82, 49, 28, 34, 1400.000000, 7, 0, NULL, 9800.000000, '{\"37\":\"7\"}', '2018-02-04 17:04:08', '2018-02-04 17:04:08'),
(83, 50, 27, 72, 130.000000, 8, 0, NULL, 1040.000000, '{\"104\":\"8\"}', '2018-02-04 17:06:46', '2018-02-04 17:06:46'),
(84, 51, 32, 58, 800.000000, 1, 0, NULL, 800.000000, '{\"84\":\"1\"}', '2018-02-04 17:35:40', '2018-02-04 17:35:40'),
(85, 51, 28, 32, 1300.000000, 2, 0, NULL, 2600.000000, '{\"36\":\"2\"}', '2018-02-04 17:35:40', '2018-02-04 17:35:40'),
(86, 51, 28, 34, 1400.000000, 4, 0, NULL, 5600.000000, '{\"37\":\"4\"}', '2018-02-04 17:35:40', '2018-02-04 17:35:40'),
(87, 51, 32, 58, 700.000000, 2, 0, NULL, 1400.000000, '{\"84\":\"2\"}', '2018-02-04 17:35:40', '2018-02-04 17:35:40'),
(88, 52, 28, 33, 1100.000000, 100, 0, NULL, 110000.000000, '{\"68\":\"100\",\"72\":0}', '2018-02-05 14:25:45', '2018-02-05 14:25:45'),
(89, 53, 27, 70, 184.000000, 868, 0, NULL, 159712.000000, '{\"102\":\"868\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(90, 53, 39, 76, 262.000000, 628, 0, NULL, 164536.000000, '{\"109\":\"316\",\"221\":312}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(91, 53, 39, 41, 200.000000, 193, 0, NULL, 38600.000000, '{\"44\":\"193\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(92, 53, 27, 31, 110.000000, 1610, 0, NULL, 177100.000000, '{\"33\":\"1610\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(93, 53, 27, 72, 90.000000, 520, 0, NULL, 46800.000000, '{\"104\":\"520\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(94, 53, 43, 77, 335.000000, 430, 0, NULL, 144050.000000, '{\"110\":\"430\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(95, 53, 43, 78, 250.000000, 171, 0, NULL, 42750.000000, '{\"111\":\"171\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(96, 53, 43, 77, 606.000000, 32, 0, NULL, 19392.000000, '{\"110\":\"32\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(97, 53, 27, 31, 140.000000, 449, 0, NULL, 62860.000000, '{\"33\":\"214\",\"219\":235}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(98, 53, 27, 71, 250.000000, 105, 0, NULL, 26250.000000, '{\"103\":\"105\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(99, 53, 27, 68, 200.000000, 202, 0, NULL, 40400.000000, '{\"100\":\"202\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(100, 53, 27, 79, 233.000000, 540, 0, NULL, 125820.000000, '{\"113\":\"540\",\"232\":0}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(101, 53, 33, 80, 300.000000, 80, 0, NULL, 24000.000000, '{\"114\":\"80\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(102, 53, 31, 47, 405.000000, 151, 0, NULL, 61155.000000, '{\"66\":\"149\",\"216\":2}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(103, 53, 32, 58, 600.000000, 380, 0, NULL, 228000.000000, '{\"84\":\"380\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(104, 53, 32, 54, 1000.000000, 75, 0, NULL, 75000.000000, '{\"78\":\"19\",\"83\":56}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(105, 53, 29, 51, 700.000000, 113, 0, NULL, 79100.000000, '{\"75\":\"5\",\"81\":108}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(106, 53, 30, 48, 472.000000, 87, 0, NULL, 41064.000000, '{\"67\":\"87\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(107, 53, 48, 64, 54.000000, 737, 0, NULL, 39798.000000, '{\"95\":\"10\",\"208\":727}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(108, 53, 42, 57, 800.000000, 5, 0, NULL, 4000.000000, '{\"82\":\"5\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(109, 53, 42, 52, 1500.000000, 7, 0, NULL, 10500.000000, '{\"76\":\"3\",\"228\":4}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(110, 53, 84, 136, 793.000000, 45, 0, NULL, 35685.000000, '{\"205\":\"45\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(111, 53, 45, 50, 1500.000000, 16, 0, NULL, 24000.000000, '{\"71\":\"16\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(112, 53, 45, 50, 1000.000000, 45, 0, NULL, 45000.000000, '{\"71\":\"9\",\"96\":\"1\",\"202\":35}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(113, 53, 44, 74, 1200.000000, 23, 0, NULL, 27600.000000, '{\"106\":\"23\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(114, 53, 84, 137, 550.000000, 11, 0, NULL, 6050.000000, '{\"206\":\"11\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(115, 53, 84, 137, 737.000000, 33, 0, NULL, 24321.000000, '{\"206\":\"33\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(116, 54, 49, 31, 1650.000000, 16, 0, NULL, 26400.000000, '{\"61\":\"16\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(117, 54, 49, 46, 2700.000000, 14, 0, NULL, 37800.000000, '{\"54\":\"14\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(118, 54, 72, 93, 1050.000000, 184, 0, NULL, 193200.000000, '{\"131\":\"159\",\"194\":25,\"218\":0}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(119, 54, 66, 104, 4000.000000, 7, 0, NULL, 28000.000000, '{\"151\":\"7\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(120, 54, 75, 129, 2900.000000, 27, 0, NULL, 78300.000000, '{\"187\":\"27\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(121, 54, 49, 31, 1600.000000, 42, 0, NULL, 67200.000000, '{\"61\":\"16\",\"62\":26}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(122, 54, 38, 44, 1250.000000, 33, 0, NULL, 41250.000000, '{\"49\":\"9\",\"50\":\"2\",\"63\":22}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(123, 54, 38, 44, 1200.000000, 40, 0, NULL, 48000.000000, '{\"63\":\"40\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(124, 54, 75, 96, 1807.000000, 28, 0, NULL, 50596.000000, '{\"138\":\"28\",\"139\":0,\"140\":0,\"176\":0,\"177\":0,\"178\":', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(125, 54, 75, 96, 2409.000000, 6, 0, NULL, 14454.000000, '{\"139\":\"6\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(126, 54, 83, 130, 2100.000000, 12, 0, NULL, 25200.000000, '{\"195\":\"12\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(127, 54, 40, 128, 1300.000000, 24, 0, NULL, 31200.000000, '{\"183\":\"24\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(128, 54, 40, 127, 2000.000000, 28, 0, NULL, 56000.000000, '{\"182\":\"28\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(129, 54, 75, 96, 1250.000000, 5, 0, NULL, 6250.000000, '{\"139\":\"5\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(130, 54, 75, 96, 1750.000000, 7, 0, NULL, 12250.000000, '{\"139\":\"7\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(131, 54, 75, 96, 1600.000000, 4, 0, NULL, 6400.000000, '{\"139\":\"2\",\"140\":2,\"176\":0}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(132, 54, 75, 126, 1800.000000, 8, 0, NULL, 14400.000000, '{\"181\":\"8\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(133, 54, 75, 125, 3900.000000, 2, 0, NULL, 7800.000000, '{\"174\":\"2\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(134, 54, 75, 125, 3600.000000, 2, 0, NULL, 7200.000000, '{\"174\":\"2\",\"175\":0,\"204\":0}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(135, 54, 52, 107, 2600.000000, 10, 0, NULL, 26000.000000, '{\"154\":\"10\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(136, 54, 55, 110, 2500.000000, 12, 0, NULL, 30000.000000, '{\"157\":\"12\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(137, 54, 53, 113, 3300.000000, 12, 0, NULL, 39600.000000, '{\"161\":\"12\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(138, 54, 55, 115, 2700.000000, 8, 0, NULL, 21600.000000, '{\"163\":\"8\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(139, 54, 58, 116, 2750.000000, 5, 0, NULL, 13750.000000, '{\"164\":\"5\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(140, 54, 58, 118, 3550.000000, 8, 0, NULL, 28400.000000, '{\"166\":\"8\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(141, 54, 56, 117, 2800.000000, 12, 0, NULL, 33600.000000, '{\"165\":\"12\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(142, 54, 59, 89, 3400.000000, 11, 0, NULL, 37400.000000, '{\"127\":\"11\",\"147\":0,\"168\":0}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(143, 54, 60, 120, 1550.000000, 7, 0, NULL, 10850.000000, '{\"169\":\"7\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(144, 54, 62, 122, 1750.000000, 8, 0, NULL, 14000.000000, '{\"171\":\"8\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(145, 54, 63, 123, 1900.000000, 8, 0, NULL, 15200.000000, '{\"172\":\"8\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(146, 54, 64, 124, 1250.000000, 10, 0, NULL, 12500.000000, '{\"173\":\"10\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(147, 54, 40, 81, 1700.000000, 15, 0, NULL, 25500.000000, '{\"116\":\"15\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(148, 54, 73, 82, 3100.000000, 6, 0, NULL, 18600.000000, '{\"117\":\"6\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(149, 54, 40, 83, 1295.000000, 11, 0, NULL, 14245.000000, '{\"118\":\"10\",\"150\":1}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(150, 54, 40, 81, 1650.000000, 20, 0, NULL, 33000.000000, '{\"116\":\"20\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(151, 54, 40, 37, 1650.000000, 1, 0, NULL, 1650.000000, '{\"119\":\"1\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(152, 54, 67, 86, 2000.000000, 8, 0, NULL, 16000.000000, '{\"123\":\"8\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(153, 54, 67, 88, 3050.000000, 4, 0, NULL, 12200.000000, '{\"126\":\"4\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(154, 54, 67, 87, 2700.000000, 4, 0, NULL, 10800.000000, '{\"124\":\"4\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(155, 54, 67, 85, 1900.000000, 11, 0, NULL, 20900.000000, '{\"122\":\"11\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(156, 54, 67, 84, 1500.000000, 30, 0, NULL, 45000.000000, '{\"121\":\"30\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(157, 54, 57, 103, 2850.000000, 16, 0, NULL, 45600.000000, '{\"148\":\"16\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(158, 54, 79, 98, 2950.000000, 10, 0, NULL, 29500.000000, '{\"142\":\"10\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(159, 54, 77, 97, 3250.000000, 12, 0, NULL, 39000.000000, '{\"141\":\"12\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(160, 54, 78, 99, 3000.000000, 9, 0, NULL, 27000.000000, '{\"143\":\"9\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(161, 54, 59, 89, 3200.000000, 22, 0, NULL, 70400.000000, '{\"147\":\"11\",\"168\":11}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(162, 54, 55, 102, 2850.000000, 8, 0, NULL, 22800.000000, '{\"146\":\"8\",\"149\":0,\"160\":0}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(163, 54, 55, 101, 2850.000000, 8, 0, NULL, 22800.000000, '{\"145\":\"8\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(164, 54, 74, 94, 2100.000000, 18, 0, NULL, 37800.000000, '{\"132\":\"18\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(165, 54, 75, 96, 1100.000000, 75, 0, NULL, 82500.000000, '{\"140\":\"2\",\"176\":\"6\",\"177\":\"4\",\"178\":\"8\",\"179\":\"5\"', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(166, 54, 75, 96, 1300.000000, 24, 0, NULL, 31200.000000, '{\"190\":\"8\",\"191\":\"4\",\"192\":\"8\",\"193\":4,\"203\":0}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(167, 54, 75, 96, 1800.000000, 12, 0, NULL, 21600.000000, '{\"203\":\"6\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(168, 54, 75, 96, 1500.000000, 4, 0, NULL, 6000.000000, '[]', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(169, 54, 75, 96, 1450.000000, 12, 0, NULL, 17400.000000, '[]', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(170, 54, 75, 96, 1700.000000, 12, 0, NULL, 20400.000000, '[]', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(171, 55, 55, 100, 3000.000000, 8, 0, NULL, 24000.000000, '{\"144\":\"8\"}', '2018-02-06 11:06:26', '2018-02-06 11:06:26'),
(172, 55, 55, 102, 2900.000000, 8, 0, NULL, 23200.000000, '{\"149\":\"8\",\"160\":0}', '2018-02-06 11:06:26', '2018-02-06 11:06:26'),
(173, 55, 53, 108, 3150.000000, 12, 0, NULL, 37800.000000, '{\"155\":\"12\"}', '2018-02-06 11:06:26', '2018-02-06 11:06:26'),
(174, 55, 53, 90, 3200.000000, 11, 0, NULL, 35200.000000, '{\"128\":\"11\"}', '2018-02-06 11:06:26', '2018-02-06 11:06:26'),
(175, 55, 58, 91, 2550.000000, 8, 0, NULL, 20400.000000, '{\"129\":\"8\"}', '2018-02-06 11:06:26', '2018-02-06 11:06:26'),
(176, 56, 44, 75, 471.000000, 110, 0, NULL, 51810.000000, '{\"107\":\"110\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(177, 56, 44, 73, 310.000000, 222, 0, NULL, 68820.000000, '{\"105\":\"222\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(178, 56, 44, 73, 200.000000, 8, 0, NULL, 1600.000000, '{\"105\":\"8\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(179, 56, 28, 32, 1000.000000, 466, 0, NULL, 466000.000000, '{\"36\":\"2\",\"57\":\"320\",\"73\":144,\"87\":0}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(180, 56, 28, 34, 1100.000000, 24, 0, NULL, 26400.000000, '{\"37\":\"24\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(181, 56, 28, 33, 1100.000000, 80, 0, NULL, 88000.000000, '{\"72\":\"80\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(182, 56, 35, 45, 1250.000000, 23, 0, NULL, 28750.000000, '{\"52\":\"23\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(183, 56, 81, 105, 300.000000, 8, 0, NULL, 2400.000000, '{\"152\":\"8\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(184, 56, 82, 106, 500.000000, 2, 0, NULL, 1000.000000, '{\"153\":\"2\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(185, 56, 86, 140, 200.000000, 103, 0, NULL, 20600.000000, '{\"226\":\"103\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(186, 56, 28, 39, 400.000000, 28, 0, NULL, 11200.000000, '{\"42\":\"28\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(187, 56, 42, 57, 514.000000, 39, 0, NULL, 20046.000000, '{\"82\":\"39\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(188, 56, 45, 50, 1100.000000, 63, 0, NULL, 69300.000000, '{\"202\":\"53\",\"233\":10}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(189, 56, 45, 49, 1800.000000, 9, 0, NULL, 16200.000000, '{\"70\":\"9\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(190, 56, 51, 60, 25.000000, 53, 0, NULL, 1325.000000, '{\"88\":\"53\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(191, 56, 51, 60, 40.000000, 41, 0, NULL, 1640.000000, '{\"88\":\"19\",\"89\":22}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(192, 56, 51, 60, 50.000000, 29, 0, NULL, 1450.000000, '{\"89\":\"29\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(193, 56, 51, 61, 17.000000, 150, 0, NULL, 2550.000000, '{\"91\":\"150\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(194, 56, 51, 62, 10.000000, 290, 0, NULL, 2900.000000, '{\"93\":\"290\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(195, 57, 28, 36, 800.000000, 7, 0, NULL, 5600.000000, '{\"39\":\"7\"}', '2018-02-06 14:10:38', '2018-02-06 14:10:38'),
(196, 58, 28, 34, 1400.000000, 2, 0, NULL, 2800.000000, '{\"37\":\"2\"}', '2018-02-06 14:15:06', '2018-02-06 14:15:06'),
(197, 58, 28, 32, 1300.000000, 3, 0, NULL, 3900.000000, '{\"73\":\"3\"}', '2018-02-06 14:15:06', '2018-02-06 14:15:06'),
(198, 59, 28, 34, 1400.000000, 4, 0, NULL, 5600.000000, '{\"37\":\"4\"}', '2018-02-06 14:17:32', '2018-02-06 14:17:33'),
(199, 60, 28, 34, 1400.000000, 2, 0, NULL, 2800.000000, '{\"37\":\"2\"}', '2018-02-06 14:20:00', '2018-02-06 14:20:00'),
(200, 61, 42, 57, 800.000000, 5, 0, NULL, 4000.000000, '{\"82\":\"5\"}', '2018-02-06 14:36:11', '2018-02-06 14:36:11'),
(201, 61, 28, 32, 1300.000000, 12, 0, NULL, 15600.000000, '{\"73\":\"12\"}', '2018-02-06 14:36:11', '2018-02-06 14:36:11'),
(202, 61, 42, 52, 1000.000000, 1, 0, NULL, 1000.000000, '{\"228\":\"1\"}', '2018-02-06 14:36:11', '2018-02-06 14:36:11'),
(203, 61, 32, 58, 850.000000, 3, 0, NULL, 2550.000000, '{\"84\":\"3\"}', '2018-02-06 14:36:11', '2018-02-06 14:36:11'),
(204, 61, 31, 47, 400.000000, 8, 0, NULL, 3200.000000, '{\"216\":\"8\"}', '2018-02-06 14:36:11', '2018-02-06 14:36:11'),
(205, 62, 28, 34, 1400.000000, 5, 0, 20, 6900.000000, '{\"37\":\"5\"}', '2018-02-06 14:46:29', '2018-02-06 14:46:29'),
(206, 62, 28, 32, 1300.000000, 2, 0, NULL, 2600.000000, '{\"73\":\"2\"}', '2018-02-06 14:46:29', '2018-02-06 14:46:29'),
(207, 62, 40, 83, 1400.000000, 5, 0, NULL, 7000.000000, '{\"150\":\"5\"}', '2018-02-06 14:46:29', '2018-02-06 14:46:29'),
(208, 63, 39, 76, 400.000000, 3, 0, NULL, 1200.000000, '{\"221\":\"3\"}', '2018-02-06 15:00:31', '2018-02-06 15:00:32'),
(209, 63, 27, 69, 250.000000, 1, 0, NULL, 250.000000, '{\"101\":\"1\"}', '2018-02-06 15:00:32', '2018-02-06 15:00:32'),
(210, 63, 67, 87, 3200.000000, 1, 0, NULL, 3200.000000, '{\"124\":\"1\"}', '2018-02-06 15:00:32', '2018-02-06 15:00:32'),
(211, 63, 40, 83, 1500.000000, 1, 0, NULL, 1500.000000, '{\"150\":\"1\"}', '2018-02-06 15:00:32', '2018-02-06 15:00:32'),
(212, 63, 73, 82, 3400.000000, 5, 0, NULL, 17000.000000, '{\"117\":\"4\",\"125\":1}', '2018-02-06 15:00:32', '2018-02-06 15:00:32'),
(213, 64, 73, 82, 3300.000000, 6, 0, NULL, 19800.000000, '{\"125\":\"6\"}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(214, 64, 67, 85, 2100.000000, 11, 0, NULL, 23100.000000, '{\"122\":\"11\"}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(215, 64, 67, 84, 1700.000000, 9, 0, NULL, 15300.000000, '{\"121\":\"9\"}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(216, 64, 39, 76, 350.000000, 37, 0, NULL, 12950.000000, '{\"221\":\"37\"}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(217, 64, 39, 41, 300.000000, 35, 0, NULL, 10500.000000, '{\"44\":\"7\",\"108\":28}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(218, 64, 43, 78, 350.000000, 37, 0, 16, 12358.000000, '{\"111\":\"37\"}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(219, 64, 27, 70, 250.000000, 32, 0, NULL, 8000.000000, '{\"102\":\"13\",\"220\":19}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(220, 64, 28, 32, 1300.000000, 8, 0, NULL, 10400.000000, '{\"73\":\"8\"}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(221, 64, 28, 34, 1400.000000, 2, 0, NULL, 2800.000000, '{\"37\":\"2\"}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(222, 65, 28, 34, 1400.000000, 2, 0, NULL, 2800.000000, '{\"37\":\"2\"}', '2018-02-06 15:57:12', '2018-02-06 15:57:12'),
(223, 65, 28, 32, 1300.000000, 3, 0, NULL, 3900.000000, '{\"73\":\"3\"}', '2018-02-06 15:57:12', '2018-02-06 15:57:12'),
(224, 65, 28, 33, 1400.000000, 1, 0, NULL, 1400.000000, '{\"72\":\"1\"}', '2018-02-06 15:57:12', '2018-02-06 15:57:12'),
(225, 65, 67, 87, 2850.000000, 2, 0, NULL, 5700.000000, '{\"124\":\"2\"}', '2018-02-06 15:57:12', '2018-02-06 15:57:12'),
(226, 66, 72, 93, 1150.000000, 12, 0, NULL, 13800.000000, '{\"194\":\"12\"}', '2018-02-06 15:59:50', '2018-02-06 15:59:50'),
(227, 67, 28, 32, 1300.000000, 3, 0, NULL, 3900.000000, '{\"73\":\"3\"}', '2018-02-06 16:01:43', '2018-02-06 16:01:43'),
(228, 67, 28, 34, 1400.000000, 3, 0, NULL, 4200.000000, '{\"37\":\"3\"}', '2018-02-06 16:01:43', '2018-02-06 16:01:43'),
(229, 68, 27, 31, 120.000000, 8, 0, NULL, 960.000000, '{\"219\":\"8\"}', '2018-02-06 16:07:23', '2018-02-06 16:07:23'),
(230, 68, 27, 31, 180.000000, 4, 0, NULL, 720.000000, '{\"219\":\"4\"}', '2018-02-06 16:07:23', '2018-02-06 16:07:23'),
(231, 68, 39, 76, 400.000000, 2, 0, 15, 770.000000, '{\"221\":\"2\"}', '2018-02-06 16:07:23', '2018-02-06 16:07:23'),
(232, 68, 27, 68, 350.000000, 3, 0, NULL, 1050.000000, '{\"100\":\"3\"}', '2018-02-06 16:07:23', '2018-02-06 16:07:23'),
(233, 68, 28, 34, 1400.000000, 1, 0, NULL, 1400.000000, '{\"37\":\"1\"}', '2018-02-06 16:07:23', '2018-02-06 16:07:23'),
(234, 69, 27, 31, 100.000000, 26, 0, NULL, 2600.000000, '{\"219\":\"26\"}', '2018-02-06 16:09:32', '2018-02-06 16:09:32'),
(235, 70, 28, 32, 1300.000000, 6, 0, NULL, 7800.000000, '{\"73\":\"6\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(236, 70, 72, 93, 1150.000000, 6, 0, NULL, 6900.000000, '{\"194\":\"6\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(237, 70, 28, 39, 800.000000, 3, 0, NULL, 2400.000000, '{\"42\":\"3\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(238, 70, 31, 47, 400.000000, 5, 0, NULL, 2000.000000, '{\"216\":\"5\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(239, 70, 33, 80, 350.000000, 2, 0, NULL, 700.000000, '{\"114\":\"2\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(240, 70, 35, 59, 1500.000000, 6, 0, NULL, 9000.000000, '{\"85\":\"6\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(241, 70, 39, 41, 350.000000, 6, 0, NULL, 2100.000000, '{\"108\":\"6\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(242, 70, 43, 77, 450.000000, 7, 0, NULL, 3150.000000, '{\"110\":\"7\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(243, 70, 27, 31, 130.000000, 13, 0, NULL, 1690.000000, '{\"219\":\"13\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(244, 70, 27, 70, 250.000000, 8, 0, NULL, 2000.000000, '{\"220\":\"8\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(245, 70, 27, 67, 270.000000, 19, 0, NULL, 5130.000000, '{\"99\":\"19\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(246, 70, 48, 64, 80.000000, 23, 0, NULL, 1840.000000, '{\"208\":\"23\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(247, 70, 48, 64, 150.000000, 5, 0, NULL, 750.000000, '{\"208\":\"5\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(248, 70, 48, 64, 130.000000, 10, 0, NULL, 1300.000000, '{\"208\":\"10\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(249, 70, 27, 31, 150.000000, 4, 0, NULL, 600.000000, '{\"219\":\"4\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(250, 71, 72, 93, 1200.000000, 3, 0, NULL, 3600.000000, '{\"194\":\"3\"}', '2018-02-06 16:31:48', '2018-02-06 16:31:48'),
(251, 71, 75, 126, 1350.000000, 2, 0, NULL, 2700.000000, '{\"181\":\"2\"}', '2018-02-06 16:31:48', '2018-02-06 16:31:48'),
(252, 71, 75, 126, 1400.000000, 1, 0, NULL, 1400.000000, '{\"181\":\"1\"}', '2018-02-06 16:31:48', '2018-02-06 16:31:48'),
(253, 72, 28, 34, 1400.000000, 1, 0, NULL, 1400.000000, '{\"37\":\"1\",\"58\":0}', '2018-02-06 16:34:30', '2018-02-06 16:34:30'),
(254, 72, 38, 44, 1250.000000, 5, 0, NULL, 6250.000000, '{\"63\":\"4\",\"64\":1}', '2018-02-06 16:34:30', '2018-02-06 16:34:30'),
(255, 73, 76, 95, 1250.000000, 3, 0, NULL, 3750.000000, '{\"133\":\"3\"}', '2018-02-06 16:37:39', '2018-02-06 16:37:39'),
(256, 73, 76, 95, 1400.000000, 1, 0, NULL, 1400.000000, '{\"133\":\"1\"}', '2018-02-06 16:37:39', '2018-02-06 16:37:39'),
(257, 74, 76, 95, 1300.000000, 2, 0, NULL, 2600.000000, '{\"133\":\"2\"}', '2018-02-06 16:40:14', '2018-02-06 16:40:14'),
(258, 74, 76, 95, 1400.000000, 2, 0, NULL, 2800.000000, '{\"133\":\"2\"}', '2018-02-06 16:40:14', '2018-02-06 16:40:14'),
(259, 75, 31, 47, 350.000000, 7, 0, NULL, 2450.000000, '{\"216\":\"7\"}', '2018-02-06 16:42:20', '2018-02-06 16:42:20'),
(260, 76, 27, 31, 110.000000, 13, 0, NULL, 1430.000000, '{\"219\":\"13\"}', '2018-02-06 16:44:57', '2018-02-06 16:44:57'),
(261, 76, 27, 69, 175.000000, 2, 0, NULL, 350.000000, '{\"101\":\"2\"}', '2018-02-06 16:44:57', '2018-02-06 16:44:57'),
(262, 77, 43, 78, 450.000000, 2, 0, NULL, 900.000000, '{\"111\":\"2\"}', '2018-02-06 16:49:44', '2018-02-06 16:49:44'),
(263, 78, 27, 31, 120.000000, 4, 0, NULL, 480.000000, '{\"219\":\"4\"}', '2018-02-06 16:52:04', '2018-02-06 16:52:04'),
(264, 78, 27, 70, 270.000000, 1, 0, NULL, 270.000000, '{\"220\":\"1\"}', '2018-02-06 16:52:04', '2018-02-06 16:52:04'),
(265, 79, 72, 93, 1140.000000, 5, 0, NULL, 5700.000000, '{\"194\":\"5\"}', '2018-02-06 16:53:58', '2018-02-06 16:53:58'),
(266, 80, 49, 31, 1800.000000, 5, 0, NULL, 9000.000000, '{\"62\":\"5\"}', '2018-02-06 16:56:09', '2018-02-06 16:56:09'),
(267, 80, 38, 44, 1400.000000, 2, 0, NULL, 2800.000000, '{\"64\":\"2\"}', '2018-02-06 16:56:09', '2018-02-06 16:56:09'),
(268, 81, 28, 39, 750.000000, 49, 0, NULL, 36750.000000, '{\"42\":\"35\",\"65\":14}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(269, 81, 28, 39, 900.000000, 5, 0, NULL, 4500.000000, '{\"65\":\"5\"}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(270, 81, 51, 60, 100.000000, 31, 0, NULL, 3100.000000, '{\"89\":\"31\"}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(271, 81, 51, 60, 80.000000, 24, 0, NULL, 1920.000000, '{\"89\":\"6\",\"90\":18}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(272, 81, 51, 60, 50.000000, 28, 0, NULL, 1400.000000, '{\"90\":\"28\"}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(273, 81, 39, 76, 350.000000, 14, 0, NULL, 4900.000000, '{\"221\":\"14\"}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(274, 81, 27, 31, 400.000000, 4, 0, NULL, 1600.000000, '{\"219\":\"4\"}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(275, 81, 31, 47, 800.000000, 24, 0, NULL, 19200.000000, '{\"216\":\"24\"}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(276, 81, 32, 54, 1200.000000, 6, 0, NULL, 7200.000000, '{\"83\":\"6\"}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(277, 82, 27, 70, 270.000000, 7, 0, NULL, 1890.000000, '{\"220\":\"7\"}', '2018-02-06 17:12:21', '2018-02-06 17:12:21'),
(278, 82, 27, 31, 120.000000, 12, 0, NULL, 1440.000000, '{\"219\":\"12\"}', '2018-02-06 17:12:21', '2018-02-06 17:12:21'),
(279, 83, 35, 31, 1500.000000, 1, 0, NULL, 1500.000000, '{\"53\":\"1\"}', '2018-02-06 17:14:51', '2018-02-06 17:14:51'),
(280, 83, 35, 59, 1800.000000, 4, 0, NULL, 7200.000000, '{\"85\":\"4\"}', '2018-02-06 17:14:51', '2018-02-06 17:14:51'),
(281, 84, 28, 32, 1300.000000, 60, 0, NULL, 78000.000000, '{\"73\":\"60\"}', '2018-02-06 17:19:15', '2018-02-06 17:19:15'),
(282, 84, 28, 34, 1500.000000, 20, 0, NULL, 30000.000000, '{\"58\":\"20\"}', '2018-02-06 17:19:15', '2018-02-06 17:19:15'),
(283, 84, 28, 33, 1400.000000, 50, 0, NULL, 70000.000000, '{\"72\":\"50\"}', '2018-02-06 17:19:15', '2018-02-06 17:19:15'),
(284, 84, 30, 40, 800.000000, 10, 0, NULL, 8000.000000, '{\"43\":\"10\"}', '2018-02-06 17:19:15', '2018-02-06 17:19:15'),
(285, 85, 28, 32, 1300.000000, 2, 0, NULL, 2600.000000, '{\"73\":\"2\"}', '2018-02-06 18:06:12', '2018-02-06 18:06:12'),
(286, 85, 28, 39, 700.000000, 2, 0, NULL, 1400.000000, '{\"65\":\"2\"}', '2018-02-06 18:06:12', '2018-02-06 18:06:12'),
(287, 85, 84, 137, 750.000000, 2, 0, NULL, 1500.000000, '{\"206\":\"2\"}', '2018-02-06 18:06:12', '2018-02-06 18:06:12'),
(288, 85, 28, 34, 1400.000000, 8, 0, 25, 11000.000000, '{\"58\":\"8\"}', '2018-02-06 18:06:12', '2018-02-06 18:06:12'),
(289, 86, 43, 78, 350.000000, 1, 0, NULL, 350.000000, '{\"111\":\"1\"}', '2018-02-06 18:08:02', '2018-02-06 18:08:02'),
(290, 87, 28, 39, 800.000000, 5, 0, NULL, 4000.000000, '{\"65\":\"5\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(291, 87, 28, 34, 1400.000000, 10, 0, NULL, 14000.000000, '{\"58\":\"10\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(292, 87, 28, 32, 1300.000000, 6, 0, NULL, 7800.000000, '{\"73\":\"6\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(293, 87, 43, 77, 425.000000, 12, 0, NULL, 5100.000000, '{\"110\":\"12\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(294, 87, 43, 77, 700.000000, 10, 0, NULL, 7000.000000, '{\"110\":\"10\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(295, 87, 43, 78, 325.000000, 8, 0, NULL, 2600.000000, '{\"111\":\"8\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(296, 87, 39, 76, 350.000000, 30, 0, NULL, 10500.000000, '{\"221\":\"30\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(297, 87, 27, 70, 270.000000, 30, 0, NULL, 8100.000000, '{\"220\":\"30\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(298, 87, 27, 70, 220.000000, 15, 0, NULL, 3300.000000, '{\"220\":\"15\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(299, 87, 27, 31, 120.000000, 20, 0, NULL, 2400.000000, '{\"219\":\"20\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(300, 87, 44, 75, 800.000000, 3, 0, NULL, 2400.000000, '{\"107\":\"3\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(301, 87, 44, 73, 400.000000, 10, 0, NULL, 4000.000000, '{\"105\":\"10\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(302, 87, 76, 95, 1250.000000, 3, 0, NULL, 3750.000000, '{\"133\":\"3\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(303, 87, 72, 93, 1150.000000, 7, 0, NULL, 8050.000000, '{\"194\":\"7\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(304, 87, 38, 44, 1300.000000, 4, 0, NULL, 5200.000000, '{\"64\":\"4\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(305, 87, 76, 95, 1600.000000, 6, 0, NULL, 9600.000000, '{\"133\":\"6\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(306, 87, 76, 95, 2000.000000, 1, 0, NULL, 2000.000000, '{\"133\":\"1\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(307, 87, 57, 103, 2800.000000, 1, 0, NULL, 2800.000000, '{\"148\":\"1\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(308, 87, 49, 46, 2800.000000, 1, 0, NULL, 2800.000000, '{\"54\":\"1\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(309, 87, 51, 61, 50.000000, 14, 0, NULL, 700.000000, '{\"91\":\"14\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(310, 88, 45, 50, 1400.000000, 24, 0, NULL, 33600.000000, '{\"233\":\"24\"}', '2018-02-06 18:42:49', '2018-02-06 18:42:49'),
(311, 88, 31, 47, 750.000000, 42, 0, NULL, 31500.000000, '{\"216\":\"42\"}', '2018-02-06 18:42:49', '2018-02-06 18:42:49'),
(312, 88, 28, 33, 1400.000000, 3, 0, NULL, 4200.000000, '{\"72\":\"3\"}', '2018-02-06 18:42:49', '2018-02-06 18:42:49'),
(313, 88, 33, 80, 300.000000, 30, 0, NULL, 9000.000000, '{\"114\":\"30\"}', '2018-02-06 18:42:49', '2018-02-06 18:42:49'),
(314, 89, 28, 34, 1400.000000, 1, 0, NULL, 1400.000000, '{\"58\":\"1\"}', '2018-02-06 18:46:25', '2018-02-06 18:46:25'),
(315, 89, 28, 32, 1300.000000, 2, 0, 25, 2550.000000, '{\"73\":\"2\"}', '2018-02-06 18:46:25', '2018-02-06 18:46:25'),
(316, 90, 39, 76, 350.000000, 4, 0, NULL, 1400.000000, '{\"221\":\"4\"}', '2018-02-06 18:50:59', '2018-02-06 18:50:59'),
(317, 90, 27, 31, 120.000000, 1, 0, NULL, 120.000000, '{\"219\":\"1\"}', '2018-02-06 18:50:59', '2018-02-06 18:50:59'),
(318, 90, 28, 32, 1300.000000, 2, 0, NULL, 2600.000000, '{\"73\":\"2\"}', '2018-02-06 18:50:59', '2018-02-06 18:50:59'),
(319, 91, 44, 75, 750.000000, 2, 0, NULL, 1500.000000, '{\"107\":\"2\"}', '2018-02-07 11:19:41', '2018-02-07 11:19:41'),
(320, 91, 45, 50, 2000.000000, 1, 0, 100, 1900.000000, '{\"233\":\"1\"}', '2018-02-07 11:19:41', '2018-02-07 11:19:41'),
(321, 92, 28, 39, 700.000000, 2, 0, NULL, 1400.000000, '{\"65\":\"2\"}', '2018-02-07 11:25:43', '2018-02-07 11:25:43'),
(322, 92, 28, 34, 1400.000000, 1, 0, NULL, 1400.000000, '{\"58\":\"1\"}', '2018-02-07 11:25:43', '2018-02-07 11:25:43'),
(323, 92, 40, 83, 1400.000000, 1, 0, NULL, 1400.000000, '{\"150\":\"1\"}', '2018-02-07 11:25:43', '2018-02-07 11:25:43'),
(324, 93, 39, 76, 400.000000, 0, 0, NULL, 0.000000, '{\"221\":\"0\"}', '2018-02-07 11:52:18', '2018-02-07 15:17:57'),
(325, 93, 28, 32, 1300.000000, 0, 0, NULL, 0.000000, '{\"73\":\"0\"}', '2018-02-07 11:52:18', '2018-02-07 15:17:57'),
(326, 93, 28, 34, 1400.000000, 0, 0, NULL, 0.000000, '{\"58\":\"0\"}', '2018-02-07 11:52:18', '2018-02-07 15:17:57'),
(327, 93, 28, 33, 2000.000000, 0, 0, 0, 0.000000, '{\"72\":\"0\"}', '2018-02-07 11:52:18', '2018-02-07 15:17:57'),
(328, 94, 28, 32, 1300.000000, 0, 0, NULL, 0.000000, '{\"73\":\"0\"}', '2018-02-07 11:57:23', '2018-02-07 15:18:54'),
(329, 94, 28, 34, 1400.000000, 0, 0, NULL, 0.000000, '{\"58\":\"0\"}', '2018-02-07 11:57:23', '2018-02-07 15:18:54'),
(330, 94, 39, 76, 400.000000, 0, 0, NULL, 0.000000, '{\"221\":\"0\"}', '2018-02-07 11:57:23', '2018-02-07 15:18:54'),
(331, 94, 43, 77, 450.000000, 0, 0, NULL, 0.000000, '{\"110\":\"0\"}', '2018-02-07 11:57:23', '2018-02-07 15:18:54'),
(332, 95, 27, 31, 100.000000, 390, 0, NULL, 39000.000000, '{\"219\":\"390\"}', '2018-02-07 12:04:20', '2018-02-07 12:04:20'),
(333, 95, 27, 70, 200.000000, 4, 0, NULL, 800.000000, '{\"220\":\"4\"}', '2018-02-07 12:04:20', '2018-02-07 12:04:20'),
(334, 95, 39, 41, 200.000000, 32, 0, NULL, 6400.000000, '{\"108\":\"32\"}', '2018-02-07 12:04:20', '2018-02-07 12:04:20'),
(335, 95, 48, 64, 50.000000, 18, 0, NULL, 900.000000, '{\"208\":\"18\"}', '2018-02-07 12:04:20', '2018-02-07 12:04:20'),
(336, 95, 27, 31, 250.000000, 12, 0, NULL, 3000.000000, '{\"219\":\"12\"}', '2018-02-07 12:04:20', '2018-02-07 12:04:20'),
(337, 96, 32, 58, 800.000000, 10, 0, 11, 7890.000000, '{\"84\":\"10\"}', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(338, 96, 29, 51, 850.000000, 5, 0, NULL, 4250.000000, '{\"81\":\"5\"}', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(339, 96, 29, 51, 750.000000, 6, 0, NULL, 4500.000000, '{\"81\":\"6\"}', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(340, 96, 28, 32, 1300.000000, 2, 0, NULL, 2600.000000, '{\"73\":\"2\"}', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(341, 96, 28, 34, 1400.000000, 4, 0, NULL, 5600.000000, '{\"58\":\"4\"}', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(342, 96, 36, 138, 850.000000, 2, 0, NULL, 1700.000000, '{\"209\":\"2\"}', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(343, 96, 27, 70, 220.000000, 13, 0, NULL, 2860.000000, '{\"220\":\"13\"}', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(344, 96, 43, 77, 420.000000, 5, 0, NULL, 2100.000000, '{\"110\":\"5\"}', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(345, 97, 27, 70, 200.000000, 51, 0, NULL, 10200.000000, '{\"220\":\"51\"}', '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(346, 97, 43, 77, 350.000000, 14, 0, NULL, 4900.000000, '{\"110\":\"14\"}', '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(347, 97, 27, 69, 150.000000, 39, 0, NULL, 5850.000000, '{\"101\":\"39\"}', '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(348, 97, 27, 68, 250.000000, 20, 0, NULL, 5000.000000, '{\"100\":\"20\"}', '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(349, 97, 28, 32, 1000.000000, 12, 0, NULL, 12000.000000, '{\"73\":\"12\"}', '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(350, 97, 48, 64, 50.000000, 44, 0, NULL, 2200.000000, '{\"208\":\"44\"}', '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(351, 97, 27, 31, 100.000000, 24, 0, NULL, 2400.000000, '{\"219\":\"24\"}', '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(352, 98, 32, 58, 800.000000, 6, 0, NULL, 4800.000000, '{\"84\":\"6\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(353, 98, 32, 58, 700.000000, 5, 0, NULL, 3500.000000, '{\"84\":\"5\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(354, 98, 29, 51, 850.000000, 6, 0, NULL, 5100.000000, '{\"81\":\"6\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(355, 98, 84, 137, 400.000000, 9, 0, NULL, 3600.000000, '{\"206\":\"9\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(356, 98, 39, 41, 300.000000, 10, 0, NULL, 3000.000000, '{\"108\":\"10\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(357, 98, 43, 77, 700.000000, 5, 0, NULL, 3500.000000, '{\"110\":\"5\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(358, 98, 43, 77, 450.000000, 10, 0, NULL, 4500.000000, '{\"110\":\"3\",\"222\":7}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(359, 98, 27, 31, 350.000000, 5, 0, NULL, 1750.000000, '{\"219\":\"5\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(360, 98, 28, 33, 2000.000000, 2, 0, 100, 3800.000000, '{\"72\":\"2\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(361, 98, 28, 33, 1250.000000, 3, 0, NULL, 3750.000000, '{\"72\":\"3\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(362, 99, 28, 32, 1300.000000, 5, 0, 20, 6400.000000, '{\"73\":\"5\"}', '2018-02-07 13:02:18', '2018-02-07 13:02:18'),
(363, 99, 28, 34, 1400.000000, 5, 0, 20, 6900.000000, '{\"58\":\"3\",\"74\":2}', '2018-02-07 13:02:18', '2018-02-07 13:02:18'),
(364, 99, 28, 33, 1400.000000, 2, 0, 50, 2700.000000, '{\"72\":\"2\"}', '2018-02-07 13:02:18', '2018-02-07 13:02:18'),
(365, 100, 27, 31, 250.000000, 55, 0, NULL, 13750.000000, '{\"219\":\"55\"}', '2018-02-07 13:05:44', '2018-02-07 15:14:00'),
(366, 100, 29, 51, 750.000000, 3, 0, NULL, 2250.000000, '{\"81\":\"3\",\"225\":0}', '2018-02-07 13:05:44', '2018-02-07 15:14:00'),
(367, 100, 29, 51, 650.000000, 0, 0, NULL, 0.000000, '{\"81\":\"0\"}', '2018-02-07 13:05:44', '2018-02-07 15:14:00'),
(368, 101, 28, 36, 600.000000, 9, 0, NULL, 5400.000000, '{\"39\":\"3\",\"55\":6}', '2018-02-07 13:41:32', '2018-02-07 13:41:32'),
(369, 101, 28, 35, 600.000000, 4, 0, NULL, 2400.000000, '{\"38\":\"4\"}', '2018-02-07 13:41:32', '2018-02-07 13:41:32'),
(370, 101, 28, 39, 550.000000, 6, 0, NULL, 3300.000000, '{\"65\":\"6\"}', '2018-02-07 13:41:32', '2018-02-07 13:41:32'),
(371, 101, 28, 33, 1050.000000, 10, 0, NULL, 10500.000000, '{\"72\":\"10\"}', '2018-02-07 13:41:32', '2018-02-07 13:41:32'),
(372, 101, 28, 34, 1100.000000, 5, 0, NULL, 5500.000000, '{\"74\":\"5\"}', '2018-02-07 13:41:32', '2018-02-07 13:41:32'),
(373, 101, 30, 40, 550.000000, 5, 0, NULL, 2750.000000, '{\"43\":\"3\",\"69\":2}', '2018-02-07 13:41:32', '2018-02-07 13:41:32'),
(374, 102, 28, 36, 900.000000, 2, 0, NULL, 1800.000000, '{\"55\":\"2\"}', '2018-02-07 13:44:23', '2018-02-07 13:44:23'),
(375, 102, 27, 31, 220.000000, 2, 0, NULL, 440.000000, '{\"219\":\"2\"}', '2018-02-07 13:44:23', '2018-02-07 13:44:23'),
(376, 102, 27, 31, 110.000000, 14, 0, NULL, 1540.000000, '{\"219\":\"14\"}', '2018-02-07 13:44:23', '2018-02-07 13:44:23'),
(377, 103, 28, 34, 1400.000000, 4, 0, NULL, 5600.000000, '{\"74\":\"4\"}', '2018-02-07 13:46:14', '2018-02-07 13:46:14'),
(378, 104, 28, 33, 1400.000000, 17, 0, NULL, 23800.000000, '{\"72\":\"17\"}', '2018-02-07 13:50:02', '2018-02-07 13:50:02'),
(379, 104, 29, 51, 800.000000, 6, 0, NULL, 4800.000000, '{\"81\":\"6\"}', '2018-02-07 13:50:02', '2018-02-07 13:50:02'),
(380, 104, 28, 37, 800.000000, 4, 0, NULL, 3200.000000, '{\"40\":\"4\"}', '2018-02-07 13:50:02', '2018-02-07 13:50:02'),
(381, 105, 39, 76, 350.000000, 26, 0, NULL, 9100.000000, '{\"221\":\"26\"}', '2018-02-07 13:52:23', '2018-02-07 13:52:23'),
(382, 106, 27, 31, 100.000000, 25, 0, NULL, 2500.000000, '{\"219\":\"25\"}', '2018-02-07 13:58:18', '2018-02-07 13:58:18'),
(383, 106, 27, 31, 250.000000, 18, 0, NULL, 4500.000000, '{\"219\":\"18\"}', '2018-02-07 13:58:18', '2018-02-07 13:58:18'),
(384, 106, 27, 31, 140.000000, 140, 0, NULL, 19600.000000, '{\"219\":\"140\"}', '2018-02-07 13:58:18', '2018-02-07 13:58:18'),
(385, 106, 28, 34, 1100.000000, 12, 0, NULL, 13200.000000, '{\"74\":\"12\"}', '2018-02-07 13:58:18', '2018-02-07 13:58:18'),
(386, 106, 28, 32, 1000.000000, 28, 0, NULL, 28000.000000, '{\"73\":\"21\",\"87\":7}', '2018-02-07 13:58:18', '2018-02-07 13:58:18'),
(387, 107, 43, 77, 450.000000, 1, 0, NULL, 450.000000, '{\"222\":\"1\"}', '2018-02-07 14:05:51', '2018-02-07 14:05:51'),
(388, 107, 39, 76, 350.000000, 2, 0, NULL, 700.000000, '{\"221\":\"2\"}', '2018-02-07 14:05:51', '2018-02-07 14:05:51'),
(389, 107, 27, 31, 155.000000, 2, 0, NULL, 310.000000, '{\"219\":\"2\"}', '2018-02-07 14:05:51', '2018-02-07 14:05:51'),
(390, 108, 27, 31, 130.000000, 13, 0, NULL, 1690.000000, '{\"219\":\"13\"}', '2018-02-07 14:09:35', '2018-02-07 14:09:35'),
(391, 108, 27, 31, 200.000000, 1, 0, NULL, 200.000000, '{\"219\":\"1\"}', '2018-02-07 14:09:35', '2018-02-07 14:09:35'),
(392, 108, 27, 31, 110.000000, 11, 0, NULL, 1210.000000, '{\"219\":\"11\"}', '2018-02-07 14:09:35', '2018-02-07 14:09:35'),
(393, 108, 27, 31, 120.000000, 4, 0, NULL, 480.000000, '{\"219\":\"4\"}', '2018-02-07 14:09:35', '2018-02-07 14:09:35'),
(394, 108, 28, 32, 1300.000000, 1, 0, NULL, 1300.000000, '{\"87\":\"1\"}', '2018-02-07 14:09:35', '2018-02-07 14:09:35'),
(395, 108, 28, 34, 1400.000000, 1, 0, NULL, 1400.000000, '{\"74\":\"1\"}', '2018-02-07 14:09:35', '2018-02-07 14:09:35'),
(396, 109, 28, 35, 1200.000000, 5, 0, NULL, 6000.000000, '{\"38\":\"5\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(397, 109, 28, 35, 1300.000000, 4, 0, NULL, 5200.000000, '{\"38\":\"4\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(398, 109, 28, 35, 1400.000000, 11, 0, NULL, 15400.000000, '{\"38\":\"11\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(399, 109, 28, 39, 780.000000, 8, 0, NULL, 6240.000000, '{\"65\":\"8\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(400, 109, 28, 32, 1300.000000, 7, 0, NULL, 9100.000000, '{\"87\":\"7\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(401, 109, 28, 34, 1400.000000, 7, 0, NULL, 9800.000000, '{\"74\":\"7\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(402, 109, 32, 58, 700.000000, 8, 0, NULL, 5600.000000, '{\"84\":\"8\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(403, 109, 32, 58, 800.000000, 2, 0, NULL, 1600.000000, '{\"84\":\"2\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(404, 109, 48, 64, 130.000000, 7, 0, NULL, 910.000000, '{\"208\":\"7\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(405, 109, 48, 64, 150.000000, 5, 0, NULL, 750.000000, '{\"208\":\"5\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(406, 109, 48, 64, 70.000000, 50, 0, NULL, 3500.000000, '{\"208\":\"50\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(407, 109, 48, 64, 100.000000, 10, 0, NULL, 1000.000000, '{\"208\":\"10\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(408, 109, 30, 48, 750.000000, 4, 0, NULL, 3000.000000, '{\"67\":\"4\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(409, 109, 29, 51, 850.000000, 7, 0, NULL, 5950.000000, '{\"81\":\"7\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(410, 109, 84, 137, 400.000000, 7, 0, NULL, 2800.000000, '{\"206\":\"7\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(411, 109, 39, 76, 350.000000, 36, 0, NULL, 12600.000000, '{\"221\":\"36\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(412, 109, 43, 77, 425.000000, 26, 0, NULL, 11050.000000, '{\"222\":\"26\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(413, 109, 43, 78, 325.000000, 33, 0, NULL, 10725.000000, '{\"111\":\"33\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(414, 109, 27, 31, 130.000000, 32, 0, NULL, 4160.000000, '{\"219\":\"32\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(415, 109, 27, 31, 400.000000, 7, 0, NULL, 2800.000000, '{\"219\":\"7\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(416, 109, 39, 41, 350.000000, 12, 0, NULL, 4200.000000, '{\"108\":\"12\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(417, 110, 28, 32, 1300.000000, 3, 0, NULL, 3900.000000, '{\"87\":\"3\"}', '2018-02-07 14:32:39', '2018-02-07 14:32:39'),
(418, 110, 28, 34, 1400.000000, 3, 0, NULL, 4200.000000, '{\"74\":\"3\"}', '2018-02-07 14:32:39', '2018-02-07 14:32:39'),
(419, 111, 43, 77, 400.000000, 60, 0, NULL, 24000.000000, '{\"222\":\"60\"}', '2018-02-07 14:34:13', '2018-02-07 14:34:13'),
(420, 112, 38, 44, 1000.000000, 1, 0, NULL, 1000.000000, '{\"64\":\"1\"}', '2018-02-07 14:36:39', '2018-02-07 14:36:39'),
(421, 112, 38, 44, 1400.000000, 2, 0, 50, 2700.000000, '{\"64\":\"2\"}', '2018-02-07 14:36:39', '2018-02-07 14:36:39'),
(422, 113, 28, 32, 1300.000000, 5, 0, NULL, 6500.000000, '{\"87\":\"5\"}', '2018-02-07 14:40:47', '2018-02-07 14:40:47'),
(423, 113, 28, 34, 1400.000000, 3, 0, NULL, 4200.000000, '{\"74\":\"3\"}', '2018-02-07 14:40:47', '2018-02-07 14:40:47'),
(424, 113, 39, 76, 400.000000, 9, 0, NULL, 3600.000000, '{\"221\":\"9\"}', '2018-02-07 14:40:47', '2018-02-07 14:40:47'),
(425, 113, 39, 76, 350.000000, 9, 0, NULL, 3150.000000, '{\"221\":\"9\"}', '2018-02-07 14:40:47', '2018-02-07 14:40:47'),
(426, 113, 27, 31, 125.000000, 11, 0, NULL, 1375.000000, '{\"219\":\"11\"}', '2018-02-07 14:40:47', '2018-02-07 14:40:47'),
(427, 114, 39, 41, 300.000000, 17, 0, NULL, 5100.000000, '{\"108\":\"17\"}', '2018-02-07 14:46:45', '2018-02-07 14:46:45'),
(428, 114, 39, 76, 350.000000, 33, 0, 5, 11385.000000, '{\"221\":\"33\"}', '2018-02-07 14:46:45', '2018-02-07 14:46:45'),
(429, 115, 28, 32, 1300.000000, 2, 0, NULL, 2600.000000, '{\"87\":\"2\"}', '2018-02-07 14:51:36', '2018-02-07 14:51:36'),
(430, 115, 28, 34, 1400.000000, 3, 0, NULL, 4200.000000, '{\"74\":\"3\"}', '2018-02-07 14:51:36', '2018-02-07 14:51:36'),
(431, 115, 28, 33, 1400.000000, 5, 0, 20, 6900.000000, '{\"72\":\"5\"}', '2018-02-07 14:51:36', '2018-02-07 14:51:36'),
(432, 116, 49, 46, 2800.000000, 6, 0, NULL, 16800.000000, '{\"54\":\"6\"}', '2018-02-07 14:56:31', '2018-02-07 14:56:31'),
(433, 116, 39, 76, 350.000000, 5, 0, 10, 1700.000000, '{\"221\":\"5\"}', '2018-02-07 14:56:31', '2018-02-07 14:56:31'),
(434, 116, 28, 32, 1300.000000, 1, 0, NULL, 1300.000000, '{\"87\":\"1\"}', '2018-02-07 14:56:31', '2018-02-07 14:56:31'),
(435, 116, 29, 51, 800.000000, 9, 0, NULL, 7200.000000, '{\"81\":\"5\",\"225\":4}', '2018-02-07 14:56:31', '2018-02-07 14:56:31'),
(436, 116, 32, 58, 800.000000, 2, 0, NULL, 1600.000000, '{\"84\":\"2\"}', '2018-02-07 14:56:31', '2018-02-07 14:56:31'),
(437, 116, 28, 36, 800.000000, 2, 0, NULL, 1600.000000, '{\"55\":\"2\"}', '2018-02-07 14:56:31', '2018-02-07 14:56:31'),
(438, 117, 27, 31, 180.000000, 14, 0, NULL, 2520.000000, '{\"219\":\"14\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47');
INSERT INTO `inventory_product_sales_item` (`id`, `fk_sales_id`, `fk_product_id`, `fk_model_id`, `product_price_amount`, `sales_qty`, `small_qty`, `product_wise_discount`, `product_paid_amount`, `inventory_item_id`, `created_at`, `updated_at`) VALUES
(439, 117, 27, 31, 130.000000, 22, 0, NULL, 2860.000000, '{\"219\":\"22\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(440, 117, 43, 78, 350.000000, 17, 0, NULL, 5950.000000, '{\"111\":\"17\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(441, 117, 27, 70, 250.000000, 14, 0, NULL, 3500.000000, '{\"220\":\"14\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(442, 117, 43, 77, 450.000000, 5, 0, NULL, 2250.000000, '{\"222\":\"5\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(443, 117, 27, 31, 350.000000, 12, 0, NULL, 4200.000000, '{\"219\":\"12\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(444, 117, 39, 41, 300.000000, 14, 0, NULL, 4200.000000, '{\"108\":\"14\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(445, 117, 28, 32, 1300.000000, 1, 0, NULL, 1300.000000, '{\"87\":\"1\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(446, 117, 28, 34, 1400.000000, 10, 0, NULL, 14000.000000, '{\"74\":\"10\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(447, 117, 76, 95, 2800.000000, 4, 0, NULL, 11200.000000, '{\"133\":\"4\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(448, 117, 38, 44, 950.000000, 1, 0, NULL, 950.000000, '{\"64\":\"1\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(449, 118, 28, 34, 1400.000000, 16, 0, NULL, 22400.000000, '{\"58\":\"3\",\"74\":13}', '2018-02-07 15:31:03', '2018-02-07 15:31:03'),
(450, 118, 28, 37, 1000.000000, 8, 0, NULL, 8000.000000, '{\"40\":\"8\"}', '2018-02-07 15:31:03', '2018-02-07 15:31:03'),
(451, 118, 28, 35, 700.000000, 8, 0, NULL, 5600.000000, '{\"38\":\"8\"}', '2018-02-07 15:31:03', '2018-02-07 15:31:03'),
(452, 118, 48, 64, 50.000000, 24, 0, NULL, 1200.000000, '{\"208\":\"24\"}', '2018-02-07 15:31:03', '2018-02-07 15:31:03'),
(453, 119, 28, 34, 1400.000000, 14, 0, NULL, 19600.000000, '{\"74\":\"14\"}', '2018-02-07 15:48:19', '2018-02-07 15:48:19'),
(454, 119, 28, 32, 1300.000000, 30, 0, NULL, 39000.000000, '{\"73\":\"7\",\"87\":23}', '2018-02-07 15:48:19', '2018-02-07 15:48:19'),
(455, 119, 35, 31, 1300.000000, 1, 0, NULL, 1300.000000, '{\"53\":\"1\"}', '2018-02-07 15:48:19', '2018-02-07 15:48:19'),
(456, 119, 39, 76, 500.000000, 1, 0, NULL, 500.000000, '{\"221\":\"1\"}', '2018-02-07 15:48:19', '2018-02-07 15:48:19'),
(457, 119, 43, 77, 600.000000, 1, 0, NULL, 600.000000, '{\"110\":\"1\",\"222\":0}', '2018-02-07 15:48:19', '2018-02-07 15:48:19'),
(458, 119, 48, 64, 100.000000, 1, 0, NULL, 100.000000, '{\"208\":\"1\"}', '2018-02-07 15:48:19', '2018-02-07 15:48:19'),
(459, 120, 28, 34, 1100.000000, 7, 0, NULL, 7700.000000, '{\"74\":\"7\"}', '2018-02-07 15:55:27', '2018-02-07 15:55:27'),
(460, 120, 84, 137, 250.000000, 7, 0, NULL, 1750.000000, '{\"206\":\"7\"}', '2018-02-07 15:55:27', '2018-02-07 15:55:27'),
(461, 120, 28, 37, 600.000000, 6, 0, NULL, 3600.000000, '{\"40\":\"6\"}', '2018-02-07 15:55:27', '2018-02-07 15:55:27'),
(462, 120, 48, 64, 50.000000, 62, 0, NULL, 3100.000000, '{\"208\":\"62\"}', '2018-02-07 15:55:27', '2018-02-07 15:55:27'),
(463, 120, 28, 32, 1000.000000, 5, 0, NULL, 5000.000000, '{\"87\":\"5\"}', '2018-02-07 15:55:27', '2018-02-07 15:55:27'),
(464, 121, 28, 32, 1300.000000, 11, 0, NULL, 14300.000000, '{\"87\":\"11\"}', '2018-02-07 16:05:03', '2018-02-07 16:05:03'),
(465, 121, 28, 34, 1400.000000, 6, 0, NULL, 8400.000000, '{\"74\":\"6\"}', '2018-02-07 16:05:03', '2018-02-07 16:05:03'),
(466, 121, 28, 33, 1400.000000, 2, 0, NULL, 2800.000000, '{\"72\":\"2\"}', '2018-02-07 16:05:03', '2018-02-07 16:05:03'),
(467, 122, 28, 32, 1300.000000, 9, 0, NULL, 11700.000000, '{\"87\":\"9\"}', '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(468, 122, 28, 34, 1400.000000, 3, 0, NULL, 4200.000000, '{\"74\":\"3\"}', '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(469, 122, 27, 70, 250.000000, 3, 0, NULL, 750.000000, '{\"220\":\"3\"}', '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(470, 122, 27, 31, 120.000000, 10, 0, NULL, 1200.000000, '{\"219\":\"10\"}', '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(471, 122, 39, 76, 350.000000, 11, 0, NULL, 3850.000000, '{\"221\":\"11\"}', '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(472, 122, 39, 76, 400.000000, 9, 0, NULL, 3600.000000, '{\"221\":\"9\"}', '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(473, 122, 27, 31, 130.000000, 16, 0, 5, 2000.000000, '{\"219\":\"16\"}', '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(474, 123, 28, 34, 1400.000000, 2, 0, NULL, 2800.000000, '{\"74\":\"2\"}', '2018-02-07 16:16:02', '2018-02-07 16:16:02'),
(475, 123, 28, 32, 1300.000000, 3, 0, NULL, 3900.000000, '{\"87\":\"3\"}', '2018-02-07 16:16:02', '2018-02-07 16:16:02'),
(476, 123, 27, 31, 120.000000, 1, 0, NULL, 120.000000, '{\"219\":\"1\"}', '2018-02-07 16:16:02', '2018-02-07 16:16:02'),
(477, 123, 39, 76, 350.000000, 1, 0, NULL, 350.000000, '{\"221\":\"1\"}', '2018-02-07 16:16:02', '2018-02-07 16:16:02'),
(478, 123, 39, 76, 400.000000, 5, 0, 4, 1980.000000, '{\"221\":\"5\"}', '2018-02-07 16:16:02', '2018-02-07 16:16:02'),
(479, 124, 27, 70, 200.000000, 32, 0, NULL, 6400.000000, '{\"220\":\"32\"}', '2018-02-07 16:24:07', '2018-02-07 16:24:07'),
(480, 124, 27, 31, 110.000000, 26, 0, NULL, 2860.000000, '{\"219\":\"26\"}', '2018-02-07 16:24:07', '2018-02-07 16:24:07'),
(481, 125, 28, 39, 600.000000, 4, 0, NULL, 2400.000000, '{\"65\":\"4\"}', '2018-02-07 16:27:27', '2018-02-07 16:27:27'),
(482, 126, 28, 32, 1300.000000, 3, 0, NULL, 3900.000000, '{\"87\":\"3\"}', '2018-02-07 16:31:55', '2018-02-07 16:31:55'),
(483, 126, 28, 34, 1400.000000, 1, 0, NULL, 1400.000000, '{\"74\":\"1\"}', '2018-02-07 16:31:55', '2018-02-07 16:31:55'),
(484, 127, 28, 34, 1250.000000, 2, 0, NULL, 2500.000000, '{\"74\":\"2\"}', '2018-02-07 16:34:49', '2018-02-07 16:34:49'),
(485, 127, 28, 32, 1150.000000, 3, 0, NULL, 3450.000000, '{\"87\":\"3\"}', '2018-02-07 16:34:49', '2018-02-07 16:34:49'),
(486, 128, 28, 32, 1300.000000, 4, 0, NULL, 5200.000000, '{\"87\":\"4\"}', '2018-02-07 16:36:47', '2018-02-07 16:36:47'),
(487, 129, 28, 32, 1300.000000, 1, 0, NULL, 1300.000000, '{\"87\":\"1\"}', '2018-02-07 16:39:18', '2018-02-07 16:39:18'),
(488, 129, 28, 34, 1400.000000, 5, 0, NULL, 7000.000000, '{\"74\":\"5\"}', '2018-02-07 16:39:18', '2018-02-07 16:39:18'),
(489, 130, 28, 32, 1300.000000, 3, 0, NULL, 3900.000000, '{\"87\":\"3\"}', '2018-02-07 16:41:46', '2018-02-07 16:41:46'),
(490, 130, 28, 39, 800.000000, 3, 0, NULL, 2400.000000, '{\"65\":\"3\"}', '2018-02-07 16:41:46', '2018-02-07 16:41:46'),
(491, 131, 28, 35, 1250.000000, 3, 0, NULL, 3750.000000, '{\"38\":\"3\"}', '2018-02-07 16:49:25', '2018-02-07 16:49:25'),
(492, 131, 28, 34, 1250.000000, 4, 0, NULL, 5000.000000, '{\"74\":\"4\"}', '2018-02-07 16:49:25', '2018-02-07 16:49:25'),
(493, 131, 28, 32, 1150.000000, 13, 0, NULL, 14950.000000, '{\"87\":\"13\"}', '2018-02-07 16:49:25', '2018-02-07 16:49:25'),
(494, 131, 27, 31, 110.000000, 10, 0, NULL, 1100.000000, '{\"219\":\"10\"}', '2018-02-07 16:49:25', '2018-02-07 16:49:25'),
(495, 132, 28, 34, 1400.000000, 4, 0, NULL, 5600.000000, '{\"74\":\"4\"}', '2018-02-07 16:51:49', '2018-02-07 16:51:49'),
(496, 132, 28, 32, 1300.000000, 18, 0, NULL, 23400.000000, '{\"87\":\"18\"}', '2018-02-07 16:51:49', '2018-02-07 16:51:49'),
(497, 133, 28, 39, 800.000000, 7, 0, NULL, 5600.000000, '{\"65\":\"7\"}', '2018-02-07 16:54:25', '2018-02-07 16:54:25'),
(498, 133, 28, 34, 1400.000000, 8, 0, NULL, 11200.000000, '{\"74\":\"8\"}', '2018-02-07 16:54:25', '2018-02-07 16:54:25'),
(499, 133, 28, 32, 1300.000000, 4, 0, NULL, 5200.000000, '{\"87\":\"4\"}', '2018-02-07 16:54:25', '2018-02-07 16:54:25'),
(500, 134, 28, 34, 1400.000000, 10, 0, NULL, 14000.000000, '{\"74\":\"10\"}', '2018-02-07 16:56:47', '2018-02-07 16:56:47'),
(501, 134, 28, 32, 1300.000000, 2, 0, NULL, 2600.000000, '{\"87\":\"2\"}', '2018-02-07 16:56:47', '2018-02-07 16:56:47'),
(502, 135, 28, 32, 1300.000000, 13, 0, NULL, 16900.000000, '{\"87\":\"13\"}', '2018-02-07 17:00:31', '2018-02-07 17:00:31'),
(503, 136, 33, 80, 300.000000, 8, 0, NULL, 2400.000000, '{\"114\":\"8\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(504, 136, 28, 39, 400.000000, 17, 0, NULL, 6800.000000, '{\"65\":\"17\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(505, 136, 45, 50, 1100.000000, 1, 0, NULL, 1100.000000, '{\"233\":\"1\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(506, 136, 43, 77, 430.000000, 46, 0, NULL, 19780.000000, '{\"222\":\"46\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(507, 136, 43, 78, 250.000000, 1, 0, NULL, 250.000000, '{\"111\":\"1\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(508, 136, 27, 31, 145.000000, 25, 0, NULL, 3625.000000, '{\"219\":\"25\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(509, 136, 45, 49, 1800.000000, 1, 0, NULL, 1800.000000, '{\"70\":\"1\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(510, 136, 45, 50, 1050.000000, 5, 0, NULL, 5250.000000, '{\"233\":\"5\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(511, 136, 28, 32, 1000.000000, 146, 0, NULL, 146000.000000, '{\"87\":\"146\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(512, 136, 28, 34, 1100.000000, 21, 0, NULL, 23100.000000, '{\"74\":\"21\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(513, 136, 28, 32, 1100.000000, 16, 0, NULL, 17600.000000, '{\"87\":\"16\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(514, 136, 48, 64, 54.000000, 119, 0, NULL, 6426.000000, '{\"208\":\"119\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(515, 136, 41, 31, 1000.000000, 2, 0, NULL, 2000.000000, '{\"213\":\"2\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(516, 136, 27, 70, 179.000000, 196, 0, NULL, 35084.000000, '{\"220\":\"196\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(517, 136, 39, 76, 271.000000, 83, 0, NULL, 22493.000000, '{\"221\":\"83\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(518, 136, 39, 41, 236.000000, 33, 0, NULL, 7788.000000, '{\"108\":\"1\",\"112\":32}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(519, 136, 50, 55, 550.000000, 24, 0, NULL, 13200.000000, '{\"79\":\"24\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(520, 136, 50, 56, 300.000000, 342, 0, NULL, 102600.000000, '{\"80\":\"342\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(521, 136, 27, 31, 104.000000, 155, 0, NULL, 16120.000000, '{\"219\":\"155\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(522, 136, 42, 57, 450.000000, 5, 0, NULL, 2250.000000, '{\"82\":\"5\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(523, 136, 84, 137, 250.000000, 18, 0, NULL, 4500.000000, '{\"206\":\"18\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(524, 136, 27, 66, 300.000000, 40, 0, NULL, 12000.000000, '{\"98\":\"40\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(525, 136, 27, 71, 250.000000, 24, 0, NULL, 6000.000000, '{\"103\":\"24\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(526, 136, 27, 70, 175.000000, 13, 0, NULL, 2275.000000, '{\"220\":\"13\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(527, 136, 27, 79, 230.000000, 108, 0, NULL, 24840.000000, '{\"232\":\"108\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(528, 137, 38, 44, 980.000000, 2, 0, NULL, 1960.000000, '{\"64\":\"2\"}', '2018-02-09 10:50:51', '2018-02-09 10:50:51'),
(529, 137, 37, 43, 780.000000, 5, 0, NULL, 3900.000000, '{\"48\":\"5\"}', '2018-02-09 10:50:51', '2018-02-09 10:50:51'),
(530, 137, 49, 46, 2900.000000, 1, 0, NULL, 2900.000000, '{\"54\":\"1\"}', '2018-02-09 10:50:51', '2018-02-09 10:50:51'),
(531, 138, 37, 43, 780.000000, 6, 0, NULL, 4680.000000, '{\"48\":\"5\",\"51\":1}', '2018-02-09 11:05:36', '2018-02-09 11:50:57'),
(532, 138, 28, 32, 1400.000000, 5, 0, NULL, 7000.000000, '{\"87\":\"5\"}', '2018-02-09 11:05:36', '2018-02-09 11:50:57'),
(533, 138, 49, 46, 2900.000000, 2, 0, NULL, 5800.000000, '{\"54\":\"2\"}', '2018-02-09 11:05:36', '2018-02-09 11:50:57'),
(534, 139, 56, 92, 3400.000000, 7, 0, NULL, 23800.000000, '{\"130\":\"7\"}', '2018-02-09 11:15:20', '2018-02-09 11:15:20'),
(535, 139, 32, 58, 850.000000, 1, 0, NULL, 850.000000, '{\"84\":\"1\"}', '2018-02-09 11:15:20', '2018-02-09 11:15:20'),
(536, 139, 76, 95, 1700.000000, 2, 0, NULL, 3400.000000, '{\"133\":\"2\"}', '2018-02-09 11:15:20', '2018-02-09 11:15:20'),
(537, 139, 49, 31, 1800.000000, 1, 0, NULL, 1800.000000, '{\"62\":\"1\"}', '2018-02-09 11:15:20', '2018-02-09 11:15:20'),
(538, 139, 76, 95, 1300.000000, 7, 0, NULL, 9100.000000, '{\"133\":\"7\"}', '2018-02-09 11:15:20', '2018-02-09 11:15:20'),
(539, 140, 53, 90, 3600.000000, 1, 0, NULL, 3600.000000, '{\"128\":\"1\"}', '2018-02-09 11:31:46', '2018-02-09 11:31:46'),
(540, 140, 53, 119, 3600.000000, 1, 0, NULL, 3600.000000, '{\"167\":\"1\"}', '2018-02-09 11:31:46', '2018-02-09 11:31:46'),
(541, 140, 76, 95, 3650.000000, 1, 0, NULL, 3650.000000, '{\"133\":\"1\"}', '2018-02-09 11:31:46', '2018-02-09 11:31:46'),
(542, 140, 76, 95, 2000.000000, 2, 0, NULL, 4000.000000, '{\"133\":\"2\"}', '2018-02-09 11:31:46', '2018-02-09 11:31:46'),
(543, 140, 76, 95, 1300.000000, 1, 0, NULL, 1300.000000, '{\"133\":\"1\"}', '2018-02-09 11:31:46', '2018-02-09 11:31:46'),
(544, 140, 43, 78, 400.000000, 1, 0, NULL, 400.000000, '{\"111\":\"1\"}', '2018-02-09 11:31:46', '2018-02-09 11:31:46'),
(545, 141, 76, 95, 1300.000000, 2, 0, NULL, 2600.000000, '{\"133\":\"2\"}', '2018-02-09 11:33:44', '2018-02-09 11:33:44'),
(546, 142, 37, 43, 800.000000, 7, 0, NULL, 5600.000000, '{\"51\":\"7\"}', '2018-02-09 11:38:31', '2018-02-09 11:38:31'),
(547, 143, 28, 32, 1400.000000, 2, 0, NULL, 2800.000000, '{\"87\":\"2\"}', '2018-02-09 11:41:52', '2018-02-09 11:41:52'),
(548, 143, 32, 58, 850.000000, 2, 0, NULL, 1700.000000, '{\"84\":\"2\"}', '2018-02-09 11:41:52', '2018-02-09 11:41:52'),
(549, 144, 72, 93, 1500.000000, 3, 0, NULL, 4500.000000, '{\"194\":\"3\"}', '2018-02-09 11:55:29', '2018-02-09 11:55:29'),
(550, 144, 72, 93, 1300.000000, 6, 0, NULL, 7800.000000, '{\"194\":\"6\"}', '2018-02-09 11:55:29', '2018-02-09 11:55:29'),
(551, 145, 85, 139, 80.000000, 23, 0, NULL, 1840.000000, '{\"215\":\"23\"}', '2018-02-09 11:56:58', '2018-02-09 11:56:58'),
(552, 146, 28, 32, 1400.000000, 6, 0, NULL, 8400.000000, '{\"87\":\"6\"}', '2018-02-09 12:08:25', '2018-02-09 12:08:25'),
(553, 146, 28, 32, 1300.000000, 7, 0, NULL, 9100.000000, '{\"87\":\"7\"}', '2018-02-09 12:08:25', '2018-02-09 12:08:25'),
(554, 146, 45, 50, 1300.000000, 4, 0, NULL, 5200.000000, '{\"233\":\"4\"}', '2018-02-09 12:08:25', '2018-02-09 12:08:25'),
(555, 146, 45, 50, 1900.000000, 4, 0, 25, 7500.000000, '{\"233\":\"4\"}', '2018-02-09 12:08:25', '2018-02-09 12:08:25'),
(556, 146, 44, 75, 700.000000, 4, 0, NULL, 2800.000000, '{\"107\":\"4\"}', '2018-02-09 12:08:25', '2018-02-09 12:08:25'),
(557, 147, 42, 57, 700.000000, 20, 0, NULL, 14000.000000, '{\"82\":\"20\"}', '2018-02-09 12:11:57', '2018-02-09 12:11:57'),
(558, 147, 32, 54, 1200.000000, 10, 0, NULL, 12000.000000, '{\"83\":\"10\"}', '2018-02-09 12:11:57', '2018-02-09 12:11:57'),
(559, 147, 32, 58, 800.000000, 8, 0, NULL, 6400.000000, '{\"84\":\"8\"}', '2018-02-09 12:11:57', '2018-02-09 12:11:57'),
(560, 147, 32, 58, 700.000000, 3, 0, NULL, 2100.000000, '{\"84\":\"3\"}', '2018-02-09 12:11:57', '2018-02-09 12:11:57'),
(561, 148, 28, 32, 1300.000000, 1, 0, NULL, 1300.000000, '{\"87\":\"1\"}', '2018-02-09 12:58:37', '2018-02-09 12:58:37'),
(562, 148, 43, 78, 350.000000, 2, 0, NULL, 700.000000, '{\"111\":\"2\"}', '2018-02-09 12:58:37', '2018-02-09 12:58:37'),
(563, 148, 27, 31, 200.000000, 1, 0, NULL, 200.000000, '{\"219\":\"1\"}', '2018-02-09 12:58:37', '2018-02-09 12:58:37'),
(564, 148, 28, 39, 800.000000, 1, 0, NULL, 800.000000, '{\"65\":\"1\"}', '2018-02-09 12:58:37', '2018-02-09 12:58:37'),
(565, 148, 28, 32, 1450.000000, 2, 0, NULL, 2900.000000, '{\"87\":\"2\"}', '2018-02-09 12:58:37', '2018-02-09 12:58:37'),
(566, 149, 27, 31, 120.000000, 14, 0, NULL, 1680.000000, '{\"219\":\"14\"}', '2018-02-09 13:01:34', '2018-02-09 13:01:34'),
(567, 149, 27, 31, 200.000000, 1, 0, NULL, 200.000000, '{\"219\":\"1\"}', '2018-02-09 13:01:34', '2018-02-09 13:01:34'),
(568, 149, 28, 32, 1300.000000, 1, 0, NULL, 1300.000000, '{\"87\":\"1\"}', '2018-02-09 13:01:34', '2018-02-09 13:01:34'),
(569, 150, 28, 32, 1400.000000, 5, 0, NULL, 7000.000000, '{\"87\":\"5\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(570, 150, 27, 31, 120.000000, 21, 0, NULL, 2520.000000, '{\"219\":\"21\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(571, 150, 27, 70, 220.000000, 25, 0, NULL, 5500.000000, '{\"220\":\"25\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(572, 150, 39, 76, 350.000000, 2, 0, NULL, 700.000000, '{\"221\":\"2\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(573, 150, 28, 32, 1300.000000, 1, 0, NULL, 1300.000000, '{\"87\":\"1\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(574, 150, 38, 44, 1300.000000, 6, 0, NULL, 7800.000000, '{\"64\":\"6\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(575, 150, 44, 75, 750.000000, 1, 0, NULL, 750.000000, '{\"107\":\"1\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(576, 150, 40, 45, 1700.000000, 6, 0, NULL, 10200.000000, '{\"120\":\"6\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(577, 150, 40, 37, 1700.000000, 14, 0, NULL, 23800.000000, '{\"119\":\"14\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(578, 151, 27, 31, 120.000000, 4, 0, NULL, 480.000000, '{\"219\":\"4\"}', '2018-02-09 13:38:04', '2018-02-09 13:38:04'),
(579, 151, 27, 70, 270.000000, 1, 0, NULL, 270.000000, '{\"220\":\"1\"}', '2018-02-09 13:38:04', '2018-02-09 13:38:04'),
(580, 152, 72, 93, 1150.000000, 5, 0, NULL, 5750.000000, '{\"194\":\"5\"}', '2018-02-09 13:42:18', '2018-02-09 13:42:18'),
(581, 152, 44, 74, 1600.000000, 1, 0, NULL, 1600.000000, '{\"106\":\"1\"}', '2018-02-09 13:42:18', '2018-02-09 13:42:18'),
(582, 153, 27, 31, 120.000000, 30, 0, NULL, 3600.000000, '{\"219\":\"30\"}', '2018-02-09 13:44:20', '2018-02-09 13:44:20'),
(583, 154, 39, 76, 350.000000, 7, 0, NULL, 2450.000000, '{\"221\":\"7\"}', '2018-02-09 14:08:24', '2018-02-09 14:08:24'),
(584, 154, 27, 31, 170.000000, 3, 0, NULL, 510.000000, '{\"219\":\"3\"}', '2018-02-09 14:08:24', '2018-02-09 14:08:24'),
(585, 154, 27, 31, 120.000000, 1, 0, NULL, 120.000000, '{\"219\":\"1\"}', '2018-02-09 14:08:24', '2018-02-09 14:08:24'),
(586, 155, 39, 76, 350.000000, 5, 0, NULL, 1750.000000, '{\"221\":\"5\"}', '2018-02-09 14:10:30', '2018-02-09 14:10:30'),
(587, 155, 27, 31, 120.000000, 1, 0, NULL, 120.000000, '{\"219\":\"1\"}', '2018-02-09 14:10:30', '2018-02-09 14:10:30'),
(588, 156, 28, 32, 1400.000000, 5, 0, NULL, 7000.000000, '{\"87\":\"5\"}', '2018-02-09 14:16:40', '2018-02-09 14:16:40'),
(589, 156, 28, 32, 1300.000000, 1, 0, NULL, 1300.000000, '{\"87\":\"1\"}', '2018-02-09 14:16:40', '2018-02-09 14:16:40'),
(590, 156, 27, 70, 220.000000, 8, 0, NULL, 1760.000000, '{\"220\":\"8\"}', '2018-02-09 14:16:40', '2018-02-09 14:16:40'),
(591, 156, 76, 95, 1450.000000, 3, 0, NULL, 4350.000000, '{\"133\":\"3\"}', '2018-02-09 14:16:40', '2018-02-09 14:16:40'),
(592, 156, 72, 93, 1150.000000, 5, 0, NULL, 5750.000000, '{\"194\":\"5\"}', '2018-02-09 14:16:40', '2018-02-09 14:16:40'),
(593, 156, 43, 77, 450.000000, 2, 0, NULL, 900.000000, '{\"222\":\"2\"}', '2018-02-09 14:16:40', '2018-02-09 14:16:40'),
(594, 156, 39, 41, 350.000000, 13, 0, NULL, 4550.000000, '{\"112\":\"13\"}', '2018-02-09 14:16:40', '2018-02-09 14:16:40'),
(595, 157, 28, 39, 700.000000, 6, 0, NULL, 4200.000000, '{\"65\":\"6\"}', '2018-02-09 14:24:09', '2018-02-09 14:24:09'),
(596, 157, 28, 33, 1400.000000, 8, 0, 30, 10960.000000, '{\"72\":\"8\"}', '2018-02-09 14:24:09', '2018-02-09 14:24:09'),
(597, 157, 42, 57, 700.000000, 4, 0, NULL, 2800.000000, '{\"82\":\"4\"}', '2018-02-09 14:24:09', '2018-02-09 14:24:09'),
(598, 157, 28, 32, 1300.000000, 2, 0, 30, 2540.000000, '{\"87\":\"2\"}', '2018-02-09 14:24:09', '2018-02-09 14:24:09'),
(599, 158, 27, 70, 250.000000, 20, 0, NULL, 5000.000000, '{\"220\":\"20\"}', '2018-02-09 14:35:03', '2018-02-09 14:35:03'),
(600, 158, 27, 31, 120.000000, 33, 0, NULL, 3960.000000, '{\"219\":\"33\"}', '2018-02-09 14:35:03', '2018-02-09 14:35:03'),
(601, 159, 28, 32, 1300.000000, 3, 0, NULL, 3900.000000, '{\"87\":\"3\"}', '2018-02-09 14:36:52', '2018-02-09 14:36:52'),
(602, 159, 28, 33, 1400.000000, 2, 0, NULL, 2800.000000, '{\"72\":\"2\"}', '2018-02-09 14:36:52', '2018-02-09 14:36:52'),
(603, 160, 28, 33, 1800.000000, 4, 0, 50, 7000.000000, '{\"72\":\"4\"}', '2018-02-09 14:43:44', '2018-02-09 14:43:44'),
(604, 160, 28, 32, 1300.000000, 8, 0, NULL, 10400.000000, '{\"87\":\"8\"}', '2018-02-09 14:43:44', '2018-02-09 14:43:44'),
(605, 160, 28, 33, 1400.000000, 9, 0, NULL, 12600.000000, '{\"72\":\"9\"}', '2018-02-09 14:43:44', '2018-02-09 14:43:44'),
(606, 160, 29, 51, 750.000000, 4, 0, NULL, 3000.000000, '{\"81\":\"3\",\"225\":1}', '2018-02-09 14:43:44', '2018-02-09 14:43:44'),
(607, 160, 30, 48, 650.000000, 2, 0, NULL, 1300.000000, '{\"67\":\"2\"}', '2018-02-09 14:43:44', '2018-02-09 14:43:44'),
(608, 161, 44, 75, 700.000000, 7, 0, NULL, 4900.000000, '{\"107\":\"7\"}', '2018-02-09 14:45:41', '2018-02-09 14:45:41'),
(609, 162, 45, 50, 1300.000000, 8, 0, NULL, 10400.000000, '{\"233\":\"8\"}', '2018-02-09 14:48:50', '2018-02-09 14:48:50'),
(610, 162, 28, 33, 1400.000000, 4, 0, NULL, 5600.000000, '{\"72\":\"4\"}', '2018-02-09 14:48:50', '2018-02-09 14:48:50'),
(611, 162, 28, 32, 1300.000000, 15, 0, NULL, 19500.000000, '{\"87\":\"15\"}', '2018-02-09 14:48:50', '2018-02-09 14:48:50'),
(612, 163, 28, 33, 1250.000000, 4, 0, NULL, 5000.000000, '{\"72\":\"4\"}', '2018-02-09 14:50:58', '2018-02-09 14:50:58'),
(613, 163, 28, 32, 1150.000000, 3, 0, NULL, 3450.000000, '{\"87\":\"3\"}', '2018-02-09 14:50:58', '2018-02-09 14:50:58'),
(614, 164, 28, 33, 1400.000000, 5, 0, 20, 6900.000000, '{\"72\":\"4\",\"86\":1}', '2018-02-09 14:54:14', '2018-02-09 14:54:14'),
(615, 164, 28, 32, 1300.000000, 2, 0, NULL, 2600.000000, '{\"87\":\"2\"}', '2018-02-09 14:54:14', '2018-02-09 14:54:14'),
(616, 164, 28, 39, 700.000000, 4, 0, NULL, 2800.000000, '{\"65\":\"4\"}', '2018-02-09 14:54:14', '2018-02-09 14:54:14'),
(617, 165, 29, 51, 800.000000, 6, 0, NULL, 4800.000000, '{\"225\":\"6\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(618, 165, 40, 83, 1300.000000, 1, 0, NULL, 1300.000000, '{\"150\":\"1\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(619, 165, 28, 35, 1000.000000, 1, 0, NULL, 1000.000000, '{\"38\":\"1\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(620, 165, 28, 32, 1300.000000, 5, 0, NULL, 6500.000000, '{\"87\":\"5\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(621, 165, 28, 33, 1400.000000, 5, 0, NULL, 7000.000000, '{\"86\":\"5\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(622, 165, 29, 53, 1200.000000, 1, 0, NULL, 1200.000000, '{\"77\":\"1\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(623, 165, 27, 31, 110.000000, 17, 0, NULL, 1870.000000, '{\"219\":\"17\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(624, 165, 27, 31, 250.000000, 3, 0, NULL, 750.000000, '{\"219\":\"3\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(625, 165, 27, 68, 250.000000, 6, 0, NULL, 1500.000000, '{\"100\":\"6\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(626, 165, 51, 62, 25.000000, 36, 0, NULL, 900.000000, '{\"93\":\"36\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(627, 165, 51, 61, 50.000000, 19, 0, NULL, 950.000000, '{\"91\":\"19\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(628, 165, 51, 61, 35.000000, 13, 0, NULL, 455.000000, '{\"91\":\"13\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(629, 166, 28, 33, 1400.000000, 4, 0, 25, 5500.000000, '{\"86\":\"4\"}', '2018-02-09 15:07:25', '2018-02-09 15:07:25'),
(630, 166, 28, 35, 1350.000000, 2, 0, NULL, 2700.000000, '{\"38\":\"2\"}', '2018-02-09 15:07:25', '2018-02-09 15:07:25'),
(631, 167, 28, 32, 1300.000000, 7, 0, NULL, 9100.000000, '{\"87\":\"7\"}', '2018-02-09 15:09:42', '2018-02-09 15:09:42'),
(632, 167, 44, 74, 1500.000000, 4, 0, 25, 5900.000000, '{\"106\":\"4\"}', '2018-02-09 15:09:42', '2018-02-09 15:09:42'),
(633, 168, 44, 73, 400.000000, 5, 0, NULL, 2000.000000, '{\"105\":\"5\"}', '2018-02-09 15:13:17', '2018-02-09 15:13:17'),
(634, 168, 44, 74, 1500.000000, 6, 0, NULL, 9000.000000, '{\"106\":\"6\"}', '2018-02-09 15:13:17', '2018-02-09 15:13:17'),
(635, 169, 39, 76, 350.000000, 41, 0, NULL, 14350.000000, '{\"221\":\"41\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(636, 169, 39, 41, 250.000000, 14, 0, NULL, 3500.000000, '{\"112\":\"14\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(637, 169, 43, 77, 450.000000, 17, 0, NULL, 7650.000000, '{\"222\":\"17\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(638, 169, 43, 78, 350.000000, 6, 0, NULL, 2100.000000, '{\"111\":\"6\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(639, 169, 27, 67, 250.000000, 10, 0, NULL, 2500.000000, '{\"99\":\"10\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(640, 169, 27, 68, 270.000000, 21, 0, NULL, 5670.000000, '{\"100\":\"21\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(641, 169, 44, 75, 800.000000, 21, 0, NULL, 16800.000000, '{\"107\":\"13\",\"223\":8}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(642, 169, 27, 66, 400.000000, 5, 0, NULL, 2000.000000, '{\"98\":\"5\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(643, 169, 28, 33, 1400.000000, 5, 0, NULL, 7000.000000, '{\"86\":\"5\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(644, 169, 51, 63, 70.000000, 16, 0, NULL, 1120.000000, '{\"94\":\"16\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(645, 170, 28, 33, 1400.000000, 3, 0, NULL, 4200.000000, '{\"86\":\"3\"}', '2018-02-09 15:34:39', '2018-02-09 15:34:39'),
(646, 170, 44, 75, 800.000000, 6, 0, NULL, 4800.000000, '{\"223\":\"6\"}', '2018-02-09 15:34:39', '2018-02-09 15:34:39'),
(647, 170, 28, 36, 800.000000, 3, 0, NULL, 2400.000000, '{\"55\":\"3\"}', '2018-02-09 15:34:39', '2018-02-09 15:34:39'),
(648, 170, 42, 52, 1200.000000, 3, 0, NULL, 3600.000000, '{\"228\":\"3\"}', '2018-02-09 15:34:39', '2018-02-09 15:34:39'),
(649, 170, 42, 57, 400.000000, 4, 0, NULL, 1600.000000, '{\"82\":\"2\",\"229\":2}', '2018-02-09 15:34:39', '2018-02-09 15:34:39'),
(650, 170, 29, 51, 800.000000, 4, 0, NULL, 3200.000000, '{\"225\":\"4\"}', '2018-02-09 15:34:40', '2018-02-09 15:34:40'),
(651, 170, 43, 78, 350.000000, 8, 0, NULL, 2800.000000, '{\"111\":\"8\"}', '2018-02-09 15:34:40', '2018-02-09 15:34:40'),
(652, 170, 27, 67, 250.000000, 16, 0, NULL, 4000.000000, '{\"99\":\"16\"}', '2018-02-09 15:34:40', '2018-02-09 15:34:40'),
(653, 170, 43, 77, 450.000000, 15, 0, NULL, 6750.000000, '{\"222\":\"15\"}', '2018-02-09 15:34:40', '2018-02-09 15:34:40'),
(654, 170, 43, 77, 700.000000, 10, 0, NULL, 7000.000000, '{\"222\":\"10\"}', '2018-02-09 15:34:40', '2018-02-09 15:34:40'),
(655, 170, 27, 66, 400.000000, 5, 0, NULL, 2000.000000, '{\"98\":\"5\"}', '2018-02-09 15:34:40', '2018-02-09 15:34:40'),
(656, 170, 39, 41, 250.000000, 8, 0, NULL, 2000.000000, '{\"112\":\"8\"}', '2018-02-09 15:34:40', '2018-02-09 15:34:40'),
(657, 170, 27, 68, 270.000000, 1, 0, NULL, 270.000000, '{\"100\":\"1\"}', '2018-02-09 15:34:40', '2018-02-09 15:34:40'),
(658, 171, 28, 32, 1300.000000, 5, 0, NULL, 6500.000000, '{\"87\":\"5\"}', '2018-02-09 15:39:17', '2018-02-09 15:39:17'),
(659, 171, 28, 33, 1400.000000, 1, 0, NULL, 1400.000000, '{\"86\":\"1\"}', '2018-02-09 15:39:17', '2018-02-09 15:39:17'),
(660, 172, 28, 33, 1500.000000, 1, 0, NULL, 1500.000000, '{\"86\":\"1\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(661, 172, 27, 70, 250.000000, 31, 0, NULL, 7750.000000, '{\"220\":\"31\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(662, 172, 27, 31, 120.000000, 33, 0, NULL, 3960.000000, '{\"219\":\"33\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(663, 172, 27, 67, 250.000000, 15, 0, NULL, 3750.000000, '{\"99\":\"15\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(664, 172, 27, 31, 350.000000, 20, 0, NULL, 7000.000000, '{\"219\":\"20\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(665, 172, 39, 76, 350.000000, 9, 0, NULL, 3150.000000, '{\"221\":\"9\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(666, 172, 27, 69, 170.000000, 13, 0, NULL, 2210.000000, '{\"101\":\"13\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(667, 172, 27, 72, 120.000000, 20, 0, NULL, 2400.000000, '{\"104\":\"20\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(668, 172, 27, 72, 110.000000, 14, 0, NULL, 1540.000000, '{\"104\":\"14\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(669, 172, 39, 41, 250.000000, 14, 0, NULL, 3500.000000, '{\"112\":\"14\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(670, 172, 27, 68, 260.000000, 22, 0, NULL, 5720.000000, '{\"100\":\"22\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(671, 173, 27, 79, 240.000000, 55, 0, NULL, 13200.000000, '{\"232\":\"55\"}', '2018-02-09 16:01:25', '2018-02-09 16:01:25'),
(672, 173, 27, 68, 260.000000, 15, 0, 10, 3750.000000, '{\"100\":\"15\"}', '2018-02-09 16:01:25', '2018-02-09 16:01:25'),
(673, 173, 27, 67, 250.000000, 14, 0, NULL, 3500.000000, '{\"99\":\"14\"}', '2018-02-09 16:01:25', '2018-02-09 16:01:25'),
(674, 173, 27, 70, 250.000000, 23, 0, NULL, 5750.000000, '{\"220\":\"23\"}', '2018-02-09 16:01:25', '2018-02-09 16:01:25'),
(675, 173, 27, 66, 380.000000, 10, 0, NULL, 3800.000000, '{\"98\":\"10\"}', '2018-02-09 16:01:25', '2018-02-09 16:01:25'),
(676, 173, 43, 77, 700.000000, 5, 0, NULL, 3500.000000, '{\"222\":\"5\"}', '2018-02-09 16:01:25', '2018-02-09 16:01:25'),
(677, 174, 44, 75, 800.000000, 11, 0, NULL, 8800.000000, '{\"223\":\"11\"}', '2018-02-09 16:07:02', '2018-02-09 16:07:02'),
(678, 174, 44, 73, 450.000000, 12, 0, NULL, 5400.000000, '{\"105\":\"12\"}', '2018-02-09 16:07:02', '2018-02-09 16:07:02'),
(679, 174, 27, 68, 270.000000, 2, 0, NULL, 540.000000, '{\"100\":\"2\"}', '2018-02-09 16:07:02', '2018-02-09 16:07:02'),
(680, 174, 39, 41, 250.000000, 14, 0, NULL, 3500.000000, '{\"112\":\"14\"}', '2018-02-09 16:07:02', '2018-02-09 16:07:02'),
(681, 174, 39, 41, 300.000000, 8, 0, NULL, 2400.000000, '{\"112\":\"8\"}', '2018-02-09 16:07:02', '2018-02-09 16:07:02'),
(682, 174, 28, 33, 1400.000000, 1, 0, NULL, 1400.000000, '{\"86\":\"1\"}', '2018-02-09 16:07:02', '2018-02-09 16:07:02'),
(683, 175, 44, 73, 430.000000, 25, 0, NULL, 10750.000000, '{\"105\":\"25\"}', '2018-02-09 16:23:25', '2018-02-09 16:23:25'),
(684, 175, 27, 67, 250.000000, 3, 0, NULL, 750.000000, '{\"99\":\"3\"}', '2018-02-09 16:23:25', '2018-02-09 16:23:25'),
(685, 175, 27, 68, 270.000000, 11, 0, NULL, 2970.000000, '{\"100\":\"11\"}', '2018-02-09 16:23:25', '2018-02-09 16:23:25'),
(686, 175, 39, 41, 250.000000, 1, 0, NULL, 250.000000, '{\"112\":\"1\"}', '2018-02-09 16:23:25', '2018-02-09 16:23:25'),
(687, 175, 82, 106, 600.000000, 2, 0, NULL, 1200.000000, '{\"153\":\"2\"}', '2018-02-09 16:23:25', '2018-02-09 16:23:25'),
(688, 176, 43, 77, 450.000000, 7, 0, NULL, 3150.000000, '{\"222\":\"7\"}', '2018-02-09 16:26:28', '2018-02-09 16:26:28'),
(689, 176, 39, 41, 250.000000, 3, 0, NULL, 750.000000, '{\"112\":\"3\"}', '2018-02-09 16:26:28', '2018-02-09 16:26:28'),
(690, 177, 28, 32, 1300.000000, 11, 0, NULL, 14300.000000, '{\"87\":\"11\"}', '2018-02-09 16:41:08', '2018-02-09 16:41:08'),
(691, 177, 28, 33, 1400.000000, 4, 0, NULL, 5600.000000, '{\"86\":\"4\"}', '2018-02-09 16:41:08', '2018-02-09 16:41:08'),
(692, 178, 28, 32, 1300.000000, 2, 0, NULL, 2600.000000, '{\"87\":\"2\"}', '2018-02-09 16:43:02', '2018-02-09 16:43:02'),
(693, 178, 28, 33, 1400.000000, 3, 0, NULL, 4200.000000, '{\"86\":\"3\"}', '2018-02-09 16:43:02', '2018-02-09 16:43:02'),
(694, 179, 28, 33, 1400.000000, 7, 0, NULL, 9800.000000, '{\"86\":\"7\"}', '2018-02-09 16:47:49', '2018-02-09 16:47:49'),
(695, 179, 28, 32, 1240.000000, 5, 0, NULL, 6200.000000, '{\"87\":\"5\"}', '2018-02-09 16:47:49', '2018-02-09 16:47:49'),
(696, 180, 28, 33, 1400.000000, 9, 0, 25, 12375.000000, '{\"86\":\"9\"}', '2018-02-09 16:50:37', '2018-02-09 16:50:37'),
(697, 180, 28, 32, 1300.000000, 6, 0, NULL, 7800.000000, '{\"87\":\"6\"}', '2018-02-09 16:50:37', '2018-02-09 16:50:37'),
(698, 181, 27, 79, 270.000000, 18, 0, NULL, 4860.000000, '{\"232\":\"18\"}', '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(699, 181, 43, 77, 450.000000, 4, 0, 20, 1720.000000, '{\"222\":\"4\"}', '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(700, 181, 28, 33, 1400.000000, 4, 0, NULL, 5600.000000, '{\"86\":\"4\"}', '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(701, 181, 76, 95, 2220.000000, 5, 0, NULL, 11100.000000, '{\"133\":\"5\"}', '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(702, 181, 27, 72, 130.000000, 12, 0, NULL, 1560.000000, '{\"104\":\"12\"}', '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(703, 181, 27, 31, 130.000000, 12, 0, NULL, 1560.000000, '{\"219\":\"12\"}', '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(704, 181, 27, 31, 200.000000, 1, 0, NULL, 200.000000, '{\"219\":\"1\"}', '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(705, 182, 39, 41, 250.000000, 12, 0, NULL, 3000.000000, '{\"112\":\"12\"}', '2018-02-09 17:03:06', '2018-02-09 17:03:06'),
(706, 182, 27, 67, 250.000000, 6, 0, NULL, 1500.000000, '{\"99\":\"6\"}', '2018-02-09 17:03:06', '2018-02-09 17:03:06'),
(707, 182, 28, 39, 800.000000, 12, 0, NULL, 9600.000000, '{\"65\":\"12\"}', '2018-02-09 17:03:06', '2018-02-09 17:03:06'),
(708, 182, 28, 32, 1300.000000, 6, 0, NULL, 7800.000000, '{\"87\":\"6\"}', '2018-02-09 17:03:06', '2018-02-09 17:03:06'),
(709, 182, 28, 33, 1400.000000, 7, 0, NULL, 9800.000000, '{\"86\":\"7\"}', '2018-02-09 17:03:06', '2018-02-09 17:03:06'),
(710, 182, 29, 51, 800.000000, 7, 0, NULL, 5600.000000, '{\"225\":\"7\"}', '2018-02-09 17:03:06', '2018-02-09 17:03:06'),
(711, 183, 28, 32, 1300.000000, 37, 0, NULL, 48100.000000, '{\"87\":\"37\"}', '2018-02-09 17:12:48', '2018-02-09 17:12:48'),
(712, 183, 28, 32, 1500.000000, 5, 0, NULL, 7500.000000, '{\"87\":\"5\"}', '2018-02-09 17:12:48', '2018-02-09 17:12:48'),
(713, 183, 28, 33, 1400.000000, 15, 0, NULL, 21000.000000, '{\"86\":\"15\"}', '2018-02-09 17:12:48', '2018-02-09 17:12:48'),
(714, 183, 39, 76, 350.000000, 21, 0, NULL, 7350.000000, '{\"221\":\"21\"}', '2018-02-09 17:12:48', '2018-02-09 17:12:48'),
(715, 183, 27, 79, 270.000000, 41, 0, NULL, 11070.000000, '{\"232\":\"41\"}', '2018-02-09 17:12:48', '2018-02-09 17:12:48'),
(716, 183, 39, 76, 400.000000, 4, 0, NULL, 1600.000000, '{\"221\":\"4\"}', '2018-02-09 17:12:48', '2018-02-09 17:12:48'),
(717, 184, 28, 32, 1300.000000, 11, 0, 20, 14080.000000, '{\"87\":\"11\"}', '2018-02-09 17:17:10', '2018-02-09 17:17:10'),
(718, 184, 28, 33, 1400.000000, 4, 0, 20, 5520.000000, '{\"86\":\"4\"}', '2018-02-09 17:17:10', '2018-02-09 17:17:10'),
(719, 185, 27, 70, 250.000000, 3, 0, 30, 660.000000, '{\"220\":\"3\"}', '2018-02-09 17:22:06', '2018-02-09 17:22:06'),
(720, 185, 27, 79, 260.000000, 9, 0, NULL, 2340.000000, '{\"232\":\"9\"}', '2018-02-09 17:22:06', '2018-02-09 17:22:06'),
(721, 185, 28, 32, 1300.000000, 10, 0, NULL, 13000.000000, '{\"87\":\"10\"}', '2018-02-09 17:22:06', '2018-02-09 17:22:06'),
(722, 185, 35, 59, 1400.000000, 1, 0, NULL, 1400.000000, '{\"85\":\"1\"}', '2018-02-09 17:22:06', '2018-02-09 17:22:06'),
(723, 186, 27, 70, 270.000000, 7, 0, NULL, 1890.000000, '{\"220\":\"7\"}', '2018-02-10 10:24:30', '2018-02-10 10:24:30'),
(724, 186, 27, 31, 400.000000, 2, 0, NULL, 800.000000, '{\"219\":\"2\"}', '2018-02-10 10:24:30', '2018-02-10 10:24:30'),
(725, 186, 27, 31, 130.000000, 3, 0, NULL, 390.000000, '{\"219\":\"3\"}', '2018-02-10 10:24:30', '2018-02-10 10:24:30'),
(726, 186, 27, 31, 200.000000, 2, 0, NULL, 400.000000, '{\"219\":\"2\"}', '2018-02-10 10:24:30', '2018-02-10 10:24:30'),
(727, 187, 39, 41, 350.000000, 6, 0, NULL, 2100.000000, '{\"112\":\"6\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(728, 187, 39, 76, 350.000000, 2, 0, NULL, 700.000000, '{\"221\":\"2\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(729, 187, 43, 78, 350.000000, 4, 0, NULL, 1400.000000, '{\"111\":\"4\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(730, 187, 43, 77, 450.000000, 5, 0, NULL, 2250.000000, '{\"222\":\"5\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(731, 187, 27, 31, 400.000000, 2, 0, NULL, 800.000000, '{\"219\":\"2\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(732, 187, 28, 32, 1300.000000, 3, 0, NULL, 3900.000000, '{\"87\":\"3\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(733, 187, 27, 72, 130.000000, 7, 0, NULL, 910.000000, '{\"104\":\"7\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(734, 187, 27, 31, 350.000000, 8, 0, NULL, 2800.000000, '{\"219\":\"8\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(735, 187, 27, 70, 270.000000, 11, 0, NULL, 2970.000000, '{\"220\":\"11\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(736, 187, 39, 76, 350.000000, 6, 0, NULL, 2100.000000, '{\"221\":\"6\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(737, 188, 27, 31, 350.000000, 4, 0, NULL, 1400.000000, '{\"219\":\"4\"}', '2018-02-10 10:44:26', '2018-02-10 10:44:26'),
(738, 189, 48, 64, 100.000000, 19, 0, NULL, 1900.000000, '{\"208\":\"19\"}', '2018-02-10 10:48:32', '2018-02-10 10:48:32'),
(739, 189, 27, 31, 130.000000, 3, 0, NULL, 390.000000, '{\"219\":\"3\"}', '2018-02-10 10:48:32', '2018-02-10 10:48:32'),
(740, 190, 39, 76, 350.000000, 1, 0, NULL, 350.000000, '{\"221\":\"1\"}', '2018-02-10 11:15:17', '2018-02-10 11:15:17'),
(741, 190, 48, 64, 100.000000, 5, 0, NULL, 500.000000, '{\"208\":\"5\"}', '2018-02-10 11:15:17', '2018-02-10 11:15:17'),
(742, 191, 35, 45, 1600.000000, 3, 0, NULL, 4800.000000, '{\"52\":\"3\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(743, 191, 45, 50, 2000.000000, 1, 0, NULL, 2000.000000, '{\"233\":\"1\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(744, 191, 27, 31, 130.000000, 6, 0, NULL, 780.000000, '{\"219\":\"6\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(745, 191, 48, 64, 130.000000, 1, 0, NULL, 130.000000, '{\"208\":\"1\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(746, 191, 48, 64, 100.000000, 1, 0, NULL, 100.000000, '{\"208\":\"1\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(747, 191, 28, 32, 1300.000000, 8, 0, NULL, 10400.000000, '{\"87\":\"8\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(748, 191, 28, 33, 1500.000000, 2, 0, NULL, 3000.000000, '{\"86\":\"2\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(749, 191, 39, 41, 350.000000, 2, 0, NULL, 700.000000, '{\"112\":\"2\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(750, 191, 27, 70, 220.000000, 6, 0, NULL, 1320.000000, '{\"220\":\"6\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(751, 191, 45, 50, 1500.000000, 1, 0, NULL, 1500.000000, '{\"233\":\"1\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(752, 191, 43, 77, 450.000000, 3, 0, NULL, 1350.000000, '{\"222\":\"3\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(753, 191, 27, 72, 120.000000, 6, 0, NULL, 720.000000, '{\"104\":\"6\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(754, 191, 27, 31, 200.000000, 4, 0, NULL, 800.000000, '{\"219\":\"4\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(755, 193, 37, 43, 750.000000, 6, 0, NULL, 4500.000000, '{\"51\":\"6\"}', '2018-02-11 10:48:37', '2018-02-11 10:48:37'),
(756, 193, 38, 44, 1000.000000, 4, 0, NULL, 4000.000000, '{\"64\":\"4\"}', '2018-02-11 10:48:37', '2018-02-11 10:48:37'),
(757, 193, 49, 46, 2900.000000, 4, 0, NULL, 11600.000000, '{\"54\":\"4\"}', '2018-02-11 10:48:37', '2018-02-11 10:48:37'),
(758, 193, 38, 44, 1500.000000, 1, 0, NULL, 1500.000000, '{\"64\":\"1\"}', '2018-02-11 10:48:37', '2018-02-11 10:48:37'),
(759, 193, 76, 95, 1500.000000, 3, 0, NULL, 4500.000000, '{\"133\":\"3\"}', '2018-02-11 10:48:37', '2018-02-11 10:48:37'),
(760, 193, 27, 70, 250.000000, 9, 0, NULL, 2250.000000, '{\"220\":\"9\"}', '2018-02-11 10:48:37', '2018-02-11 10:48:37'),
(761, 194, 37, 43, 900.000000, 4, 0, NULL, 3600.000000, '{\"51\":\"4\"}', '2018-02-11 11:06:51', '2018-02-11 11:06:51'),
(762, 194, 72, 93, 1150.000000, 10, 0, NULL, 11500.000000, '{\"194\":\"10\"}', '2018-02-11 11:06:51', '2018-02-11 11:06:51'),
(763, 194, 29, 51, 800.000000, 1, 0, NULL, 800.000000, '{\"225\":\"1\"}', '2018-02-11 11:06:51', '2018-02-11 11:06:51'),
(764, 194, 74, 94, 2800.000000, 1, 0, NULL, 2800.000000, '{\"132\":\"1\"}', '2018-02-11 11:06:51', '2018-02-11 11:06:51'),
(765, 195, 27, 31, 231.000000, 123, 0, NULL, 28413.000000, '{\"219\":\"123\"}', '2018-02-11 11:49:54', '2018-02-11 11:49:54'),
(766, 195, 27, 70, 306.000000, 43, 0, NULL, 13158.000000, '{\"220\":\"43\"}', '2018-02-11 11:49:54', '2018-02-11 11:49:54'),
(767, 195, 43, 77, 650.000000, 80, 0, NULL, 52000.000000, '{\"222\":\"80\"}', '2018-02-11 11:49:54', '2018-02-11 11:49:54'),
(768, 195, 38, 44, 1225.000000, 34, 0, NULL, 41650.000000, '{\"64\":\"34\"}', '2018-02-11 11:49:54', '2018-02-11 11:49:54'),
(769, 195, 36, 138, 843.000000, 7, 0, NULL, 5901.000000, '{\"209\":\"7\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(770, 195, 39, 76, 505.000000, 48, 0, NULL, 24240.000000, '{\"221\":\"48\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(771, 195, 48, 64, 125.000000, 53, 0, NULL, 6625.000000, '{\"208\":\"53\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(772, 195, 32, 58, 848.000000, 21, 0, NULL, 17808.000000, '{\"84\":\"21\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(773, 195, 29, 51, 901.000000, 7, 0, NULL, 6307.000000, '{\"225\":\"7\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(774, 195, 51, 60, 37.000000, 66, 0, NULL, 2442.000000, '{\"90\":\"66\",\"207\":0}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(775, 195, 75, 125, 2050.000000, 2, 0, NULL, 4100.000000, '{\"175\":\"2\",\"204\":0}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(776, 195, 28, 32, 1483.000000, 15, 0, NULL, 22245.000000, '{\"87\":\"15\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(777, 195, 28, 33, 1750.000000, 16, 0, NULL, 28000.000000, '{\"86\":\"16\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(778, 195, 37, 43, 836.000000, 11, 0, NULL, 9196.000000, '{\"51\":\"9\",\"211\":2}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(779, 195, 49, 31, 1300.000000, 1, 0, NULL, 1300.000000, '{\"62\":\"1\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(780, 195, 41, 31, 900.000000, 4, 0, NULL, 3600.000000, '{\"213\":\"4\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(781, 195, 76, 95, 2900.000000, 1, 0, NULL, 2900.000000, '{\"133\":\"1\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(782, 195, 49, 46, 2500.000000, 1, 0, NULL, 2500.000000, '{\"54\":\"1\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(783, 195, 84, 137, 483.000000, 3, 0, NULL, 1449.000000, '{\"206\":\"3\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(784, 195, 39, 41, 400.000000, 1, 0, NULL, 400.000000, '{\"112\":\"1\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(785, 195, 31, 47, 550.000000, 2, 0, NULL, 1100.000000, '{\"216\":\"2\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(786, 195, 35, 59, 1700.000000, 2, 0, NULL, 3400.000000, '{\"85\":\"2\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(787, 195, 34, 42, 1350.000000, 4, 0, NULL, 5400.000000, '{\"45\":\"3\",\"46\":1}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(788, 195, 51, 60, 175.000000, 4, 0, NULL, 700.000000, '{\"207\":\"4\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(789, 195, 42, 57, 1100.000000, 2, 0, 20, 2160.000000, '{\"229\":\"2\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(790, 196, 27, 70, 308.000000, 98, 0, NULL, 30184.000000, '{\"220\":\"98\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(791, 196, 43, 77, 685.000000, 51, 0, NULL, 34935.000000, '{\"222\":\"51\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(792, 196, 27, 31, 240.000000, 197, 0, NULL, 47280.000000, '{\"219\":\"197\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(793, 196, 39, 76, 490.000000, 62, 0, NULL, 30380.000000, '{\"221\":\"62\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(794, 196, 48, 64, 105.000000, 91, 0, NULL, 9555.000000, '{\"208\":\"91\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(795, 196, 29, 51, 911.000000, 18, 0, NULL, 16398.000000, '{\"225\":\"18\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(796, 196, 32, 58, 903.000000, 36, 0, NULL, 32508.000000, '{\"84\":\"36\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(797, 196, 38, 44, 1060.000000, 38, 0, NULL, 40280.000000, '{\"64\":\"22\",\"212\":16}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(798, 196, 28, 33, 1556.000000, 19, 0, NULL, 29564.000000, '{\"86\":\"19\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(799, 196, 28, 35, 1356.000000, 42, 0, NULL, 56952.000000, '{\"38\":\"42\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(800, 196, 31, 47, 483.000000, 6, 0, NULL, 2898.000000, '{\"216\":\"6\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(801, 196, 35, 59, 1700.000000, 6, 0, NULL, 10200.000000, '{\"85\":\"6\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(802, 196, 34, 42, 1775.000000, 4, 0, NULL, 7100.000000, '{\"46\":\"4\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(803, 196, 51, 60, 52.000000, 28, 0, NULL, 1456.000000, '{\"207\":\"28\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(804, 196, 72, 93, 1800.000000, 1, 0, NULL, 1800.000000, '{\"194\":\"1\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(805, 196, 49, 46, 2925.000000, 14, 0, NULL, 40950.000000, '{\"54\":\"14\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(806, 196, 37, 43, 829.000000, 24, 0, NULL, 19896.000000, '{\"211\":\"24\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(807, 196, 86, 140, 400.000000, 3, 0, NULL, 1200.000000, '{\"226\":\"3\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(808, 196, 28, 37, 985.000000, 14, 0, NULL, 13790.000000, '{\"40\":\"14\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(809, 196, 84, 137, 700.000000, 2, 0, NULL, 1400.000000, '{\"206\":\"2\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(810, 196, 42, 57, 1250.000000, 2, 0, NULL, 2500.000000, '{\"229\":\"2\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(811, 196, 30, 40, 950.000000, 2, 0, NULL, 1900.000000, '{\"69\":\"2\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(812, 196, 76, 95, 1400.000000, 5, 0, NULL, 7000.000000, '{\"133\":\"5\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(813, 197, 28, 32, 1490.000000, 24, 0, NULL, 35760.000000, '{\"87\":\"24\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(814, 197, 28, 32, 1740.000000, 5, 0, NULL, 8700.000000, '{\"87\":\"5\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(815, 197, 27, 70, 303.000000, 59, 0, NULL, 17877.000000, '{\"220\":\"59\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(816, 197, 27, 31, 221.000000, 87, 0, NULL, 19227.000000, '{\"219\":\"87\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(817, 197, 43, 77, 645.000000, 21, 0, NULL, 13545.000000, '{\"222\":\"21\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(818, 197, 39, 76, 439.000000, 31, 0, NULL, 13609.000000, '{\"221\":\"31\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(819, 197, 48, 64, 111.000000, 39, 0, NULL, 4329.000000, '{\"208\":\"39\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(820, 197, 35, 59, 1810.000000, 10, 0, NULL, 18100.000000, '{\"85\":\"10\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(821, 197, 38, 44, 1286.000000, 7, 0, NULL, 9002.000000, '{\"212\":\"7\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(822, 197, 28, 39, 900.000000, 1, 0, NULL, 900.000000, '{\"65\":\"1\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(823, 197, 51, 60, 102.000000, 18, 0, NULL, 1836.000000, '{\"207\":\"18\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(824, 197, 42, 52, 1225.000000, 2, 0, NULL, 2450.000000, '{\"228\":\"2\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(825, 197, 84, 137, 450.000000, 4, 0, NULL, 1800.000000, '{\"206\":\"4\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(826, 197, 31, 47, 525.000000, 4, 0, NULL, 2100.000000, '{\"216\":\"4\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(827, 197, 32, 58, 950.000000, 4, 0, NULL, 3800.000000, '{\"84\":\"4\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(828, 197, 40, 45, 2550.000000, 1, 0, NULL, 2550.000000, '{\"120\":\"1\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(829, 197, 40, 83, 1600.000000, 1, 0, NULL, 1600.000000, '{\"150\":\"1\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(830, 197, 34, 42, 1950.000000, 2, 0, NULL, 3900.000000, '{\"46\":\"1\",\"47\":1}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(831, 197, 86, 140, 333.000000, 3, 0, NULL, 999.000000, '{\"226\":\"3\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(832, 197, 72, 93, 1200.000000, 4, 0, NULL, 4800.000000, '{\"194\":\"4\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(833, 198, 32, 58, 880.000000, 5, 0, NULL, 4400.000000, '{\"84\":\"5\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(834, 198, 32, 54, 1350.000000, 2, 0, NULL, 2700.000000, '{\"83\":\"2\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(835, 198, 48, 64, 106.000000, 32, 0, NULL, 3392.000000, '{\"208\":\"32\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(836, 198, 39, 76, 460.000000, 20, 0, NULL, 9200.000000, '{\"221\":\"20\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(837, 198, 27, 31, 246.000000, 108, 0, NULL, 26568.000000, '{\"219\":\"108\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(838, 198, 43, 77, 591.000000, 41, 0, NULL, 24231.000000, '{\"222\":\"41\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(839, 198, 27, 70, 384.000000, 22, 0, NULL, 8448.000000, '{\"220\":\"22\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(840, 198, 49, 31, 1805.000000, 22, 0, NULL, 39710.000000, '{\"62\":\"22\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(841, 198, 49, 46, 2950.000000, 4, 0, NULL, 11800.000000, '{\"54\":\"4\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(842, 198, 38, 44, 1453.000000, 15, 0, NULL, 21795.000000, '{\"212\":\"15\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(843, 198, 28, 32, 1400.000000, 1, 0, NULL, 1400.000000, '{\"87\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(844, 198, 31, 47, 520.000000, 10, 0, NULL, 5200.000000, '{\"216\":\"10\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(845, 198, 33, 80, 420.000000, 9, 0, NULL, 3780.000000, '{\"114\":\"9\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(846, 198, 76, 95, 1550.000000, 9, 0, NULL, 13950.000000, '{\"133\":\"9\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(847, 198, 34, 42, 1528.000000, 7, 0, NULL, 10696.000000, '{\"47\":\"2\",\"59\":5}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(848, 198, 35, 59, 1875.000000, 4, 0, NULL, 7500.000000, '{\"85\":\"4\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04');
INSERT INTO `inventory_product_sales_item` (`id`, `fk_sales_id`, `fk_product_id`, `fk_model_id`, `product_price_amount`, `sales_qty`, `small_qty`, `product_wise_discount`, `product_paid_amount`, `inventory_item_id`, `created_at`, `updated_at`) VALUES
(849, 198, 51, 60, 160.000000, 5, 0, NULL, 800.000000, '{\"207\":\"5\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(850, 198, 53, 119, 3600.000000, 1, 0, NULL, 3600.000000, '{\"167\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(851, 198, 56, 92, 3400.000000, 1, 0, NULL, 3400.000000, '{\"130\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(852, 198, 67, 88, 3800.000000, 1, 0, NULL, 3800.000000, '{\"126\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(853, 198, 58, 114, 2900.000000, 2, 0, NULL, 5800.000000, '{\"162\":\"2\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(854, 198, 57, 76, 1900.000000, 3, 0, NULL, 5700.000000, '{\"137\":\"3\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(855, 198, 76, 95, 1662.000000, 8, 0, NULL, 13296.000000, '{\"133\":\"8\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(856, 198, 73, 82, 3300.000000, 3, 0, NULL, 9900.000000, '{\"125\":\"3\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(857, 198, 37, 43, 900.000000, 1, 0, NULL, 900.000000, '{\"211\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(858, 198, 28, 32, 1170.000000, 8, 0, NULL, 9360.000000, '{\"87\":\"8\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(859, 198, 67, 84, 1933.000000, 3, 0, NULL, 5799.000000, '{\"121\":\"3\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(860, 198, 29, 53, 1500.000000, 2, 0, NULL, 3000.000000, '{\"77\":\"2\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(861, 198, 67, 87, 2900.000000, 1, 0, NULL, 2900.000000, '{\"124\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(862, 198, 72, 93, 1216.000000, 12, 0, NULL, 14592.000000, '{\"194\":\"12\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(863, 198, 84, 137, 300.000000, 1, 0, NULL, 300.000000, '{\"206\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(864, 198, 86, 140, 300.000000, 1, 0, NULL, 300.000000, '{\"226\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(865, 198, 42, 52, 1300.000000, 1, 0, NULL, 1300.000000, '{\"228\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(866, 198, 84, 136, 1500.000000, 1, 0, NULL, 1500.000000, '{\"205\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(867, 198, 51, 61, 150.000000, 1, 0, NULL, 150.000000, '{\"91\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(868, 198, 36, 138, 950.000000, 2, 0, NULL, 1900.000000, '{\"209\":\"2\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(869, 198, 74, 94, 2633.000000, 3, 0, NULL, 7899.000000, '{\"132\":\"3\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(870, 199, 39, 76, 437.000000, 27, 0, NULL, 11799.000000, '{\"221\":\"27\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(871, 199, 76, 95, 1320.000000, 5, 0, NULL, 6600.000000, '{\"133\":\"5\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(872, 199, 72, 93, 1063.000000, 12, 0, NULL, 12756.000000, '{\"194\":\"12\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(873, 199, 43, 77, 529.000000, 29, 0, NULL, 15341.000000, '{\"222\":\"29\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(874, 199, 28, 32, 1572.000000, 18, 0, NULL, 28296.000000, '{\"87\":\"12\",\"227\":6}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(875, 199, 48, 64, 107.000000, 59, 0, NULL, 6313.000000, '{\"208\":\"59\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(876, 199, 27, 31, 201.000000, 132, 0, NULL, 26532.000000, '{\"219\":\"132\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(877, 199, 33, 80, 380.000000, 5, 0, NULL, 1900.000000, '{\"114\":\"5\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(878, 199, 32, 58, 900.000000, 16, 0, NULL, 14400.000000, '{\"84\":\"16\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(879, 199, 27, 67, 294.000000, 21, 0, NULL, 6174.000000, '{\"99\":\"21\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(880, 199, 29, 53, 1433.000000, 3, 0, NULL, 4299.000000, '{\"77\":\"3\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(881, 199, 51, 61, 80.000000, 42, 0, NULL, 3360.000000, '{\"91\":\"42\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(882, 199, 51, 62, 50.000000, 3, 0, NULL, 150.000000, '{\"93\":\"3\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(883, 199, 51, 60, 45.000000, 21, 0, NULL, 945.000000, '{\"207\":\"21\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(884, 199, 31, 47, 700.000000, 2, 0, NULL, 1400.000000, '{\"216\":\"2\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(885, 199, 38, 44, 1383.000000, 3, 0, NULL, 4149.000000, '{\"212\":\"3\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(886, 199, 42, 52, 880.000000, 5, 0, NULL, 4400.000000, '{\"228\":\"5\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(887, 199, 49, 31, 1813.000000, 4, 0, NULL, 7252.000000, '{\"62\":\"4\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(888, 199, 49, 46, 2800.000000, 3, 0, NULL, 8400.000000, '{\"54\":\"3\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(889, 199, 57, 76, 1700.000000, 1, 0, NULL, 1700.000000, '{\"137\":\"1\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(890, 199, 29, 51, 900.000000, 1, 0, NULL, 900.000000, '{\"225\":\"1\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(891, 199, 84, 137, 360.000000, 10, 0, NULL, 3600.000000, '{\"206\":\"10\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(892, 199, 74, 94, 2100.000000, 2, 0, NULL, 4200.000000, '{\"132\":\"2\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(893, 199, 45, 50, 1800.000000, 1, 0, NULL, 1800.000000, '{\"233\":\"1\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(894, 199, 44, 75, 700.000000, 2, 0, NULL, 1400.000000, '{\"223\":\"2\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(895, 199, 32, 54, 1300.000000, 1, 0, NULL, 1300.000000, '{\"83\":\"1\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(896, 199, 35, 141, 1500.000000, 2, 0, NULL, 3000.000000, '{\"231\":\"2\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(897, 199, 34, 42, 2000.000000, 1, 0, NULL, 2000.000000, '{\"59\":\"1\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(898, 200, 27, 66, 464.000000, 7, 0, NULL, 3248.000000, '{\"98\":\"7\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(899, 200, 44, 74, 1700.000000, 6, 0, NULL, 10200.000000, '{\"106\":\"6\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(900, 200, 44, 75, 929.000000, 7, 0, NULL, 6503.000000, '{\"223\":\"7\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(901, 200, 28, 32, 1565.000000, 23, 0, NULL, 35995.000000, '{\"227\":\"23\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(902, 200, 43, 77, 537.000000, 60, 0, NULL, 32220.000000, '{\"222\":\"60\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(903, 200, 27, 31, 217.000000, 136, 0, NULL, 29512.000000, '{\"219\":\"136\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(904, 200, 39, 76, 441.000000, 33, 0, NULL, 14553.000000, '{\"221\":\"33\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(905, 200, 29, 51, 962.000000, 4, 0, NULL, 3848.000000, '{\"225\":\"4\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(906, 200, 27, 67, 284.000000, 62, 0, NULL, 17608.000000, '{\"99\":\"62\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(907, 200, 35, 59, 1584.000000, 9, 0, NULL, 14256.000000, '{\"85\":\"9\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(908, 200, 35, 141, 1584.000000, 3, 0, NULL, 4752.000000, '{\"231\":\"3\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(909, 200, 48, 64, 128.000000, 59, 0, NULL, 7552.000000, '{\"208\":\"59\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(910, 200, 32, 58, 880.000000, 20, 0, NULL, 17600.000000, '{\"84\":\"20\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(911, 200, 31, 47, 600.000000, 5, 0, NULL, 3000.000000, '{\"216\":\"5\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(912, 200, 51, 61, 67.000000, 3, 0, NULL, 201.000000, '{\"91\":\"3\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(913, 200, 29, 53, 1400.000000, 2, 0, NULL, 2800.000000, '{\"77\":\"2\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(914, 200, 57, 76, 1850.000000, 2, 0, NULL, 3700.000000, '{\"137\":\"2\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(915, 200, 51, 60, 73.000000, 7, 0, NULL, 511.000000, '{\"207\":\"7\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(916, 200, 38, 44, 1267.000000, 9, 0, NULL, 11403.000000, '{\"212\":\"9\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(917, 200, 84, 137, 304.000000, 14, 0, NULL, 4256.000000, '{\"206\":\"14\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(918, 200, 42, 52, 733.000000, 6, 0, NULL, 4398.000000, '{\"228\":\"6\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(919, 200, 32, 54, 1386.000000, 7, 0, NULL, 9702.000000, '{\"83\":\"7\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(920, 200, 42, 52, 1300.000000, 2, 0, NULL, 2600.000000, '{\"228\":\"2\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(921, 200, 30, 40, 850.000000, 4, 0, NULL, 3400.000000, '{\"69\":\"4\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(922, 200, 76, 95, 1873.000000, 11, 0, NULL, 20603.000000, '{\"133\":\"11\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(923, 200, 72, 93, 1200.000000, 1, 0, NULL, 1200.000000, '{\"194\":\"1\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(924, 200, 49, 31, 1800.000000, 5, 0, NULL, 9000.000000, '{\"62\":\"5\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(925, 200, 67, 84, 1850.000000, 2, 0, NULL, 3700.000000, '{\"121\":\"2\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(926, 200, 84, 136, 1350.000000, 2, 0, NULL, 2700.000000, '{\"205\":\"2\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(927, 200, 28, 39, 800.000000, 1, 0, NULL, 800.000000, '{\"65\":\"1\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(928, 200, 33, 80, 341.000000, 11, 0, NULL, 3751.000000, '{\"114\":\"11\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(929, 200, 67, 88, 3233.000000, 3, 0, NULL, 9699.000000, '{\"126\":\"3\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(930, 200, 44, 73, 565.000000, 20, 0, NULL, 11300.000000, '{\"105\":\"18\",\"224\":2}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(931, 200, 27, 68, 357.000000, 28, 0, NULL, 9996.000000, '{\"100\":\"28\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(932, 200, 27, 67, 338.000000, 17, 0, NULL, 5746.000000, '{\"99\":\"17\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(933, 200, 27, 72, 196.000000, 10, 0, NULL, 1960.000000, '{\"104\":\"10\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(934, 200, 27, 71, 400.000000, 7, 0, NULL, 2800.000000, '{\"103\":\"7\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(935, 200, 45, 50, 1500.000000, 1, 0, NULL, 1500.000000, '{\"233\":\"1\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(936, 200, 49, 46, 3000.000000, 1, 0, NULL, 3000.000000, '{\"54\":\"1\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(937, 201, 49, 46, 2850.000000, 2, 0, NULL, 5700.000000, '{\"54\":\"2\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(938, 201, 48, 64, 100.000000, 13, 0, NULL, 1300.000000, '{\"208\":\"13\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(939, 201, 43, 77, 568.000000, 17, 0, NULL, 9656.000000, '{\"222\":\"17\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(940, 201, 27, 31, 199.000000, 24, 0, NULL, 4776.000000, '{\"219\":\"24\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(941, 201, 27, 72, 197.000000, 9, 0, NULL, 1773.000000, '{\"104\":\"9\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(942, 201, 27, 79, 350.000000, 3, 0, NULL, 1050.000000, '{\"232\":\"3\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(943, 201, 35, 141, 1650.000000, 2, 0, NULL, 3300.000000, '{\"231\":\"2\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(944, 201, 27, 67, 300.000000, 14, 0, NULL, 4200.000000, '{\"99\":\"14\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(945, 201, 27, 68, 340.000000, 2, 0, NULL, 680.000000, '{\"100\":\"2\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(946, 201, 27, 71, 400.000000, 2, 0, NULL, 800.000000, '{\"103\":\"2\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(947, 201, 75, 129, 3300.000000, 1, 0, NULL, 3300.000000, '{\"187\":\"1\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(948, 201, 51, 60, 200.000000, 1, 0, NULL, 200.000000, '{\"207\":\"1\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(949, 201, 28, 32, 1450.000000, 6, 0, NULL, 8700.000000, '{\"227\":\"6\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(950, 201, 37, 43, 900.000000, 1, 0, NULL, 900.000000, '{\"211\":\"1\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(951, 201, 39, 76, 437.000000, 4, 0, NULL, 1748.000000, '{\"221\":\"4\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(952, 201, 33, 80, 400.000000, 1, 0, NULL, 400.000000, '{\"114\":\"1\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(953, 201, 27, 66, 490.000000, 5, 0, NULL, 2450.000000, '{\"98\":\"5\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(954, 201, 41, 135, 1400.000000, 1, 0, NULL, 1400.000000, '{\"200\":\"1\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(955, 201, 44, 73, 500.000000, 3, 0, NULL, 1500.000000, '{\"224\":\"3\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(956, 201, 32, 58, 900.000000, 1, 0, NULL, 900.000000, '{\"84\":\"1\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(957, 202, 27, 31, 197.000000, 93, 0, NULL, 18321.000000, '{\"219\":\"93\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(958, 202, 44, 75, 794.000000, 39, 0, NULL, 30966.000000, '{\"223\":\"39\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(959, 202, 33, 80, 306.000000, 26, 0, NULL, 7956.000000, '{\"114\":\"26\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(960, 202, 43, 77, 571.000000, 41, 0, NULL, 23411.000000, '{\"222\":\"41\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(961, 202, 44, 73, 559.000000, 35, 0, NULL, 19565.000000, '{\"224\":\"35\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(962, 202, 27, 71, 329.000000, 8, 0, NULL, 2632.000000, '{\"103\":\"8\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(963, 202, 44, 74, 1522.000000, 9, 0, NULL, 13698.000000, '{\"106\":\"9\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(964, 202, 27, 70, 301.000000, 43, 0, NULL, 12943.000000, '{\"220\":\"43\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(965, 202, 27, 68, 313.000000, 41, 0, NULL, 12833.000000, '{\"100\":\"41\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(966, 202, 27, 79, 333.000000, 18, 0, NULL, 5994.000000, '{\"232\":\"18\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(967, 202, 34, 42, 1200.000000, 1, 0, NULL, 1200.000000, '{\"59\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(968, 202, 39, 76, 464.000000, 21, 0, NULL, 9744.000000, '{\"221\":\"21\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(969, 202, 82, 106, 767.000000, 3, 0, NULL, 2301.000000, '{\"153\":\"3\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(970, 202, 28, 32, 1332.000000, 22, 0, NULL, 29304.000000, '{\"227\":\"22\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(971, 202, 36, 138, 600.000000, 1, 0, NULL, 600.000000, '{\"209\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(972, 202, 51, 60, 6.000000, 11, 0, NULL, 66.000000, '{\"207\":\"11\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(973, 202, 51, 62, 15.000000, 7, 0, NULL, 105.000000, '{\"93\":\"7\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(974, 202, 27, 66, 500.000000, 4, 0, NULL, 2000.000000, '{\"98\":\"4\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(975, 202, 84, 136, 1000.000000, 1, 0, NULL, 1000.000000, '{\"205\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(976, 202, 84, 137, 800.000000, 1, 0, NULL, 800.000000, '{\"206\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(977, 202, 56, 111, 3000.000000, 1, 0, NULL, 3000.000000, '{\"158\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(978, 202, 56, 92, 3000.000000, 1, 0, NULL, 3000.000000, '{\"130\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(979, 202, 40, 127, 2500.000000, 1, 0, NULL, 2500.000000, '{\"182\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(980, 202, 40, 45, 1600.000000, 2, 0, NULL, 3200.000000, '{\"120\":\"2\",\"214\":0}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(981, 202, 32, 54, 1200.000000, 1, 0, NULL, 1200.000000, '{\"83\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(982, 202, 76, 95, 1633.000000, 3, 0, NULL, 4899.000000, '{\"133\":\"3\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(983, 202, 45, 50, 1667.000000, 3, 0, NULL, 5001.000000, '{\"233\":\"3\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(984, 202, 51, 61, 50.000000, 1, 0, NULL, 50.000000, '{\"91\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(985, 202, 29, 51, 883.000000, 3, 0, NULL, 2649.000000, '{\"225\":\"3\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(986, 202, 57, 112, 4100.000000, 1, 0, NULL, 4100.000000, '{\"159\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(987, 202, 57, 76, 1700.000000, 1, 0, NULL, 1700.000000, '{\"137\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(988, 202, 61, 121, 1800.000000, 1, 0, NULL, 1800.000000, '{\"170\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(989, 202, 81, 105, 500.000000, 4, 0, NULL, 2000.000000, '{\"152\":\"4\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(990, 202, 48, 64, 124.000000, 47, 0, NULL, 5828.000000, '{\"208\":\"47\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(991, 202, 49, 31, 2000.000000, 1, 0, NULL, 2000.000000, '{\"62\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(992, 202, 49, 31, 1775.000000, 4, 0, NULL, 7100.000000, '{\"62\":\"4\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(993, 202, 38, 44, 1380.000000, 5, 0, NULL, 6900.000000, '{\"212\":\"5\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(994, 202, 27, 72, 189.000000, 23, 0, NULL, 4347.000000, '{\"104\":\"23\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(995, 202, 35, 45, 1760.000000, 5, 0, NULL, 8800.000000, '{\"52\":\"1\",\"201\":4}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(996, 202, 32, 58, 887.000000, 15, 0, NULL, 13305.000000, '{\"84\":\"11\",\"217\":4}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(997, 202, 31, 47, 500.000000, 2, 0, NULL, 1000.000000, '{\"216\":\"2\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(998, 202, 30, 40, 800.000000, 1, 0, NULL, 800.000000, '{\"69\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(999, 202, 27, 70, 318.000000, 11, 0, NULL, 3498.000000, '{\"220\":\"11\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(1000, 202, 28, 37, 750.000000, 1, 0, NULL, 750.000000, '{\"40\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(1001, 202, 76, 95, 3150.000000, 1, 0, NULL, 3150.000000, '{\"133\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(1002, 217, 82, 106, 750.000000, 2, 0, 0, 1500.000000, '{\"153\":\"2\"}', '2018-02-16 18:12:56', '2018-02-16 18:12:56'),
(1003, 218, 45, 50, 1500.000000, 1, 0, 0, 1500.000000, '{\"233\":\"1\"}', '2018-02-16 19:05:21', '2018-02-16 19:05:21'),
(1004, 219, 56, 111, 3300.000000, 1, 0, 0, 3300.000000, '{\"158\":\"1\"}', '2018-02-16 19:43:43', '2018-02-16 19:43:43'),
(1005, 219, 49, 31, 1800.000000, 1, 0, 0, 1800.000000, '{\"62\":\"1\"}', '2018-02-16 19:43:43', '2018-02-16 19:43:43'),
(1006, 221, 72, 93, 1200.000000, 2, 0, 15.6352, 2384.364821, '{\"194\":\"2\"}', '2018-02-16 20:10:51', '2018-02-16 20:10:51'),
(1007, 221, 27, 70, 280.000000, 8, 0, 14.5928, 2225.407166, '{\"220\":\"8\"}', '2018-02-16 20:10:51', '2018-02-16 20:10:51'),
(1008, 221, 28, 32, 1500.000000, 1, 0, 9.77199, 1490.228013, '{\"227\":\"1\"}', '2018-02-16 20:10:51', '2018-02-16 20:10:51'),
(1009, 222, 49, 46, 3000.000000, 2, 0, 0, 6000.000000, '{\"54\":\"2\"}', '2018-02-16 20:17:48', '2018-02-16 20:17:48'),
(1010, 222, 49, 31, 1800.000000, 2, 0, 0, 3600.000000, '{\"62\":\"2\"}', '2018-02-16 20:17:48', '2018-02-16 20:17:48'),
(1011, 223, 34, 42, 2000.000000, 2, 0, 0, 4000.000000, '{\"59\":\"2\",\"60\":0}', '2018-02-16 20:24:55', '2018-02-16 20:24:55'),
(1012, 223, 35, 45, 1600.000000, 1, 0, 0, 1600.000000, '{\"201\":\"1\"}', '2018-02-16 20:24:55', '2018-02-16 20:24:55'),
(1013, 223, 27, 68, 300.000000, 3, 0, 0, 900.000000, '{\"100\":\"3\"}', '2018-02-16 20:24:55', '2018-02-16 20:24:55'),
(1014, 223, 27, 70, 270.000000, 1, 0, 0, 270.000000, '{\"220\":\"1\"}', '2018-02-16 20:24:55', '2018-02-16 20:24:55'),
(1015, 223, 31, 47, 800.000000, 3, 0, 0, 2400.000000, '{\"216\":\"3\"}', '2018-02-16 20:24:55', '2018-02-16 20:24:55'),
(1016, 224, 27, 31, 200.000000, 1, 0, 0, 200.000000, '{\"219\":\"1\"}', '2018-02-16 20:27:23', '2018-02-16 20:27:23'),
(1017, 226, 41, 131, 1000.000000, 2, 0, 0, 2000.000000, '{\"196\":\"2\"}', '2018-02-17 21:00:27', '2018-02-17 21:00:27'),
(1018, 226, 41, 132, 1200.000000, 2, 0, 0, 2400.000000, '{\"197\":\"2\"}', '2018-02-17 21:00:27', '2018-02-17 21:00:27'),
(1019, 226, 41, 133, 900.000000, 2, 0, 0, 1800.000000, '{\"198\":\"2\"}', '2018-02-17 21:00:27', '2018-02-17 21:00:27'),
(1020, 226, 41, 134, 1060.000000, 3, 0, 0, 3180.000000, '{\"199\":\"3\"}', '2018-02-17 21:00:27', '2018-02-17 21:00:27'),
(1021, 226, 41, 135, 1150.000000, 2, 0, 0, 2300.000000, '{\"200\":\"2\"}', '2018-02-17 21:00:27', '2018-02-17 21:00:27'),
(1022, 227, 42, 57, 450.000000, 3, 0, 0, 1350.000000, '{\"229\":\"3\"}', '2018-02-17 21:13:57', '2018-02-17 21:13:57'),
(1023, 227, 42, 52, 450.000000, 4, 0, 0, 1800.000000, '{\"228\":\"4\"}', '2018-02-17 21:13:57', '2018-02-17 21:13:57'),
(1024, 227, 27, 67, 175.000000, 3, 0, 0, 525.000000, '{\"99\":\"3\"}', '2018-02-17 21:13:57', '2018-02-17 21:13:57'),
(1025, 227, 27, 70, 175.000000, 2, 0, 0, 350.000000, '{\"220\":\"2\"}', '2018-02-17 21:13:57', '2018-02-17 21:13:57'),
(1026, 227, 43, 77, 250.000000, 8, 0, 0, 2000.000000, '{\"222\":\"8\"}', '2018-02-17 21:13:57', '2018-02-17 21:13:57'),
(1027, 227, 39, 76, 250.000000, 11, 0, 0, 2750.000000, '{\"221\":\"11\"}', '2018-02-17 21:13:57', '2018-02-17 21:13:57'),
(1028, 228, 66, 143, 2900.000000, 12, 0, 0, 34800.000000, '{\"235\":\"12\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1029, 228, 67, 144, 1950.000000, 8, 0, 0, 15600.000000, '{\"236\":\"8\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1030, 228, 68, 145, 3000.000000, 6, 0, 0, 18000.000000, '{\"237\":\"6\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1031, 228, 69, 150, 2500.000000, 5, 0, 0, 12500.000000, '{\"242\":\"5\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1032, 228, 70, 148, 2100.000000, 12, 0, 0, 25200.000000, '{\"240\":\"12\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1033, 228, 70, 149, 2250.000000, 9, 0, 0, 20250.000000, '{\"241\":\"9\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1034, 228, 66, 151, 3050.000000, 12, 0, 0, 36600.000000, '{\"243\":\"12\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1035, 228, 66, 152, 2600.000000, 6, 0, 0, 15600.000000, '{\"244\":\"6\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1036, 228, 71, 153, 2700.000000, 5, 0, 0, 13500.000000, '{\"245\":\"5\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1037, 228, 67, 84, 1510.000000, 9, 0, 0, 13590.000000, '{\"121\":\"1\",\"246\":8}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1038, 229, 39, 76, 350.000000, 20, 0, 92.1053, 6907.894737, '{\"221\":\"20\"}', '2018-02-17 22:39:51', '2018-02-17 22:39:51'),
(1039, 229, 27, 68, 270.000000, 8, 0, 28.4211, 2131.578947, '{\"100\":\"8\"}', '2018-02-17 22:39:51', '2018-02-17 22:39:51'),
(1040, 229, 27, 70, 250.000000, 12, 0, 39.4737, 2960.526316, '{\"220\":\"12\"}', '2018-02-17 22:39:51', '2018-02-17 22:39:51'),
(1041, 230, 44, 73, 430.000000, 23, 0, 200, 9690.000000, '{\"224\":\"23\"}', '2018-02-17 22:48:02', '2018-02-17 22:48:02'),
(1042, 231, 28, 32, 1400.000000, 3, 0, 0, 4200.000000, '{\"227\":\"3\"}', '2018-02-17 22:53:28', '2018-02-17 22:53:28'),
(1043, 231, 28, 32, 1300.000000, 4, 0, 0, 5200.000000, '{\"227\":\"4\"}', '2018-02-17 22:53:28', '2018-02-17 22:53:28'),
(1044, 232, 28, 32, 1300.000000, 1, 0, 0, 1300.000000, '{\"227\":\"1\"}', '2018-02-17 22:55:57', '2018-02-17 22:55:57'),
(1045, 232, 27, 70, 250.000000, 4, 0, 0, 1000.000000, '{\"220\":\"4\"}', '2018-02-17 22:55:57', '2018-02-17 22:55:57'),
(1046, 232, 27, 31, 120.000000, 1, 0, 0, 120.000000, '{\"219\":\"1\"}', '2018-02-17 22:55:57', '2018-02-17 22:55:57'),
(1047, 233, 28, 32, 1300.000000, 2, 0, 37.6812, 2562.318841, '{\"227\":\"2\"}', '2018-02-17 22:58:51', '2018-02-17 22:58:51'),
(1048, 233, 28, 32, 1400.000000, 2, 0, 40.5797, 2759.420290, '{\"227\":\"2\"}', '2018-02-17 22:58:51', '2018-02-17 22:58:51'),
(1049, 233, 27, 68, 250.000000, 6, 0, 21.7391, 1478.260870, '{\"100\":\"6\"}', '2018-02-17 22:58:51', '2018-02-17 22:58:51'),
(1050, 234, 61, 121, 1700.000000, 4, 0, 0, 6800.000000, '{\"170\":\"4\"}', '2018-02-18 21:17:59', '2018-02-18 21:17:59'),
(1051, 234, 49, 46, 2900.000000, 2, 0, 0, 5800.000000, '{\"54\":\"2\"}', '2018-02-18 21:17:59', '2018-02-18 21:17:59'),
(1052, 235, 33, 80, 350.000000, 1, 0, 0, 350.000000, '{\"114\":\"1\"}', '2018-02-18 21:19:26', '2018-02-18 21:19:26'),
(1053, 236, 32, 58, 1000.000000, 1, 0, 0, 1000.000000, '{\"217\":\"1\"}', '2018-02-18 21:29:50', '2018-02-18 21:29:50'),
(1054, 236, 27, 70, 350.000000, 1, 0, 0, 350.000000, '{\"220\":\"1\"}', '2018-02-18 21:29:50', '2018-02-18 21:29:50'),
(1055, 236, 27, 31, 200.000000, 1, 0, 0, 200.000000, '{\"219\":\"1\"}', '2018-02-18 21:29:50', '2018-02-18 21:29:50'),
(1056, 236, 84, 136, 1300.000000, 1, 0, 0, 1300.000000, '{\"205\":\"1\"}', '2018-02-18 21:29:50', '2018-02-18 21:29:50'),
(1057, 237, 49, 31, 1800.000000, 4, 0, 0, 7200.000000, '{\"62\":\"4\"}', '2018-02-18 21:32:25', '2018-02-18 21:32:25'),
(1058, 237, 27, 31, 150.000000, 3, 0, 0, 450.000000, '{\"219\":\"3\"}', '2018-02-18 21:32:25', '2018-02-18 21:32:25'),
(1059, 238, 38, 44, 1100.000000, 5, 0, 0, 5500.000000, '{\"212\":\"5\"}', '2018-02-18 21:39:58', '2018-02-18 21:39:58'),
(1060, 238, 49, 46, 3000.000000, 2, 0, 0, 6000.000000, '{\"54\":\"2\"}', '2018-02-18 21:39:58', '2018-02-18 21:39:58'),
(1061, 239, 49, 46, 2900.000000, 3, 0, 0, 8700.000000, '{\"54\":\"3\"}', '2018-02-18 22:06:32', '2018-02-18 22:12:32'),
(1062, 239, 38, 44, 1000.000000, 2, 0, 0, 2000.000000, '{\"212\":\"2\"}', '2018-02-18 22:06:32', '2018-02-18 22:12:32'),
(1063, 242, 28, 39, 1000.000000, 2, 0, 0, 2000.000000, '{\"65\":\"2\"}', '2018-02-18 22:32:18', '2018-02-18 22:32:18'),
(1064, 243, 39, 76, 400.000000, 2, 0, 0, 800.000000, '{\"221\":\"2\"}', '2018-02-18 22:39:07', '2018-02-18 22:39:07'),
(1065, 243, 27, 31, 150.000000, 1, 0, 0, 150.000000, '{\"219\":\"1\"}', '2018-02-18 22:39:07', '2018-02-18 22:39:07'),
(1066, 243, 44, 75, 800.000000, 1, 0, 0, 800.000000, '{\"223\":\"1\"}', '2018-02-18 22:39:07', '2018-02-18 22:39:07'),
(1067, 243, 34, 42, 1500.000000, 1, 0, 0, 1500.000000, '{\"60\":\"1\"}', '2018-02-18 22:39:07', '2018-02-18 22:39:07'),
(1068, 243, 45, 50, 1500.000000, 4, 0, 0, 6000.000000, '{\"233\":\"4\"}', '2018-02-18 22:39:07', '2018-02-18 22:39:07'),
(1069, 243, 45, 50, 2000.000000, 1, 0, 0, 2000.000000, '{\"233\":\"1\"}', '2018-02-18 22:39:07', '2018-02-18 22:39:07'),
(1070, 244, 48, 64, 150.000000, 1, 0, 0, 150.000000, '{\"208\":\"1\"}', '2018-02-18 22:42:00', '2018-02-18 22:42:00'),
(1071, 249, 27, 31, 200.000000, 8, 0, 0, 1600.000000, '{\"219\":\"8\"}', '2018-02-18 23:13:45', '2018-02-18 23:13:45'),
(1072, 250, 49, 46, 2900.000000, 2, 0, 0, 5800.000000, '{\"54\":\"2\"}', '2018-02-18 23:16:17', '2018-02-18 23:16:17'),
(1073, 251, 27, 31, 150.000000, 2, 0, 0, 300.000000, '{\"219\":\"2\"}', '2018-02-18 23:18:20', '2018-02-18 23:18:20'),
(1074, 252, 28, 32, 1300.000000, 2, 0, 0, 2600.000000, '{\"227\":\"2\"}', '2018-02-18 23:19:28', '2018-02-18 23:19:28'),
(1075, 255, 35, 45, 1700.000000, 1, 0, 0, 1700.000000, '{\"201\":\"1\"}', '2018-02-18 23:34:43', '2018-02-18 23:34:43'),
(1076, 256, 67, 84, 1900.000000, 1, 0, 0, 1900.000000, '{\"246\":\"1\"}', '2018-02-18 23:36:07', '2018-02-18 23:36:07'),
(1077, 257, 27, 70, 220.000000, 40, 0, 0, 8800.000000, '{\"220\":\"40\"}', '2018-02-19 23:30:26', '2018-02-19 23:30:26'),
(1078, 257, 28, 32, 1300.000000, 4, 0, 0, 5200.000000, '{\"227\":\"4\"}', '2018-02-19 23:30:26', '2018-02-19 23:30:26'),
(1079, 257, 28, 33, 1400.000000, 6, 0, 0, 8400.000000, '{\"86\":\"6\"}', '2018-02-19 23:30:26', '2018-02-19 23:30:26'),
(1080, 257, 84, 137, 250.000000, 4, 0, 0, 1000.000000, '{\"206\":\"4\"}', '2018-02-19 23:30:26', '2018-02-19 23:30:26'),
(1081, 257, 28, 36, 600.000000, 4, 0, 0, 2400.000000, '{\"55\":\"4\"}', '2018-02-19 23:30:26', '2018-02-19 23:30:26'),
(1082, 258, 28, 33, 1400.000000, 2, 0, 40, 2760.000000, '{\"86\":\"2\"}', '2018-02-19 23:34:56', '2018-02-19 23:34:56'),
(1083, 259, 27, 68, 250.000000, 2, 0, 0, 500.000000, '{\"100\":\"2\"}', '2018-02-19 23:37:29', '2018-02-19 23:37:29'),
(1084, 259, 27, 69, 170.000000, 2, 0, 0, 340.000000, '{\"101\":\"2\"}', '2018-02-19 23:37:29', '2018-02-19 23:37:29'),
(1085, 259, 27, 65, 250.000000, 2, 0, 0, 500.000000, '{\"97\":\"2\"}', '2018-02-19 23:37:29', '2018-02-19 23:37:29'),
(1086, 260, 33, 80, 350.000000, 2, 0, 0, 700.000000, '{\"114\":\"2\"}', '2018-02-20 17:03:39', '2018-02-20 17:03:39'),
(1087, 260, 27, 31, 150.000000, 2, 0, 0, 300.000000, '{\"219\":\"2\"}', '2018-02-20 17:03:39', '2018-02-20 17:03:39'),
(1088, 260, 27, 68, 350.000000, 1, 0, 0, 350.000000, '{\"100\":\"1\"}', '2018-02-20 17:03:39', '2018-02-20 17:03:39'),
(1089, 260, 76, 95, 2400.000000, 2, 0, 0, 4800.000000, '{\"133\":\"2\"}', '2018-02-20 17:03:39', '2018-02-20 17:03:39'),
(1090, 260, 27, 72, 150.000000, 2, 0, 0, 300.000000, '{\"104\":\"2\"}', '2018-02-20 17:03:39', '2018-02-20 17:03:39'),
(1091, 260, 28, 32, 1300.000000, 3, 0, 0, 3900.000000, '{\"227\":\"3\"}', '2018-02-20 17:03:39', '2018-02-20 17:03:39'),
(1092, 261, 28, 32, 1300.000000, 7, 0, 30.2326, 9069.767442, '{\"227\":\"7\"}', '2018-02-23 21:29:08', '2018-02-23 21:29:08'),
(1093, 261, 28, 33, 1400.000000, 3, 0, 13.9535, 4186.046512, '{\"86\":\"3\"}', '2018-02-23 21:29:08', '2018-02-23 21:29:08'),
(1094, 261, 39, 41, 250.000000, 9, 0, 7.47508, 2242.524917, '{\"112\":\"9\"}', '2018-02-23 21:29:08', '2018-02-23 21:29:08'),
(1095, 261, 27, 68, 260.000000, 12, 0, 10.3654, 3109.634551, '{\"100\":\"12\"}', '2018-02-23 21:29:08', '2018-02-23 21:29:08'),
(1096, 261, 27, 66, 380.000000, 9, 0, 11.3621, 3408.637874, '{\"98\":\"9\"}', '2018-02-23 21:29:08', '2018-02-23 21:29:08'),
(1097, 261, 27, 79, 250.000000, 20, 0, 16.6113, 4983.388704, '{\"232\":\"20\"}', '2018-02-23 21:29:08', '2018-02-23 21:29:08'),
(1098, 262, 28, 32, 1300.000000, 6, 0, 0, 7800.000000, '{\"227\":\"6\"}', '2018-02-23 21:35:39', '2018-02-23 21:35:39'),
(1099, 262, 28, 33, 1400.000000, 1, 0, 0, 1400.000000, '{\"86\":\"1\"}', '2018-02-23 21:35:39', '2018-02-23 21:35:39'),
(1100, 263, 43, 77, 800.000000, 5, 0, 0, 4000.000000, '{\"222\":\"5\"}', '2018-02-23 22:25:06', '2018-02-23 22:25:06'),
(1101, 264, 55, 102, 3200.000000, 7, 0, 0, 22400.000000, '{\"160\":\"7\"}', '2018-02-23 22:28:02', '2018-02-23 22:28:02'),
(1102, 264, 53, 119, 3000.000000, 7, 0, 0, 21000.000000, '{\"167\":\"7\"}', '2018-02-23 22:28:02', '2018-02-23 22:28:02'),
(1103, 265, 44, 73, 450.000000, 6, 0, 0, 2700.000000, '{\"224\":\"6\"}', '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(1104, 265, 27, 31, 200.000000, 3, 0, 0, 600.000000, '{\"219\":\"3\"}', '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(1105, 265, 75, 129, 3300.000000, 5, 0, 0, 16500.000000, '{\"187\":\"5\"}', '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(1106, 265, 82, 106, 700.000000, 1, 0, 0, 700.000000, '{\"153\":\"1\"}', '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(1107, 265, 42, 57, 900.000000, 1, 0, 0, 900.000000, '{\"229\":\"1\"}', '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(1108, 266, 43, 77, 900.000000, 2, 0, 0, 1800.000000, '{\"222\":\"2\"}', '2018-02-23 22:46:58', '2018-02-23 22:46:58'),
(1109, 266, 28, 33, 1100.000000, 2, 0, 0, 2200.000000, '{\"86\":\"2\"}', '2018-02-23 22:46:58', '2018-02-23 22:46:58'),
(1110, 267, 27, 68, 200.000000, 3, 0, 0, 600.000000, '{\"100\":\"3\"}', '2018-02-23 22:50:12', '2018-02-23 22:50:12'),
(1111, 268, 43, 77, 650.000000, 1, 0, 0, 650.000000, '{\"222\":\"1\"}', '2018-02-24 15:58:37', '2018-02-24 15:58:37'),
(1112, 268, 61, 121, 1700.000000, 1, 0, 0, 1700.000000, '{\"170\":\"1\"}', '2018-02-24 15:58:37', '2018-02-24 15:58:37'),
(1113, 269, 43, 77, 600.000000, 1, 0, 0.108349, 599.891651, '{\"222\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1114, 269, 27, 31, 180.000000, 2, 0, 0.0650093, 359.934991, '{\"219\":\"2\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1115, 269, 48, 64, 100.000000, 1, 0, 0.0180581, 99.981942, '{\"208\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1116, 269, 27, 72, 200.000000, 1, 0, 0.0361163, 199.963884, '{\"104\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1117, 269, 33, 80, 350.000000, 1, 0, 0.0632035, 349.936796, '{\"114\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1118, 269, 27, 70, 267.000000, 9, 0, 0.433937, 2402.566063, '{\"220\":\"9\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1119, 269, 27, 31, 225.000000, 2, 0, 0.0812617, 449.918738, '{\"219\":\"2\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1120, 269, 39, 76, 500.000000, 1, 0, 0.0902907, 499.909709, '{\"221\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1121, 269, 43, 77, 450.000000, 2, 0, 0.162523, 899.837477, '{\"222\":\"2\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1122, 269, 48, 64, 100.000000, 1, 0, 0.0180581, 99.981942, '{\"208\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1123, 269, 51, 60, 50.000000, 2, 0, 0.0180581, 99.981942, '{\"207\":\"2\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1124, 269, 33, 80, 350.000000, 1, 0, 0.0632035, 349.936796, '{\"114\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1125, 269, 76, 95, 2100.000000, 1, 0, 0.379221, 2099.620779, '{\"133\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1126, 269, 75, 129, 3200.000000, 1, 0, 0.577861, 3199.422139, '{\"187\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1127, 269, 28, 32, 1500.000000, 1, 0, 0.270872, 1499.729128, '{\"227\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1128, 269, 27, 31, 250.000000, 1, 0, 0.0451454, 249.954855, '{\"219\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1129, 269, 27, 70, 300.000000, 3, 0, 0.162523, 899.837477, '{\"220\":\"3\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1130, 269, 27, 31, 180.000000, 5, 0, 0.162523, 899.837477, '{\"219\":\"5\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1131, 269, 27, 72, 150.000000, 2, 0, 0.0541744, 299.945826, '{\"104\":\"2\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1132, 269, 27, 31, 200.000000, 1, 0, 0.0361163, 199.963884, '{\"219\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1133, 269, 39, 76, 500.000000, 1, 0, 0.0902907, 499.909709, '{\"221\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1134, 269, 27, 71, 350.000000, 1, 0, 0.0632035, 349.936796, '{\"103\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1135, 270, 48, 64, 100.000000, 3, 0, 0, 300.000000, '{\"208\":\"3\"}', '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(1136, 270, 35, 45, 1800.000000, 1, 0, 0, 1800.000000, '{\"201\":\"1\"}', '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(1137, 270, 27, 31, 120.000000, 20, 0, 0, 2400.000000, '{\"219\":\"20\"}', '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(1138, 270, 39, 76, 500.000000, 1, 0, 0, 500.000000, '{\"221\":\"1\"}', '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(1139, 270, 48, 64, 100.000000, 1, 0, 0, 100.000000, '{\"208\":\"1\"}', '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(1140, 270, 43, 77, 500.000000, 1, 0, 0, 500.000000, '{\"222\":\"1\"}', '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(1141, 270, 27, 68, 350.000000, 1, 0, 0, 350.000000, '{\"100\":\"1\"}', '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(1142, 271, 32, 58, 800.000000, 1, 0, 0, 800.000000, '{\"217\":\"1\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1143, 271, 27, 68, 350.000000, 1, 0, 0, 350.000000, '{\"100\":\"1\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1144, 271, 43, 77, 600.000000, 8, 0, 0, 4800.000000, '{\"222\":\"8\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1145, 271, 43, 77, 450.000000, 1, 0, 0, 450.000000, '{\"222\":\"1\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1146, 271, 27, 31, 350.000000, 3, 0, 0, 1050.000000, '{\"219\":\"3\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1147, 271, 27, 79, 350.000000, 2, 0, 0, 700.000000, '{\"232\":\"2\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1148, 271, 28, 32, 1550.000000, 2, 0, 0, 3100.000000, '{\"227\":\"2\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1149, 271, 76, 95, 1150.000000, 1, 0, 0, 1150.000000, '{\"133\":\"1\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1150, 271, 32, 54, 1200.000000, 1, 0, 0, 1200.000000, '{\"83\":\"1\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1151, 271, 43, 77, 600.000000, 2, 0, 0, 1200.000000, '{\"222\":\"2\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1152, 271, 27, 70, 300.000000, 1, 0, 0, 300.000000, '{\"220\":\"1\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1153, 272, 28, 32, 1600.000000, 1, 0, 0, 1600.000000, '{\"227\":\"1\"}', '2018-02-24 16:34:23', '2018-02-24 16:34:23'),
(1154, 272, 33, 80, 350.000000, 1, 0, 0, 350.000000, '{\"114\":\"1\"}', '2018-02-24 16:34:23', '2018-02-24 16:34:23'),
(1155, 272, 48, 64, 100.000000, 3, 0, 0, 300.000000, '{\"208\":\"3\"}', '2018-02-24 16:34:23', '2018-02-24 16:34:23'),
(1156, 272, 76, 95, 2000.000000, 1, 0, 0, 2000.000000, '{\"133\":\"1\"}', '2018-02-24 16:34:23', '2018-02-24 16:34:23'),
(1157, 272, 27, 31, 300.000000, 1, 0, 0, 300.000000, '{\"219\":\"1\"}', '2018-02-24 16:34:23', '2018-02-24 16:34:23'),
(1158, 273, 27, 31, 183.000000, 3, 0, 0, 549.000000, '{\"219\":\"3\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1159, 273, 27, 70, 400.000000, 1, 0, 0, 400.000000, '{\"220\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1160, 273, 27, 71, 450.000000, 1, 0, 0, 450.000000, '{\"103\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1161, 273, 27, 79, 550.000000, 1, 0, 0, 550.000000, '{\"232\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1162, 273, 51, 60, 200.000000, 1, 0, 0, 200.000000, '{\"207\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1163, 273, 27, 31, 300.000000, 1, 0, 0, 300.000000, '{\"219\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1164, 273, 43, 77, 500.000000, 2, 0, 0, 1000.000000, '{\"222\":\"2\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1165, 273, 39, 76, 400.000000, 1, 0, 0, 400.000000, '{\"221\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1166, 273, 39, 76, 500.000000, 1, 0, 0, 500.000000, '{\"221\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1167, 273, 48, 64, 90.000000, 8, 0, 0, 720.000000, '{\"208\":\"8\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1168, 273, 27, 71, 400.000000, 1, 0, 0, 400.000000, '{\"103\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1169, 273, 48, 64, 100.000000, 1, 0, 0, 100.000000, '{\"208\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1170, 273, 29, 51, 900.000000, 1, 0, 0, 900.000000, '{\"225\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1171, 274, 27, 70, 275.000000, 4, 0, 0, 1100.000000, '{\"220\":\"4\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1172, 274, 27, 31, 266.000000, 3, 0, 0, 798.000000, '{\"219\":\"3\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1173, 274, 32, 58, 800.000000, 2, 0, 0, 1600.000000, '{\"217\":\"2\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1174, 274, 27, 79, 325.000000, 2, 0, 0, 650.000000, '{\"232\":\"2\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1175, 274, 27, 68, 340.000000, 3, 0, 0, 1020.000000, '{\"100\":\"3\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1176, 274, 72, 93, 1250.000000, 2, 0, 0, 2500.000000, '{\"194\":\"2\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1177, 274, 28, 33, 1475.000000, 4, 0, 0, 5900.000000, '{\"86\":\"4\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1178, 274, 28, 33, 1600.000000, 1, 0, 0, 1600.000000, '{\"86\":\"1\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1179, 274, 28, 36, 800.000000, 1, 0, 0, 800.000000, '{\"55\":\"1\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1180, 274, 86, 140, 300.000000, 1, 0, 0, 300.000000, '{\"226\":\"1\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1181, 274, 27, 79, 250.000000, 2, 0, 0, 500.000000, '{\"232\":\"2\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1182, 274, 33, 80, 365.000000, 2, 0, 0, 730.000000, '{\"114\":\"2\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1183, 274, 34, 42, 1500.000000, 1, 0, 0, 1500.000000, '{\"60\":\"1\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1184, 274, 43, 77, 600.000000, 2, 0, 0, 1200.000000, '{\"222\":\"2\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1185, 275, 43, 77, 650.000000, 2, 0, 0, 1300.000000, '{\"222\":\"2\"}', '2018-02-24 17:19:25', '2018-02-24 17:19:25'),
(1186, 275, 32, 58, 900.000000, 1, 0, 0, 900.000000, '{\"217\":\"1\"}', '2018-02-24 17:19:25', '2018-02-24 17:19:25'),
(1187, 275, 27, 31, 267.000000, 6, 0, 0, 1602.000000, '{\"219\":\"6\"}', '2018-02-24 17:19:25', '2018-02-24 17:19:25'),
(1188, 275, 27, 71, 400.000000, 1, 0, 0, 400.000000, '{\"103\":\"1\"}', '2018-02-24 17:19:25', '2018-02-24 17:19:25'),
(1189, 275, 70, 147, 3000.000000, 1, 0, 0, 3000.000000, '{\"239\":\"1\"}', '2018-02-24 17:19:25', '2018-02-24 17:19:25'),
(1190, 275, 27, 70, 300.000000, 1, 0, 0, 300.000000, '{\"220\":\"1\"}', '2018-02-24 17:19:25', '2018-02-24 17:19:25'),
(1191, 276, 27, 31, 110.000000, 35, 0, 0, 3850.000000, '{\"272\":\"35\"}', '2018-02-25 00:16:54', '2018-02-25 00:16:54'),
(1192, 277, 27, 31, 170.000000, 30, 0, 17.3175, 5082.682513, '{\"272\":\"30\"}', '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(1193, 277, 39, 41, 300.000000, 18, 0, 18.3362, 5381.663837, '{\"271\":\"18\"}', '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(1194, 277, 39, 156, 350.000000, 28, 0, 33.2767, 9766.723260, '{\"270\":\"28\"}', '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(1195, 277, 39, 156, 320.000000, 8, 0, 8.6927, 2551.307301, '{\"270\":\"8\"}', '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(1196, 277, 27, 70, 220.000000, 22, 0, 16.4346, 4823.565365, '{\"269\":\"22\"}', '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(1197, 277, 27, 31, 120.000000, 190, 0, 77.4194, 22722.580645, '{\"272\":\"190\"}', '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(1198, 277, 31, 47, 400.000000, 21, 0, 28.5229, 8371.477080, '{\"282\":\"21\"}', '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(1199, 278, 28, 32, 1500.000000, 12, 0, 121.212, 17878.787879, '{\"255\":\"12\"}', '2018-02-25 00:34:55', '2018-02-25 00:34:55'),
(1200, 278, 28, 32, 1300.000000, 9, 0, 78.7879, 11621.212121, '{\"255\":\"9\"}', '2018-02-25 00:34:55', '2018-02-25 00:34:55'),
(1201, 279, 73, 82, 3300.000000, 6, 0, 0, 19800.000000, '{\"321\":\"6\"}', '2018-02-25 00:38:04', '2018-02-25 00:38:04'),
(1202, 280, 27, 31, 130.000000, 8, 0, 1.47832, 1038.521677, '{\"272\":\"8\"}', '2018-02-25 00:46:56', '2018-02-25 00:46:56'),
(1203, 280, 27, 70, 220.000000, 18, 0, 5.629, 3954.371002, '{\"269\":\"18\"}', '2018-02-25 00:46:56', '2018-02-25 00:46:56'),
(1204, 280, 27, 31, 180.000000, 4, 0, 1.02345, 718.976546, '{\"272\":\"4\"}', '2018-02-25 00:46:56', '2018-02-25 00:46:56'),
(1205, 280, 39, 156, 350.000000, 5, 0, 2.48756, 1747.512438, '{\"270\":\"5\"}', '2018-02-25 00:46:56', '2018-02-25 00:46:56'),
(1206, 280, 27, 31, 300.000000, 2, 0, 0.852878, 599.147122, '{\"272\":\"2\"}', '2018-02-25 00:46:56', '2018-02-25 00:46:56'),
(1207, 280, 40, 81, 2000.000000, 3, 0, 8.52878, 5991.471215, '{\"320\":\"3\"}', '2018-02-25 00:46:56', '2018-02-25 00:46:56'),
(1208, 281, 27, 31, 120.000000, 15, 0, 4.57433, 1795.425667, '{\"272\":\"15\"}', '2018-02-25 00:54:36', '2018-02-25 00:54:36'),
(1209, 281, 27, 31, 170.000000, 1, 0, 0.43202, 169.567980, '{\"272\":\"1\"}', '2018-02-25 00:54:36', '2018-02-25 00:54:36'),
(1210, 281, 27, 70, 270.000000, 10, 0, 6.8615, 2693.138501, '{\"269\":\"10\"}', '2018-02-25 00:54:36', '2018-02-25 00:54:36'),
(1211, 281, 75, 96, 1600.000000, 2, 0, 8.13215, 3191.867853, '{\"302\":\"2\"}', '2018-02-25 00:54:36', '2018-02-25 00:54:36'),
(1212, 282, 78, 99, 3500.000000, 1, 0, 0, 3500.000000, '{\"332\":\"1\"}', '2018-02-25 01:05:44', '2018-02-25 01:05:44'),
(1213, 282, 55, 100, 3500.000000, 2, 0, 0, 7000.000000, '{\"247\":\"2\"}', '2018-02-25 01:05:44', '2018-02-25 01:05:44'),
(1214, 282, 67, 84, 2000.000000, 1, 0, 0, 2000.000000, '{\"328\":\"1\"}', '2018-02-25 01:05:44', '2018-02-25 01:05:44'),
(1215, 282, 27, 70, 300.000000, 2, 0, 0, 600.000000, '{\"269\":\"2\"}', '2018-02-25 01:05:44', '2018-02-25 01:05:44'),
(1216, 282, 39, 41, 450.000000, 2, 0, 0, 900.000000, '{\"271\":\"2\"}', '2018-02-25 01:05:44', '2018-02-25 01:05:44'),
(1217, 283, 45, 50, 1300.000000, 4, 0, 0, 5200.000000, '{\"262\":\"4\"}', '2018-02-25 18:52:33', '2018-02-25 18:52:33'),
(1218, 283, 44, 75, 700.000000, 3, 0, 0, 2100.000000, '{\"252\":\"3\"}', '2018-02-25 18:52:33', '2018-02-25 18:52:33'),
(1219, 284, 55, 100, 3100.000000, 2, 0, 0, 6200.000000, '{\"247\":\"2\"}', '2018-02-25 18:59:13', '2018-02-25 18:59:13'),
(1220, 284, 59, 89, 3800.000000, 2, 0, 0, 7600.000000, '{\"315\":\"2\"}', '2018-02-25 18:59:13', '2018-02-25 18:59:13'),
(1221, 284, 55, 102, 3200.000000, 1, 0, 0, 3200.000000, '{\"248\":\"1\"}', '2018-02-25 18:59:13', '2018-02-25 18:59:13'),
(1222, 285, 72, 93, 1150.000000, 9, 0, 23.5763, 10326.423690, '{\"298\":\"9\"}', '2018-02-25 19:02:44', '2018-02-25 19:02:44'),
(1223, 285, 75, 96, 1600.000000, 2, 0, 7.28929, 3192.710706, '{\"302\":\"2\"}', '2018-02-25 19:02:44', '2018-02-25 19:02:44'),
(1224, 285, 75, 95, 1200.000000, 7, 0, 19.1344, 8380.865604, '{\"337\":\"7\"}', '2018-02-25 19:02:44', '2018-02-25 19:02:44'),
(1225, 286, 72, 93, 1150.000000, 25, 0, 50, 28700.000000, '{\"298\":\"25\"}', '2018-02-25 19:08:08', '2018-02-25 19:08:08'),
(1226, 287, 38, 44, 1350.000000, 5, 0, 0, 6750.000000, '{\"299\":\"5\"}', '2018-02-25 19:14:46', '2018-02-25 19:14:46'),
(1227, 287, 75, 95, 1250.000000, 2, 0, 0, 2500.000000, '{\"337\":\"2\"}', '2018-02-25 19:14:46', '2018-02-25 19:14:46'),
(1228, 287, 45, 50, 1400.000000, 4, 0, 0, 5600.000000, '{\"262\":\"4\"}', '2018-02-25 19:14:46', '2018-02-25 19:14:46'),
(1229, 287, 44, 75, 800.000000, 3, 0, 0, 2400.000000, '{\"252\":\"3\"}', '2018-02-25 19:14:46', '2018-02-25 19:14:46'),
(1230, 287, 67, 84, 1750.000000, 7, 0, 0, 12250.000000, '{\"328\":\"7\"}', '2018-02-25 19:14:46', '2018-02-25 19:14:46'),
(1231, 288, 44, 75, 750.000000, 10, 0, 0, 7500.000000, '{\"252\":\"10\"}', '2018-02-25 19:19:58', '2018-02-25 19:19:58'),
(1232, 288, 45, 49, 2200.000000, 3, 0, 0, 6600.000000, '{\"263\":\"3\"}', '2018-02-25 19:19:58', '2018-02-25 19:19:58'),
(1233, 288, 45, 50, 1300.000000, 8, 0, 0, 10400.000000, '{\"262\":\"8\"}', '2018-02-25 19:19:58', '2018-02-25 19:19:58'),
(1234, 288, 75, 96, 1900.000000, 6, 0, 0, 11400.000000, '{\"302\":\"6\"}', '2018-02-25 19:19:58', '2018-02-25 19:19:58'),
(1235, 288, 51, 62, 20.000000, 72, 0, 0, 1440.000000, '{\"268\":\"72\"}', '2018-02-25 19:19:58', '2018-02-25 19:19:58'),
(1236, 289, 44, 75, 700.000000, 10, 0, 0, 7000.000000, '{\"252\":\"10\"}', '2018-02-25 19:22:56', '2018-02-25 19:22:56'),
(1237, 289, 27, 70, 225.000000, 16, 0, 0, 3600.000000, '{\"269\":\"16\"}', '2018-02-25 19:22:56', '2018-02-25 19:22:56'),
(1238, 290, 51, 62, 30.000000, 42, 0, 18.6207, 1241.379310, '{\"268\":\"42\"}', '2018-02-25 19:25:18', '2018-02-25 19:25:18'),
(1239, 290, 51, 61, 50.000000, 56, 0, 41.3793, 2758.620690, '{\"267\":\"56\"}', '2018-02-25 19:25:18', '2018-02-25 19:25:18'),
(1240, 291, 28, 32, 1400.000000, 5, 0, 0, 7000.000000, '{\"255\":\"5\"}', '2018-02-25 19:27:12', '2018-02-25 19:27:12'),
(1241, 291, 44, 75, 750.000000, 4, 0, 0, 3000.000000, '{\"252\":\"4\"}', '2018-02-25 19:27:12', '2018-02-25 19:27:12'),
(1242, 292, 44, 75, 800.000000, 6, 0, 0, 4800.000000, '{\"252\":\"6\"}', '2018-02-25 19:46:47', '2018-02-25 19:46:47'),
(1243, 292, 78, 99, 3200.000000, 1, 0, 0, 3200.000000, '{\"332\":\"1\"}', '2018-02-25 19:46:47', '2018-02-25 19:46:47'),
(1244, 293, 44, 75, 800.000000, 1, 0, 0, 800.000000, '{\"252\":\"1\"}', '2018-02-25 19:49:55', '2018-02-25 19:49:55'),
(1245, 294, 45, 49, 2200.000000, 5, 0, 0, 11000.000000, '{\"263\":\"5\"}', '2018-02-25 19:54:16', '2018-02-25 19:54:16'),
(1246, 294, 28, 32, 1300.000000, 2, 0, 0, 2600.000000, '{\"255\":\"2\"}', '2018-02-25 19:54:16', '2018-02-25 19:54:16'),
(1247, 294, 28, 32, 1400.000000, 4, 0, 0, 5600.000000, '{\"255\":\"4\"}', '2018-02-25 19:54:16', '2018-02-25 19:54:16'),
(1248, 295, 44, 75, 750.000000, 4, 0, 2.34192, 2997.658080, '{\"252\":\"4\"}', '2018-02-25 20:02:35', '2018-02-25 20:02:35'),
(1249, 295, 44, 75, 800.000000, 2, 0, 1.24902, 1598.750976, '{\"252\":\"2\"}', '2018-02-25 20:02:35', '2018-02-25 20:02:35'),
(1250, 295, 45, 50, 1300.000000, 7, 0, 7.10383, 9092.896175, '{\"262\":\"7\"}', '2018-02-25 20:02:35', '2018-02-25 20:02:35'),
(1251, 295, 32, 54, 1200.000000, 7, 0, 6.55738, 8393.442623, '{\"284\":\"7\"}', '2018-02-25 20:02:35', '2018-02-25 20:02:35'),
(1252, 295, 42, 57, 800.000000, 2, 0, 1.24902, 1598.750976, '{\"261\":\"2\"}', '2018-02-25 20:02:35', '2018-02-25 20:02:35'),
(1253, 295, 51, 60, 120.000000, 16, 0, 1.49883, 1918.501171, '{\"264\":\"16\"}', '2018-02-25 20:02:35', '2018-02-25 20:02:35'),
(1254, 296, 28, 32, 1350.000000, 6, 0, 163.361, 7936.638655, '{\"255\":\"6\"}', '2018-02-25 20:05:47', '2018-02-25 20:05:47'),
(1255, 296, 75, 96, 1900.000000, 2, 0, 76.6387, 3723.361345, '{\"302\":\"2\"}', '2018-02-25 20:05:47', '2018-02-25 20:05:47'),
(1256, 297, 27, 31, 110.000000, 16, 0, 4.0367, 1755.963303, '{\"272\":\"16\"}', '2018-02-25 20:10:56', '2018-02-25 20:10:56'),
(1257, 297, 27, 70, 230.000000, 4, 0, 2.11009, 917.889908, '{\"269\":\"4\"}', '2018-02-25 20:10:56', '2018-02-25 20:10:56'),
(1258, 297, 27, 31, 170.000000, 7, 0, 2.72936, 1187.270642, '{\"272\":\"7\"}', '2018-02-25 20:10:56', '2018-02-25 20:10:56'),
(1259, 297, 27, 31, 200.000000, 4, 0, 1.83486, 798.165138, '{\"272\":\"4\"}', '2018-02-25 20:10:56', '2018-02-25 20:10:56'),
(1260, 297, 27, 71, 250.000000, 5, 0, 2.86697, 1247.133028, '{\"278\":\"5\"}', '2018-02-25 20:10:56', '2018-02-25 20:10:56');
INSERT INTO `inventory_product_sales_item` (`id`, `fk_sales_id`, `fk_product_id`, `fk_model_id`, `product_price_amount`, `sales_qty`, `small_qty`, `product_wise_discount`, `product_paid_amount`, `inventory_item_id`, `created_at`, `updated_at`) VALUES
(1261, 297, 43, 77, 425.000000, 2, 0, 1.94954, 848.050459, '{\"274\":\"2\"}', '2018-02-25 20:10:56', '2018-02-25 20:10:56'),
(1262, 297, 39, 76, 325.000000, 6, 0, 4.47248, 1945.527523, '{\"341\":\"6\"}', '2018-02-25 20:10:56', '2018-02-25 20:10:56'),
(1263, 298, 45, 50, 1300.000000, 6, 0, 0, 7800.000000, '{\"262\":\"6\"}', '2018-02-25 20:14:40', '2018-02-25 20:14:40'),
(1264, 298, 44, 75, 750.000000, 2, 0, 0, 1500.000000, '{\"252\":\"2\"}', '2018-02-25 20:14:40', '2018-02-25 20:14:40'),
(1265, 299, 28, 32, 1400.000000, 2, 0, 0, 2800.000000, '{\"255\":\"2\"}', '2018-02-25 20:21:01', '2018-02-25 20:21:01'),
(1266, 299, 28, 32, 1300.000000, 3, 0, 0, 3900.000000, '{\"255\":\"3\"}', '2018-02-25 20:21:01', '2018-02-25 20:21:01'),
(1267, 299, 77, 97, 3500.000000, 2, 0, 0, 7000.000000, '{\"331\":\"2\"}', '2018-02-25 20:21:01', '2018-02-25 20:21:01'),
(1268, 300, 45, 50, 1300.000000, 7, 0, 0, 9100.000000, '{\"262\":\"7\"}', '2018-02-25 20:52:12', '2018-02-25 20:52:12'),
(1269, 300, 42, 57, 800.000000, 2, 0, 0, 1600.000000, '{\"261\":\"2\"}', '2018-02-25 20:52:12', '2018-02-25 20:52:12'),
(1270, 300, 44, 75, 800.000000, 1, 0, 0, 800.000000, '{\"252\":\"1\"}', '2018-02-25 20:52:12', '2018-02-25 20:52:12'),
(1271, 300, 44, 75, 750.000000, 2, 0, 0, 1500.000000, '{\"252\":\"2\"}', '2018-02-25 20:52:12', '2018-02-25 20:52:12'),
(1272, 301, 28, 32, 1300.000000, 2, 0, 0, 2600.000000, '{\"255\":\"2\"}', '2018-02-25 20:57:01', '2018-02-25 20:57:01'),
(1273, 301, 28, 32, 1400.000000, 4, 0, 0, 5600.000000, '{\"255\":\"4\"}', '2018-02-25 20:57:01', '2018-02-25 20:57:01'),
(1274, 301, 28, 39, 800.000000, 3, 0, 0, 2400.000000, '{\"260\":\"3\"}', '2018-02-25 20:57:01', '2018-02-25 20:57:01'),
(1275, 302, 28, 32, 1250.000000, 5, 0, 0, 6250.000000, '{\"255\":\"5\"}', '2018-02-25 20:58:37', '2018-02-25 20:58:37'),
(1276, 303, 28, 32, 1300.000000, 8, 0, 0, 10400.000000, '{\"255\":\"8\"}', '2018-02-25 21:01:25', '2018-02-25 21:01:25'),
(1277, 303, 28, 32, 1400.000000, 1, 0, 0, 1400.000000, '{\"255\":\"1\"}', '2018-02-25 21:01:25', '2018-02-25 21:01:25'),
(1278, 304, 32, 58, 800.000000, 6, 0, 0, 4800.000000, '{\"283\":\"6\"}', '2018-02-25 21:05:02', '2018-02-25 21:05:02'),
(1279, 304, 39, 76, 350.000000, 2, 0, 0, 700.000000, '{\"341\":\"2\"}', '2018-02-25 21:05:02', '2018-02-25 21:05:02'),
(1280, 304, 84, 136, 900.000000, 2, 0, 0, 1800.000000, '{\"290\":\"2\"}', '2018-02-25 21:05:02', '2018-02-25 21:05:02'),
(1281, 305, 28, 32, 1300.000000, 2, 0, 0, 2600.000000, '{\"255\":\"2\"}', '2018-02-25 21:10:47', '2018-02-25 21:10:47'),
(1282, 305, 28, 32, 1200.000000, 7, 0, 0, 8400.000000, '{\"255\":\"7\"}', '2018-02-25 21:10:47', '2018-02-25 21:10:47'),
(1283, 305, 45, 50, 1200.000000, 2, 0, 0, 2400.000000, '{\"262\":\"2\"}', '2018-02-25 21:10:47', '2018-02-25 21:10:47'),
(1284, 305, 29, 51, 800.000000, 4, 0, 0, 3200.000000, '{\"285\":\"4\"}', '2018-02-25 21:10:47', '2018-02-25 21:10:47'),
(1285, 306, 29, 51, 900.000000, 7, 0, 0, 6300.000000, '{\"285\":\"7\"}', '2018-02-25 21:16:55', '2018-02-25 21:16:55'),
(1286, 306, 28, 32, 1350.000000, 2, 0, 0, 2700.000000, '{\"255\":\"2\"}', '2018-02-25 21:16:55', '2018-02-25 21:16:55'),
(1287, 307, 78, 99, 3200.000000, 2, 0, 0, 6400.000000, '{\"332\":\"2\"}', '2018-02-25 21:22:00', '2018-02-25 21:22:00'),
(1288, 307, 39, 156, 350.000000, 14, 0, 0, 4900.000000, '{\"270\":\"14\"}', '2018-02-25 21:22:00', '2018-02-25 21:22:00'),
(1289, 307, 27, 70, 250.000000, 2, 0, 0, 500.000000, '{\"269\":\"2\"}', '2018-02-25 21:22:00', '2018-02-25 21:22:00'),
(1290, 308, 44, 74, 1500.000000, 8, 0, 0, 12000.000000, '{\"293\":\"8\"}', '2018-02-25 21:24:59', '2018-02-25 21:24:59'),
(1291, 308, 39, 41, 250.000000, 1, 0, 0, 250.000000, '{\"271\":\"1\"}', '2018-02-25 21:24:59', '2018-02-25 21:24:59'),
(1292, 309, 35, 59, 1600.000000, 1, 0, 0, 1600.000000, '{\"256\":\"1\"}', '2018-02-25 21:27:39', '2018-02-25 21:27:39'),
(1293, 310, 30, 48, 700.000000, 2, 0, 0, 1400.000000, '{\"286\":\"2\"}', '2018-02-25 21:29:40', '2018-02-25 21:29:40'),
(1294, 311, 44, 75, 650.000000, 3, 0, 4.74453, 1945.255474, '{\"252\":\"3\"}', '2018-02-25 21:32:15', '2018-02-25 21:32:15'),
(1295, 311, 44, 73, 450.000000, 12, 0, 13.1387, 5386.861314, '{\"253\":\"12\"}', '2018-02-25 21:32:15', '2018-02-25 21:32:15'),
(1296, 311, 28, 32, 1200.000000, 11, 0, 32.1168, 13167.883212, '{\"255\":\"11\"}', '2018-02-25 21:32:15', '2018-02-25 21:32:15'),
(1297, 312, 28, 32, 1150.000000, 9, 0, 0, 10350.000000, '{\"255\":\"9\"}', '2018-02-25 21:35:05', '2018-02-25 21:35:05'),
(1298, 312, 28, 32, 1250.000000, 1, 0, 0, 1250.000000, '{\"255\":\"1\"}', '2018-02-25 21:35:05', '2018-02-25 21:35:05'),
(1299, 313, 28, 32, 1200.000000, 18, 0, 69.4534, 21530.546624, '{\"255\":\"18\"}', '2018-02-25 21:40:10', '2018-02-25 21:40:10'),
(1300, 313, 28, 32, 1300.000000, 1, 0, 4.18006, 1295.819936, '{\"255\":\"1\"}', '2018-02-25 21:40:10', '2018-02-25 21:40:10'),
(1301, 313, 29, 51, 800.000000, 7, 0, 18.0064, 5581.993569, '{\"285\":\"7\"}', '2018-02-25 21:40:10', '2018-02-25 21:40:10'),
(1302, 313, 31, 47, 325.000000, 8, 0, 8.36013, 2591.639871, '{\"282\":\"8\"}', '2018-02-25 21:40:10', '2018-02-25 21:40:10'),
(1303, 314, 44, 75, 750.000000, 6, 0, 0, 4500.000000, '{\"252\":\"6\"}', '2018-02-25 21:44:03', '2018-02-25 21:44:03'),
(1304, 314, 44, 73, 400.000000, 7, 0, 0, 2800.000000, '{\"253\":\"7\"}', '2018-02-25 21:44:03', '2018-02-25 21:44:03'),
(1305, 314, 48, 64, 80.000000, 1, 0, 0, 80.000000, '{\"287\":\"1\"}', '2018-02-25 21:44:03', '2018-02-25 21:44:04'),
(1306, 315, 28, 32, 1150.000000, 6, 0, 0, 6900.000000, '{\"255\":\"6\"}', '2018-02-25 21:48:34', '2018-02-25 21:48:34'),
(1307, 316, 44, 74, 1600.000000, 2, 0, 0, 3200.000000, '{\"293\":\"2\"}', '2018-02-25 22:16:13', '2018-02-25 22:16:13'),
(1308, 316, 27, 70, 240.000000, 2, 0, 0, 480.000000, '{\"269\":\"2\"}', '2018-02-25 22:16:13', '2018-02-25 22:16:13'),
(1309, 316, 39, 41, 350.000000, 2, 0, 0, 700.000000, '{\"271\":\"2\"}', '2018-02-25 22:16:13', '2018-02-25 22:16:13'),
(1310, 317, 29, 51, 800.000000, 5, 0, 96, 3904.000000, '{\"285\":\"5\"}', '2018-02-25 22:19:46', '2018-02-25 22:19:46'),
(1311, 317, 27, 79, 225.000000, 10, 0, 54, 2196.000000, '{\"280\":\"10\"}', '2018-02-25 22:19:46', '2018-02-25 22:19:46'),
(1312, 318, 27, 31, 110.000000, 16, 0, 0, 1760.000000, '{\"272\":\"16\"}', '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(1313, 318, 27, 70, 225.000000, 7, 0, 0, 1575.000000, '{\"269\":\"7\"}', '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(1314, 318, 27, 71, 275.000000, 6, 0, 0, 1650.000000, '{\"278\":\"6\"}', '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(1315, 318, 27, 79, 225.000000, 7, 0, 0, 1575.000000, '{\"280\":\"7\"}', '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(1316, 318, 39, 41, 230.000000, 6, 0, 0, 1380.000000, '{\"271\":\"6\"}', '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(1317, 318, 27, 68, 230.000000, 10, 0, 0, 2300.000000, '{\"279\":\"10\"}', '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(1318, 318, 28, 32, 1200.000000, 2, 0, 0, 2400.000000, '{\"255\":\"2\"}', '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(1319, 319, 28, 32, 1200.000000, 6, 0, 4.65216, 7195.347835, '{\"255\":\"6\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1320, 319, 31, 47, 325.000000, 8, 0, 1.67995, 2598.320052, '{\"282\":\"8\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1321, 319, 27, 68, 230.000000, 27, 0, 4.01249, 6205.987508, '{\"279\":\"27\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1322, 319, 27, 70, 220.000000, 16, 0, 2.27439, 3517.725608, '{\"269\":\"16\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1323, 319, 43, 77, 400.000000, 12, 0, 3.10144, 4796.898557, '{\"274\":\"12\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1324, 319, 43, 78, 300.000000, 16, 0, 3.10144, 4796.898557, '{\"275\":\"16\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1325, 319, 27, 71, 250.000000, 12, 0, 1.9384, 2998.061598, '{\"278\":\"12\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1326, 319, 27, 31, 160.000000, 14, 0, 1.44734, 2238.552660, '{\"272\":\"14\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1327, 319, 27, 79, 230.000000, 47, 0, 6.98471, 10803.015292, '{\"280\":\"47\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1328, 319, 48, 64, 50.000000, 25, 0, 0.807667, 1249.192333, '{\"287\":\"25\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1329, 320, 44, 73, 500.000000, 10, 0, 0, 5000.000000, '{\"253\":\"10\"}', '2018-02-25 22:42:39', '2018-02-25 22:42:39'),
(1330, 321, 39, 41, 300.000000, 16, 0, 0, 4800.000000, '{\"271\":\"16\"}', '2018-02-25 22:45:19', '2018-02-25 22:45:19'),
(1331, 322, 27, 68, 270.000000, 3, 0, 0.586532, 809.413469, '', '2018-02-25 22:53:29', '2018-02-25 22:53:29'),
(1332, 322, 44, 73, 500.000000, 5, 0, 1.81028, 2498.189718, '', '2018-02-25 22:53:29', '2018-02-25 22:53:29'),
(1333, 322, 33, 157, 300.000000, 7, 0, 1.52064, 2098.479363, '', '2018-02-25 22:53:29', '2018-02-25 22:53:29'),
(1334, 322, 27, 79, 270.000000, 4, 0, 0.782042, 1079.217958, '', '2018-02-25 22:53:29', '2018-02-25 22:53:29'),
(1335, 322, 28, 32, 1350.000000, 4, 0, 3.91021, 5396.089790, '', '2018-02-25 22:53:29', '2018-02-25 22:53:29'),
(1336, 322, 27, 31, 120.000000, 4, 0, 0.347574, 479.652426, '', '2018-02-25 22:53:29', '2018-02-25 22:53:29'),
(1337, 322, 39, 156, 320.000000, 2, 0, 0.463432, 639.536568, '', '2018-02-25 22:53:29', '2018-02-25 22:53:29'),
(1338, 322, 32, 58, 800.000000, 1, 0, 0.57929, 799.420710, '', '2018-02-25 22:53:29', '2018-02-25 22:53:29'),
(1339, 323, 40, 83, 1400.000000, 3, 0, 0, 4200.000000, '{\"322\":\"3\"}', '2018-02-25 22:56:28', '2018-02-25 22:56:28'),
(1340, 324, 27, 31, 120.000000, 4, 0, 0.519293, 479.480707, '{\"272\":\"4\"}', '2018-02-25 23:05:24', '2018-02-25 23:05:24'),
(1341, 324, 43, 78, 325.000000, 16, 0, 5.62568, 5194.374324, '{\"275\":\"16\"}', '2018-02-25 23:05:24', '2018-02-25 23:05:24'),
(1342, 324, 27, 79, 250.000000, 23, 0, 6.2207, 5743.779300, '{\"280\":\"23\"}', '2018-02-25 23:05:24', '2018-02-25 23:05:24'),
(1343, 324, 39, 41, 250.000000, 20, 0, 5.4093, 4994.590696, '{\"271\":\"20\"}', '2018-02-25 23:05:24', '2018-02-25 23:05:24'),
(1344, 324, 29, 51, 800.000000, 3, 0, 2.59647, 2397.403534, '{\"285\":\"3\"}', '2018-02-25 23:05:24', '2018-02-25 23:05:24'),
(1345, 324, 28, 32, 1300.000000, 4, 0, 5.62568, 5194.374324, '{\"255\":\"4\"}', '2018-02-25 23:05:24', '2018-02-25 23:05:24'),
(1346, 324, 28, 32, 1500.000000, 1, 0, 1.62279, 1498.377209, '{\"255\":\"1\"}', '2018-02-25 23:05:25', '2018-02-25 23:05:25'),
(1347, 324, 39, 156, 350.000000, 4, 0, 1.51461, 1398.485395, '{\"270\":\"4\"}', '2018-02-25 23:05:25', '2018-02-25 23:05:25'),
(1348, 324, 32, 58, 800.000000, 1, 0, 0.865489, 799.134511, '{\"283\":\"1\"}', '2018-02-25 23:05:25', '2018-02-25 23:05:25'),
(1349, 325, 27, 70, 220.000000, 61, 0, 0, 13420.000000, '', '2018-02-25 23:19:40', '2018-02-25 23:19:40'),
(1350, 325, 27, 79, 325.000000, 17, 0, 0, 5525.000000, '', '2018-02-25 23:19:40', '2018-02-25 23:19:40'),
(1351, 325, 39, 156, 300.000000, 12, 0, 0, 3600.000000, '', '2018-02-25 23:19:40', '2018-02-25 23:19:40'),
(1352, 325, 39, 156, 350.000000, 6, 0, 0, 2100.000000, '', '2018-02-25 23:19:40', '2018-02-25 23:19:40'),
(1353, 325, 43, 78, 325.000000, 16, 0, 0, 5200.000000, '', '2018-02-25 23:19:40', '2018-02-25 23:19:40'),
(1354, 325, 43, 77, 425.000000, 14, 0, 0, 5950.000000, '', '2018-02-25 23:19:40', '2018-02-25 23:19:40'),
(1355, 325, 39, 41, 225.000000, 15, 0, 0, 3375.000000, '', '2018-02-25 23:19:40', '2018-02-25 23:19:40'),
(1356, 325, 39, 156, 325.000000, 4, 0, 0, 1300.000000, '', '2018-02-25 23:19:40', '2018-02-25 23:19:40'),
(1357, 325, 29, 51, 800.000000, 8, 0, 0, 6400.000000, '', '2018-02-25 23:19:40', '2018-02-25 23:19:40'),
(1358, 325, 27, 71, 275.000000, 12, 0, 0, 3300.000000, '', '2018-02-25 23:19:40', '2018-02-25 23:19:40'),
(1359, 325, 27, 72, 120.000000, 30, 0, 0, 3600.000000, '', '2018-02-25 23:19:40', '2018-02-25 23:19:40'),
(1360, 326, 51, 60, 100.000000, 12, 0, 0, 1200.000000, '{\"264\":\"12\"}', '2018-02-25 23:28:02', '2018-02-25 23:28:02'),
(1361, 326, 51, 60, 80.000000, 34, 0, 0, 2720.000000, '{\"264\":\"25\",\"265\":9}', '2018-02-25 23:28:02', '2018-02-25 23:28:02'),
(1362, 326, 51, 60, 50.000000, 49, 0, 0, 2450.000000, '{\"265\":\"32\",\"266\":17}', '2018-02-25 23:28:02', '2018-02-25 23:28:02'),
(1363, 326, 51, 62, 20.000000, 174, 0, 0, 3480.000000, '{\"268\":\"174\"}', '2018-02-25 23:28:02', '2018-02-25 23:28:02'),
(1364, 327, 44, 73, 500.000000, 7, 0, 0, 3500.000000, '{\"253\":\"7\"}', '2018-02-25 23:34:09', '2018-02-25 23:34:09'),
(1365, 327, 27, 71, 300.000000, 2, 0, 0, 600.000000, '{\"278\":\"2\"}', '2018-02-25 23:34:09', '2018-02-25 23:34:09'),
(1366, 327, 27, 68, 270.000000, 1, 0, 0, 270.000000, '{\"279\":\"1\"}', '2018-02-25 23:34:09', '2018-02-25 23:34:09'),
(1367, 328, 27, 70, 307.000000, 7, 0, 0, 2149.000000, '{\"269\":\"7\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1368, 328, 27, 31, 158.000000, 47, 0, 0, 7426.000000, '{\"272\":\"47\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1369, 328, 39, 41, 500.000000, 3, 0, 0, 1500.000000, '{\"271\":\"3\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1370, 328, 28, 32, 1533.000000, 6, 0, 0, 9198.000000, '{\"255\":\"6\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1371, 328, 43, 77, 700.000000, 1, 0, 0, 700.000000, '{\"274\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1372, 328, 67, 84, 2000.000000, 2, 0, 0, 4000.000000, '{\"328\":\"2\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1373, 328, 31, 47, 500.000000, 1, 0, 0, 500.000000, '{\"282\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1374, 328, 86, 140, 500.000000, 1, 0, 0, 500.000000, '{\"259\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1375, 328, 45, 50, 1300.000000, 1, 0, 0, 1300.000000, '{\"262\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1376, 328, 40, 81, 2000.000000, 1, 0, 0, 2000.000000, '{\"320\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1377, 328, 55, 100, 3500.000000, 1, 0, 0, 3500.000000, '{\"247\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1378, 328, 59, 89, 3500.000000, 1, 0, 0, 3500.000000, '{\"315\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1379, 328, 44, 75, 700.000000, 1, 0, 0, 700.000000, '{\"252\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1380, 328, 72, 93, 1100.000000, 4, 0, 0, 4400.000000, '{\"298\":\"4\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1381, 328, 74, 94, 2400.000000, 1, 0, 0, 2400.000000, '{\"336\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1382, 328, 67, 159, 2500.000000, 1, 0, 0, 2500.000000, '{\"324\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1383, 329, 27, 70, 325.000000, 4, 0, 0, 1300.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1384, 329, 48, 64, 99.000000, 26, 0, 0, 2574.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1385, 329, 44, 75, 878.000000, 16, 0, 0, 14048.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1386, 329, 33, 157, 300.000000, 3, 0, 0, 900.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1387, 329, 31, 47, 500.000000, 1, 0, 0, 500.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1388, 329, 39, 156, 444.000000, 60, 0, 0, 26640.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1389, 329, 39, 41, 500.000000, 2, 0, 0, 1000.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1390, 329, 43, 77, 610.000000, 24, 0, 0, 14640.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1391, 329, 51, 62, 75.000000, 2, 0, 0, 150.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1392, 329, 51, 61, 75.000000, 17, 0, 0, 1275.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1393, 329, 27, 79, 365.000000, 24, 0, 0, 8760.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1394, 329, 32, 58, 862.000000, 21, 0, 0, 18102.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1395, 329, 72, 93, 1220.000000, 5, 0, 0, 6100.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1396, 329, 75, 95, 1413.000000, 4, 0, 0, 5652.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1397, 329, 40, 127, 2460.000000, 5, 0, 0, 12300.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1398, 329, 66, 104, 5000.000000, 1, 0, 0, 5000.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1399, 329, 27, 68, 358.000000, 25, 0, 0, 8950.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1400, 329, 27, 31, 208.000000, 40, 0, 0, 8320.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1401, 329, 44, 73, 500.000000, 33, 0, 0, 16500.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1402, 329, 29, 51, 894.000000, 9, 0, 0, 8046.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1403, 329, 27, 70, 305.000000, 50, 0, 0, 15250.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1404, 329, 51, 60, 120.000000, 5, 0, 0, 600.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1405, 329, 59, 89, 3500.000000, 1, 0, 0, 3500.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1406, 329, 81, 154, 433.000000, 3, 0, 0, 1299.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1407, 329, 44, 74, 1900.000000, 1, 0, 0, 1900.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1408, 329, 40, 83, 1600.000000, 1, 0, 0, 1600.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1409, 329, 40, 128, 1725.000000, 4, 0, 0, 6900.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1410, 329, 27, 71, 367.000000, 6, 0, 0, 2202.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1411, 329, 42, 57, 850.000000, 2, 0, 0, 1700.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1412, 329, 84, 136, 910.000000, 10, 0, 0, 9100.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1413, 329, 35, 59, 1775.000000, 4, 0, 0, 7100.000000, '', '2018-02-26 23:40:43', '2018-02-26 23:40:43'),
(1414, 330, 45, 50, 1350.000000, 6, 0, 0, 8100.000000, '{\"262\":\"6\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1415, 330, 38, 44, 1270.000000, 5, 0, 0, 6350.000000, '{\"299\":\"5\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1416, 330, 28, 32, 1546.000000, 15, 0, 0, 23190.000000, '{\"255\":\"15\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1417, 330, 67, 144, 2200.000000, 2, 0, 0, 4400.000000, '{\"343\":\"2\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1418, 330, 27, 72, 163.000000, 4, 0, 0, 652.000000, '{\"273\":\"4\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1419, 330, 32, 54, 1100.000000, 1, 0, 0, 1100.000000, '{\"284\":\"1\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1420, 330, 82, 155, 750.000000, 1, 0, 0, 750.000000, '{\"258\":\"1\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1421, 330, 33, 157, 300.000000, 4, 0, 0, 1200.000000, '{\"281\":\"4\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1422, 330, 75, 96, 2261.000000, 9, 0, 0, 20349.000000, '{\"302\":\"9\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1423, 330, 49, 46, 2900.000000, 2, 0, 0, 5800.000000, '{\"297\":\"2\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1424, 330, 49, 31, 1700.000000, 1, 0, 0, 1700.000000, '{\"296\":\"1\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1425, 330, 84, 137, 600.000000, 1, 0, 0, 600.000000, '{\"294\":\"1\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1426, 330, 75, 95, 1550.000000, 2, 0, 0, 3100.000000, '{\"337\":\"2\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1427, 330, 55, 110, 2960.000000, 5, 0, 0, 14800.000000, '{\"309\":\"5\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1428, 330, 67, 87, 3000.000000, 1, 0, 0, 3000.000000, '{\"326\":\"1\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1429, 331, 55, 115, 3500.000000, 1, 0, 0, 3500.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1430, 331, 40, 81, 2000.000000, 1, 0, 0, 2000.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1431, 331, 86, 140, 400.000000, 1, 0, 0, 400.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1432, 331, 64, 124, 2067.000000, 3, 0, 0, 6201.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1433, 331, 43, 78, 483.000000, 3, 0, 0, 1449.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1434, 331, 58, 116, 2933.000000, 3, 0, 0, 8799.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1435, 331, 74, 94, 2167.000000, 3, 0, 0, 6501.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1436, 331, 77, 97, 3866.000000, 3, 0, 0, 11598.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1437, 331, 79, 98, 3600.000000, 2, 0, 0, 7200.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1438, 331, 59, 89, 4000.000000, 5, 0, 0, 20000.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1439, 331, 67, 84, 1900.000000, 3, 0, 0, 5700.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1440, 331, 58, 118, 4100.000000, 1, 0, 0, 4100.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1441, 331, 56, 117, 3200.000000, 2, 0, 0, 6400.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1442, 331, 52, 107, 2700.000000, 1, 0, 0, 2700.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1443, 331, 67, 159, 2600.000000, 1, 0, 0, 2600.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1444, 331, 55, 110, 3267.000000, 3, 0, 0, 9801.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1445, 331, 63, 158, 2350.000000, 2, 0, 0, 4700.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1446, 331, 78, 99, 3150.000000, 1, 0, 0, 3150.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1447, 331, 53, 113, 3833.000000, 3, 0, 0, 11499.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1448, 331, 53, 108, 4100.000000, 3, 0, 0, 12300.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1449, 331, 75, 126, 2260.000000, 5, 0, 0, 11300.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1450, 331, 62, 122, 2150.000000, 1, 0, 0, 2150.000000, '', '2018-02-27 00:52:31', '2018-02-27 00:52:31'),
(1451, 332, 27, 31, 110.000000, 21, 0, 0, 2310.000000, '{\"272\":\"21\"}', '2018-02-27 01:21:11', '2018-02-27 01:21:11'),
(1452, 332, 27, 71, 275.000000, 11, 0, 0, 3025.000000, '{\"278\":\"11\"}', '2018-02-27 01:21:11', '2018-02-27 01:21:11'),
(1453, 332, 28, 32, 1250.000000, 4, 0, 0, 5000.000000, '{\"255\":\"4\"}', '2018-02-27 01:21:11', '2018-02-27 01:21:11'),
(1454, 332, 28, 32, 1150.000000, 1, 0, 0, 1150.000000, '{\"255\":\"1\"}', '2018-02-27 01:21:11', '2018-02-27 01:21:11'),
(1455, 333, 67, 88, 3400.000000, 1, 0, 0.186803, 3399.813197, '{\"325\":\"1\"}', '2018-02-27 01:26:27', '2018-02-27 01:26:27'),
(1456, 333, 75, 96, 2367.000000, 3, 0, 0.390143, 7100.609857, '{\"302\":\"3\"}', '2018-02-27 01:26:27', '2018-02-27 01:26:27'),
(1457, 333, 67, 159, 2250.000000, 1, 0, 0.12362, 2249.876380, '{\"324\":\"1\"}', '2018-02-27 01:26:27', '2018-02-27 01:26:27'),
(1458, 333, 67, 85, 2150.000000, 1, 0, 0.118125, 2149.881875, '{\"327\":\"1\"}', '2018-02-27 01:26:27', '2018-02-27 01:26:28'),
(1459, 333, 55, 100, 3300.000000, 1, 0, 0.181309, 3299.818691, '{\"247\":\"1\"}', '2018-02-27 01:26:28', '2018-02-27 01:26:28'),
(1460, 334, 28, 32, 1200.000000, 40, 0, 0, 48000.000000, '{\"255\":\"40\"}', '2018-02-27 01:30:52', '2018-02-27 01:30:52'),
(1461, 334, 29, 51, 800.000000, 8, 0, 0, 6400.000000, '{\"285\":\"8\"}', '2018-02-27 01:30:52', '2018-02-27 01:30:52'),
(1462, 334, 30, 48, 700.000000, 2, 0, 0, 1400.000000, '{\"286\":\"2\"}', '2018-02-27 01:30:52', '2018-02-27 01:30:52'),
(1463, 334, 43, 77, 400.000000, 16, 0, 0, 6400.000000, '{\"274\":\"16\"}', '2018-02-27 01:30:52', '2018-02-27 01:30:52'),
(1464, 334, 43, 78, 300.000000, 6, 0, 0, 1800.000000, '{\"275\":\"6\"}', '2018-02-27 01:30:52', '2018-02-27 01:30:53'),
(1465, 335, 28, 32, 1150.000000, 22, 0, 0, 25300.000000, '{\"255\":\"22\"}', '2018-02-28 18:47:13', '2018-02-28 18:47:13'),
(1466, 335, 28, 32, 1250.000000, 3, 0, 0, 3750.000000, '{\"255\":\"3\"}', '2018-02-28 18:47:13', '2018-02-28 18:47:13'),
(1467, 336, 29, 51, 800.000000, 5, 0, 0, 4000.000000, '{\"285\":\"5\"}', '2018-02-28 18:51:12', '2018-02-28 18:51:12'),
(1468, 336, 42, 57, 550.000000, 8, 0, 0, 4400.000000, '{\"261\":\"8\"}', '2018-02-28 18:51:12', '2018-02-28 18:51:12'),
(1469, 337, 33, 157, 300.000000, 4, 0, 0, 1200.000000, '{\"281\":\"4\"}', '2018-02-28 18:56:18', '2018-02-28 18:56:18'),
(1470, 337, 28, 32, 1400.000000, 1, 0, 0, 1400.000000, '{\"255\":\"1\"}', '2018-02-28 18:56:18', '2018-02-28 18:56:18'),
(1471, 337, 39, 156, 350.000000, 3, 0, 0, 1050.000000, '{\"270\":\"3\"}', '2018-02-28 18:56:18', '2018-02-28 18:56:18'),
(1472, 337, 27, 71, 300.000000, 1, 0, 0, 300.000000, '{\"278\":\"1\"}', '2018-02-28 18:56:18', '2018-02-28 18:56:18'),
(1473, 338, 40, 127, 2200.000000, 14, 0, 0, 30800.000000, '{\"305\":\"14\"}', '2018-02-28 19:00:36', '2018-02-28 19:00:36'),
(1474, 338, 28, 32, 1400.000000, 2, 0, 0, 2800.000000, '{\"255\":\"2\"}', '2018-02-28 19:00:36', '2018-02-28 19:00:36'),
(1475, 339, 67, 87, 2500.000000, 2, 0, 0, 5000.000000, '{\"326\":\"2\"}', '2018-02-28 19:03:40', '2018-02-28 19:03:40'),
(1476, 339, 75, 96, 2000.000000, 3, 0, 0, 6000.000000, '{\"302\":\"3\"}', '2018-02-28 19:03:40', '2018-02-28 19:03:40'),
(1477, 340, 40, 128, 1400.000000, 12, 0, 0, 16800.000000, '{\"304\":\"12\"}', '2018-02-28 19:06:03', '2018-02-28 19:06:03'),
(1478, 341, 28, 32, 1200.000000, 5, 0, 0, 6000.000000, '{\"255\":\"5\"}', '2018-02-28 19:11:58', '2018-02-28 19:11:58'),
(1479, 341, 28, 32, 1300.000000, 3, 0, 0, 3900.000000, '{\"255\":\"3\"}', '2018-02-28 19:11:58', '2018-02-28 19:11:58'),
(1480, 341, 27, 79, 230.000000, 4, 0, 0, 920.000000, '{\"280\":\"4\"}', '2018-02-28 19:11:58', '2018-02-28 19:11:58'),
(1481, 341, 27, 68, 230.000000, 1, 0, 0, 230.000000, '{\"279\":\"1\"}', '2018-02-28 19:11:58', '2018-02-28 19:11:58'),
(1482, 342, 27, 70, 250.000000, 2, 0, 11.4943, 488.505747, '{\"269\":\"2\"}', '2018-02-28 19:15:18', '2018-02-28 19:15:18'),
(1483, 342, 27, 31, 120.000000, 14, 0, 38.6207, 1641.379310, '{\"272\":\"14\"}', '2018-02-28 19:15:18', '2018-02-28 19:15:18'),
(1484, 342, 28, 32, 1300.000000, 1, 0, 29.8851, 1270.114943, '{\"255\":\"1\"}', '2018-02-28 19:15:18', '2018-02-28 19:15:18'),
(1485, 343, 75, 96, 2650.000000, 4, 0, 77.3723, 10522.627737, '{\"302\":\"4\"}', '2018-02-28 19:17:07', '2018-02-28 19:17:07'),
(1486, 343, 78, 99, 3100.000000, 1, 0, 22.6277, 3077.372263, '{\"332\":\"1\"}', '2018-02-28 19:17:07', '2018-02-28 19:17:07'),
(1487, 344, 28, 32, 1200.000000, 4, 0, 0, 4800.000000, '{\"255\":\"4\"}', '2018-02-28 19:18:29', '2018-02-28 19:18:29'),
(1488, 345, 42, 57, 550.000000, 10, 0, 0, 5500.000000, '{\"261\":\"10\"}', '2018-02-28 19:21:00', '2018-02-28 19:21:00'),
(1489, 345, 29, 51, 800.000000, 5, 0, 0, 4000.000000, '{\"285\":\"5\"}', '2018-02-28 19:21:00', '2018-02-28 19:21:00'),
(1490, 346, 28, 32, 1250.000000, 4, 0, 0, 5000.000000, '{\"255\":\"4\"}', '2018-02-28 19:25:04', '2018-02-28 19:25:04'),
(1491, 346, 27, 68, 225.000000, 40, 0, 0, 9000.000000, '{\"279\":\"40\"}', '2018-02-28 19:25:04', '2018-02-28 19:25:04'),
(1492, 346, 27, 79, 230.000000, 14, 0, 0, 3220.000000, '{\"280\":\"14\"}', '2018-02-28 19:25:04', '2018-02-28 19:25:04'),
(1493, 346, 29, 51, 800.000000, 3, 0, 0, 2400.000000, '{\"285\":\"3\"}', '2018-02-28 19:25:04', '2018-02-28 19:25:04'),
(1494, 347, 72, 93, 1150.000000, 3, 0, 0, 3450.000000, '{\"298\":\"3\"}', '2018-02-28 19:27:53', '2018-02-28 19:27:53'),
(1495, 347, 75, 95, 1200.000000, 1, 0, 0, 1200.000000, '{\"337\":\"1\"}', '2018-02-28 19:27:53', '2018-02-28 19:27:53'),
(1496, 348, 49, 31, 1769.000000, 8, 0, 0, 14152.000000, '{\"296\":\"8\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1497, 348, 49, 46, 2900.000000, 1, 0, 0, 2900.000000, '{\"297\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1498, 348, 31, 47, 500.000000, 4, 0, 0, 2000.000000, '{\"282\":\"4\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1499, 348, 75, 96, 1900.000000, 3, 0, 0, 5700.000000, '{\"302\":\"3\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1500, 348, 29, 51, 900.000000, 3, 0, 0, 2700.000000, '{\"285\":\"3\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1501, 348, 57, 103, 3433.000000, 3, 0, 0, 10299.000000, '{\"329\":\"3\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1502, 348, 40, 81, 1950.000000, 2, 0, 0, 3900.000000, '{\"320\":\"2\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1503, 348, 40, 81, 3800.000000, 1, 0, 0, 3800.000000, '{\"320\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1504, 348, 59, 89, 3512.000000, 8, 0, 0, 28096.000000, '{\"315\":\"8\",\"333\":0}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1505, 348, 33, 157, 400.000000, 1, 0, 0, 400.000000, '{\"281\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1506, 348, 44, 73, 250.000000, 1, 0, 0, 250.000000, '{\"253\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1507, 348, 67, 84, 1850.000000, 11, 0, 0, 20350.000000, '{\"328\":\"11\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1508, 348, 55, 100, 3350.000000, 2, 0, 0, 6700.000000, '{\"247\":\"2\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1509, 348, 53, 108, 3900.000000, 3, 0, 0, 11700.000000, '{\"249\":\"3\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1510, 348, 32, 58, 800.000000, 1, 0, 0, 800.000000, '{\"283\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1511, 348, 27, 31, 184.000000, 11, 0, 0, 2024.000000, '{\"272\":\"11\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1512, 348, 72, 93, 1214.000000, 15, 0, 0, 18210.000000, '{\"298\":\"15\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1513, 348, 48, 64, 100.000000, 3, 0, 0, 300.000000, '{\"287\":\"3\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1514, 348, 38, 44, 1381.000000, 13, 0, 0, 17953.000000, '{\"299\":\"13\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1515, 348, 75, 95, 1500.000000, 2, 0, 0, 3000.000000, '{\"337\":\"2\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1516, 348, 75, 95, 1200.000000, 1, 0, 0, 1200.000000, '{\"337\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1517, 348, 40, 81, 1767.000000, 3, 0, 0, 5301.000000, '{\"320\":\"3\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1518, 348, 28, 32, 1562.000000, 4, 0, 0, 6248.000000, '{\"255\":\"4\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1519, 348, 77, 97, 3634.000000, 3, 0, 0, 10902.000000, '{\"331\":\"3\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1520, 348, 55, 102, 3450.000000, 2, 0, 0, 6900.000000, '{\"248\":\"2\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1521, 348, 55, 101, 3700.000000, 2, 0, 0, 7400.000000, '{\"335\":\"2\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1522, 348, 27, 70, 350.000000, 2, 0, 0, 700.000000, '{\"269\":\"2\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1523, 348, 67, 159, 3900.000000, 1, 0, 0, 3900.000000, '{\"324\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1524, 348, 43, 77, 650.000000, 1, 0, 0, 650.000000, '{\"274\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1525, 348, 39, 41, 500.000000, 1, 0, 0, 500.000000, '{\"271\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1526, 348, 75, 95, 1508.000000, 6, 0, 0, 9048.000000, '{\"337\":\"6\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1527, 348, 67, 159, 2650.000000, 2, 0, 0, 5300.000000, '{\"324\":\"2\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1528, 349, 28, 39, 800.000000, 7, 0, 0, 5600.000000, '{\"260\":\"7\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1529, 349, 40, 81, 1737.000000, 8, 0, 0, 13896.000000, '{\"320\":\"5\",\"323\":3}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1530, 349, 67, 88, 3500.000000, 3, 0, 0, 10500.000000, '{\"325\":\"3\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1531, 349, 67, 84, 1900.000000, 3, 0, 0, 5700.000000, '{\"328\":\"3\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1532, 349, 43, 78, 450.000000, 2, 0, 0, 900.000000, '{\"275\":\"2\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1533, 349, 72, 93, 1250.000000, 10, 0, 0, 12500.000000, '{\"298\":\"10\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1534, 349, 53, 90, 3700.000000, 1, 0, 0, 3700.000000, '{\"250\":\"1\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1535, 349, 33, 157, 325.000000, 8, 0, 0, 2600.000000, '{\"281\":\"8\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1536, 349, 31, 47, 500.000000, 5, 0, 0, 2500.000000, '{\"282\":\"5\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1537, 349, 55, 102, 3400.000000, 1, 0, 0, 3400.000000, '{\"248\":\"1\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1538, 349, 67, 159, 2700.000000, 2, 0, 0, 5400.000000, '{\"324\":\"2\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1539, 349, 45, 50, 1380.000000, 5, 0, 0, 6900.000000, '{\"262\":\"5\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1540, 349, 84, 136, 1200.000000, 1, 0, 0, 1200.000000, '{\"290\":\"1\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1541, 349, 49, 31, 1764.000000, 14, 0, 0, 24696.000000, '{\"296\":\"14\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1542, 349, 38, 44, 1333.000000, 6, 0, 0, 7998.000000, '{\"299\":\"6\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1543, 349, 44, 75, 850.000000, 2, 0, 0, 1700.000000, '{\"252\":\"2\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1544, 349, 45, 49, 2500.000000, 1, 0, 0, 2500.000000, '{\"263\":\"1\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1545, 349, 44, 73, 470.000000, 5, 0, 0, 2350.000000, '{\"253\":\"5\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1546, 349, 51, 61, 100.000000, 3, 0, 0, 300.000000, '{\"267\":\"3\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1547, 349, 39, 41, 471.000000, 12, 0, 0, 5652.000000, '{\"271\":\"12\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1548, 349, 28, 32, 1553.000000, 19, 0, 0, 29507.000000, '{\"255\":\"19\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1549, 349, 75, 95, 1578.000000, 9, 0, 0, 14202.000000, '{\"337\":\"9\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1550, 349, 27, 31, 163.000000, 27, 0, 0, 4401.000000, '{\"272\":\"27\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1551, 349, 32, 58, 900.000000, 4, 0, 0, 3600.000000, '{\"283\":\"4\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1552, 349, 53, 108, 3500.000000, 2, 0, 0, 7000.000000, '{\"249\":\"2\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1553, 349, 75, 95, 1200.000000, 1, 0, 0, 1200.000000, '{\"337\":\"1\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1554, 349, 78, 99, 3500.000000, 1, 0, 0, 3500.000000, '{\"332\":\"1\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1555, 349, 27, 70, 280.000000, 5, 0, 0, 1400.000000, '{\"269\":\"5\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1556, 349, 55, 102, 3300.000000, 1, 0, 0, 3300.000000, '{\"248\":\"1\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1557, 349, 75, 95, 1433.000000, 3, 0, 0, 4299.000000, '{\"337\":\"3\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1558, 349, 32, 54, 1350.000000, 2, 0, 0, 2700.000000, '{\"284\":\"2\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1559, 349, 29, 51, 950.000000, 2, 0, 0, 1900.000000, '{\"285\":\"2\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1560, 349, 42, 57, 850.000000, 2, 0, 0, 1700.000000, '{\"261\":\"2\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1561, 349, 27, 70, 250.000000, 2, 0, 0, 500.000000, '{\"269\":\"2\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1562, 350, 29, 51, 906.000000, 16, 0, 0, 14496.000000, '{\"285\":\"16\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1563, 350, 51, 60, 100.000000, 1, 0, 0, 100.000000, '{\"266\":\"1\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1564, 350, 27, 31, 214.000000, 76, 0, 0, 16264.000000, '{\"272\":\"76\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1565, 350, 33, 157, 329.000000, 16, 0, 0, 5264.000000, '{\"281\":\"16\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1566, 350, 31, 47, 525.000000, 10, 0, 0, 5250.000000, '{\"282\":\"10\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1567, 350, 75, 95, 1250.000000, 6, 0, 0, 7500.000000, '{\"337\":\"6\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1568, 350, 44, 75, 921.000000, 17, 0, 0, 15657.000000, '{\"252\":\"17\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1569, 350, 51, 62, 125.000000, 2, 0, 0, 250.000000, '{\"268\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1570, 350, 75, 96, 2000.000000, 2, 0, 0, 4000.000000, '{\"302\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1571, 350, 49, 31, 1719.000000, 8, 0, 0, 13752.000000, '{\"296\":\"8\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1572, 350, 39, 156, 441.000000, 55, 0, 0, 24255.000000, '{\"270\":\"55\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1573, 350, 27, 70, 294.000000, 40, 0, 0, 11760.000000, '{\"269\":\"40\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1574, 350, 43, 77, 600.000000, 12, 0, 0, 7200.000000, '{\"274\":\"12\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1575, 350, 42, 57, 1000.000000, 3, 0, 0, 3000.000000, '{\"261\":\"3\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1576, 350, 84, 136, 1014.000000, 14, 0, 0, 14196.000000, '{\"290\":\"14\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1577, 350, 59, 89, 3600.000000, 4, 0, 0, 14400.000000, '{\"333\":\"4\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1578, 350, 44, 74, 1820.000000, 10, 0, 0, 18200.000000, '{\"293\":\"10\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1579, 350, 74, 94, 2250.000000, 2, 0, 0, 4500.000000, '{\"336\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1580, 350, 77, 97, 3500.000000, 2, 0, 0, 7000.000000, '{\"331\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1581, 350, 45, 50, 1300.000000, 1, 0, 0, 1300.000000, '{\"262\":\"1\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1582, 350, 55, 102, 3350.000000, 2, 0, 0, 6700.000000, '{\"248\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1583, 350, 35, 59, 1775.000000, 2, 0, 0, 3550.000000, '{\"256\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1584, 350, 84, 137, 618.000000, 8, 0, 0, 4944.000000, '{\"294\":\"8\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1585, 350, 79, 98, 3300.000000, 1, 0, 0, 3300.000000, '{\"330\":\"1\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1586, 350, 58, 91, 2767.000000, 3, 0, 0, 8301.000000, '{\"251\":\"3\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1587, 350, 45, 50, 1560.000000, 10, 0, 0, 15600.000000, '{\"262\":\"10\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1588, 350, 67, 84, 1750.000000, 2, 0, 0, 3500.000000, '{\"328\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1589, 350, 84, 136, 1500.000000, 1, 0, 0, 1500.000000, '{\"290\":\"1\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1590, 350, 27, 71, 341.000000, 6, 0, 0, 2046.000000, '{\"278\":\"6\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1591, 350, 28, 32, 1577.000000, 26, 0, 0, 41002.000000, '{\"255\":\"26\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1592, 350, 48, 64, 2850.000000, 28, 0, 0, 79800.000000, '{\"287\":\"28\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1593, 350, 32, 58, 872.000000, 16, 0, 0, 13952.000000, '{\"283\":\"16\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1594, 350, 72, 93, 1166.000000, 3, 0, 0, 3498.000000, '{\"298\":\"3\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1595, 350, 44, 73, 632.000000, 17, 0, 0, 10744.000000, '{\"253\":\"17\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1596, 350, 57, 103, 3200.000000, 4, 0, 0, 12800.000000, '{\"329\":\"4\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1597, 350, 43, 78, 470.000000, 5, 0, 0, 2350.000000, '{\"275\":\"5\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1598, 350, 55, 102, 3378.000000, 7, 0, 0, 23646.000000, '{\"248\":\"1\",\"334\":6}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1599, 350, 38, 44, 1347.000000, 3, 0, 0, 4041.000000, '{\"299\":\"3\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1600, 350, 27, 68, 284.000000, 12, 0, 0, 3408.000000, '{\"279\":\"12\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1601, 350, 32, 54, 1200.000000, 2, 0, 0, 2400.000000, '{\"284\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1602, 350, 30, 48, 800.000000, 2, 0, 0, 1600.000000, '{\"286\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1603, 350, 43, 77, 833.000000, 6, 0, 0, 4998.000000, '{\"274\":\"6\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1604, 350, 27, 70, 310.000000, 5, 0, 0, 1550.000000, '{\"269\":\"5\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1605, 350, 86, 140, 390.000000, 5, 0, 0, 1950.000000, '{\"259\":\"5\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1606, 351, 27, 31, 165.000000, 18, 0, 0, 2970.000000, '{\"272\":\"18\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1607, 351, 84, 136, 833.000000, 3, 0, 0, 2499.000000, '{\"290\":\"3\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1608, 351, 40, 128, 1600.000000, 1, 0, 0, 1600.000000, '{\"304\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1609, 351, 49, 31, 1700.000000, 5, 0, 0, 8500.000000, '{\"296\":\"5\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1610, 351, 44, 73, 500.000000, 4, 0, 0, 2000.000000, '{\"253\":\"4\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1611, 351, 38, 44, 1300.000000, 1, 0, 0, 1300.000000, '{\"299\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1612, 351, 75, 95, 1300.000000, 4, 0, 0, 5200.000000, '{\"337\":\"4\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1613, 351, 83, 130, 2900.000000, 1, 0, 0, 2900.000000, '{\"303\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1614, 351, 58, 91, 3375.000000, 4, 0, 0, 13500.000000, '{\"251\":\"4\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1615, 351, 75, 126, 2050.000000, 2, 0, 0, 4100.000000, '{\"306\":\"2\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1616, 351, 40, 83, 1600.000000, 1, 0, 0, 1600.000000, '{\"322\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1617, 351, 67, 85, 2425.000000, 4, 0, 0, 9700.000000, '{\"327\":\"4\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1618, 351, 27, 70, 252.000000, 32, 0, 0, 8064.000000, '{\"269\":\"32\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1619, 351, 28, 32, 1519.000000, 18, 0, 0, 27342.000000, '{\"255\":\"18\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1620, 351, 62, 122, 2400.000000, 2, 0, 0, 4800.000000, '{\"317\":\"2\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1621, 351, 31, 47, 563.000000, 8, 0, 0, 4504.000000, '{\"282\":\"8\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1622, 351, 39, 41, 460.000000, 30, 0, 0, 13800.000000, '{\"271\":\"30\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1623, 351, 43, 77, 573.000000, 20, 0, 0, 11460.000000, '{\"274\":\"20\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1624, 351, 66, 143, 3200.000000, 1, 0, 0, 3200.000000, '{\"342\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1625, 351, 27, 79, 356.000000, 19, 0, 0, 6764.000000, '{\"280\":\"19\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1626, 351, 55, 102, 3000.000000, 1, 0, 0, 3000.000000, '{\"334\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1627, 351, 70, 163, 3000.000000, 1, 0, 0, 3000.000000, '{\"347\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1628, 351, 48, 64, 105.000000, 26, 0, 0, 2730.000000, '{\"287\":\"26\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1629, 351, 32, 58, 936.000000, 7, 0, 0, 6552.000000, '{\"283\":\"7\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1630, 351, 33, 157, 300.000000, 4, 0, 0, 1200.000000, '{\"281\":\"4\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1631, 351, 27, 71, 358.000000, 6, 0, 0, 2148.000000, '{\"278\":\"6\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1632, 351, 27, 68, 316.000000, 13, 0, 0, 4108.000000, '{\"279\":\"13\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1633, 351, 29, 51, 975.000000, 2, 0, 0, 1950.000000, '{\"285\":\"2\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1634, 351, 72, 93, 1228.000000, 9, 0, 0, 11052.000000, '{\"298\":\"9\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1635, 351, 86, 140, 333.000000, 3, 0, 0, 999.000000, '{\"259\":\"3\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1636, 351, 60, 120, 2150.000000, 2, 0, 0, 4300.000000, '{\"316\":\"2\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1637, 351, 30, 48, 3400.000000, 5, 0, 0, 17000.000000, '{\"286\":\"5\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1638, 351, 40, 127, 2500.000000, 2, 0, 0, 5000.000000, '{\"305\":\"2\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1639, 351, 27, 72, 178.000000, 10, 0, 0, 1780.000000, '{\"273\":\"10\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1640, 351, 67, 84, 1820.000000, 5, 0, 0, 9100.000000, '{\"328\":\"4\",\"351\":1}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1641, 351, 68, 160, 3300.000000, 1, 0, 0, 3300.000000, '{\"344\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1642, 351, 51, 61, 100.000000, 2, 0, 0, 200.000000, '{\"267\":\"2\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1643, 351, 75, 96, 2000.000000, 7, 0, 0, 14000.000000, '{\"302\":\"7\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1644, 351, 42, 57, 800.000000, 2, 0, 0, 1600.000000, '{\"261\":\"2\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1645, 351, 39, 156, 450.000000, 4, 0, 0, 1800.000000, '{\"270\":\"4\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1646, 351, 40, 81, 1800.000000, 1, 0, 0, 1800.000000, '{\"323\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1647, 352, 72, 93, 1030.000000, 5, 0, 0, 5150.000000, '{\"298\":\"5\"}', '2018-03-04 01:04:33', '2018-03-04 01:04:33'),
(1648, 353, 28, 32, 1300.000000, 5, 0, 0, 6500.000000, '{\"255\":\"5\"}', '2018-03-04 01:07:46', '2018-03-04 01:07:46'),
(1649, 354, 27, 68, 200.000000, 140, 0, 0, 28000.000000, '{\"100\":\"140\"}', '2018-03-04 16:58:34', '2018-03-04 16:58:34'),
(1650, 354, 27, 31, 140.000000, 20, 0, 0, 2800.000000, '{\"219\":\"20\"}', '2018-03-04 16:58:34', '2018-03-04 16:58:34'),
(1651, 354, 27, 71, 250.000000, 48, 0, 0, 12000.000000, '{\"103\":\"48\"}', '2018-03-04 16:58:34', '2018-03-04 16:58:34'),
(1652, 354, 41, 132, 1200.000000, 1, 0, 0, 1200.000000, '{\"197\":\"1\"}', '2018-03-04 16:58:34', '2018-03-04 16:58:34'),
(1653, 354, 81, 157, 120.000000, 5, 0, 0, 600.000000, '{\"356\":\"5\"}', '2018-03-04 16:58:34', '2018-03-04 16:58:34'),
(1654, 355, 72, 93, 910.000000, 190, 0, 0, 172900.000000, '{\"194\":\"23\",\"218\":\"19\",\"355\":148}', '2018-03-04 17:06:46', '2018-03-04 17:06:46'),
(1655, 356, 67, 144, 1950.000000, 2, 0, 0, 3900.000000, '{\"236\":\"2\"}', '2018-03-04 17:16:43', '2018-03-04 17:16:43'),
(1656, 356, 70, 149, 2250.000000, 1, 0, 0, 2250.000000, '{\"354\":\"1\"}', '2018-03-04 17:16:43', '2018-03-04 17:16:43'),
(1657, 356, 72, 93, 910.000000, 160, 0, 0, 145600.000000, '{\"355\":\"160\"}', '2018-03-04 17:16:43', '2018-03-04 17:16:43'),
(1658, 357, 51, 61, 75.000000, 19, 0, 0, 1425.000000, '{\"267\":\"19\"}', '2018-03-04 21:42:03', '2018-03-04 21:42:03'),
(1659, 358, 41, 166, 1250.000000, 3, 0, 0, 3750.000000, '{\"358\":\"3\"}', '2018-03-04 21:53:46', '2018-03-04 21:53:46'),
(1660, 358, 41, 166, 1100.000000, 2, 0, 0, 2200.000000, '{\"358\":\"2\"}', '2018-03-04 21:53:46', '2018-03-04 21:53:46'),
(1661, 358, 40, 83, 1400.000000, 5, 0, 0, 7000.000000, '{\"322\":\"5\"}', '2018-03-04 21:53:46', '2018-03-04 21:53:46'),
(1662, 359, 72, 93, 1130.000000, 23, 0, 10, 25980.000000, '{\"298\":\"23\"}', '2018-03-05 00:38:14', '2018-03-05 00:38:14'),
(1663, 360, 33, 157, 300.000000, 1, 0, 0, 300.000000, '', '2018-03-05 00:56:07', '2018-03-05 00:56:07'),
(1664, 360, 72, 93, 1159.000000, 6, 0, 0, 6954.000000, '', '2018-03-05 00:56:07', '2018-03-05 00:56:07'),
(1665, 360, 27, 79, 350.000000, 1, 0, 0, 350.000000, '', '2018-03-05 00:56:07', '2018-03-05 00:56:07'),
(1666, 360, 39, 41, 475.000000, 4, 0, 0, 1900.000000, '', '2018-03-05 00:56:07', '2018-03-05 00:56:07'),
(1667, 360, 27, 72, 200.000000, 2, 0, 0, 400.000000, '', '2018-03-05 00:56:07', '2018-03-05 00:56:07'),
(1668, 360, 27, 31, 250.000000, 1, 0, 0, 250.000000, '', '2018-03-05 00:56:07', '2018-03-05 00:56:07'),
(1669, 360, 43, 77, 566.000000, 3, 0, 0, 1698.000000, '', '2018-03-05 00:56:07', '2018-03-05 00:56:07'),
(1670, 360, 48, 64, 100.000000, 2, 0, 0, 200.000000, '', '2018-03-05 00:56:07', '2018-03-05 00:56:07'),
(1671, 360, 42, 57, 800.000000, 1, 0, 0, 800.000000, '', '2018-03-05 00:56:07', '2018-03-05 00:56:07'),
(1672, 360, 30, 48, 700.000000, 1, 0, 0, 700.000000, '', '2018-03-05 00:56:07', '2018-03-05 00:56:07'),
(1673, 360, 32, 58, 900.000000, 1, 0, 0, 900.000000, '', '2018-03-05 00:56:07', '2018-03-05 00:56:07'),
(1674, 360, 70, 163, 2500.000000, 1, 0, 0, 2500.000000, '', '2018-03-05 00:56:07', '2018-03-05 00:56:07'),
(1675, 361, 27, 69, 300.000000, 1, 0, 0, 300.000000, '{\"101\":\"1\"}', '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(1676, 361, 32, 58, 800.000000, 2, 0, 0, 1600.000000, '{\"217\":\"2\"}', '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(1677, 361, 38, 44, 1300.000000, 1, 0, 0, 1300.000000, '{\"212\":\"1\"}', '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(1678, 361, 27, 70, 300.000000, 2, 0, 0, 600.000000, '{\"220\":\"2\"}', '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(1679, 361, 43, 77, 500.000000, 1, 0, 0, 500.000000, '{\"222\":\"1\"}', '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(1680, 361, 27, 72, 120.000000, 8, 0, 0, 960.000000, '{\"104\":\"8\"}', '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(1681, 361, 43, 77, 600.000000, 1, 0, 0, 600.000000, '{\"222\":\"1\"}', '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(1682, 362, 27, 31, 183.000000, 3, 0, 0, 549.000000, '{\"219\":\"3\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1683, 362, 84, 137, 300.000000, 1, 0, 0, 300.000000, '{\"206\":\"1\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1684, 362, 27, 71, 400.000000, 1, 0, 0, 400.000000, '{\"103\":\"1\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1685, 362, 27, 68, 315.000000, 2, 0, 0, 630.000000, '{\"100\":\"2\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53');
INSERT INTO `inventory_product_sales_item` (`id`, `fk_sales_id`, `fk_product_id`, `fk_model_id`, `product_price_amount`, `sales_qty`, `small_qty`, `product_wise_discount`, `product_paid_amount`, `inventory_item_id`, `created_at`, `updated_at`) VALUES
(1686, 362, 39, 41, 500.000000, 1, 0, 0, 500.000000, '{\"112\":\"1\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1687, 362, 48, 64, 100.000000, 3, 0, 0, 300.000000, '{\"208\":\"3\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1688, 362, 27, 70, 300.000000, 1, 0, 0, 300.000000, '{\"220\":\"1\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1689, 362, 33, 80, 350.000000, 2, 0, 0, 700.000000, '{\"114\":\"2\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1690, 362, 27, 79, 350.000000, 2, 0, 0, 700.000000, '{\"232\":\"2\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1691, 362, 43, 77, 450.000000, 1, 0, 0, 450.000000, '{\"222\":\"1\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1692, 362, 27, 70, 300.000000, 2, 0, 0, 600.000000, '{\"220\":\"2\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1693, 363, 35, 45, 1500.000000, 1, 0, 0, 1500.000000, '{\"201\":\"1\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1694, 363, 27, 31, 450.000000, 1, 0, 0, 450.000000, '{\"219\":\"1\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1695, 363, 33, 80, 375.000000, 4, 0, 0, 1500.000000, '{\"114\":\"4\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1696, 363, 43, 77, 600.000000, 1, 0, 0, 600.000000, '{\"222\":\"1\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1697, 363, 48, 64, 100.000000, 1, 0, 0, 100.000000, '{\"208\":\"1\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1698, 363, 27, 72, 180.000000, 1, 0, 0, 180.000000, '{\"104\":\"1\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1699, 363, 27, 70, 300.000000, 2, 0, 0, 600.000000, '{\"220\":\"2\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1700, 363, 48, 64, 100.000000, 2, 0, 0, 200.000000, '{\"208\":\"2\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1701, 363, 27, 70, 292.000000, 6, 0, 0, 1752.000000, '{\"220\":\"6\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1702, 363, 27, 31, 175.000000, 4, 0, 0, 700.000000, '{\"219\":\"4\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1703, 363, 37, 43, 800.000000, 1, 0, 0, 800.000000, '{\"211\":\"1\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1704, 364, 27, 68, 300.000000, 3, 0, 0, 900.000000, '{\"100\":\"3\"}', '2018-03-05 16:32:20', '2018-03-05 16:32:20'),
(1705, 364, 39, 41, 400.000000, 1, 0, 0, 400.000000, '{\"112\":\"1\"}', '2018-03-05 16:32:20', '2018-03-05 16:32:20'),
(1706, 364, 27, 70, 300.000000, 1, 0, 0, 300.000000, '{\"220\":\"1\"}', '2018-03-05 16:32:20', '2018-03-05 16:32:20'),
(1707, 364, 43, 77, 600.000000, 1, 0, 0, 600.000000, '{\"222\":\"1\"}', '2018-03-05 16:32:20', '2018-03-05 16:32:20'),
(1708, 365, 76, 95, 1300.000000, 1, 0, 0, 1300.000000, '{\"133\":\"1\"}', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(1709, 365, 39, 76, 300.000000, 1, 0, 0, 300.000000, '{\"221\":\"1\"}', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(1710, 365, 27, 79, 300.000000, 1, 0, 0, 300.000000, '{\"232\":\"1\"}', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(1711, 365, 48, 64, 100.000000, 2, 0, 0, 200.000000, '{\"208\":\"2\"}', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(1712, 365, 32, 58, 900.000000, 3, 0, 0, 2700.000000, '{\"217\":\"3\"}', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(1713, 365, 43, 77, 487.000000, 4, 0, 0, 1948.000000, '{\"222\":\"4\"}', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(1714, 365, 84, 137, 333.000000, 3, 0, 0, 999.000000, '{\"206\":\"3\"}', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(1715, 365, 35, 45, 1450.000000, 1, 0, 0, 1450.000000, '{\"201\":\"1\"}', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(1716, 366, 39, 76, 350.000000, 12, 0, 11.5543, 4188.445667, '{\"221\":\"12\"}', '2018-03-05 16:57:45', '2018-03-05 16:57:45'),
(1717, 366, 27, 72, 110.000000, 12, 0, 3.63136, 1316.368638, '{\"104\":\"12\"}', '2018-03-05 16:57:45', '2018-03-05 16:57:45'),
(1718, 366, 27, 68, 250.000000, 7, 0, 4.81431, 1745.185695, '{\"100\":\"7\"}', '2018-03-05 16:57:45', '2018-03-05 16:57:45'),
(1719, 367, 27, 68, 250.000000, 6, 0, 0, 1500.000000, '{\"100\":\"6\"}', '2018-03-05 17:03:42', '2018-03-05 17:03:42'),
(1720, 367, 27, 79, 250.000000, 4, 0, 0, 1000.000000, '{\"232\":\"4\"}', '2018-03-05 17:03:42', '2018-03-05 17:03:42'),
(1721, 367, 27, 31, 120.000000, 1, 0, 0, 120.000000, '{\"219\":\"1\"}', '2018-03-05 17:03:42', '2018-03-05 17:03:42'),
(1722, 368, 72, 93, 1020.000000, 5, 0, 0, 5100.000000, '{\"355\":\"5\"}', '2018-03-05 17:09:19', '2018-03-05 17:09:19'),
(1723, 368, 28, 32, 1300.000000, 1, 0, 0, 1300.000000, '{\"227\":\"1\"}', '2018-03-05 17:09:19', '2018-03-05 17:09:19'),
(1724, 368, 28, 32, 1400.000000, 1, 0, 0, 1400.000000, '{\"227\":\"1\"}', '2018-03-05 17:09:19', '2018-03-05 17:09:19'),
(1725, 368, 51, 60, 100.000000, 11, 0, 0, 1100.000000, '{\"207\":\"11\"}', '2018-03-05 17:09:19', '2018-03-05 17:09:19'),
(1726, 369, 28, 32, 1300.000000, 3, 0, 232.836, 3667.164179, '{\"227\":\"3\"}', '2018-03-05 17:12:09', '2018-03-05 17:12:09'),
(1727, 369, 28, 32, 1400.000000, 2, 0, 167.164, 2632.835821, '{\"227\":\"2\"}', '2018-03-05 17:12:09', '2018-03-05 17:12:09'),
(1728, 370, 27, 31, 150.000000, 1, 0, 0, 150.000000, '{\"219\":\"1\"}', '2018-04-01 05:14:13', '2018-04-01 05:14:14'),
(1729, 371, 55, 102, 3000.000000, 1, 0, 0, 3000.000000, '{\"334\":\"1\"}', '2020-10-02 14:54:49', '2020-10-02 14:54:49'),
(1730, 372, 53, 90, 4000.000000, 1, 0, 0, 4000.000000, '{\"250\":\"1\"}', '2020-10-02 14:55:43', '2020-10-02 14:55:43'),
(1731, 373, 44, 75, 500.000000, 1, 0, 0, 500.000000, '', '2020-10-02 14:57:36', '2020-10-02 14:57:36');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_product_sale_price`
--

CREATE TABLE `inventory_product_sale_price` (
  `id` int(11) NOT NULL,
  `fk_client_id` int(11) UNSIGNED NOT NULL,
  `fk_product_id` int(11) UNSIGNED NOT NULL,
  `sale_price` float NOT NULL,
  `created_by` int(11) UNSIGNED NOT NULL,
  `updated_by` int(11) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_product_transfer`
--

CREATE TABLE `inventory_product_transfer` (
  `id` int(11) NOT NULL,
  `transfer_from` int(11) UNSIGNED NOT NULL,
  `transfer_to` int(11) UNSIGNED NOT NULL,
  `total_amount` float NOT NULL,
  `date` date NOT NULL,
  `details` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_product_transfer`
--

INSERT INTO `inventory_product_transfer` (`id`, `transfer_from`, `transfer_to`, `total_amount`, `date`, `details`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 4, 2, 25340, '2018-02-19', NULL, 5, '2018-02-28 20:21:43', '2018-02-28 20:21:43'),
(2, 4, 2, 27330, '2018-02-19', NULL, 6, '2018-03-04 22:00:57', '2018-03-04 22:00:57');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_product_transfer_item`
--

CREATE TABLE `inventory_product_transfer_item` (
  `id` int(11) NOT NULL,
  `fk_transfer_id` int(11) NOT NULL,
  `fk_product_id` int(11) UNSIGNED NOT NULL,
  `qty` float NOT NULL,
  `cost_amount` float UNSIGNED NOT NULL,
  `cost_per_unit` float NOT NULL,
  `fk_model_id` int(11) NOT NULL,
  `inventory_item_id` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `fk_inventory_item_id` int(11) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_product_transfer_item`
--

INSERT INTO `inventory_product_transfer_item` (`id`, `fk_transfer_id`, `fk_product_id`, `qty`, `cost_amount`, `cost_per_unit`, `fk_model_id`, `inventory_item_id`, `fk_inventory_item_id`, `created_at`, `updated_at`) VALUES
(1, 1, 27, 181, 19910, 140, 31, '{\"272\":\"181\"}', 352, '2018-02-28 20:21:43', '2018-02-28 20:21:43'),
(2, 2, 27, 98, 18032, 175, 70, '{\"269\":\"98\"}', 359, '2018-03-04 22:00:57', '2018-03-04 22:00:57'),
(3, 2, 28, 10, 10180, 1018, 32, '{\"255\":\"10\"}', 360, '2018-03-04 22:00:57', '2018-03-04 22:00:57');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_receive_executive`
--

CREATE TABLE `inventory_receive_executive` (
  `id` int(11) NOT NULL,
  `executive_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `details` text COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_by` int(11) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_receive_executive`
--

INSERT INTO `inventory_receive_executive` (`id`, `executive_name`, `details`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(2, 'Rupom', '01811951215', 1, 1, '2017-10-15 00:27:30', '2017-10-15 00:27:30'),
(3, 'Fahim', 'Dhaka', 1, 1, '2017-10-15 00:27:44', '2017-10-15 00:27:44');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_sales_challan_item`
--

CREATE TABLE `inventory_sales_challan_item` (
  `id` int(11) NOT NULL,
  `fk_sales_challan_id` int(10) NOT NULL,
  `fk_sales_item_id` int(10) UNSIGNED NOT NULL,
  `qty` float NOT NULL DEFAULT 0,
  `cost_amount` float NOT NULL DEFAULT 0,
  `small_qty` float NOT NULL DEFAULT 0,
  `payable_amount` decimal(17,6) NOT NULL,
  `inventory_item_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_sales_challan_item`
--

INSERT INTO `inventory_sales_challan_item` (`id`, `fk_sales_challan_id`, `fk_sales_item_id`, `qty`, `cost_amount`, `small_qty`, `payable_amount`, `inventory_item_id`, `created_at`, `updated_at`) VALUES
(30, 23, 30, 5, 5000, 0, 6750.000000, '{\"34\":\"5\"}', '2018-02-03 14:29:59', '2018-02-03 14:29:59'),
(31, 23, 31, 4, 4400, 0, 5800.000000, '{\"37\":\"4\"}', '2018-02-03 14:29:59', '2018-02-03 14:29:59'),
(32, 24, 32, 1, 1000, 0, 2000.000000, '{\"35\":\"1\"}', '2018-02-03 15:09:35', '2018-02-03 15:09:35'),
(33, 24, 33, 2, 1330, 0, 2000.000000, '{\"40\":\"2\"}', '2018-02-03 15:09:35', '2018-02-03 15:09:35'),
(34, 25, 34, 15, 1350, 0, 1650.000000, '{\"104\":\"15\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(35, 25, 35, 48, 4800, 0, 5280.000000, '{\"33\":\"48\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(36, 25, 36, 16, 2800, 0, 3520.000000, '{\"102\":\"16\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(37, 25, 37, 5, 500, 0, 1500.000000, '{\"33\":\"5\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(38, 25, 38, 7, 1050, 0, 1260.000000, '{\"101\":\"7\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(39, 25, 39, 5, 1000, 0, 1250.000000, '{\"100\":\"5\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(40, 25, 40, 5, 1000, 0, 1500.000000, '{\"100\":\"5\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(41, 25, 41, 3, 750, 0, 900.000000, '{\"111\":\"3\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(42, 25, 42, 2, 200, 0, 360.000000, '{\"33\":\"2\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(43, 25, 43, 2, 2200, 0, 2500.000000, '{\"37\":\"2\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(44, 25, 44, 1, 1000, 0, 1150.000000, '{\"34\":\"1\"}', '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(45, 26, 45, 25, 13000, 0, 17500.000000, '{\"41\":\"25\"}', '2018-02-03 17:32:04', '2018-02-03 17:32:04'),
(46, 26, 46, 75, 71350, 0, 112500.000000, '{\"35\":\"2\",\"56\":73}', '2018-02-03 17:32:04', '2018-02-03 17:32:04'),
(47, 26, 47, 12, 6840, 0, 9600.000000, '{\"43\":\"12\"}', '2018-02-03 17:32:04', '2018-02-03 17:32:04'),
(48, 26, 48, 30, 15000, 0, 12000.000000, '{\"66\":\"30\"}', '2018-02-03 17:32:04', '2018-02-03 17:32:04'),
(49, 26, 49, 12, 12300, 0, 12000.000000, '{\"38\":\"12\"}', '2018-02-03 17:32:04', '2018-02-03 17:32:04'),
(50, 26, 50, 59, 35400, 0, 47200.000000, '{\"39\":\"59\"}', '2018-02-03 17:32:04', '2018-02-03 17:32:04'),
(51, 26, 51, 13, 7800, 0, 13000.000000, '{\"39\":\"13\"}', '2018-02-03 17:32:04', '2018-02-03 17:32:04'),
(52, 27, 52, 15, 4125, 0, 6000.000000, '{\"109\":\"15\"}', '2018-02-04 10:06:04', '2018-02-04 10:06:04'),
(53, 27, 53, 5, 5000, 0, 6500.000000, '{\"34\":\"5\"}', '2018-02-04 10:06:04', '2018-02-04 10:06:04'),
(54, 27, 54, 1, 1100, 0, 1400.000000, '{\"37\":\"1\"}', '2018-02-04 10:06:04', '2018-02-04 10:06:04'),
(55, 27, 55, 5, 4750, 0, 10000.000000, '{\"56\":\"5\",\"68\":0}', '2018-02-04 10:06:04', '2018-02-04 10:06:04'),
(56, 28, 56, 2, 2000, 0, 2600.000000, '{\"34\":\"2\"}', '2018-02-04 11:07:09', '2018-02-04 11:07:09'),
(57, 28, 57, 2, 2200, 0, 2800.000000, '{\"37\":\"2\"}', '2018-02-04 11:07:09', '2018-02-04 11:07:09'),
(58, 28, 58, 19, 5225, 0, 7600.000000, '{\"109\":\"19\"}', '2018-02-04 11:07:09', '2018-02-04 11:07:09'),
(59, 28, 59, 1, 325, 0, 450.000000, '{\"110\":\"1\"}', '2018-02-04 11:07:09', '2018-02-04 11:07:09'),
(60, 29, 60, 70, 68425, 0, 91000.000000, '{\"34\":\"7\",\"36\":63}', '2018-02-04 11:19:36', '2018-02-04 11:19:36'),
(61, 29, 61, 10, 11000, 0, 14000.000000, '{\"37\":\"10\"}', '2018-02-04 11:19:36', '2018-02-04 11:19:36'),
(62, 29, 62, 32, 32800, 0, 44800.000000, '{\"38\":\"32\"}', '2018-02-04 11:19:36', '2018-02-04 11:19:36'),
(63, 29, 63, 10, 6000, 0, 8000.000000, '{\"39\":\"10\"}', '2018-02-04 11:19:36', '2018-02-04 11:19:36'),
(64, 30, 64, 22, 6600, 0, 7700.000000, '{\"114\":\"22\"}', '2018-02-04 11:35:41', '2018-02-04 11:35:41'),
(65, 30, 65, 6, 6600, 0, 9000.000000, '{\"37\":\"6\"}', '2018-02-04 11:35:41', '2018-02-04 11:35:41'),
(66, 30, 66, 17, 16575, 0, 22100.000000, '{\"36\":\"17\"}', '2018-02-04 11:35:41', '2018-02-04 11:35:41'),
(67, 30, 67, 10, 12500, 0, 14000.000000, '{\"118\":\"10\"}', '2018-02-04 11:35:41', '2018-02-04 11:35:41'),
(68, 30, 68, 12, 19800, 0, 24000.000000, '{\"119\":\"12\"}', '2018-02-04 11:35:41', '2018-02-04 11:35:41'),
(69, 30, 69, 5, 8500, 0, 9000.000000, '{\"116\":\"5\"}', '2018-02-04 11:35:41', '2018-02-04 11:35:41'),
(70, 30, 70, 10, 1000, 0, 1200.000000, '{\"33\":\"10\"}', '2018-02-04 11:35:41', '2018-02-04 11:35:41'),
(72, 32, 72, 4, 1000, 0, 1400.000000, '{\"103\":\"4\"}', '2018-02-04 16:36:24', '2018-02-04 16:36:24'),
(73, 33, 73, 7, 6825, 0, 8050.000000, '{\"36\":\"7\"}', '2018-02-04 16:44:22', '2018-02-04 16:44:22'),
(74, 33, 74, 8, 8800, 0, 10000.000000, '{\"37\":\"8\"}', '2018-02-04 16:44:22', '2018-02-04 16:44:22'),
(75, 34, 75, 3, 525, 0, 810.000000, '{\"102\":\"3\",\"220\":0}', '2018-02-04 16:50:08', '2018-02-10 15:31:43'),
(76, 34, 76, 10, 1000, 0, 1300.000000, '{\"33\":\"10\",\"219\":0}', '2018-02-04 16:50:08', '2018-02-10 15:31:43'),
(77, 34, 77, 1, 100, 0, 150.000000, '{\"33\":\"1\",\"219\":0}', '2018-02-04 16:50:08', '2018-02-10 15:31:43'),
(78, 35, 78, 4, 3900, 0, 5400.000000, '{\"36\":\"4\"}', '2018-02-04 17:01:14', '2018-02-04 17:01:14'),
(79, 35, 79, 6, 6600, 0, 8460.000000, '{\"37\":\"6\"}', '2018-02-04 17:01:14', '2018-02-04 17:01:14'),
(80, 35, 80, 22, 1980, 0, 2640.000000, '{\"104\":\"22\"}', '2018-02-04 17:01:14', '2018-02-04 17:01:14'),
(81, 36, 81, 5, 4875, 0, 6400.000000, '{\"36\":\"5\"}', '2018-02-04 17:04:08', '2018-02-04 17:04:08'),
(82, 36, 82, 7, 7700, 0, 9800.000000, '{\"37\":\"7\"}', '2018-02-04 17:04:08', '2018-02-04 17:04:08'),
(83, 37, 83, 8, 720, 0, 1040.000000, '{\"104\":\"8\"}', '2018-02-04 17:06:46', '2018-02-04 17:06:46'),
(84, 38, 84, 1, 600, 0, 800.000000, '{\"84\":\"1\"}', '2018-02-04 17:35:40', '2018-02-04 17:35:40'),
(85, 38, 85, 2, 1950, 0, 2600.000000, '{\"36\":\"2\"}', '2018-02-04 17:35:40', '2018-02-04 17:35:40'),
(86, 38, 86, 4, 4400, 0, 5600.000000, '{\"37\":\"4\"}', '2018-02-04 17:35:40', '2018-02-04 17:35:40'),
(87, 38, 87, 2, 1200, 0, 1400.000000, '{\"84\":\"2\"}', '2018-02-04 17:35:40', '2018-02-04 17:35:40'),
(88, 39, 88, 100, 110000, 0, 110000.000000, '{\"68\":\"100\",\"72\":0}', '2018-02-05 14:25:45', '2018-02-05 14:25:45'),
(89, 40, 89, 868, 151900, 0, 159712.000000, '{\"102\":\"868\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(90, 40, 90, 628, 184868, 0, 164536.000000, '{\"109\":\"316\",\"221\":312}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(91, 40, 91, 193, 48250, 0, 38600.000000, '{\"44\":\"193\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(92, 40, 92, 1610, 161000, 0, 177100.000000, '{\"33\":\"1610\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(93, 40, 93, 520, 46800, 0, 46800.000000, '{\"104\":\"520\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(94, 40, 94, 430, 139750, 0, 144050.000000, '{\"110\":\"430\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(95, 40, 95, 171, 42750, 0, 42750.000000, '{\"111\":\"171\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(96, 40, 96, 32, 10400, 0, 19392.000000, '{\"110\":\"32\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(97, 40, 97, 449, 59000, 0, 62860.000000, '{\"33\":\"214\",\"219\":235}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(98, 40, 98, 105, 26250, 0, 26250.000000, '{\"103\":\"105\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(99, 40, 99, 202, 40400, 0, 40400.000000, '{\"100\":\"202\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(100, 40, 100, 540, 116100, 0, 125820.000000, '{\"113\":\"540\",\"232\":0}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(101, 40, 101, 80, 24000, 0, 24000.000000, '{\"114\":\"80\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(102, 40, 102, 151, 75134, 0, 61155.000000, '{\"66\":\"149\",\"216\":2}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(103, 40, 103, 380, 228000, 0, 228000.000000, '{\"84\":\"380\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(104, 40, 104, 75, 74050, 0, 75000.000000, '{\"78\":\"19\",\"83\":56}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(105, 40, 105, 113, 79350, 0, 79100.000000, '{\"75\":\"5\",\"81\":108}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(106, 40, 106, 87, 39150, 0, 41064.000000, '{\"67\":\"87\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(107, 40, 107, 737, 62822, 0, 39798.000000, '{\"95\":\"10\",\"208\":727}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(108, 40, 108, 5, 2250, 0, 4000.000000, '{\"82\":\"5\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(109, 40, 109, 7, 7632, 0, 10500.000000, '{\"76\":\"3\",\"228\":4}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(110, 40, 110, 45, 32040, 0, 35685.000000, '{\"205\":\"45\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(111, 40, 111, 16, 16800, 0, 24000.000000, '{\"71\":\"16\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(112, 40, 112, 45, 62530, 0, 45000.000000, '{\"71\":\"9\",\"96\":\"1\",\"202\":35}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(113, 40, 113, 23, 27600, 0, 27600.000000, '{\"106\":\"23\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(114, 40, 114, 11, 6050, 0, 6050.000000, '{\"206\":\"11\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(115, 40, 115, 33, 18150, 0, 24321.000000, '{\"206\":\"33\"}', '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(116, 41, 116, 16, 26400, 0, 26400.000000, '{\"61\":\"16\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(117, 41, 117, 14, 37800, 0, 37800.000000, '{\"54\":\"14\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(118, 41, 118, 184, 193200, 0, 193200.000000, '{\"131\":\"159\",\"194\":25,\"218\":0}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(119, 41, 119, 7, 28000, 0, 28000.000000, '{\"151\":\"7\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(120, 41, 120, 27, 78300, 0, 78300.000000, '{\"187\":\"27\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(121, 41, 121, 42, 68000, 0, 67200.000000, '{\"61\":\"16\",\"62\":26}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(122, 41, 122, 33, 37460, 0, 41250.000000, '{\"49\":\"9\",\"50\":\"2\",\"63\":22}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(123, 41, 123, 40, 50000, 0, 48000.000000, '{\"63\":\"40\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(124, 41, 124, 28, 47600, 0, 50596.000000, '{\"138\":\"28\",\"139\":0,\"140\":0,\"176\":0,\"177\":0,\"178\":', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(125, 41, 125, 6, 10800, 0, 14454.000000, '{\"139\":\"6\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(126, 41, 126, 12, 25200, 0, 25200.000000, '{\"195\":\"12\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(127, 41, 127, 24, 31200, 0, 31200.000000, '{\"183\":\"24\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(128, 41, 128, 28, 56000, 0, 56000.000000, '{\"182\":\"28\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(129, 41, 129, 5, 9000, 0, 6250.000000, '{\"139\":\"5\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(130, 41, 130, 7, 12600, 0, 12250.000000, '{\"139\":\"7\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(131, 41, 131, 4, 6400, 0, 6400.000000, '{\"139\":\"2\",\"140\":2,\"176\":0}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(132, 41, 132, 8, 14400, 0, 14400.000000, '{\"181\":\"8\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(133, 41, 133, 2, 7800, 0, 7800.000000, '{\"174\":\"2\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(134, 41, 134, 2, 7800, 0, 7200.000000, '{\"174\":\"2\",\"175\":0,\"204\":0}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(135, 41, 135, 10, 26000, 0, 26000.000000, '{\"154\":\"10\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(136, 41, 136, 12, 30000, 0, 30000.000000, '{\"157\":\"12\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(137, 41, 137, 12, 39600, 0, 39600.000000, '{\"161\":\"12\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(138, 41, 138, 8, 21600, 0, 21600.000000, '{\"163\":\"8\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(139, 41, 139, 5, 13750, 0, 13750.000000, '{\"164\":\"5\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(140, 41, 140, 8, 28400, 0, 28400.000000, '{\"166\":\"8\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(141, 41, 141, 12, 33600, 0, 33600.000000, '{\"165\":\"12\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(142, 41, 142, 11, 37400, 0, 37400.000000, '{\"127\":\"11\",\"147\":0,\"168\":0}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(143, 41, 143, 7, 10850, 0, 10850.000000, '{\"169\":\"7\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(144, 41, 144, 8, 14000, 0, 14000.000000, '{\"171\":\"8\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(145, 41, 145, 8, 15200, 0, 15200.000000, '{\"172\":\"8\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(146, 41, 146, 10, 12500, 0, 12500.000000, '{\"173\":\"10\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(147, 41, 147, 15, 25500, 0, 25500.000000, '{\"116\":\"15\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(148, 41, 148, 6, 18600, 0, 18600.000000, '{\"117\":\"6\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(149, 41, 149, 11, 13800, 0, 14245.000000, '{\"118\":\"10\",\"150\":1}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(150, 41, 150, 20, 34000, 0, 33000.000000, '{\"116\":\"20\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(151, 41, 151, 1, 1650, 0, 1650.000000, '{\"119\":\"1\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(152, 41, 152, 8, 16000, 0, 16000.000000, '{\"123\":\"8\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(153, 41, 153, 4, 12148, 0, 12200.000000, '{\"126\":\"4\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(154, 41, 154, 4, 10800, 0, 10800.000000, '{\"124\":\"4\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(155, 41, 155, 11, 20900, 0, 20900.000000, '{\"122\":\"11\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(156, 41, 156, 30, 44400, 0, 45000.000000, '{\"121\":\"30\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(157, 41, 157, 16, 45600, 0, 45600.000000, '{\"148\":\"16\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(158, 41, 158, 10, 29500, 0, 29500.000000, '{\"142\":\"10\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(159, 41, 159, 12, 39000, 0, 39000.000000, '{\"141\":\"12\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(160, 41, 160, 9, 27000, 0, 27000.000000, '{\"143\":\"9\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(161, 41, 161, 22, 70400, 0, 70400.000000, '{\"147\":\"11\",\"168\":11}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(162, 41, 162, 8, 22800, 0, 22800.000000, '{\"146\":\"8\",\"149\":0,\"160\":0}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(163, 41, 163, 8, 22800, 0, 22800.000000, '{\"145\":\"8\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(164, 41, 164, 18, 35172, 0, 37800.000000, '{\"132\":\"18\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(165, 41, 165, 75, 135350, 0, 82500.000000, '{\"140\":\"2\",\"176\":\"6\",\"177\":\"4\",\"178\":\"8\",\"179\":\"5\"', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(166, 41, 166, 24, 42400, 0, 31200.000000, '{\"190\":\"8\",\"191\":\"4\",\"192\":\"8\",\"193\":4,\"203\":0}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(167, 41, 167, 12, 15216, 0, 21600.000000, '{\"203\":\"6\"}', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(168, 41, 168, 4, 0, 0, 6000.000000, '[]', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(169, 41, 169, 12, 0, 0, 17400.000000, '[]', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(170, 41, 170, 12, 0, 0, 20400.000000, '[]', '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(171, 42, 171, 8, 24000, 0, 24000.000000, '{\"144\":\"8\"}', '2018-02-06 11:06:26', '2018-02-06 11:06:26'),
(172, 42, 172, 8, 24000, 0, 23200.000000, '{\"149\":\"8\",\"160\":0}', '2018-02-06 11:06:26', '2018-02-06 11:06:26'),
(173, 42, 173, 12, 37800, 0, 37800.000000, '{\"155\":\"12\"}', '2018-02-06 11:06:26', '2018-02-06 11:06:26'),
(174, 42, 174, 11, 35200, 0, 35200.000000, '{\"128\":\"11\"}', '2018-02-06 11:06:26', '2018-02-06 11:06:26'),
(175, 42, 175, 8, 20400, 0, 20400.000000, '{\"129\":\"8\"}', '2018-02-06 11:06:26', '2018-02-06 11:06:26'),
(176, 43, 176, 110, 60500, 0, 51810.000000, '{\"107\":\"110\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(177, 43, 177, 222, 66600, 0, 68820.000000, '{\"105\":\"222\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(178, 43, 178, 8, 2400, 0, 1600.000000, '{\"105\":\"8\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(179, 43, 179, 466, 417950, 0, 466000.000000, '{\"36\":\"2\",\"57\":\"320\",\"73\":144,\"87\":0}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(180, 43, 180, 24, 26400, 0, 26400.000000, '{\"37\":\"24\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(181, 43, 181, 80, 80000, 0, 88000.000000, '{\"72\":\"80\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(182, 43, 182, 23, 28750, 0, 28750.000000, '{\"52\":\"23\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(183, 43, 183, 8, 2400, 0, 2400.000000, '{\"152\":\"8\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(184, 43, 184, 2, 1000, 0, 1000.000000, '{\"153\":\"2\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(185, 43, 185, 103, 23690, 0, 20600.000000, '{\"226\":\"103\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(186, 43, 186, 28, 14560, 0, 11200.000000, '{\"42\":\"28\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(187, 43, 187, 39, 17550, 0, 20046.000000, '{\"82\":\"39\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(188, 43, 188, 63, 89864, 0, 69300.000000, '{\"202\":\"53\",\"233\":10}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(189, 43, 189, 9, 16200, 0, 16200.000000, '{\"70\":\"9\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(190, 43, 190, 53, 2650, 0, 1325.000000, '{\"88\":\"53\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(191, 43, 191, 41, 1830, 0, 1640.000000, '{\"88\":\"19\",\"89\":22}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(192, 43, 192, 29, 1160, 0, 1450.000000, '{\"89\":\"29\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(193, 43, 193, 150, 2550, 0, 2550.000000, '{\"91\":\"150\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(194, 43, 194, 290, 2900, 0, 2900.000000, '{\"93\":\"290\"}', '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(195, 44, 195, 7, 4200, 0, 5600.000000, '{\"39\":\"7\"}', '2018-02-06 14:10:38', '2018-02-06 14:10:38'),
(196, 45, 196, 2, 2200, 0, 2800.000000, '{\"37\":\"2\"}', '2018-02-06 14:15:06', '2018-02-06 14:15:06'),
(197, 45, 197, 3, 3000, 0, 3900.000000, '{\"73\":\"3\"}', '2018-02-06 14:15:06', '2018-02-06 14:15:06'),
(198, 46, 198, 4, 4400, 0, 5600.000000, '{\"37\":\"4\"}', '2018-02-06 14:17:33', '2018-02-06 14:17:33'),
(199, 47, 199, 2, 2200, 0, 2800.000000, '{\"37\":\"2\"}', '2018-02-06 14:20:00', '2018-02-06 14:20:00'),
(200, 48, 200, 5, 2250, 0, 4000.000000, '{\"82\":\"5\"}', '2018-02-06 14:36:11', '2018-02-06 14:36:11'),
(201, 48, 201, 12, 12000, 0, 15600.000000, '{\"73\":\"12\"}', '2018-02-06 14:36:11', '2018-02-06 14:36:11'),
(202, 48, 202, 1, 1233, 0, 1000.000000, '{\"228\":\"1\"}', '2018-02-06 14:36:11', '2018-02-06 14:36:11'),
(203, 48, 203, 3, 1800, 0, 2550.000000, '{\"84\":\"3\"}', '2018-02-06 14:36:11', '2018-02-06 14:36:11'),
(204, 48, 204, 8, 2536, 0, 3200.000000, '{\"216\":\"8\"}', '2018-02-06 14:36:11', '2018-02-06 14:36:11'),
(205, 49, 205, 5, 5500, 0, 6900.000000, '{\"37\":\"5\"}', '2018-02-06 14:46:29', '2018-02-06 14:46:29'),
(206, 49, 206, 2, 2000, 0, 2600.000000, '{\"73\":\"2\"}', '2018-02-06 14:46:29', '2018-02-06 14:46:29'),
(207, 49, 207, 5, 6500, 0, 7000.000000, '{\"150\":\"5\"}', '2018-02-06 14:46:29', '2018-02-06 14:46:29'),
(208, 50, 208, 3, 942, 0, 1200.000000, '{\"221\":\"3\"}', '2018-02-06 15:00:32', '2018-02-06 15:00:32'),
(209, 50, 209, 1, 150, 0, 250.000000, '{\"101\":\"1\"}', '2018-02-06 15:00:32', '2018-02-06 15:00:32'),
(210, 50, 210, 1, 2700, 0, 3200.000000, '{\"124\":\"1\"}', '2018-02-06 15:00:32', '2018-02-06 15:00:32'),
(211, 50, 211, 1, 1300, 0, 1500.000000, '{\"150\":\"1\"}', '2018-02-06 15:00:32', '2018-02-06 15:00:32'),
(212, 50, 212, 5, 15500, 0, 17000.000000, '{\"117\":\"4\",\"125\":1}', '2018-02-06 15:00:32', '2018-02-06 15:00:32'),
(213, 51, 213, 6, 18600, 0, 19800.000000, '{\"125\":\"6\"}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(214, 51, 214, 11, 20900, 0, 23100.000000, '{\"122\":\"11\"}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(215, 51, 215, 9, 13320, 0, 15300.000000, '{\"121\":\"9\"}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(216, 51, 216, 37, 11618, 0, 12950.000000, '{\"221\":\"37\"}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(217, 51, 217, 35, 8750, 0, 10500.000000, '{\"44\":\"7\",\"108\":28}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(218, 51, 218, 37, 9250, 0, 12358.000000, '{\"111\":\"37\"}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(219, 51, 219, 32, 6569, 0, 8000.000000, '{\"102\":\"13\",\"220\":19}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(220, 51, 220, 8, 8000, 0, 10400.000000, '{\"73\":\"8\"}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(221, 51, 221, 2, 2200, 0, 2800.000000, '{\"37\":\"2\"}', '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(222, 52, 222, 2, 2200, 0, 2800.000000, '{\"37\":\"2\"}', '2018-02-06 15:57:12', '2018-02-06 15:57:12'),
(223, 52, 223, 3, 3000, 0, 3900.000000, '{\"73\":\"3\"}', '2018-02-06 15:57:12', '2018-02-06 15:57:12'),
(224, 52, 224, 1, 1000, 0, 1400.000000, '{\"72\":\"1\"}', '2018-02-06 15:57:12', '2018-02-06 15:57:12'),
(225, 52, 225, 2, 5400, 0, 5700.000000, '{\"124\":\"2\"}', '2018-02-06 15:57:12', '2018-02-06 15:57:12'),
(226, 53, 226, 12, 12600, 0, 13800.000000, '{\"194\":\"12\"}', '2018-02-06 15:59:50', '2018-02-06 15:59:50'),
(227, 54, 227, 3, 3000, 0, 3900.000000, '{\"73\":\"3\"}', '2018-02-06 16:01:43', '2018-02-06 16:01:43'),
(228, 54, 228, 3, 3300, 0, 4200.000000, '{\"37\":\"3\"}', '2018-02-06 16:01:43', '2018-02-06 16:01:43'),
(229, 55, 229, 8, 1280, 0, 960.000000, '{\"219\":\"8\"}', '2018-02-06 16:07:23', '2018-02-06 16:07:23'),
(230, 55, 230, 4, 640, 0, 720.000000, '{\"219\":\"4\"}', '2018-02-06 16:07:23', '2018-02-06 16:07:23'),
(231, 55, 231, 2, 628, 0, 770.000000, '{\"221\":\"2\"}', '2018-02-06 16:07:23', '2018-02-06 16:07:23'),
(232, 55, 232, 3, 600, 0, 1050.000000, '{\"100\":\"3\"}', '2018-02-06 16:07:23', '2018-02-06 16:07:23'),
(233, 55, 233, 1, 1100, 0, 1400.000000, '{\"37\":\"1\"}', '2018-02-06 16:07:23', '2018-02-06 16:07:23'),
(234, 56, 234, 26, 4160, 0, 2600.000000, '{\"219\":\"26\"}', '2018-02-06 16:09:32', '2018-02-06 16:09:32'),
(235, 57, 235, 6, 6000, 0, 7800.000000, '{\"73\":\"6\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(236, 57, 236, 6, 6300, 0, 6900.000000, '{\"194\":\"6\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(237, 57, 237, 3, 1560, 0, 2400.000000, '{\"42\":\"3\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(238, 57, 238, 5, 1585, 0, 2000.000000, '{\"216\":\"5\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(239, 57, 239, 2, 600, 0, 700.000000, '{\"114\":\"2\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(240, 57, 240, 6, 7500, 0, 9000.000000, '{\"85\":\"6\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(241, 57, 241, 6, 1500, 0, 2100.000000, '{\"108\":\"6\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(242, 57, 242, 7, 2275, 0, 3150.000000, '{\"110\":\"7\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(243, 57, 243, 13, 2080, 0, 1690.000000, '{\"219\":\"13\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(244, 57, 244, 8, 1808, 0, 2000.000000, '{\"220\":\"8\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(245, 57, 245, 19, 3325, 0, 5130.000000, '{\"99\":\"19\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(246, 57, 246, 23, 1978, 0, 1840.000000, '{\"208\":\"23\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(247, 57, 247, 5, 430, 0, 750.000000, '{\"208\":\"5\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(248, 57, 248, 10, 860, 0, 1300.000000, '{\"208\":\"10\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(249, 57, 249, 4, 640, 0, 600.000000, '{\"219\":\"4\"}', '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(250, 58, 250, 3, 3150, 0, 3600.000000, '{\"194\":\"3\"}', '2018-02-06 16:31:48', '2018-02-06 16:31:48'),
(251, 58, 251, 2, 3600, 0, 2700.000000, '{\"181\":\"2\"}', '2018-02-06 16:31:48', '2018-02-06 16:31:48'),
(252, 58, 252, 1, 1800, 0, 1400.000000, '{\"181\":\"1\"}', '2018-02-06 16:31:48', '2018-02-06 16:31:48'),
(253, 59, 253, 1, 1100, 0, 1400.000000, '{\"37\":\"1\",\"58\":0}', '2018-02-06 16:34:30', '2018-02-06 16:34:30'),
(254, 59, 254, 5, 6200, 0, 6250.000000, '{\"63\":\"4\",\"64\":1}', '2018-02-06 16:34:30', '2018-02-06 16:34:30'),
(255, 60, 255, 3, 3300, 0, 3750.000000, '{\"133\":\"3\"}', '2018-02-06 16:37:39', '2018-02-06 16:37:39'),
(256, 60, 256, 1, 1100, 0, 1400.000000, '{\"133\":\"1\"}', '2018-02-06 16:37:39', '2018-02-06 16:37:39'),
(257, 61, 257, 2, 2200, 0, 2600.000000, '{\"133\":\"2\"}', '2018-02-06 16:40:14', '2018-02-06 16:40:14'),
(258, 61, 258, 2, 2200, 0, 2800.000000, '{\"133\":\"2\"}', '2018-02-06 16:40:14', '2018-02-06 16:40:14'),
(259, 62, 259, 7, 2219, 0, 2450.000000, '{\"216\":\"7\"}', '2018-02-06 16:42:20', '2018-02-06 16:42:20'),
(260, 63, 260, 13, 2080, 0, 1430.000000, '{\"219\":\"13\"}', '2018-02-06 16:44:57', '2018-02-06 16:44:57'),
(261, 63, 261, 2, 300, 0, 350.000000, '{\"101\":\"2\"}', '2018-02-06 16:44:57', '2018-02-06 16:44:57'),
(262, 64, 262, 2, 500, 0, 900.000000, '{\"111\":\"2\"}', '2018-02-06 16:49:44', '2018-02-06 16:49:44'),
(263, 65, 263, 4, 640, 0, 480.000000, '{\"219\":\"4\"}', '2018-02-06 16:52:04', '2018-02-06 16:52:04'),
(264, 65, 264, 1, 226, 0, 270.000000, '{\"220\":\"1\"}', '2018-02-06 16:52:04', '2018-02-06 16:52:04'),
(265, 66, 265, 5, 5250, 0, 5700.000000, '{\"194\":\"5\"}', '2018-02-06 16:53:58', '2018-02-06 16:53:58'),
(266, 67, 266, 5, 8000, 0, 9000.000000, '{\"62\":\"5\"}', '2018-02-06 16:56:09', '2018-02-06 16:56:09'),
(267, 67, 267, 2, 2400, 0, 2800.000000, '{\"64\":\"2\"}', '2018-02-06 16:56:09', '2018-02-06 16:56:09'),
(268, 68, 268, 49, 23800, 0, 36750.000000, '{\"42\":\"35\",\"65\":14}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(269, 68, 269, 5, 2000, 0, 4500.000000, '{\"65\":\"5\"}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(270, 68, 270, 31, 1240, 0, 3100.000000, '{\"89\":\"31\"}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(271, 68, 271, 24, 690, 0, 1920.000000, '{\"89\":\"6\",\"90\":18}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(272, 68, 272, 28, 700, 0, 1400.000000, '{\"90\":\"28\"}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(273, 68, 273, 14, 4396, 0, 4900.000000, '{\"221\":\"14\"}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(274, 68, 274, 4, 640, 0, 1600.000000, '{\"219\":\"4\"}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(275, 68, 275, 24, 7608, 0, 19200.000000, '{\"216\":\"24\"}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(276, 68, 276, 6, 6000, 0, 7200.000000, '{\"83\":\"6\"}', '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(277, 69, 277, 7, 1582, 0, 1890.000000, '{\"220\":\"7\"}', '2018-02-06 17:12:21', '2018-02-06 17:12:21'),
(278, 69, 278, 12, 1920, 0, 1440.000000, '{\"219\":\"12\"}', '2018-02-06 17:12:21', '2018-02-06 17:12:21'),
(279, 70, 279, 1, 950, 0, 1500.000000, '{\"53\":\"1\"}', '2018-02-06 17:14:51', '2018-02-06 17:14:51'),
(280, 70, 280, 4, 5000, 0, 7200.000000, '{\"85\":\"4\"}', '2018-02-06 17:14:51', '2018-02-06 17:14:51'),
(281, 71, 281, 60, 60000, 0, 78000.000000, '{\"73\":\"60\"}', '2018-02-06 17:19:15', '2018-02-06 17:19:15'),
(282, 71, 282, 20, 19000, 0, 30000.000000, '{\"58\":\"20\"}', '2018-02-06 17:19:15', '2018-02-06 17:19:15'),
(283, 71, 283, 50, 50000, 0, 70000.000000, '{\"72\":\"50\"}', '2018-02-06 17:19:15', '2018-02-06 17:19:15'),
(284, 71, 284, 10, 5700, 0, 8000.000000, '{\"43\":\"10\"}', '2018-02-06 17:19:15', '2018-02-06 17:19:15'),
(285, 72, 285, 2, 2000, 0, 2600.000000, '{\"73\":\"2\"}', '2018-02-06 18:06:12', '2018-02-06 18:06:12'),
(286, 72, 286, 2, 800, 0, 1400.000000, '{\"65\":\"2\"}', '2018-02-06 18:06:12', '2018-02-06 18:06:12'),
(287, 72, 287, 2, 1100, 0, 1500.000000, '{\"206\":\"2\"}', '2018-02-06 18:06:12', '2018-02-06 18:06:12'),
(288, 72, 288, 8, 7600, 0, 11000.000000, '{\"58\":\"8\"}', '2018-02-06 18:06:12', '2018-02-06 18:06:12'),
(289, 73, 289, 1, 250, 0, 350.000000, '{\"111\":\"1\"}', '2018-02-06 18:08:02', '2018-02-06 18:08:02'),
(290, 74, 290, 5, 2000, 0, 4000.000000, '{\"65\":\"5\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(291, 74, 291, 10, 9500, 0, 14000.000000, '{\"58\":\"10\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(292, 74, 292, 6, 6000, 0, 7800.000000, '{\"73\":\"6\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(293, 74, 293, 12, 3900, 0, 5100.000000, '{\"110\":\"12\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(294, 74, 294, 10, 3250, 0, 7000.000000, '{\"110\":\"10\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(295, 74, 295, 8, 2000, 0, 2600.000000, '{\"111\":\"8\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(296, 74, 296, 30, 9420, 0, 10500.000000, '{\"221\":\"30\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(297, 74, 297, 30, 6780, 0, 8100.000000, '{\"220\":\"30\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(298, 74, 298, 15, 3390, 0, 3300.000000, '{\"220\":\"15\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(299, 74, 299, 20, 3200, 0, 2400.000000, '{\"219\":\"20\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(300, 74, 300, 3, 1650, 0, 2400.000000, '{\"107\":\"3\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(301, 74, 301, 10, 3000, 0, 4000.000000, '{\"105\":\"10\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(302, 74, 302, 3, 3300, 0, 3750.000000, '{\"133\":\"3\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(303, 74, 303, 7, 7350, 0, 8050.000000, '{\"194\":\"7\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(304, 74, 304, 4, 4800, 0, 5200.000000, '{\"64\":\"4\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(305, 74, 305, 6, 6600, 0, 9600.000000, '{\"133\":\"6\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(306, 74, 306, 1, 1100, 0, 2000.000000, '{\"133\":\"1\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(307, 74, 307, 1, 2850, 0, 2800.000000, '{\"148\":\"1\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(308, 74, 308, 1, 2700, 0, 2800.000000, '{\"54\":\"1\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(309, 74, 309, 14, 238, 0, 700.000000, '{\"91\":\"14\"}', '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(310, 75, 310, 24, 26400, 0, 33600.000000, '{\"233\":\"24\"}', '2018-02-06 18:42:49', '2018-02-06 18:42:49'),
(311, 75, 311, 42, 13314, 0, 31500.000000, '{\"216\":\"42\"}', '2018-02-06 18:42:49', '2018-02-06 18:42:49'),
(312, 75, 312, 3, 3000, 0, 4200.000000, '{\"72\":\"3\"}', '2018-02-06 18:42:49', '2018-02-06 18:42:49'),
(313, 75, 313, 30, 9000, 0, 9000.000000, '{\"114\":\"30\"}', '2018-02-06 18:42:49', '2018-02-06 18:42:49'),
(314, 76, 314, 1, 950, 0, 1400.000000, '{\"58\":\"1\"}', '2018-02-06 18:46:25', '2018-02-06 18:46:25'),
(315, 76, 315, 2, 2000, 0, 2550.000000, '{\"73\":\"2\"}', '2018-02-06 18:46:25', '2018-02-06 18:46:25'),
(316, 77, 316, 4, 1256, 0, 1400.000000, '{\"221\":\"4\"}', '2018-02-06 18:50:59', '2018-02-06 18:50:59'),
(317, 77, 317, 1, 160, 0, 120.000000, '{\"219\":\"1\"}', '2018-02-06 18:50:59', '2018-02-06 18:50:59'),
(318, 77, 318, 2, 2000, 0, 2600.000000, '{\"73\":\"2\"}', '2018-02-06 18:50:59', '2018-02-06 18:50:59'),
(319, 78, 319, 2, 1100, 0, 1500.000000, '{\"107\":\"2\"}', '2018-02-07 11:19:41', '2018-02-07 11:19:41'),
(320, 78, 320, 1, 1100, 0, 1900.000000, '{\"233\":\"1\"}', '2018-02-07 11:19:41', '2018-02-07 11:19:41'),
(321, 79, 321, 2, 800, 0, 1400.000000, '{\"65\":\"2\"}', '2018-02-07 11:25:43', '2018-02-07 11:25:43'),
(322, 79, 322, 1, 950, 0, 1400.000000, '{\"58\":\"1\"}', '2018-02-07 11:25:43', '2018-02-07 11:25:43'),
(323, 79, 323, 1, 1300, 0, 1400.000000, '{\"150\":\"1\"}', '2018-02-07 11:25:43', '2018-02-07 11:25:43'),
(324, 80, 324, 0, 0, 0, 0.000000, '{\"221\":\"0\"}', '2018-02-07 11:52:18', '2018-02-07 15:17:57'),
(325, 80, 325, 0, 0, 0, 0.000000, '{\"73\":\"0\"}', '2018-02-07 11:52:18', '2018-02-07 15:17:57'),
(326, 80, 326, 0, 0, 0, 0.000000, '{\"58\":\"0\"}', '2018-02-07 11:52:18', '2018-02-07 15:17:57'),
(327, 80, 327, 0, 0, 0, 0.000000, '{\"72\":\"0\"}', '2018-02-07 11:52:18', '2018-02-07 15:17:57'),
(328, 81, 328, 0, 0, 0, 0.000000, '{\"73\":\"0\"}', '2018-02-07 11:57:23', '2018-02-07 15:18:54'),
(329, 81, 329, 0, 0, 0, 0.000000, '{\"58\":\"0\"}', '2018-02-07 11:57:23', '2018-02-07 15:18:54'),
(330, 81, 330, 0, 0, 0, 0.000000, '{\"221\":\"0\"}', '2018-02-07 11:57:23', '2018-02-07 15:18:54'),
(331, 81, 331, 0, 0, 0, 0.000000, '{\"110\":\"0\"}', '2018-02-07 11:57:23', '2018-02-07 15:18:54'),
(332, 82, 332, 390, 62400, 0, 39000.000000, '{\"219\":\"390\"}', '2018-02-07 12:04:20', '2018-02-07 12:04:20'),
(333, 82, 333, 4, 904, 0, 800.000000, '{\"220\":\"4\"}', '2018-02-07 12:04:20', '2018-02-07 12:04:20'),
(334, 82, 334, 32, 8000, 0, 6400.000000, '{\"108\":\"32\"}', '2018-02-07 12:04:20', '2018-02-07 12:04:20'),
(335, 82, 335, 18, 1548, 0, 900.000000, '{\"208\":\"18\"}', '2018-02-07 12:04:20', '2018-02-07 12:04:20'),
(336, 82, 336, 12, 1920, 0, 3000.000000, '{\"219\":\"12\"}', '2018-02-07 12:04:20', '2018-02-07 12:04:20'),
(337, 83, 337, 10, 6000, 0, 7890.000000, '{\"84\":\"10\"}', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(338, 83, 338, 5, 3500, 0, 4250.000000, '{\"81\":\"5\"}', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(339, 83, 339, 6, 4200, 0, 4500.000000, '{\"81\":\"6\"}', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(340, 83, 340, 2, 2000, 0, 2600.000000, '{\"73\":\"2\"}', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(341, 83, 341, 4, 3800, 0, 5600.000000, '{\"58\":\"4\"}', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(342, 83, 342, 2, 1680, 0, 1700.000000, '{\"209\":\"2\"}', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(343, 83, 343, 13, 2938, 0, 2860.000000, '{\"220\":\"13\"}', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(344, 83, 344, 5, 1625, 0, 2100.000000, '{\"110\":\"5\"}', '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(345, 84, 345, 51, 11526, 0, 10200.000000, '{\"220\":\"51\"}', '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(346, 84, 346, 14, 4550, 0, 4900.000000, '{\"110\":\"14\"}', '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(347, 84, 347, 39, 5850, 0, 5850.000000, '{\"101\":\"39\"}', '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(348, 84, 348, 20, 4000, 0, 5000.000000, '{\"100\":\"20\"}', '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(349, 84, 349, 12, 12000, 0, 12000.000000, '{\"73\":\"12\"}', '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(350, 84, 350, 44, 3784, 0, 2200.000000, '{\"208\":\"44\"}', '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(351, 84, 351, 24, 3840, 0, 2400.000000, '{\"219\":\"24\"}', '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(352, 85, 352, 6, 3600, 0, 4800.000000, '{\"84\":\"6\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(353, 85, 353, 5, 3000, 0, 3500.000000, '{\"84\":\"5\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(354, 85, 354, 6, 4200, 0, 5100.000000, '{\"81\":\"6\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(355, 85, 355, 9, 4950, 0, 3600.000000, '{\"206\":\"9\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(356, 85, 356, 10, 2500, 0, 3000.000000, '{\"108\":\"10\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(357, 85, 357, 5, 1625, 0, 3500.000000, '{\"110\":\"5\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(358, 85, 358, 10, 3845, 0, 4500.000000, '{\"110\":\"3\",\"222\":7}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(359, 85, 359, 5, 800, 0, 1750.000000, '{\"219\":\"5\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(360, 85, 360, 2, 2000, 0, 3800.000000, '{\"72\":\"2\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(361, 85, 361, 3, 3000, 0, 3750.000000, '{\"72\":\"3\"}', '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(362, 86, 362, 5, 5000, 0, 6400.000000, '{\"73\":\"5\"}', '2018-02-07 13:02:18', '2018-02-07 13:02:18'),
(363, 86, 363, 5, 5050, 0, 6900.000000, '{\"58\":\"3\",\"74\":2}', '2018-02-07 13:02:18', '2018-02-07 13:02:18'),
(364, 86, 364, 2, 2000, 0, 2700.000000, '{\"72\":\"2\"}', '2018-02-07 13:02:18', '2018-02-07 13:02:18'),
(365, 87, 365, 55, 8800, 0, 13750.000000, '{\"219\":\"55\"}', '2018-02-07 13:05:44', '2018-02-07 15:14:00'),
(366, 87, 366, 3, 2100, 0, 2250.000000, '{\"81\":\"3\",\"225\":0}', '2018-02-07 13:05:44', '2018-02-07 15:14:00'),
(367, 87, 367, 0, 0, 0, 0.000000, '{\"81\":\"0\"}', '2018-02-07 13:05:44', '2018-02-07 15:14:00'),
(368, 88, 368, 9, 5400, 0, 5400.000000, '{\"39\":\"3\",\"55\":6}', '2018-02-07 13:41:32', '2018-02-07 13:41:32'),
(369, 88, 369, 4, 4100, 0, 2400.000000, '{\"38\":\"4\"}', '2018-02-07 13:41:32', '2018-02-07 13:41:32'),
(370, 88, 370, 6, 2400, 0, 3300.000000, '{\"65\":\"6\"}', '2018-02-07 13:41:32', '2018-02-07 13:41:32'),
(371, 88, 371, 10, 10000, 0, 10500.000000, '{\"72\":\"10\"}', '2018-02-07 13:41:32', '2018-02-07 13:41:32'),
(372, 88, 372, 5, 5500, 0, 5500.000000, '{\"74\":\"5\"}', '2018-02-07 13:41:32', '2018-02-07 13:41:32'),
(373, 88, 373, 5, 2710, 0, 2750.000000, '{\"43\":\"3\",\"69\":2}', '2018-02-07 13:41:32', '2018-02-07 13:41:32'),
(374, 89, 374, 2, 1200, 0, 1800.000000, '{\"55\":\"2\"}', '2018-02-07 13:44:23', '2018-02-07 13:44:23'),
(375, 89, 375, 2, 320, 0, 440.000000, '{\"219\":\"2\"}', '2018-02-07 13:44:23', '2018-02-07 13:44:23'),
(376, 89, 376, 14, 2240, 0, 1540.000000, '{\"219\":\"14\"}', '2018-02-07 13:44:23', '2018-02-07 13:44:23'),
(377, 90, 377, 4, 4400, 0, 5600.000000, '{\"74\":\"4\"}', '2018-02-07 13:46:14', '2018-02-07 13:46:14'),
(378, 91, 378, 17, 17000, 0, 23800.000000, '{\"72\":\"17\"}', '2018-02-07 13:50:02', '2018-02-07 13:50:02'),
(379, 91, 379, 6, 4200, 0, 4800.000000, '{\"81\":\"6\"}', '2018-02-07 13:50:02', '2018-02-07 13:50:02'),
(380, 91, 380, 4, 2660, 0, 3200.000000, '{\"40\":\"4\"}', '2018-02-07 13:50:02', '2018-02-07 13:50:02'),
(381, 92, 381, 26, 8164, 0, 9100.000000, '{\"221\":\"26\"}', '2018-02-07 13:52:23', '2018-02-07 13:52:23'),
(382, 93, 382, 25, 4000, 0, 2500.000000, '{\"219\":\"25\"}', '2018-02-07 13:58:18', '2018-02-07 13:58:18'),
(383, 93, 383, 18, 2880, 0, 4500.000000, '{\"219\":\"18\"}', '2018-02-07 13:58:18', '2018-02-07 13:58:18'),
(384, 93, 384, 140, 22400, 0, 19600.000000, '{\"219\":\"140\"}', '2018-02-07 13:58:18', '2018-02-07 13:58:18'),
(385, 93, 385, 12, 13200, 0, 13200.000000, '{\"74\":\"12\"}', '2018-02-07 13:58:18', '2018-02-07 13:58:18'),
(386, 93, 386, 28, 27300, 0, 28000.000000, '{\"73\":\"21\",\"87\":7}', '2018-02-07 13:58:18', '2018-02-07 13:58:18'),
(387, 94, 387, 1, 410, 0, 450.000000, '{\"222\":\"1\"}', '2018-02-07 14:05:51', '2018-02-07 14:05:51'),
(388, 94, 388, 2, 628, 0, 700.000000, '{\"221\":\"2\"}', '2018-02-07 14:05:51', '2018-02-07 14:05:51'),
(389, 94, 389, 2, 320, 0, 310.000000, '{\"219\":\"2\"}', '2018-02-07 14:05:51', '2018-02-07 14:05:51'),
(390, 95, 390, 13, 2080, 0, 1690.000000, '{\"219\":\"13\"}', '2018-02-07 14:09:35', '2018-02-07 14:09:35'),
(391, 95, 391, 1, 160, 0, 200.000000, '{\"219\":\"1\"}', '2018-02-07 14:09:35', '2018-02-07 14:09:35'),
(392, 95, 392, 11, 1760, 0, 1210.000000, '{\"219\":\"11\"}', '2018-02-07 14:09:35', '2018-02-07 14:09:35'),
(393, 95, 393, 4, 640, 0, 480.000000, '{\"219\":\"4\"}', '2018-02-07 14:09:35', '2018-02-07 14:09:35'),
(394, 95, 394, 1, 900, 0, 1300.000000, '{\"87\":\"1\"}', '2018-02-07 14:09:35', '2018-02-07 14:09:35'),
(395, 95, 395, 1, 1100, 0, 1400.000000, '{\"74\":\"1\"}', '2018-02-07 14:09:35', '2018-02-07 14:09:35'),
(396, 96, 396, 5, 5125, 0, 6000.000000, '{\"38\":\"5\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(397, 96, 397, 4, 4100, 0, 5200.000000, '{\"38\":\"4\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(398, 96, 398, 11, 11275, 0, 15400.000000, '{\"38\":\"11\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(399, 96, 399, 8, 3200, 0, 6240.000000, '{\"65\":\"8\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(400, 96, 400, 7, 6300, 0, 9100.000000, '{\"87\":\"7\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(401, 96, 401, 7, 7700, 0, 9800.000000, '{\"74\":\"7\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(402, 96, 402, 8, 4800, 0, 5600.000000, '{\"84\":\"8\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(403, 96, 403, 2, 1200, 0, 1600.000000, '{\"84\":\"2\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(404, 96, 404, 7, 602, 0, 910.000000, '{\"208\":\"7\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(405, 96, 405, 5, 430, 0, 750.000000, '{\"208\":\"5\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(406, 96, 406, 50, 4300, 0, 3500.000000, '{\"208\":\"50\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(407, 96, 407, 10, 860, 0, 1000.000000, '{\"208\":\"10\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(408, 96, 408, 4, 1800, 0, 3000.000000, '{\"67\":\"4\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(409, 96, 409, 7, 4900, 0, 5950.000000, '{\"81\":\"7\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(410, 96, 410, 7, 3850, 0, 2800.000000, '{\"206\":\"7\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(411, 96, 411, 36, 11304, 0, 12600.000000, '{\"221\":\"36\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(412, 96, 412, 26, 10660, 0, 11050.000000, '{\"222\":\"26\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(413, 96, 413, 33, 8250, 0, 10725.000000, '{\"111\":\"33\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(414, 96, 414, 32, 5120, 0, 4160.000000, '{\"219\":\"32\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(415, 96, 415, 7, 1120, 0, 2800.000000, '{\"219\":\"7\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(416, 96, 416, 12, 3000, 0, 4200.000000, '{\"108\":\"12\"}', '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(417, 97, 417, 3, 2700, 0, 3900.000000, '{\"87\":\"3\"}', '2018-02-07 14:32:39', '2018-02-07 14:32:39'),
(418, 97, 418, 3, 3300, 0, 4200.000000, '{\"74\":\"3\"}', '2018-02-07 14:32:39', '2018-02-07 14:32:39'),
(419, 98, 419, 60, 24600, 0, 24000.000000, '{\"222\":\"60\"}', '2018-02-07 14:34:13', '2018-02-07 14:34:13'),
(420, 99, 420, 1, 1200, 0, 1000.000000, '{\"64\":\"1\"}', '2018-02-07 14:36:39', '2018-02-07 14:36:39'),
(421, 99, 421, 2, 2400, 0, 2700.000000, '{\"64\":\"2\"}', '2018-02-07 14:36:39', '2018-02-07 14:36:39'),
(422, 100, 422, 5, 4500, 0, 6500.000000, '{\"87\":\"5\"}', '2018-02-07 14:40:47', '2018-02-07 14:40:47'),
(423, 100, 423, 3, 3300, 0, 4200.000000, '{\"74\":\"3\"}', '2018-02-07 14:40:47', '2018-02-07 14:40:47'),
(424, 100, 424, 9, 2826, 0, 3600.000000, '{\"221\":\"9\"}', '2018-02-07 14:40:47', '2018-02-07 14:40:47'),
(425, 100, 425, 9, 2826, 0, 3150.000000, '{\"221\":\"9\"}', '2018-02-07 14:40:47', '2018-02-07 14:40:47'),
(426, 100, 426, 11, 1760, 0, 1375.000000, '{\"219\":\"11\"}', '2018-02-07 14:40:47', '2018-02-07 14:40:47'),
(427, 101, 427, 17, 4250, 0, 5100.000000, '{\"108\":\"17\"}', '2018-02-07 14:46:45', '2018-02-07 14:46:45'),
(428, 101, 428, 33, 10362, 0, 11385.000000, '{\"221\":\"33\"}', '2018-02-07 14:46:45', '2018-02-07 14:46:45'),
(429, 102, 429, 2, 1800, 0, 2600.000000, '{\"87\":\"2\"}', '2018-02-07 14:51:36', '2018-02-07 14:51:36'),
(430, 102, 430, 3, 3300, 0, 4200.000000, '{\"74\":\"3\"}', '2018-02-07 14:51:36', '2018-02-07 14:51:36'),
(431, 102, 431, 5, 5000, 0, 6900.000000, '{\"72\":\"5\"}', '2018-02-07 14:51:36', '2018-02-07 14:51:36'),
(432, 103, 432, 6, 16200, 0, 16800.000000, '{\"54\":\"6\"}', '2018-02-07 14:56:31', '2018-02-07 14:56:31'),
(433, 103, 433, 5, 1570, 0, 1700.000000, '{\"221\":\"5\"}', '2018-02-07 14:56:31', '2018-02-07 14:56:31'),
(434, 103, 434, 1, 900, 0, 1300.000000, '{\"87\":\"1\"}', '2018-02-07 14:56:31', '2018-02-07 14:56:31'),
(435, 103, 435, 9, 5980, 0, 7200.000000, '{\"81\":\"5\",\"225\":4}', '2018-02-07 14:56:31', '2018-02-07 14:56:31'),
(436, 103, 436, 2, 1200, 0, 1600.000000, '{\"84\":\"2\"}', '2018-02-07 14:56:31', '2018-02-07 14:56:31'),
(437, 103, 437, 2, 1200, 0, 1600.000000, '{\"55\":\"2\"}', '2018-02-07 14:56:31', '2018-02-07 14:56:31'),
(438, 104, 438, 14, 2240, 0, 2520.000000, '{\"219\":\"14\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(439, 104, 439, 22, 3520, 0, 2860.000000, '{\"219\":\"22\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(440, 104, 440, 17, 4250, 0, 5950.000000, '{\"111\":\"17\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(441, 104, 441, 14, 3164, 0, 3500.000000, '{\"220\":\"14\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(442, 104, 442, 5, 2050, 0, 2250.000000, '{\"222\":\"5\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(443, 104, 443, 12, 1920, 0, 4200.000000, '{\"219\":\"12\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(444, 104, 444, 14, 3500, 0, 4200.000000, '{\"108\":\"14\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(445, 104, 445, 1, 900, 0, 1300.000000, '{\"87\":\"1\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(446, 104, 446, 10, 11000, 0, 14000.000000, '{\"74\":\"10\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(447, 104, 447, 4, 4400, 0, 11200.000000, '{\"133\":\"4\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(448, 104, 448, 1, 1200, 0, 950.000000, '{\"64\":\"1\"}', '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(449, 105, 449, 16, 17150, 0, 22400.000000, '{\"58\":\"3\",\"74\":13}', '2018-02-07 15:31:03', '2018-02-07 15:31:03'),
(450, 105, 450, 8, 5320, 0, 8000.000000, '{\"40\":\"8\"}', '2018-02-07 15:31:03', '2018-02-07 15:31:03'),
(451, 105, 451, 8, 8200, 0, 5600.000000, '{\"38\":\"8\"}', '2018-02-07 15:31:03', '2018-02-07 15:31:03'),
(452, 105, 452, 24, 2064, 0, 1200.000000, '{\"208\":\"24\"}', '2018-02-07 15:31:03', '2018-02-07 15:31:03'),
(453, 106, 453, 14, 15400, 0, 19600.000000, '{\"74\":\"14\"}', '2018-02-07 15:48:19', '2018-02-07 15:48:19'),
(454, 106, 454, 30, 27700, 0, 39000.000000, '{\"73\":\"7\",\"87\":23}', '2018-02-07 15:48:19', '2018-02-07 15:48:19'),
(455, 106, 455, 1, 950, 0, 1300.000000, '{\"53\":\"1\"}', '2018-02-07 15:48:19', '2018-02-07 15:48:19'),
(456, 106, 456, 1, 314, 0, 500.000000, '{\"221\":\"1\"}', '2018-02-07 15:48:19', '2018-02-07 15:48:19'),
(457, 106, 457, 1, 325, 0, 600.000000, '{\"110\":\"1\",\"222\":0}', '2018-02-07 15:48:19', '2018-02-07 15:48:19'),
(458, 106, 458, 1, 86, 0, 100.000000, '{\"208\":\"1\"}', '2018-02-07 15:48:19', '2018-02-07 15:48:19'),
(459, 107, 459, 7, 7700, 0, 7700.000000, '{\"74\":\"7\"}', '2018-02-07 15:55:27', '2018-02-07 15:55:27'),
(460, 107, 460, 7, 3850, 0, 1750.000000, '{\"206\":\"7\"}', '2018-02-07 15:55:27', '2018-02-07 15:55:27'),
(461, 107, 461, 6, 3990, 0, 3600.000000, '{\"40\":\"6\"}', '2018-02-07 15:55:27', '2018-02-07 15:55:27'),
(462, 107, 462, 62, 5332, 0, 3100.000000, '{\"208\":\"62\"}', '2018-02-07 15:55:27', '2018-02-07 15:55:27'),
(463, 107, 463, 5, 4500, 0, 5000.000000, '{\"87\":\"5\"}', '2018-02-07 15:55:27', '2018-02-07 15:55:27'),
(464, 108, 464, 11, 9900, 0, 14300.000000, '{\"87\":\"11\"}', '2018-02-07 16:05:03', '2018-02-07 16:05:03'),
(465, 108, 465, 6, 6600, 0, 8400.000000, '{\"74\":\"6\"}', '2018-02-07 16:05:03', '2018-02-07 16:05:03'),
(466, 108, 466, 2, 2000, 0, 2800.000000, '{\"72\":\"2\"}', '2018-02-07 16:05:03', '2018-02-07 16:05:03'),
(467, 109, 467, 9, 8100, 0, 11700.000000, '{\"87\":\"9\"}', '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(468, 109, 468, 3, 3300, 0, 4200.000000, '{\"74\":\"3\"}', '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(469, 109, 469, 3, 678, 0, 750.000000, '{\"220\":\"3\"}', '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(470, 109, 470, 10, 1600, 0, 1200.000000, '{\"219\":\"10\"}', '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(471, 109, 471, 11, 3454, 0, 3850.000000, '{\"221\":\"11\"}', '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(472, 109, 472, 9, 2826, 0, 3600.000000, '{\"221\":\"9\"}', '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(473, 109, 473, 16, 2560, 0, 2000.000000, '{\"219\":\"16\"}', '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(474, 110, 474, 2, 2200, 0, 2800.000000, '{\"74\":\"2\"}', '2018-02-07 16:16:02', '2018-02-07 16:16:02'),
(475, 110, 475, 3, 2700, 0, 3900.000000, '{\"87\":\"3\"}', '2018-02-07 16:16:02', '2018-02-07 16:16:02'),
(476, 110, 476, 1, 160, 0, 120.000000, '{\"219\":\"1\"}', '2018-02-07 16:16:02', '2018-02-07 16:16:02'),
(477, 110, 477, 1, 314, 0, 350.000000, '{\"221\":\"1\"}', '2018-02-07 16:16:02', '2018-02-07 16:16:02'),
(478, 110, 478, 5, 1570, 0, 1980.000000, '{\"221\":\"5\"}', '2018-02-07 16:16:02', '2018-02-07 16:16:02'),
(479, 111, 479, 32, 7232, 0, 6400.000000, '{\"220\":\"32\"}', '2018-02-07 16:24:07', '2018-02-07 16:24:07'),
(480, 111, 480, 26, 4160, 0, 2860.000000, '{\"219\":\"26\"}', '2018-02-07 16:24:07', '2018-02-07 16:24:07'),
(481, 112, 481, 4, 1600, 0, 2400.000000, '{\"65\":\"4\"}', '2018-02-07 16:27:27', '2018-02-07 16:27:27'),
(482, 113, 482, 3, 2700, 0, 3900.000000, '{\"87\":\"3\"}', '2018-02-07 16:31:55', '2018-02-07 16:31:55'),
(483, 113, 483, 1, 1100, 0, 1400.000000, '{\"74\":\"1\"}', '2018-02-07 16:31:55', '2018-02-07 16:31:55'),
(484, 114, 484, 2, 2200, 0, 2500.000000, '{\"74\":\"2\"}', '2018-02-07 16:34:49', '2018-02-07 16:34:49'),
(485, 114, 485, 3, 2700, 0, 3450.000000, '{\"87\":\"3\"}', '2018-02-07 16:34:49', '2018-02-07 16:34:49'),
(486, 115, 486, 4, 3600, 0, 5200.000000, '{\"87\":\"4\"}', '2018-02-07 16:36:47', '2018-02-07 16:36:47'),
(487, 116, 487, 1, 900, 0, 1300.000000, '{\"87\":\"1\"}', '2018-02-07 16:39:18', '2018-02-07 16:39:18'),
(488, 116, 488, 5, 5500, 0, 7000.000000, '{\"74\":\"5\"}', '2018-02-07 16:39:18', '2018-02-07 16:39:18'),
(489, 117, 489, 3, 2700, 0, 3900.000000, '{\"87\":\"3\"}', '2018-02-07 16:41:46', '2018-02-07 16:41:46'),
(490, 117, 490, 3, 1200, 0, 2400.000000, '{\"65\":\"3\"}', '2018-02-07 16:41:46', '2018-02-07 16:41:46'),
(491, 118, 491, 3, 3075, 0, 3750.000000, '{\"38\":\"3\"}', '2018-02-07 16:49:25', '2018-02-07 16:49:25'),
(492, 118, 492, 4, 4400, 0, 5000.000000, '{\"74\":\"4\"}', '2018-02-07 16:49:25', '2018-02-07 16:49:25'),
(493, 118, 493, 13, 11700, 0, 14950.000000, '{\"87\":\"13\"}', '2018-02-07 16:49:25', '2018-02-07 16:49:25'),
(494, 118, 494, 10, 1600, 0, 1100.000000, '{\"219\":\"10\"}', '2018-02-07 16:49:25', '2018-02-07 16:49:25'),
(495, 119, 495, 4, 4400, 0, 5600.000000, '{\"74\":\"4\"}', '2018-02-07 16:51:49', '2018-02-07 16:51:49'),
(496, 119, 496, 18, 16200, 0, 23400.000000, '{\"87\":\"18\"}', '2018-02-07 16:51:49', '2018-02-07 16:51:49'),
(497, 120, 497, 7, 2800, 0, 5600.000000, '{\"65\":\"7\"}', '2018-02-07 16:54:25', '2018-02-07 16:54:25'),
(498, 120, 498, 8, 8800, 0, 11200.000000, '{\"74\":\"8\"}', '2018-02-07 16:54:25', '2018-02-07 16:54:25'),
(499, 120, 499, 4, 3600, 0, 5200.000000, '{\"87\":\"4\"}', '2018-02-07 16:54:25', '2018-02-07 16:54:25');
INSERT INTO `inventory_sales_challan_item` (`id`, `fk_sales_challan_id`, `fk_sales_item_id`, `qty`, `cost_amount`, `small_qty`, `payable_amount`, `inventory_item_id`, `created_at`, `updated_at`) VALUES
(500, 121, 500, 10, 11000, 0, 14000.000000, '{\"74\":\"10\"}', '2018-02-07 16:56:47', '2018-02-07 16:56:47'),
(501, 121, 501, 2, 1800, 0, 2600.000000, '{\"87\":\"2\"}', '2018-02-07 16:56:47', '2018-02-07 16:56:47'),
(502, 122, 502, 13, 11700, 0, 16900.000000, '{\"87\":\"13\"}', '2018-02-07 17:00:31', '2018-02-07 17:00:31'),
(503, 123, 503, 8, 2400, 0, 2400.000000, '{\"114\":\"8\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(504, 123, 504, 17, 6800, 0, 6800.000000, '{\"65\":\"17\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(505, 123, 505, 1, 1100, 0, 1100.000000, '{\"233\":\"1\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(506, 123, 506, 46, 18860, 0, 19780.000000, '{\"222\":\"46\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(507, 123, 507, 1, 250, 0, 250.000000, '{\"111\":\"1\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(508, 123, 508, 25, 4000, 0, 3625.000000, '{\"219\":\"25\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(509, 123, 509, 1, 1800, 0, 1800.000000, '{\"70\":\"1\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(510, 123, 510, 5, 5500, 0, 5250.000000, '{\"233\":\"5\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(511, 123, 511, 146, 131400, 0, 146000.000000, '{\"87\":\"146\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(512, 123, 512, 21, 23100, 0, 23100.000000, '{\"74\":\"21\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(513, 123, 513, 16, 14400, 0, 17600.000000, '{\"87\":\"16\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(514, 123, 514, 119, 10234, 0, 6426.000000, '{\"208\":\"119\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(515, 123, 515, 2, 1500, 0, 2000.000000, '{\"213\":\"2\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(516, 123, 516, 196, 44296, 0, 35084.000000, '{\"220\":\"196\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(517, 123, 517, 83, 26062, 0, 22493.000000, '{\"221\":\"83\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(518, 123, 518, 33, 5850, 0, 7788.000000, '{\"108\":\"1\",\"112\":32}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(519, 123, 519, 24, 13200, 0, 13200.000000, '{\"79\":\"24\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(520, 123, 520, 342, 102600, 0, 102600.000000, '{\"80\":\"342\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(521, 123, 521, 155, 24800, 0, 16120.000000, '{\"219\":\"155\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(522, 123, 522, 5, 2250, 0, 2250.000000, '{\"82\":\"5\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(523, 123, 523, 18, 9900, 0, 4500.000000, '{\"206\":\"18\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(524, 123, 524, 40, 12000, 0, 12000.000000, '{\"98\":\"40\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(525, 123, 525, 24, 6000, 0, 6000.000000, '{\"103\":\"24\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(526, 123, 526, 13, 2938, 0, 2275.000000, '{\"220\":\"13\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(527, 123, 527, 108, 23220, 0, 24840.000000, '{\"232\":\"108\"}', '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(528, 124, 528, 2, 2400, 0, 1960.000000, '{\"64\":\"2\"}', '2018-02-09 10:50:51', '2018-02-09 10:50:51'),
(529, 124, 529, 5, 3500, 0, 3900.000000, '{\"48\":\"5\"}', '2018-02-09 10:50:51', '2018-02-09 10:50:51'),
(530, 124, 530, 1, 2700, 0, 2900.000000, '{\"54\":\"1\"}', '2018-02-09 10:50:51', '2018-02-09 10:50:51'),
(531, 125, 531, 6, 4220, 0, 4680.000000, '{\"48\":\"5\",\"51\":1}', '2018-02-09 11:05:36', '2018-02-09 11:50:57'),
(532, 125, 532, 5, 4500, 0, 7000.000000, '{\"87\":\"5\"}', '2018-02-09 11:05:36', '2018-02-09 11:50:57'),
(533, 125, 533, 2, 5400, 0, 5800.000000, '{\"54\":\"2\"}', '2018-02-09 11:05:36', '2018-02-09 11:50:57'),
(534, 126, 534, 7, 21000, 0, 23800.000000, '{\"130\":\"7\"}', '2018-02-09 11:15:20', '2018-02-09 11:15:20'),
(535, 126, 535, 1, 600, 0, 850.000000, '{\"84\":\"1\"}', '2018-02-09 11:15:20', '2018-02-09 11:15:20'),
(536, 126, 536, 2, 2200, 0, 3400.000000, '{\"133\":\"2\"}', '2018-02-09 11:15:20', '2018-02-09 11:15:20'),
(537, 126, 537, 1, 1600, 0, 1800.000000, '{\"62\":\"1\"}', '2018-02-09 11:15:20', '2018-02-09 11:15:20'),
(538, 126, 538, 7, 7700, 0, 9100.000000, '{\"133\":\"7\"}', '2018-02-09 11:15:20', '2018-02-09 11:15:20'),
(539, 127, 539, 1, 3200, 0, 3600.000000, '{\"128\":\"1\"}', '2018-02-09 11:31:46', '2018-02-09 11:31:46'),
(540, 127, 540, 1, 2500, 0, 3600.000000, '{\"167\":\"1\"}', '2018-02-09 11:31:46', '2018-02-09 11:31:46'),
(541, 127, 541, 1, 1100, 0, 3650.000000, '{\"133\":\"1\"}', '2018-02-09 11:31:46', '2018-02-09 11:31:46'),
(542, 127, 542, 2, 2200, 0, 4000.000000, '{\"133\":\"2\"}', '2018-02-09 11:31:46', '2018-02-09 11:31:46'),
(543, 127, 543, 1, 1100, 0, 1300.000000, '{\"133\":\"1\"}', '2018-02-09 11:31:46', '2018-02-09 11:31:46'),
(544, 127, 544, 1, 250, 0, 400.000000, '{\"111\":\"1\"}', '2018-02-09 11:31:46', '2018-02-09 11:31:46'),
(545, 128, 545, 2, 2200, 0, 2600.000000, '{\"133\":\"2\"}', '2018-02-09 11:33:44', '2018-02-09 11:33:44'),
(546, 129, 546, 7, 5040, 0, 5600.000000, '{\"51\":\"7\"}', '2018-02-09 11:38:31', '2018-02-09 11:38:31'),
(547, 130, 547, 2, 1800, 0, 2800.000000, '{\"87\":\"2\"}', '2018-02-09 11:41:52', '2018-02-09 11:41:52'),
(548, 130, 548, 2, 1200, 0, 1700.000000, '{\"84\":\"2\"}', '2018-02-09 11:41:52', '2018-02-09 11:41:52'),
(549, 131, 549, 3, 3150, 0, 4500.000000, '{\"194\":\"3\"}', '2018-02-09 11:55:29', '2018-02-09 11:55:29'),
(550, 131, 550, 6, 6300, 0, 7800.000000, '{\"194\":\"6\"}', '2018-02-09 11:55:29', '2018-02-09 11:55:29'),
(551, 132, 551, 23, 2990, 0, 1840.000000, '{\"215\":\"23\"}', '2018-02-09 11:56:58', '2018-02-09 11:56:58'),
(552, 133, 552, 6, 5400, 0, 8400.000000, '{\"87\":\"6\"}', '2018-02-09 12:08:25', '2018-02-09 12:08:25'),
(553, 133, 553, 7, 6300, 0, 9100.000000, '{\"87\":\"7\"}', '2018-02-09 12:08:25', '2018-02-09 12:08:25'),
(554, 133, 554, 4, 4400, 0, 5200.000000, '{\"233\":\"4\"}', '2018-02-09 12:08:25', '2018-02-09 12:08:25'),
(555, 133, 555, 4, 4400, 0, 7500.000000, '{\"233\":\"4\"}', '2018-02-09 12:08:25', '2018-02-09 12:08:25'),
(556, 133, 556, 4, 2200, 0, 2800.000000, '{\"107\":\"4\"}', '2018-02-09 12:08:25', '2018-02-09 12:08:25'),
(557, 134, 557, 20, 9000, 0, 14000.000000, '{\"82\":\"20\"}', '2018-02-09 12:11:57', '2018-02-09 12:11:57'),
(558, 134, 558, 10, 10000, 0, 12000.000000, '{\"83\":\"10\"}', '2018-02-09 12:11:57', '2018-02-09 12:11:57'),
(559, 134, 559, 8, 4800, 0, 6400.000000, '{\"84\":\"8\"}', '2018-02-09 12:11:57', '2018-02-09 12:11:57'),
(560, 134, 560, 3, 1800, 0, 2100.000000, '{\"84\":\"3\"}', '2018-02-09 12:11:57', '2018-02-09 12:11:57'),
(561, 135, 561, 1, 900, 0, 1300.000000, '{\"87\":\"1\"}', '2018-02-09 12:58:37', '2018-02-09 12:58:37'),
(562, 135, 562, 2, 500, 0, 700.000000, '{\"111\":\"2\"}', '2018-02-09 12:58:37', '2018-02-09 12:58:37'),
(563, 135, 563, 1, 160, 0, 200.000000, '{\"219\":\"1\"}', '2018-02-09 12:58:37', '2018-02-09 12:58:37'),
(564, 135, 564, 1, 400, 0, 800.000000, '{\"65\":\"1\"}', '2018-02-09 12:58:37', '2018-02-09 12:58:37'),
(565, 135, 565, 2, 1800, 0, 2900.000000, '{\"87\":\"2\"}', '2018-02-09 12:58:37', '2018-02-09 12:58:37'),
(566, 136, 566, 14, 2240, 0, 1680.000000, '{\"219\":\"14\"}', '2018-02-09 13:01:34', '2018-02-09 13:01:34'),
(567, 136, 567, 1, 160, 0, 200.000000, '{\"219\":\"1\"}', '2018-02-09 13:01:34', '2018-02-09 13:01:34'),
(568, 136, 568, 1, 900, 0, 1300.000000, '{\"87\":\"1\"}', '2018-02-09 13:01:34', '2018-02-09 13:01:34'),
(569, 137, 569, 5, 4500, 0, 7000.000000, '{\"87\":\"5\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(570, 137, 570, 21, 3360, 0, 2520.000000, '{\"219\":\"21\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(571, 137, 571, 25, 5650, 0, 5500.000000, '{\"220\":\"25\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(572, 137, 572, 2, 628, 0, 700.000000, '{\"221\":\"2\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(573, 137, 573, 1, 900, 0, 1300.000000, '{\"87\":\"1\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(574, 137, 574, 6, 7200, 0, 7800.000000, '{\"64\":\"6\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(575, 137, 575, 1, 550, 0, 750.000000, '{\"107\":\"1\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(576, 137, 576, 6, 20898, 0, 10200.000000, '{\"120\":\"6\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(577, 137, 577, 14, 23100, 0, 23800.000000, '{\"119\":\"14\"}', '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(578, 138, 578, 4, 640, 0, 480.000000, '{\"219\":\"4\"}', '2018-02-09 13:38:04', '2018-02-09 13:38:04'),
(579, 138, 579, 1, 226, 0, 270.000000, '{\"220\":\"1\"}', '2018-02-09 13:38:04', '2018-02-09 13:38:04'),
(580, 139, 580, 5, 5250, 0, 5750.000000, '{\"194\":\"5\"}', '2018-02-09 13:42:18', '2018-02-09 13:42:18'),
(581, 139, 581, 1, 1200, 0, 1600.000000, '{\"106\":\"1\"}', '2018-02-09 13:42:18', '2018-02-09 13:42:18'),
(582, 140, 582, 30, 4800, 0, 3600.000000, '{\"219\":\"30\"}', '2018-02-09 13:44:20', '2018-02-09 13:44:20'),
(583, 141, 583, 7, 2198, 0, 2450.000000, '{\"221\":\"7\"}', '2018-02-09 14:08:24', '2018-02-09 14:08:24'),
(584, 141, 584, 3, 480, 0, 510.000000, '{\"219\":\"3\"}', '2018-02-09 14:08:24', '2018-02-09 14:08:24'),
(585, 141, 585, 1, 160, 0, 120.000000, '{\"219\":\"1\"}', '2018-02-09 14:08:24', '2018-02-09 14:08:24'),
(586, 142, 586, 5, 1570, 0, 1750.000000, '{\"221\":\"5\"}', '2018-02-09 14:10:30', '2018-02-09 14:10:30'),
(587, 142, 587, 1, 160, 0, 120.000000, '{\"219\":\"1\"}', '2018-02-09 14:10:30', '2018-02-09 14:10:30'),
(588, 143, 588, 5, 4500, 0, 7000.000000, '{\"87\":\"5\"}', '2018-02-09 14:16:40', '2018-02-09 14:16:40'),
(589, 143, 589, 1, 900, 0, 1300.000000, '{\"87\":\"1\"}', '2018-02-09 14:16:40', '2018-02-09 14:16:40'),
(590, 143, 590, 8, 1808, 0, 1760.000000, '{\"220\":\"8\"}', '2018-02-09 14:16:40', '2018-02-09 14:16:40'),
(591, 143, 591, 3, 3300, 0, 4350.000000, '{\"133\":\"3\"}', '2018-02-09 14:16:40', '2018-02-09 14:16:40'),
(592, 143, 592, 5, 5250, 0, 5750.000000, '{\"194\":\"5\"}', '2018-02-09 14:16:40', '2018-02-09 14:16:40'),
(593, 143, 593, 2, 820, 0, 900.000000, '{\"222\":\"2\"}', '2018-02-09 14:16:40', '2018-02-09 14:16:40'),
(594, 143, 594, 13, 2275, 0, 4550.000000, '{\"112\":\"13\"}', '2018-02-09 14:16:40', '2018-02-09 14:16:40'),
(595, 144, 595, 6, 2400, 0, 4200.000000, '{\"65\":\"6\"}', '2018-02-09 14:24:09', '2018-02-09 14:24:09'),
(596, 144, 596, 8, 8000, 0, 10960.000000, '{\"72\":\"8\"}', '2018-02-09 14:24:09', '2018-02-09 14:24:09'),
(597, 144, 597, 4, 1800, 0, 2800.000000, '{\"82\":\"4\"}', '2018-02-09 14:24:09', '2018-02-09 14:24:09'),
(598, 144, 598, 2, 1800, 0, 2540.000000, '{\"87\":\"2\"}', '2018-02-09 14:24:09', '2018-02-09 14:24:09'),
(599, 145, 599, 20, 4520, 0, 5000.000000, '{\"220\":\"20\"}', '2018-02-09 14:35:03', '2018-02-09 14:35:03'),
(600, 145, 600, 33, 5280, 0, 3960.000000, '{\"219\":\"33\"}', '2018-02-09 14:35:03', '2018-02-09 14:35:03'),
(601, 146, 601, 3, 2700, 0, 3900.000000, '{\"87\":\"3\"}', '2018-02-09 14:36:52', '2018-02-09 14:36:52'),
(602, 146, 602, 2, 2000, 0, 2800.000000, '{\"72\":\"2\"}', '2018-02-09 14:36:52', '2018-02-09 14:36:52'),
(603, 147, 603, 4, 4000, 0, 7000.000000, '{\"72\":\"4\"}', '2018-02-09 14:43:44', '2018-02-09 14:43:44'),
(604, 147, 604, 8, 7200, 0, 10400.000000, '{\"87\":\"8\"}', '2018-02-09 14:43:44', '2018-02-09 14:43:44'),
(605, 147, 605, 9, 9000, 0, 12600.000000, '{\"72\":\"9\"}', '2018-02-09 14:43:44', '2018-02-09 14:43:44'),
(606, 147, 606, 4, 2720, 0, 3000.000000, '{\"81\":\"3\",\"225\":1}', '2018-02-09 14:43:44', '2018-02-09 14:43:44'),
(607, 147, 607, 2, 900, 0, 1300.000000, '{\"67\":\"2\"}', '2018-02-09 14:43:44', '2018-02-09 14:43:44'),
(608, 148, 608, 7, 3850, 0, 4900.000000, '{\"107\":\"7\"}', '2018-02-09 14:45:41', '2018-02-09 14:45:41'),
(609, 149, 609, 8, 8800, 0, 10400.000000, '{\"233\":\"8\"}', '2018-02-09 14:48:50', '2018-02-09 14:48:50'),
(610, 149, 610, 4, 4000, 0, 5600.000000, '{\"72\":\"4\"}', '2018-02-09 14:48:50', '2018-02-09 14:48:50'),
(611, 149, 611, 15, 13500, 0, 19500.000000, '{\"87\":\"15\"}', '2018-02-09 14:48:50', '2018-02-09 14:48:50'),
(612, 150, 612, 4, 4000, 0, 5000.000000, '{\"72\":\"4\"}', '2018-02-09 14:50:58', '2018-02-09 14:50:58'),
(613, 150, 613, 3, 2700, 0, 3450.000000, '{\"87\":\"3\"}', '2018-02-09 14:50:58', '2018-02-09 14:50:58'),
(614, 151, 614, 5, 5000, 0, 6900.000000, '{\"72\":\"4\",\"86\":1}', '2018-02-09 14:54:14', '2018-02-09 14:54:14'),
(615, 151, 615, 2, 1800, 0, 2600.000000, '{\"87\":\"2\"}', '2018-02-09 14:54:14', '2018-02-09 14:54:14'),
(616, 151, 616, 4, 1600, 0, 2800.000000, '{\"65\":\"4\"}', '2018-02-09 14:54:14', '2018-02-09 14:54:14'),
(617, 152, 617, 6, 3720, 0, 4800.000000, '{\"225\":\"6\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(618, 152, 618, 1, 1300, 0, 1300.000000, '{\"150\":\"1\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(619, 152, 619, 1, 1025, 0, 1000.000000, '{\"38\":\"1\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(620, 152, 620, 5, 4500, 0, 6500.000000, '{\"87\":\"5\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(621, 152, 621, 5, 5000, 0, 7000.000000, '{\"86\":\"5\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(622, 152, 622, 1, 1000, 0, 1200.000000, '{\"77\":\"1\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(623, 152, 623, 17, 2720, 0, 1870.000000, '{\"219\":\"17\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(624, 152, 624, 3, 480, 0, 750.000000, '{\"219\":\"3\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(625, 152, 625, 6, 1200, 0, 1500.000000, '{\"100\":\"6\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(626, 152, 626, 36, 360, 0, 900.000000, '{\"93\":\"36\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(627, 152, 627, 19, 323, 0, 950.000000, '{\"91\":\"19\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(628, 152, 628, 13, 221, 0, 455.000000, '{\"91\":\"13\"}', '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(629, 153, 629, 4, 4000, 0, 5500.000000, '{\"86\":\"4\"}', '2018-02-09 15:07:25', '2018-02-09 15:07:25'),
(630, 153, 630, 2, 2050, 0, 2700.000000, '{\"38\":\"2\"}', '2018-02-09 15:07:25', '2018-02-09 15:07:25'),
(631, 154, 631, 7, 6300, 0, 9100.000000, '{\"87\":\"7\"}', '2018-02-09 15:09:42', '2018-02-09 15:09:42'),
(632, 154, 632, 4, 4800, 0, 5900.000000, '{\"106\":\"4\"}', '2018-02-09 15:09:42', '2018-02-09 15:09:42'),
(633, 155, 633, 5, 1500, 0, 2000.000000, '{\"105\":\"5\"}', '2018-02-09 15:13:17', '2018-02-09 15:13:17'),
(634, 155, 634, 6, 7200, 0, 9000.000000, '{\"106\":\"6\"}', '2018-02-09 15:13:17', '2018-02-09 15:13:17'),
(635, 156, 635, 41, 12874, 0, 14350.000000, '{\"221\":\"41\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(636, 156, 636, 14, 2450, 0, 3500.000000, '{\"112\":\"14\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(637, 156, 637, 17, 6970, 0, 7650.000000, '{\"222\":\"17\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(638, 156, 638, 6, 1500, 0, 2100.000000, '{\"111\":\"6\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(639, 156, 639, 10, 1750, 0, 2500.000000, '{\"99\":\"10\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(640, 156, 640, 21, 4200, 0, 5670.000000, '{\"100\":\"21\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(641, 156, 641, 21, 11950, 0, 16800.000000, '{\"107\":\"13\",\"223\":8}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(642, 156, 642, 5, 1500, 0, 2000.000000, '{\"98\":\"5\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(643, 156, 643, 5, 5000, 0, 7000.000000, '{\"86\":\"5\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(644, 156, 644, 16, 800, 0, 1120.000000, '{\"94\":\"16\"}', '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(645, 157, 645, 3, 3000, 0, 4200.000000, '{\"86\":\"3\"}', '2018-02-09 15:34:39', '2018-02-09 15:34:39'),
(646, 157, 646, 6, 3600, 0, 4800.000000, '{\"223\":\"6\"}', '2018-02-09 15:34:39', '2018-02-09 15:34:39'),
(647, 157, 647, 3, 1800, 0, 2400.000000, '{\"55\":\"3\"}', '2018-02-09 15:34:39', '2018-02-09 15:34:39'),
(648, 157, 648, 3, 3699, 0, 3600.000000, '{\"228\":\"3\"}', '2018-02-09 15:34:39', '2018-02-09 15:34:39'),
(649, 157, 649, 4, 2600, 0, 1600.000000, '{\"82\":\"2\",\"229\":2}', '2018-02-09 15:34:39', '2018-02-09 15:34:39'),
(650, 157, 650, 4, 2480, 0, 3200.000000, '{\"225\":\"4\"}', '2018-02-09 15:34:40', '2018-02-09 15:34:40'),
(651, 157, 651, 8, 2000, 0, 2800.000000, '{\"111\":\"8\"}', '2018-02-09 15:34:40', '2018-02-09 15:34:40'),
(652, 157, 652, 16, 2800, 0, 4000.000000, '{\"99\":\"16\"}', '2018-02-09 15:34:40', '2018-02-09 15:34:40'),
(653, 157, 653, 15, 6150, 0, 6750.000000, '{\"222\":\"15\"}', '2018-02-09 15:34:40', '2018-02-09 15:34:40'),
(654, 157, 654, 10, 4100, 0, 7000.000000, '{\"222\":\"10\"}', '2018-02-09 15:34:40', '2018-02-09 15:34:40'),
(655, 157, 655, 5, 1500, 0, 2000.000000, '{\"98\":\"5\"}', '2018-02-09 15:34:40', '2018-02-09 15:34:40'),
(656, 157, 656, 8, 1400, 0, 2000.000000, '{\"112\":\"8\"}', '2018-02-09 15:34:40', '2018-02-09 15:34:40'),
(657, 157, 657, 1, 200, 0, 270.000000, '{\"100\":\"1\"}', '2018-02-09 15:34:40', '2018-02-09 15:34:40'),
(658, 158, 658, 5, 4500, 0, 6500.000000, '{\"87\":\"5\"}', '2018-02-09 15:39:17', '2018-02-09 15:39:17'),
(659, 158, 659, 1, 1000, 0, 1400.000000, '{\"86\":\"1\"}', '2018-02-09 15:39:17', '2018-02-09 15:39:17'),
(660, 159, 660, 1, 1000, 0, 1500.000000, '{\"86\":\"1\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(661, 159, 661, 31, 7006, 0, 7750.000000, '{\"220\":\"31\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(662, 159, 662, 33, 5280, 0, 3960.000000, '{\"219\":\"33\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(663, 159, 663, 15, 2625, 0, 3750.000000, '{\"99\":\"15\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(664, 159, 664, 20, 3200, 0, 7000.000000, '{\"219\":\"20\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(665, 159, 665, 9, 2826, 0, 3150.000000, '{\"221\":\"9\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(666, 159, 666, 13, 1950, 0, 2210.000000, '{\"101\":\"13\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(667, 159, 667, 20, 1800, 0, 2400.000000, '{\"104\":\"20\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(668, 159, 668, 14, 1260, 0, 1540.000000, '{\"104\":\"14\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(669, 159, 669, 14, 2450, 0, 3500.000000, '{\"112\":\"14\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(670, 159, 670, 22, 4400, 0, 5720.000000, '{\"100\":\"22\"}', '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(671, 160, 671, 55, 11825, 0, 13200.000000, '{\"232\":\"55\"}', '2018-02-09 16:01:25', '2018-02-09 16:01:25'),
(672, 160, 672, 15, 3000, 0, 3750.000000, '{\"100\":\"15\"}', '2018-02-09 16:01:25', '2018-02-09 16:01:25'),
(673, 160, 673, 14, 2450, 0, 3500.000000, '{\"99\":\"14\"}', '2018-02-09 16:01:25', '2018-02-09 16:01:25'),
(674, 160, 674, 23, 5198, 0, 5750.000000, '{\"220\":\"23\"}', '2018-02-09 16:01:25', '2018-02-09 16:01:25'),
(675, 160, 675, 10, 3000, 0, 3800.000000, '{\"98\":\"10\"}', '2018-02-09 16:01:25', '2018-02-09 16:01:25'),
(676, 160, 676, 5, 2050, 0, 3500.000000, '{\"222\":\"5\"}', '2018-02-09 16:01:25', '2018-02-09 16:01:25'),
(677, 161, 677, 11, 6600, 0, 8800.000000, '{\"223\":\"11\"}', '2018-02-09 16:07:02', '2018-02-09 16:07:02'),
(678, 161, 678, 12, 3600, 0, 5400.000000, '{\"105\":\"12\"}', '2018-02-09 16:07:02', '2018-02-09 16:07:02'),
(679, 161, 679, 2, 400, 0, 540.000000, '{\"100\":\"2\"}', '2018-02-09 16:07:02', '2018-02-09 16:07:02'),
(680, 161, 680, 14, 2450, 0, 3500.000000, '{\"112\":\"14\"}', '2018-02-09 16:07:02', '2018-02-09 16:07:02'),
(681, 161, 681, 8, 1400, 0, 2400.000000, '{\"112\":\"8\"}', '2018-02-09 16:07:02', '2018-02-09 16:07:02'),
(682, 161, 682, 1, 1000, 0, 1400.000000, '{\"86\":\"1\"}', '2018-02-09 16:07:02', '2018-02-09 16:07:02'),
(683, 162, 683, 25, 7500, 0, 10750.000000, '{\"105\":\"25\"}', '2018-02-09 16:23:25', '2018-02-09 16:23:25'),
(684, 162, 684, 3, 525, 0, 750.000000, '{\"99\":\"3\"}', '2018-02-09 16:23:25', '2018-02-09 16:23:25'),
(685, 162, 685, 11, 2200, 0, 2970.000000, '{\"100\":\"11\"}', '2018-02-09 16:23:25', '2018-02-09 16:23:25'),
(686, 162, 686, 1, 175, 0, 250.000000, '{\"112\":\"1\"}', '2018-02-09 16:23:25', '2018-02-09 16:23:25'),
(687, 162, 687, 2, 1000, 0, 1200.000000, '{\"153\":\"2\"}', '2018-02-09 16:23:25', '2018-02-09 16:23:25'),
(688, 163, 688, 7, 2870, 0, 3150.000000, '{\"222\":\"7\"}', '2018-02-09 16:26:28', '2018-02-09 16:26:28'),
(689, 163, 689, 3, 525, 0, 750.000000, '{\"112\":\"3\"}', '2018-02-09 16:26:28', '2018-02-09 16:26:28'),
(690, 164, 690, 11, 9900, 0, 14300.000000, '{\"87\":\"11\"}', '2018-02-09 16:41:08', '2018-02-09 16:41:08'),
(691, 164, 691, 4, 4000, 0, 5600.000000, '{\"86\":\"4\"}', '2018-02-09 16:41:08', '2018-02-09 16:41:08'),
(692, 165, 692, 2, 1800, 0, 2600.000000, '{\"87\":\"2\"}', '2018-02-09 16:43:02', '2018-02-09 16:43:02'),
(693, 165, 693, 3, 3000, 0, 4200.000000, '{\"86\":\"3\"}', '2018-02-09 16:43:02', '2018-02-09 16:43:02'),
(694, 166, 694, 7, 7000, 0, 9800.000000, '{\"86\":\"7\"}', '2018-02-09 16:47:49', '2018-02-09 16:47:49'),
(695, 166, 695, 5, 4500, 0, 6200.000000, '{\"87\":\"5\"}', '2018-02-09 16:47:49', '2018-02-09 16:47:49'),
(696, 167, 696, 9, 9000, 0, 12375.000000, '{\"86\":\"9\"}', '2018-02-09 16:50:37', '2018-02-09 16:50:37'),
(697, 167, 697, 6, 5400, 0, 7800.000000, '{\"87\":\"6\"}', '2018-02-09 16:50:37', '2018-02-09 16:50:37'),
(698, 168, 698, 18, 3870, 0, 4860.000000, '{\"232\":\"18\"}', '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(699, 168, 699, 4, 1640, 0, 1720.000000, '{\"222\":\"4\"}', '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(700, 168, 700, 4, 4000, 0, 5600.000000, '{\"86\":\"4\"}', '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(701, 168, 701, 5, 5500, 0, 11100.000000, '{\"133\":\"5\"}', '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(702, 168, 702, 12, 1080, 0, 1560.000000, '{\"104\":\"12\"}', '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(703, 168, 703, 12, 1920, 0, 1560.000000, '{\"219\":\"12\"}', '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(704, 168, 704, 1, 160, 0, 200.000000, '{\"219\":\"1\"}', '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(705, 169, 705, 12, 2100, 0, 3000.000000, '{\"112\":\"12\"}', '2018-02-09 17:03:06', '2018-02-09 17:03:06'),
(706, 169, 706, 6, 1050, 0, 1500.000000, '{\"99\":\"6\"}', '2018-02-09 17:03:06', '2018-02-09 17:03:06'),
(707, 169, 707, 12, 4800, 0, 9600.000000, '{\"65\":\"12\"}', '2018-02-09 17:03:06', '2018-02-09 17:03:06'),
(708, 169, 708, 6, 5400, 0, 7800.000000, '{\"87\":\"6\"}', '2018-02-09 17:03:06', '2018-02-09 17:03:06'),
(709, 169, 709, 7, 7000, 0, 9800.000000, '{\"86\":\"7\"}', '2018-02-09 17:03:06', '2018-02-09 17:03:06'),
(710, 169, 710, 7, 4340, 0, 5600.000000, '{\"225\":\"7\"}', '2018-02-09 17:03:06', '2018-02-09 17:03:06'),
(711, 170, 711, 37, 33300, 0, 48100.000000, '{\"87\":\"37\"}', '2018-02-09 17:12:48', '2018-02-09 17:12:48'),
(712, 170, 712, 5, 4500, 0, 7500.000000, '{\"87\":\"5\"}', '2018-02-09 17:12:48', '2018-02-09 17:12:48'),
(713, 170, 713, 15, 15000, 0, 21000.000000, '{\"86\":\"15\"}', '2018-02-09 17:12:48', '2018-02-09 17:12:48'),
(714, 170, 714, 21, 6594, 0, 7350.000000, '{\"221\":\"21\"}', '2018-02-09 17:12:48', '2018-02-09 17:12:48'),
(715, 170, 715, 41, 8815, 0, 11070.000000, '{\"232\":\"41\"}', '2018-02-09 17:12:48', '2018-02-09 17:12:48'),
(716, 170, 716, 4, 1256, 0, 1600.000000, '{\"221\":\"4\"}', '2018-02-09 17:12:48', '2018-02-09 17:12:48'),
(717, 171, 717, 11, 9900, 0, 14080.000000, '{\"87\":\"11\"}', '2018-02-09 17:17:10', '2018-02-09 17:17:10'),
(718, 171, 718, 4, 4000, 0, 5520.000000, '{\"86\":\"4\"}', '2018-02-09 17:17:10', '2018-02-09 17:17:10'),
(719, 172, 719, 3, 678, 0, 660.000000, '{\"220\":\"3\"}', '2018-02-09 17:22:06', '2018-02-09 17:22:06'),
(720, 172, 720, 9, 1935, 0, 2340.000000, '{\"232\":\"9\"}', '2018-02-09 17:22:06', '2018-02-09 17:22:06'),
(721, 172, 721, 10, 9000, 0, 13000.000000, '{\"87\":\"10\"}', '2018-02-09 17:22:06', '2018-02-09 17:22:06'),
(722, 172, 722, 1, 1250, 0, 1400.000000, '{\"85\":\"1\"}', '2018-02-09 17:22:06', '2018-02-09 17:22:06'),
(723, 173, 723, 7, 1582, 0, 1890.000000, '{\"220\":\"7\"}', '2018-02-10 10:24:30', '2018-02-10 10:24:30'),
(724, 173, 724, 2, 320, 0, 800.000000, '{\"219\":\"2\"}', '2018-02-10 10:24:30', '2018-02-10 10:24:30'),
(725, 173, 725, 3, 480, 0, 390.000000, '{\"219\":\"3\"}', '2018-02-10 10:24:30', '2018-02-10 10:24:30'),
(726, 173, 726, 2, 320, 0, 400.000000, '{\"219\":\"2\"}', '2018-02-10 10:24:30', '2018-02-10 10:24:30'),
(727, 174, 727, 6, 1050, 0, 2100.000000, '{\"112\":\"6\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(728, 174, 728, 2, 628, 0, 700.000000, '{\"221\":\"2\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(729, 174, 729, 4, 1000, 0, 1400.000000, '{\"111\":\"4\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(730, 174, 730, 5, 2050, 0, 2250.000000, '{\"222\":\"5\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(731, 174, 731, 2, 320, 0, 800.000000, '{\"219\":\"2\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(732, 174, 732, 3, 2700, 0, 3900.000000, '{\"87\":\"3\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(733, 174, 733, 7, 630, 0, 910.000000, '{\"104\":\"7\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(734, 174, 734, 8, 1280, 0, 2800.000000, '{\"219\":\"8\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(735, 174, 735, 11, 2486, 0, 2970.000000, '{\"220\":\"11\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(736, 174, 736, 6, 1884, 0, 2100.000000, '{\"221\":\"6\"}', '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(737, 175, 737, 4, 640, 0, 1400.000000, '{\"219\":\"4\"}', '2018-02-10 10:44:26', '2018-02-10 10:44:26'),
(738, 176, 738, 19, 1634, 0, 1900.000000, '{\"208\":\"19\"}', '2018-02-10 10:48:32', '2018-02-10 10:48:32'),
(739, 176, 739, 3, 480, 0, 390.000000, '{\"219\":\"3\"}', '2018-02-10 10:48:32', '2018-02-10 10:48:32'),
(740, 177, 740, 1, 314, 0, 350.000000, '{\"221\":\"1\"}', '2018-02-10 11:15:17', '2018-02-10 11:15:17'),
(741, 177, 741, 5, 430, 0, 500.000000, '{\"208\":\"5\"}', '2018-02-10 11:15:17', '2018-02-10 11:15:17'),
(742, 178, 742, 3, 3750, 0, 4800.000000, '{\"52\":\"3\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(743, 178, 743, 1, 1100, 0, 2000.000000, '{\"233\":\"1\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(744, 178, 744, 6, 960, 0, 780.000000, '{\"219\":\"6\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(745, 178, 745, 1, 86, 0, 130.000000, '{\"208\":\"1\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(746, 178, 746, 1, 86, 0, 100.000000, '{\"208\":\"1\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(747, 178, 747, 8, 7200, 0, 10400.000000, '{\"87\":\"8\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(748, 178, 748, 2, 2000, 0, 3000.000000, '{\"86\":\"2\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(749, 178, 749, 2, 350, 0, 700.000000, '{\"112\":\"2\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(750, 178, 750, 6, 1356, 0, 1320.000000, '{\"220\":\"6\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(751, 178, 751, 1, 1100, 0, 1500.000000, '{\"233\":\"1\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(752, 178, 752, 3, 1230, 0, 1350.000000, '{\"222\":\"3\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(753, 178, 753, 6, 540, 0, 720.000000, '{\"104\":\"6\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(754, 178, 754, 4, 640, 0, 800.000000, '{\"219\":\"4\"}', '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(755, 179, 755, 6, 4320, 0, 4500.000000, '{\"51\":\"6\"}', '2018-02-11 10:48:37', '2018-02-11 10:48:37'),
(756, 179, 756, 4, 4800, 0, 4000.000000, '{\"64\":\"4\"}', '2018-02-11 10:48:37', '2018-02-11 10:48:37'),
(757, 179, 757, 4, 10800, 0, 11600.000000, '{\"54\":\"4\"}', '2018-02-11 10:48:37', '2018-02-11 10:48:37'),
(758, 179, 758, 1, 1200, 0, 1500.000000, '{\"64\":\"1\"}', '2018-02-11 10:48:37', '2018-02-11 10:48:37'),
(759, 179, 759, 3, 3300, 0, 4500.000000, '{\"133\":\"3\"}', '2018-02-11 10:48:37', '2018-02-11 10:48:37'),
(760, 179, 760, 9, 2034, 0, 2250.000000, '{\"220\":\"9\"}', '2018-02-11 10:48:37', '2018-02-11 10:48:37'),
(761, 180, 761, 4, 2880, 0, 3600.000000, '{\"51\":\"4\"}', '2018-02-11 11:06:51', '2018-02-11 11:06:51'),
(762, 180, 762, 10, 10500, 0, 11500.000000, '{\"194\":\"10\"}', '2018-02-11 11:06:51', '2018-02-11 11:06:51'),
(763, 180, 763, 1, 620, 0, 800.000000, '{\"225\":\"1\"}', '2018-02-11 11:06:51', '2018-02-11 11:06:51'),
(764, 180, 764, 1, 1954, 0, 2800.000000, '{\"132\":\"1\"}', '2018-02-11 11:06:51', '2018-02-11 11:06:51'),
(765, 181, 765, 123, 19680, 0, 28413.000000, '{\"219\":\"123\"}', '2018-02-11 11:49:54', '2018-02-11 11:49:54'),
(766, 181, 766, 43, 9718, 0, 13158.000000, '{\"220\":\"43\"}', '2018-02-11 11:49:54', '2018-02-11 11:49:54'),
(767, 181, 767, 80, 32800, 0, 52000.000000, '{\"222\":\"80\"}', '2018-02-11 11:49:54', '2018-02-11 11:49:54'),
(768, 181, 768, 34, 40800, 0, 41650.000000, '{\"64\":\"34\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(769, 181, 769, 7, 5880, 0, 5901.000000, '{\"209\":\"7\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(770, 181, 770, 48, 15072, 0, 24240.000000, '{\"221\":\"48\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(771, 181, 771, 53, 4558, 0, 6625.000000, '{\"208\":\"53\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(772, 181, 772, 21, 12600, 0, 17808.000000, '{\"84\":\"21\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(773, 181, 773, 7, 4340, 0, 6307.000000, '{\"225\":\"7\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(774, 181, 774, 66, 1650, 0, 2442.000000, '{\"90\":\"66\",\"207\":0}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(775, 181, 775, 2, 7200, 0, 4100.000000, '{\"175\":\"2\",\"204\":0}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(776, 181, 776, 15, 13500, 0, 22245.000000, '{\"87\":\"15\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(777, 181, 777, 16, 16000, 0, 28000.000000, '{\"86\":\"16\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(778, 181, 778, 11, 7904, 0, 9196.000000, '{\"51\":\"9\",\"211\":2}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(779, 181, 779, 1, 1600, 0, 1300.000000, '{\"62\":\"1\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(780, 181, 780, 4, 3000, 0, 3600.000000, '{\"213\":\"4\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(781, 181, 781, 1, 1100, 0, 2900.000000, '{\"133\":\"1\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(782, 181, 782, 1, 2700, 0, 2500.000000, '{\"54\":\"1\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(783, 181, 783, 3, 1650, 0, 1449.000000, '{\"206\":\"3\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(784, 181, 784, 1, 175, 0, 400.000000, '{\"112\":\"1\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(785, 181, 785, 2, 634, 0, 1100.000000, '{\"216\":\"2\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(786, 181, 786, 2, 2500, 0, 3400.000000, '{\"85\":\"2\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(787, 181, 787, 4, 5400, 0, 5400.000000, '{\"45\":\"3\",\"46\":1}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(788, 181, 788, 4, 448, 0, 700.000000, '{\"207\":\"4\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(789, 181, 789, 2, 1700, 0, 2160.000000, '{\"229\":\"2\"}', '2018-02-11 11:49:55', '2018-02-11 11:49:55'),
(790, 182, 790, 98, 22148, 0, 30184.000000, '{\"220\":\"98\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(791, 182, 791, 51, 20910, 0, 34935.000000, '{\"222\":\"51\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(792, 182, 792, 197, 31520, 0, 47280.000000, '{\"219\":\"197\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(793, 182, 793, 62, 19468, 0, 30380.000000, '{\"221\":\"62\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(794, 182, 794, 91, 7826, 0, 9555.000000, '{\"208\":\"91\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(795, 182, 795, 18, 11160, 0, 16398.000000, '{\"225\":\"18\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(796, 182, 796, 36, 21600, 0, 32508.000000, '{\"84\":\"36\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(797, 182, 797, 38, 42960, 0, 40280.000000, '{\"64\":\"22\",\"212\":16}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(798, 182, 798, 19, 19000, 0, 29564.000000, '{\"86\":\"19\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(799, 182, 799, 42, 43050, 0, 56952.000000, '{\"38\":\"42\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(800, 182, 800, 6, 1902, 0, 2898.000000, '{\"216\":\"6\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(801, 182, 801, 6, 7500, 0, 10200.000000, '{\"85\":\"6\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(802, 182, 802, 4, 4800, 0, 7100.000000, '{\"46\":\"4\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(803, 182, 803, 28, 3136, 0, 1456.000000, '{\"207\":\"28\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(804, 182, 804, 1, 1050, 0, 1800.000000, '{\"194\":\"1\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(805, 182, 805, 14, 37800, 0, 40950.000000, '{\"54\":\"14\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(806, 182, 806, 24, 17088, 0, 19896.000000, '{\"211\":\"24\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(807, 182, 807, 3, 690, 0, 1200.000000, '{\"226\":\"3\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(808, 182, 808, 14, 9310, 0, 13790.000000, '{\"40\":\"14\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(809, 182, 809, 2, 1100, 0, 1400.000000, '{\"206\":\"2\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(810, 182, 810, 2, 1700, 0, 2500.000000, '{\"229\":\"2\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(811, 182, 811, 2, 1000, 0, 1900.000000, '{\"69\":\"2\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(812, 182, 812, 5, 5500, 0, 7000.000000, '{\"133\":\"5\"}', '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(813, 183, 813, 24, 21600, 0, 35760.000000, '{\"87\":\"24\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(814, 183, 814, 5, 4500, 0, 8700.000000, '{\"87\":\"5\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(815, 183, 815, 59, 13334, 0, 17877.000000, '{\"220\":\"59\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(816, 183, 816, 87, 13920, 0, 19227.000000, '{\"219\":\"87\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(817, 183, 817, 21, 8610, 0, 13545.000000, '{\"222\":\"21\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(818, 183, 818, 31, 9734, 0, 13609.000000, '{\"221\":\"31\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(819, 183, 819, 39, 3354, 0, 4329.000000, '{\"208\":\"39\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(820, 183, 820, 10, 12500, 0, 18100.000000, '{\"85\":\"10\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(821, 183, 821, 7, 7245, 0, 9002.000000, '{\"212\":\"7\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(822, 183, 822, 1, 400, 0, 900.000000, '{\"65\":\"1\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(823, 183, 823, 18, 2016, 0, 1836.000000, '{\"207\":\"18\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(824, 183, 824, 2, 2466, 0, 2450.000000, '{\"228\":\"2\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(825, 183, 825, 4, 2200, 0, 1800.000000, '{\"206\":\"4\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(826, 183, 826, 4, 1268, 0, 2100.000000, '{\"216\":\"4\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(827, 183, 827, 4, 2400, 0, 3800.000000, '{\"84\":\"4\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(828, 183, 828, 1, 3483, 0, 2550.000000, '{\"120\":\"1\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(829, 183, 829, 1, 1300, 0, 1600.000000, '{\"150\":\"1\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(830, 183, 830, 2, 2450, 0, 3900.000000, '{\"46\":\"1\",\"47\":1}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(831, 183, 831, 3, 690, 0, 999.000000, '{\"226\":\"3\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(832, 183, 832, 4, 4200, 0, 4800.000000, '{\"194\":\"4\"}', '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(833, 184, 833, 5, 3000, 0, 4400.000000, '{\"84\":\"5\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(834, 184, 834, 2, 2000, 0, 2700.000000, '{\"83\":\"2\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(835, 184, 835, 32, 2752, 0, 3392.000000, '{\"208\":\"32\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(836, 184, 836, 20, 6280, 0, 9200.000000, '{\"221\":\"20\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(837, 184, 837, 108, 17280, 0, 26568.000000, '{\"219\":\"108\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(838, 184, 838, 41, 16810, 0, 24231.000000, '{\"222\":\"41\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(839, 184, 839, 22, 4972, 0, 8448.000000, '{\"220\":\"22\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(840, 184, 840, 22, 35200, 0, 39710.000000, '{\"62\":\"22\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(841, 184, 841, 4, 10800, 0, 11800.000000, '{\"54\":\"4\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(842, 184, 842, 15, 15525, 0, 21795.000000, '{\"212\":\"15\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(843, 184, 843, 1, 900, 0, 1400.000000, '{\"87\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(844, 184, 844, 10, 3170, 0, 5200.000000, '{\"216\":\"10\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(845, 184, 845, 9, 2700, 0, 3780.000000, '{\"114\":\"9\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(846, 184, 846, 9, 9900, 0, 13950.000000, '{\"133\":\"9\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(847, 184, 847, 7, 8500, 0, 10696.000000, '{\"47\":\"2\",\"59\":5}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(848, 184, 848, 4, 5000, 0, 7500.000000, '{\"85\":\"4\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(849, 184, 849, 5, 560, 0, 800.000000, '{\"207\":\"5\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(850, 184, 850, 1, 2500, 0, 3600.000000, '{\"167\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(851, 184, 851, 1, 3000, 0, 3400.000000, '{\"130\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(852, 184, 852, 1, 3037, 0, 3800.000000, '{\"126\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(853, 184, 853, 2, 5400, 0, 5800.000000, '{\"162\":\"2\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(854, 184, 854, 3, 4500, 0, 5700.000000, '{\"137\":\"3\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(855, 184, 855, 8, 8800, 0, 13296.000000, '{\"133\":\"8\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(856, 184, 856, 3, 9300, 0, 9900.000000, '{\"125\":\"3\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(857, 184, 857, 1, 712, 0, 900.000000, '{\"211\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(858, 184, 858, 8, 7200, 0, 9360.000000, '{\"87\":\"8\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(859, 184, 859, 3, 4440, 0, 5799.000000, '{\"121\":\"3\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(860, 184, 860, 2, 2000, 0, 3000.000000, '{\"77\":\"2\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(861, 184, 861, 1, 2700, 0, 2900.000000, '{\"124\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(862, 184, 862, 12, 12600, 0, 14592.000000, '{\"194\":\"12\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(863, 184, 863, 1, 550, 0, 300.000000, '{\"206\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(864, 184, 864, 1, 230, 0, 300.000000, '{\"226\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(865, 184, 865, 1, 1233, 0, 1300.000000, '{\"228\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(866, 184, 866, 1, 712, 0, 1500.000000, '{\"205\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(867, 184, 867, 1, 17, 0, 150.000000, '{\"91\":\"1\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(868, 184, 868, 2, 1680, 0, 1900.000000, '{\"209\":\"2\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(869, 184, 869, 3, 5862, 0, 7899.000000, '{\"132\":\"3\"}', '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(870, 185, 870, 27, 8478, 0, 11799.000000, '{\"221\":\"27\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(871, 185, 871, 5, 5500, 0, 6600.000000, '{\"133\":\"5\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(872, 185, 872, 12, 12600, 0, 12756.000000, '{\"194\":\"12\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(873, 185, 873, 29, 11890, 0, 15341.000000, '{\"222\":\"29\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(874, 185, 874, 18, 17520, 0, 28296.000000, '{\"87\":\"12\",\"227\":6}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(875, 185, 875, 59, 5074, 0, 6313.000000, '{\"208\":\"59\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(876, 185, 876, 132, 21120, 0, 26532.000000, '{\"219\":\"132\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(877, 185, 877, 5, 1500, 0, 1900.000000, '{\"114\":\"5\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(878, 185, 878, 16, 9600, 0, 14400.000000, '{\"84\":\"16\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(879, 185, 879, 21, 3675, 0, 6174.000000, '{\"99\":\"21\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(880, 185, 880, 3, 3000, 0, 4299.000000, '{\"77\":\"3\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(881, 185, 881, 42, 714, 0, 3360.000000, '{\"91\":\"42\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(882, 185, 882, 3, 30, 0, 150.000000, '{\"93\":\"3\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(883, 185, 883, 21, 2352, 0, 945.000000, '{\"207\":\"21\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(884, 185, 884, 2, 634, 0, 1400.000000, '{\"216\":\"2\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(885, 185, 885, 3, 3105, 0, 4149.000000, '{\"212\":\"3\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(886, 185, 886, 5, 6165, 0, 4400.000000, '{\"228\":\"5\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(887, 185, 887, 4, 6400, 0, 7252.000000, '{\"62\":\"4\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(888, 185, 888, 3, 8100, 0, 8400.000000, '{\"54\":\"3\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(889, 185, 889, 1, 1500, 0, 1700.000000, '{\"137\":\"1\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(890, 185, 890, 1, 620, 0, 900.000000, '{\"225\":\"1\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(891, 185, 891, 10, 5500, 0, 3600.000000, '{\"206\":\"10\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(892, 185, 892, 2, 3908, 0, 4200.000000, '{\"132\":\"2\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(893, 185, 893, 1, 1100, 0, 1800.000000, '{\"233\":\"1\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(894, 185, 894, 2, 1200, 0, 1400.000000, '{\"223\":\"2\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(895, 185, 895, 1, 1000, 0, 1300.000000, '{\"83\":\"1\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(896, 185, 896, 2, 2500, 0, 3000.000000, '{\"231\":\"2\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(897, 185, 897, 1, 1200, 0, 2000.000000, '{\"59\":\"1\"}', '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(898, 186, 898, 7, 2100, 0, 3248.000000, '{\"98\":\"7\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(899, 186, 899, 6, 7200, 0, 10200.000000, '{\"106\":\"6\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(900, 186, 900, 7, 4200, 0, 6503.000000, '{\"223\":\"7\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(901, 186, 901, 23, 25760, 0, 35995.000000, '{\"227\":\"23\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(902, 186, 902, 60, 24600, 0, 32220.000000, '{\"222\":\"60\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(903, 186, 903, 136, 21760, 0, 29512.000000, '{\"219\":\"136\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(904, 186, 904, 33, 10362, 0, 14553.000000, '{\"221\":\"33\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(905, 186, 905, 4, 2480, 0, 3848.000000, '{\"225\":\"4\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(906, 186, 906, 62, 10850, 0, 17608.000000, '{\"99\":\"62\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(907, 186, 907, 9, 11250, 0, 14256.000000, '{\"85\":\"9\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(908, 186, 908, 3, 3750, 0, 4752.000000, '{\"231\":\"3\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(909, 186, 909, 59, 5074, 0, 7552.000000, '{\"208\":\"59\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(910, 186, 910, 20, 12000, 0, 17600.000000, '{\"84\":\"20\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(911, 186, 911, 5, 1585, 0, 3000.000000, '{\"216\":\"5\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(912, 186, 912, 3, 51, 0, 201.000000, '{\"91\":\"3\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(913, 186, 913, 2, 2000, 0, 2800.000000, '{\"77\":\"2\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(914, 186, 914, 2, 3000, 0, 3700.000000, '{\"137\":\"2\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(915, 186, 915, 7, 784, 0, 511.000000, '{\"207\":\"7\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(916, 186, 916, 9, 9315, 0, 11403.000000, '{\"212\":\"9\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(917, 186, 917, 14, 7700, 0, 4256.000000, '{\"206\":\"14\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(918, 186, 918, 6, 7398, 0, 4398.000000, '{\"228\":\"6\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(919, 186, 919, 7, 7000, 0, 9702.000000, '{\"83\":\"7\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(920, 186, 920, 2, 2466, 0, 2600.000000, '{\"228\":\"2\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(921, 186, 921, 4, 2000, 0, 3400.000000, '{\"69\":\"4\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(922, 186, 922, 11, 12100, 0, 20603.000000, '{\"133\":\"11\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(923, 186, 923, 1, 1050, 0, 1200.000000, '{\"194\":\"1\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(924, 186, 924, 5, 8000, 0, 9000.000000, '{\"62\":\"5\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(925, 186, 925, 2, 2960, 0, 3700.000000, '{\"121\":\"2\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(926, 186, 926, 2, 1424, 0, 2700.000000, '{\"205\":\"2\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(927, 186, 927, 1, 400, 0, 800.000000, '{\"65\":\"1\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(928, 186, 928, 11, 3300, 0, 3751.000000, '{\"114\":\"11\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(929, 186, 929, 3, 9111, 0, 9699.000000, '{\"126\":\"3\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(930, 186, 930, 20, 6044, 0, 11300.000000, '{\"105\":\"18\",\"224\":2}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(931, 186, 931, 28, 5600, 0, 9996.000000, '{\"100\":\"28\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(932, 186, 932, 17, 2975, 0, 5746.000000, '{\"99\":\"17\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(933, 186, 933, 10, 900, 0, 1960.000000, '{\"104\":\"10\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(934, 186, 934, 7, 1750, 0, 2800.000000, '{\"103\":\"7\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(935, 186, 935, 1, 1100, 0, 1500.000000, '{\"233\":\"1\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(936, 186, 936, 1, 2700, 0, 3000.000000, '{\"54\":\"1\"}', '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(937, 187, 937, 2, 5400, 0, 5700.000000, '{\"54\":\"2\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(938, 187, 938, 13, 1118, 0, 1300.000000, '{\"208\":\"13\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(939, 187, 939, 17, 6970, 0, 9656.000000, '{\"222\":\"17\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(940, 187, 940, 24, 3840, 0, 4776.000000, '{\"219\":\"24\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(941, 187, 941, 9, 810, 0, 1773.000000, '{\"104\":\"9\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(942, 187, 942, 3, 645, 0, 1050.000000, '{\"232\":\"3\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(943, 187, 943, 2, 2500, 0, 3300.000000, '{\"231\":\"2\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(944, 187, 944, 14, 2450, 0, 4200.000000, '{\"99\":\"14\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(945, 187, 945, 2, 400, 0, 680.000000, '{\"100\":\"2\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(946, 187, 946, 2, 500, 0, 800.000000, '{\"103\":\"2\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(947, 187, 947, 1, 2900, 0, 3300.000000, '{\"187\":\"1\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(948, 187, 948, 1, 112, 0, 200.000000, '{\"207\":\"1\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(949, 187, 949, 6, 6720, 0, 8700.000000, '{\"227\":\"6\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(950, 187, 950, 1, 712, 0, 900.000000, '{\"211\":\"1\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(951, 187, 951, 4, 1256, 0, 1748.000000, '{\"221\":\"4\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(952, 187, 952, 1, 300, 0, 400.000000, '{\"114\":\"1\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(953, 187, 953, 5, 1500, 0, 2450.000000, '{\"98\":\"5\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(954, 187, 954, 1, 1150, 0, 1400.000000, '{\"200\":\"1\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(955, 187, 955, 3, 966, 0, 1500.000000, '{\"224\":\"3\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(956, 187, 956, 1, 600, 0, 900.000000, '{\"84\":\"1\"}', '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(957, 188, 957, 93, 14880, 0, 18321.000000, '{\"219\":\"93\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(958, 188, 958, 39, 23400, 0, 30966.000000, '{\"223\":\"39\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(959, 188, 959, 26, 7800, 0, 7956.000000, '{\"114\":\"26\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(960, 188, 960, 41, 16810, 0, 23411.000000, '{\"222\":\"41\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(961, 188, 961, 35, 11270, 0, 19565.000000, '{\"224\":\"35\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(962, 188, 962, 8, 2000, 0, 2632.000000, '{\"103\":\"8\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(963, 188, 963, 9, 10800, 0, 13698.000000, '{\"106\":\"9\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(964, 188, 964, 43, 9718, 0, 12943.000000, '{\"220\":\"43\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(965, 188, 965, 41, 8200, 0, 12833.000000, '{\"100\":\"41\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(966, 188, 966, 18, 3870, 0, 5994.000000, '{\"232\":\"18\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(967, 188, 967, 1, 1200, 0, 1200.000000, '{\"59\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(968, 188, 968, 21, 6594, 0, 9744.000000, '{\"221\":\"21\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(969, 188, 969, 3, 1500, 0, 2301.000000, '{\"153\":\"3\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(970, 188, 970, 22, 24640, 0, 29304.000000, '{\"227\":\"22\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17');
INSERT INTO `inventory_sales_challan_item` (`id`, `fk_sales_challan_id`, `fk_sales_item_id`, `qty`, `cost_amount`, `small_qty`, `payable_amount`, `inventory_item_id`, `created_at`, `updated_at`) VALUES
(971, 188, 971, 1, 840, 0, 600.000000, '{\"209\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(972, 188, 972, 11, 1232, 0, 66.000000, '{\"207\":\"11\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(973, 188, 973, 7, 70, 0, 105.000000, '{\"93\":\"7\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(974, 188, 974, 4, 1200, 0, 2000.000000, '{\"98\":\"4\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(975, 188, 975, 1, 712, 0, 1000.000000, '{\"205\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(976, 188, 976, 1, 550, 0, 800.000000, '{\"206\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(977, 188, 977, 1, 2500, 0, 3000.000000, '{\"158\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(978, 188, 978, 1, 3000, 0, 3000.000000, '{\"130\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(979, 188, 979, 1, 2000, 0, 2500.000000, '{\"182\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(980, 188, 980, 2, 6966, 0, 3200.000000, '{\"120\":\"2\",\"214\":0}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(981, 188, 981, 1, 1000, 0, 1200.000000, '{\"83\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(982, 188, 982, 3, 3300, 0, 4899.000000, '{\"133\":\"3\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(983, 188, 983, 3, 3300, 0, 5001.000000, '{\"233\":\"3\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(984, 188, 984, 1, 17, 0, 50.000000, '{\"91\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(985, 188, 985, 3, 1860, 0, 2649.000000, '{\"225\":\"3\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(986, 188, 986, 1, 3600, 0, 4100.000000, '{\"159\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(987, 188, 987, 1, 1500, 0, 1700.000000, '{\"137\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(988, 188, 988, 1, 1400, 0, 1800.000000, '{\"170\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(989, 188, 989, 4, 1200, 0, 2000.000000, '{\"152\":\"4\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(990, 188, 990, 47, 4042, 0, 5828.000000, '{\"208\":\"47\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(991, 188, 991, 1, 1600, 0, 2000.000000, '{\"62\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(992, 188, 992, 4, 6400, 0, 7100.000000, '{\"62\":\"4\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(993, 188, 993, 5, 5175, 0, 6900.000000, '{\"212\":\"5\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(994, 188, 994, 23, 2070, 0, 4347.000000, '{\"104\":\"23\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(995, 188, 995, 5, 7050, 0, 8800.000000, '{\"52\":\"1\",\"201\":4}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(996, 188, 996, 15, 9256, 0, 13305.000000, '{\"84\":\"11\",\"217\":4}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(997, 188, 997, 2, 634, 0, 1000.000000, '{\"216\":\"2\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(998, 188, 998, 1, 500, 0, 800.000000, '{\"69\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(999, 188, 999, 11, 2486, 0, 3498.000000, '{\"220\":\"11\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(1000, 188, 1000, 1, 665, 0, 750.000000, '{\"40\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(1001, 188, 1001, 1, 1100, 0, 3150.000000, '{\"133\":\"1\"}', '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(1002, 189, 1002, 2, 1000, 0, 1500.000000, '{\"153\":\"2\"}', '2018-02-16 18:12:56', '2018-02-16 18:12:56'),
(1003, 190, 1003, 1, 1100, 0, 1500.000000, '{\"233\":\"1\"}', '2018-02-16 19:05:21', '2018-02-16 19:05:21'),
(1004, 191, 1004, 1, 2500, 0, 3300.000000, '{\"158\":\"1\"}', '2018-02-16 19:43:43', '2018-02-16 19:43:43'),
(1005, 191, 1005, 1, 1600, 0, 1800.000000, '{\"62\":\"1\"}', '2018-02-16 19:43:43', '2018-02-16 19:43:43'),
(1006, 192, 1006, 2, 2100, 0, 2384.364821, '{\"194\":\"2\"}', '2018-02-16 20:10:51', '2018-02-16 20:10:51'),
(1007, 192, 1007, 8, 1808, 0, 2225.407166, '{\"220\":\"8\"}', '2018-02-16 20:10:51', '2018-02-16 20:10:51'),
(1008, 192, 1008, 1, 1120, 0, 1490.228013, '{\"227\":\"1\"}', '2018-02-16 20:10:51', '2018-02-16 20:10:51'),
(1009, 193, 1009, 2, 5400, 0, 6000.000000, '{\"54\":\"2\"}', '2018-02-16 20:17:48', '2018-02-16 20:17:48'),
(1010, 193, 1010, 2, 3200, 0, 3600.000000, '{\"62\":\"2\"}', '2018-02-16 20:17:48', '2018-02-16 20:17:48'),
(1011, 194, 1011, 2, 2400, 0, 4000.000000, '{\"59\":\"2\",\"60\":0}', '2018-02-16 20:24:55', '2018-02-16 20:24:55'),
(1012, 194, 1012, 1, 1450, 0, 1600.000000, '{\"201\":\"1\"}', '2018-02-16 20:24:55', '2018-02-16 20:24:55'),
(1013, 194, 1013, 3, 600, 0, 900.000000, '{\"100\":\"3\"}', '2018-02-16 20:24:55', '2018-02-16 20:24:55'),
(1014, 194, 1014, 1, 226, 0, 270.000000, '{\"220\":\"1\"}', '2018-02-16 20:24:55', '2018-02-16 20:24:55'),
(1015, 194, 1015, 3, 951, 0, 2400.000000, '{\"216\":\"3\"}', '2018-02-16 20:24:55', '2018-02-16 20:24:55'),
(1016, 195, 1016, 1, 160, 0, 200.000000, '{\"219\":\"1\"}', '2018-02-16 20:27:23', '2018-02-16 20:27:23'),
(1017, 196, 1017, 2, 2000, 0, 2000.000000, '{\"196\":\"2\"}', '2018-02-17 21:00:27', '2018-02-17 21:00:27'),
(1018, 196, 1018, 2, 2400, 0, 2400.000000, '{\"197\":\"2\"}', '2018-02-17 21:00:27', '2018-02-17 21:00:27'),
(1019, 196, 1019, 2, 1800, 0, 1800.000000, '{\"198\":\"2\"}', '2018-02-17 21:00:27', '2018-02-17 21:00:27'),
(1020, 196, 1020, 3, 3180, 0, 3180.000000, '{\"199\":\"3\"}', '2018-02-17 21:00:27', '2018-02-17 21:00:27'),
(1021, 196, 1021, 2, 2300, 0, 2300.000000, '{\"200\":\"2\"}', '2018-02-17 21:00:27', '2018-02-17 21:00:27'),
(1022, 197, 1022, 3, 2550, 0, 1350.000000, '{\"229\":\"3\"}', '2018-02-17 21:13:57', '2018-02-17 21:13:57'),
(1023, 197, 1023, 4, 4932, 0, 1800.000000, '{\"228\":\"4\"}', '2018-02-17 21:13:57', '2018-02-17 21:13:57'),
(1024, 197, 1024, 3, 525, 0, 525.000000, '{\"99\":\"3\"}', '2018-02-17 21:13:57', '2018-02-17 21:13:57'),
(1025, 197, 1025, 2, 452, 0, 350.000000, '{\"220\":\"2\"}', '2018-02-17 21:13:57', '2018-02-17 21:13:57'),
(1026, 197, 1026, 8, 3280, 0, 2000.000000, '{\"222\":\"8\"}', '2018-02-17 21:13:57', '2018-02-17 21:13:57'),
(1027, 197, 1027, 11, 3454, 0, 2750.000000, '{\"221\":\"11\"}', '2018-02-17 21:13:57', '2018-02-17 21:13:57'),
(1028, 198, 1028, 12, 34800, 0, 34800.000000, '{\"235\":\"12\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1029, 198, 1029, 8, 15600, 0, 15600.000000, '{\"236\":\"8\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1030, 198, 1030, 6, 18000, 0, 18000.000000, '{\"237\":\"6\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1031, 198, 1031, 5, 12500, 0, 12500.000000, '{\"242\":\"5\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1032, 198, 1032, 12, 25200, 0, 25200.000000, '{\"240\":\"12\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1033, 198, 1033, 9, 20250, 0, 20250.000000, '{\"241\":\"9\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1034, 198, 1034, 12, 36600, 0, 36600.000000, '{\"243\":\"12\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1035, 198, 1035, 6, 15600, 0, 15600.000000, '{\"244\":\"6\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1036, 198, 1036, 5, 13500, 0, 13500.000000, '{\"245\":\"5\"}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1037, 198, 1037, 9, 13560, 0, 13590.000000, '{\"121\":\"1\",\"246\":8}', '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(1038, 199, 1038, 20, 6280, 0, 6907.894737, '{\"221\":\"20\"}', '2018-02-17 22:39:51', '2018-02-17 22:39:51'),
(1039, 199, 1039, 8, 1600, 0, 2131.578947, '{\"100\":\"8\"}', '2018-02-17 22:39:51', '2018-02-17 22:39:51'),
(1040, 199, 1040, 12, 2712, 0, 2960.526316, '{\"220\":\"12\"}', '2018-02-17 22:39:51', '2018-02-17 22:39:51'),
(1041, 200, 1041, 23, 7406, 0, 9690.000000, '{\"224\":\"23\"}', '2018-02-17 22:48:02', '2018-02-17 22:48:02'),
(1042, 201, 1042, 3, 3360, 0, 4200.000000, '{\"227\":\"3\"}', '2018-02-17 22:53:28', '2018-02-17 22:53:28'),
(1043, 201, 1043, 4, 4480, 0, 5200.000000, '{\"227\":\"4\"}', '2018-02-17 22:53:28', '2018-02-17 22:53:28'),
(1044, 202, 1044, 1, 1120, 0, 1300.000000, '{\"227\":\"1\"}', '2018-02-17 22:55:57', '2018-02-17 22:55:57'),
(1045, 202, 1045, 4, 904, 0, 1000.000000, '{\"220\":\"4\"}', '2018-02-17 22:55:57', '2018-02-17 22:55:57'),
(1046, 202, 1046, 1, 160, 0, 120.000000, '{\"219\":\"1\"}', '2018-02-17 22:55:57', '2018-02-17 22:55:57'),
(1047, 203, 1047, 2, 2240, 0, 2562.318841, '{\"227\":\"2\"}', '2018-02-17 22:58:51', '2018-02-17 22:58:51'),
(1048, 203, 1048, 2, 2240, 0, 2759.420290, '{\"227\":\"2\"}', '2018-02-17 22:58:51', '2018-02-17 22:58:51'),
(1049, 203, 1049, 6, 1200, 0, 1478.260870, '{\"100\":\"6\"}', '2018-02-17 22:58:51', '2018-02-17 22:58:51'),
(1050, 204, 1050, 4, 5600, 0, 6800.000000, '{\"170\":\"4\"}', '2018-02-18 21:17:59', '2018-02-18 21:17:59'),
(1051, 204, 1051, 2, 5400, 0, 5800.000000, '{\"54\":\"2\"}', '2018-02-18 21:17:59', '2018-02-18 21:17:59'),
(1052, 205, 1052, 1, 300, 0, 350.000000, '{\"114\":\"1\"}', '2018-02-18 21:19:26', '2018-02-18 21:19:26'),
(1053, 206, 1053, 1, 664, 0, 1000.000000, '{\"217\":\"1\"}', '2018-02-18 21:29:50', '2018-02-18 21:29:50'),
(1054, 206, 1054, 1, 226, 0, 350.000000, '{\"220\":\"1\"}', '2018-02-18 21:29:50', '2018-02-18 21:29:50'),
(1055, 206, 1055, 1, 160, 0, 200.000000, '{\"219\":\"1\"}', '2018-02-18 21:29:50', '2018-02-18 21:29:50'),
(1056, 206, 1056, 1, 712, 0, 1300.000000, '{\"205\":\"1\"}', '2018-02-18 21:29:50', '2018-02-18 21:29:50'),
(1057, 207, 1057, 4, 6400, 0, 7200.000000, '{\"62\":\"4\"}', '2018-02-18 21:32:25', '2018-02-18 21:32:25'),
(1058, 207, 1058, 3, 480, 0, 450.000000, '{\"219\":\"3\"}', '2018-02-18 21:32:25', '2018-02-18 21:32:25'),
(1059, 208, 1059, 5, 5175, 0, 5500.000000, '{\"212\":\"5\"}', '2018-02-18 21:39:58', '2018-02-18 21:39:58'),
(1060, 208, 1060, 2, 5400, 0, 6000.000000, '{\"54\":\"2\"}', '2018-02-18 21:39:58', '2018-02-18 21:39:58'),
(1061, 209, 1061, 3, 8100, 0, 8700.000000, '{\"54\":\"3\"}', '2018-02-18 22:06:32', '2018-02-18 22:12:32'),
(1062, 209, 1062, 2, 2070, 0, 2000.000000, '{\"212\":\"2\"}', '2018-02-18 22:06:32', '2018-02-18 22:12:32'),
(1063, 210, 1063, 2, 800, 0, 2000.000000, '{\"65\":\"2\"}', '2018-02-18 22:32:18', '2018-02-18 22:32:18'),
(1064, 211, 1064, 2, 628, 0, 800.000000, '{\"221\":\"2\"}', '2018-02-18 22:39:07', '2018-02-18 22:39:07'),
(1065, 211, 1065, 1, 160, 0, 150.000000, '{\"219\":\"1\"}', '2018-02-18 22:39:07', '2018-02-18 22:39:07'),
(1066, 211, 1066, 1, 600, 0, 800.000000, '{\"223\":\"1\"}', '2018-02-18 22:39:07', '2018-02-18 22:39:07'),
(1067, 211, 1067, 1, 1400, 0, 1500.000000, '{\"60\":\"1\"}', '2018-02-18 22:39:07', '2018-02-18 22:39:07'),
(1068, 211, 1068, 4, 4400, 0, 6000.000000, '{\"233\":\"4\"}', '2018-02-18 22:39:07', '2018-02-18 22:39:07'),
(1069, 211, 1069, 1, 1100, 0, 2000.000000, '{\"233\":\"1\"}', '2018-02-18 22:39:07', '2018-02-18 22:39:07'),
(1070, 212, 1070, 1, 86, 0, 150.000000, '{\"208\":\"1\"}', '2018-02-18 22:42:00', '2018-02-18 22:42:00'),
(1071, 213, 1071, 8, 1280, 0, 1600.000000, '{\"219\":\"8\"}', '2018-02-18 23:13:45', '2018-02-18 23:13:45'),
(1072, 214, 1072, 2, 5400, 0, 5800.000000, '{\"54\":\"2\"}', '2018-02-18 23:16:17', '2018-02-18 23:16:17'),
(1073, 215, 1073, 2, 320, 0, 300.000000, '{\"219\":\"2\"}', '2018-02-18 23:18:20', '2018-02-18 23:18:20'),
(1074, 216, 1074, 2, 2240, 0, 2600.000000, '{\"227\":\"2\"}', '2018-02-18 23:19:28', '2018-02-18 23:19:28'),
(1075, 217, 1075, 1, 1450, 0, 1700.000000, '{\"201\":\"1\"}', '2018-02-18 23:34:43', '2018-02-18 23:34:43'),
(1076, 218, 1076, 1, 1510, 0, 1900.000000, '{\"246\":\"1\"}', '2018-02-18 23:36:07', '2018-02-18 23:36:07'),
(1077, 219, 1077, 40, 9040, 0, 8800.000000, '{\"220\":\"40\"}', '2018-02-19 23:30:26', '2018-02-19 23:30:26'),
(1078, 219, 1078, 4, 4480, 0, 5200.000000, '{\"227\":\"4\"}', '2018-02-19 23:30:26', '2018-02-19 23:30:26'),
(1079, 219, 1079, 6, 6000, 0, 8400.000000, '{\"86\":\"6\"}', '2018-02-19 23:30:26', '2018-02-19 23:30:26'),
(1080, 219, 1080, 4, 2200, 0, 1000.000000, '{\"206\":\"4\"}', '2018-02-19 23:30:26', '2018-02-19 23:30:26'),
(1081, 219, 1081, 4, 2400, 0, 2400.000000, '{\"55\":\"4\"}', '2018-02-19 23:30:26', '2018-02-19 23:30:26'),
(1082, 220, 1082, 2, 2000, 0, 2760.000000, '{\"86\":\"2\"}', '2018-02-19 23:34:56', '2018-02-19 23:34:56'),
(1083, 221, 1083, 2, 400, 0, 500.000000, '{\"100\":\"2\"}', '2018-02-19 23:37:29', '2018-02-19 23:37:29'),
(1084, 221, 1084, 2, 300, 0, 340.000000, '{\"101\":\"2\"}', '2018-02-19 23:37:29', '2018-02-19 23:37:29'),
(1085, 221, 1085, 2, 400, 0, 500.000000, '{\"97\":\"2\"}', '2018-02-19 23:37:29', '2018-02-19 23:37:29'),
(1086, 222, 1086, 2, 600, 0, 700.000000, '{\"114\":\"2\"}', '2018-02-20 17:03:39', '2018-02-20 17:03:39'),
(1087, 222, 1087, 2, 320, 0, 300.000000, '{\"219\":\"2\"}', '2018-02-20 17:03:39', '2018-02-20 17:03:39'),
(1088, 222, 1088, 1, 200, 0, 350.000000, '{\"100\":\"1\"}', '2018-02-20 17:03:39', '2018-02-20 17:03:39'),
(1089, 222, 1089, 2, 2200, 0, 4800.000000, '{\"133\":\"2\"}', '2018-02-20 17:03:39', '2018-02-20 17:03:39'),
(1090, 222, 1090, 2, 180, 0, 300.000000, '{\"104\":\"2\"}', '2018-02-20 17:03:39', '2018-02-20 17:03:39'),
(1091, 222, 1091, 3, 3360, 0, 3900.000000, '{\"227\":\"3\"}', '2018-02-20 17:03:39', '2018-02-20 17:03:39'),
(1092, 223, 1092, 7, 7840, 0, 9069.767442, '{\"227\":\"7\"}', '2018-02-23 21:29:08', '2018-02-23 21:29:08'),
(1093, 223, 1093, 3, 3000, 0, 4186.046512, '{\"86\":\"3\"}', '2018-02-23 21:29:08', '2018-02-23 21:29:08'),
(1094, 223, 1094, 9, 1575, 0, 2242.524917, '{\"112\":\"9\"}', '2018-02-23 21:29:08', '2018-02-23 21:29:08'),
(1095, 223, 1095, 12, 2400, 0, 3109.634551, '{\"100\":\"12\"}', '2018-02-23 21:29:08', '2018-02-23 21:29:08'),
(1096, 223, 1096, 9, 2700, 0, 3408.637874, '{\"98\":\"9\"}', '2018-02-23 21:29:08', '2018-02-23 21:29:08'),
(1097, 223, 1097, 20, 4300, 0, 4983.388704, '{\"232\":\"20\"}', '2018-02-23 21:29:08', '2018-02-23 21:29:08'),
(1098, 224, 1098, 6, 6720, 0, 7800.000000, '{\"227\":\"6\"}', '2018-02-23 21:35:39', '2018-02-23 21:35:39'),
(1099, 224, 1099, 1, 1000, 0, 1400.000000, '{\"86\":\"1\"}', '2018-02-23 21:35:39', '2018-02-23 21:35:39'),
(1100, 225, 1100, 5, 2050, 0, 4000.000000, '{\"222\":\"5\"}', '2018-02-23 22:25:06', '2018-02-23 22:25:06'),
(1101, 226, 1101, 7, 20300, 0, 22400.000000, '{\"160\":\"7\"}', '2018-02-23 22:28:02', '2018-02-23 22:28:02'),
(1102, 226, 1102, 7, 17500, 0, 21000.000000, '{\"167\":\"7\"}', '2018-02-23 22:28:02', '2018-02-23 22:28:02'),
(1103, 227, 1103, 6, 1932, 0, 2700.000000, '{\"224\":\"6\"}', '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(1104, 227, 1104, 3, 480, 0, 600.000000, '{\"219\":\"3\"}', '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(1105, 227, 1105, 5, 14500, 0, 16500.000000, '{\"187\":\"5\"}', '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(1106, 227, 1106, 1, 500, 0, 700.000000, '{\"153\":\"1\"}', '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(1107, 227, 1107, 1, 850, 0, 900.000000, '{\"229\":\"1\"}', '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(1108, 228, 1108, 2, 820, 0, 1800.000000, '{\"222\":\"2\"}', '2018-02-23 22:46:58', '2018-02-23 22:46:58'),
(1109, 228, 1109, 2, 2000, 0, 2200.000000, '{\"86\":\"2\"}', '2018-02-23 22:46:58', '2018-02-23 22:46:58'),
(1110, 229, 1110, 3, 600, 0, 600.000000, '{\"100\":\"3\"}', '2018-02-23 22:50:12', '2018-02-23 22:50:12'),
(1111, 230, 1111, 1, 410, 0, 650.000000, '{\"222\":\"1\"}', '2018-02-24 15:58:37', '2018-02-24 15:58:37'),
(1112, 230, 1112, 1, 1400, 0, 1700.000000, '{\"170\":\"1\"}', '2018-02-24 15:58:37', '2018-02-24 15:58:37'),
(1113, 231, 1113, 1, 410, 0, 599.891651, '{\"222\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1114, 231, 1114, 2, 320, 0, 359.934991, '{\"219\":\"2\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1115, 231, 1115, 1, 86, 0, 99.981942, '{\"208\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1116, 231, 1116, 1, 90, 0, 199.963884, '{\"104\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1117, 231, 1117, 1, 300, 0, 349.936796, '{\"114\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1118, 231, 1118, 9, 2034, 0, 2402.566063, '{\"220\":\"9\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1119, 231, 1119, 2, 320, 0, 449.918738, '{\"219\":\"2\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1120, 231, 1120, 1, 314, 0, 499.909709, '{\"221\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1121, 231, 1121, 2, 820, 0, 899.837477, '{\"222\":\"2\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1122, 231, 1122, 1, 86, 0, 99.981942, '{\"208\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1123, 231, 1123, 2, 224, 0, 99.981942, '{\"207\":\"2\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1124, 231, 1124, 1, 300, 0, 349.936796, '{\"114\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1125, 231, 1125, 1, 1100, 0, 2099.620779, '{\"133\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1126, 231, 1126, 1, 2900, 0, 3199.422139, '{\"187\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1127, 231, 1127, 1, 1120, 0, 1499.729128, '{\"227\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1128, 231, 1128, 1, 160, 0, 249.954855, '{\"219\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1129, 231, 1129, 3, 678, 0, 899.837477, '{\"220\":\"3\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1130, 231, 1130, 5, 800, 0, 899.837477, '{\"219\":\"5\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1131, 231, 1131, 2, 180, 0, 299.945826, '{\"104\":\"2\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1132, 231, 1132, 1, 160, 0, 199.963884, '{\"219\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1133, 231, 1133, 1, 314, 0, 499.909709, '{\"221\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1134, 231, 1134, 1, 250, 0, 349.936796, '{\"103\":\"1\"}', '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(1135, 232, 1135, 3, 258, 0, 300.000000, '{\"208\":\"3\"}', '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(1136, 232, 1136, 1, 1450, 0, 1800.000000, '{\"201\":\"1\"}', '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(1137, 232, 1137, 20, 3200, 0, 2400.000000, '{\"219\":\"20\"}', '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(1138, 232, 1138, 1, 314, 0, 500.000000, '{\"221\":\"1\"}', '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(1139, 232, 1139, 1, 86, 0, 100.000000, '{\"208\":\"1\"}', '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(1140, 232, 1140, 1, 410, 0, 500.000000, '{\"222\":\"1\"}', '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(1141, 232, 1141, 1, 200, 0, 350.000000, '{\"100\":\"1\"}', '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(1142, 233, 1142, 1, 664, 0, 800.000000, '{\"217\":\"1\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1143, 233, 1143, 1, 200, 0, 350.000000, '{\"100\":\"1\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1144, 233, 1144, 8, 3280, 0, 4800.000000, '{\"222\":\"8\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1145, 233, 1145, 1, 410, 0, 450.000000, '{\"222\":\"1\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1146, 233, 1146, 3, 480, 0, 1050.000000, '{\"219\":\"3\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1147, 233, 1147, 2, 430, 0, 700.000000, '{\"232\":\"2\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1148, 233, 1148, 2, 2240, 0, 3100.000000, '{\"227\":\"2\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1149, 233, 1149, 1, 1100, 0, 1150.000000, '{\"133\":\"1\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1150, 233, 1150, 1, 1000, 0, 1200.000000, '{\"83\":\"1\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1151, 233, 1151, 2, 820, 0, 1200.000000, '{\"222\":\"2\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1152, 233, 1152, 1, 226, 0, 300.000000, '{\"220\":\"1\"}', '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(1153, 234, 1153, 1, 1120, 0, 1600.000000, '{\"227\":\"1\"}', '2018-02-24 16:34:23', '2018-02-24 16:34:23'),
(1154, 234, 1154, 1, 300, 0, 350.000000, '{\"114\":\"1\"}', '2018-02-24 16:34:23', '2018-02-24 16:34:23'),
(1155, 234, 1155, 3, 258, 0, 300.000000, '{\"208\":\"3\"}', '2018-02-24 16:34:23', '2018-02-24 16:34:23'),
(1156, 234, 1156, 1, 1100, 0, 2000.000000, '{\"133\":\"1\"}', '2018-02-24 16:34:23', '2018-02-24 16:34:23'),
(1157, 234, 1157, 1, 160, 0, 300.000000, '{\"219\":\"1\"}', '2018-02-24 16:34:23', '2018-02-24 16:34:23'),
(1158, 235, 1158, 3, 480, 0, 549.000000, '{\"219\":\"3\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1159, 235, 1159, 1, 226, 0, 400.000000, '{\"220\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1160, 235, 1160, 1, 250, 0, 450.000000, '{\"103\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1161, 235, 1161, 1, 215, 0, 550.000000, '{\"232\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1162, 235, 1162, 1, 112, 0, 200.000000, '{\"207\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1163, 235, 1163, 1, 160, 0, 300.000000, '{\"219\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1164, 235, 1164, 2, 820, 0, 1000.000000, '{\"222\":\"2\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1165, 235, 1165, 1, 314, 0, 400.000000, '{\"221\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1166, 235, 1166, 1, 314, 0, 500.000000, '{\"221\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1167, 235, 1167, 8, 688, 0, 720.000000, '{\"208\":\"8\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1168, 235, 1168, 1, 250, 0, 400.000000, '{\"103\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1169, 235, 1169, 1, 86, 0, 100.000000, '{\"208\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1170, 235, 1170, 1, 620, 0, 900.000000, '{\"225\":\"1\"}', '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(1171, 236, 1171, 4, 904, 0, 1100.000000, '{\"220\":\"4\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1172, 236, 1172, 3, 480, 0, 798.000000, '{\"219\":\"3\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1173, 236, 1173, 2, 1328, 0, 1600.000000, '{\"217\":\"2\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1174, 236, 1174, 2, 430, 0, 650.000000, '{\"232\":\"2\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1175, 236, 1175, 3, 600, 0, 1020.000000, '{\"100\":\"3\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1176, 236, 1176, 2, 2100, 0, 2500.000000, '{\"194\":\"2\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1177, 236, 1177, 4, 4000, 0, 5900.000000, '{\"86\":\"4\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1178, 236, 1178, 1, 1000, 0, 1600.000000, '{\"86\":\"1\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1179, 236, 1179, 1, 600, 0, 800.000000, '{\"55\":\"1\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1180, 236, 1180, 1, 230, 0, 300.000000, '{\"226\":\"1\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1181, 236, 1181, 2, 430, 0, 500.000000, '{\"232\":\"2\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1182, 236, 1182, 2, 600, 0, 730.000000, '{\"114\":\"2\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1183, 236, 1183, 1, 1400, 0, 1500.000000, '{\"60\":\"1\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1184, 236, 1184, 2, 820, 0, 1200.000000, '{\"222\":\"2\"}', '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(1185, 237, 1185, 2, 820, 0, 1300.000000, '{\"222\":\"2\"}', '2018-02-24 17:19:25', '2018-02-24 17:19:25'),
(1186, 237, 1186, 1, 664, 0, 900.000000, '{\"217\":\"1\"}', '2018-02-24 17:19:25', '2018-02-24 17:19:25'),
(1187, 237, 1187, 6, 960, 0, 1602.000000, '{\"219\":\"6\"}', '2018-02-24 17:19:25', '2018-02-24 17:19:25'),
(1188, 237, 1188, 1, 250, 0, 400.000000, '{\"103\":\"1\"}', '2018-02-24 17:19:25', '2018-02-24 17:19:25'),
(1189, 237, 1189, 1, 1900, 0, 3000.000000, '{\"239\":\"1\"}', '2018-02-24 17:19:25', '2018-02-24 17:19:25'),
(1190, 237, 1190, 1, 226, 0, 300.000000, '{\"220\":\"1\"}', '2018-02-24 17:19:25', '2018-02-24 17:19:25'),
(1191, 238, 1191, 35, 3850, 0, 3850.000000, '{\"272\":\"35\"}', '2018-02-25 00:16:54', '2018-02-25 00:16:54'),
(1192, 239, 1192, 30, 3300, 0, 5082.682513, '{\"272\":\"30\"}', '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(1193, 239, 1193, 18, 3600, 0, 5381.663837, '{\"271\":\"18\"}', '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(1194, 239, 1194, 28, 7336, 0, 9766.723260, '{\"270\":\"28\"}', '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(1195, 239, 1195, 8, 2096, 0, 2551.307301, '{\"270\":\"8\"}', '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(1196, 239, 1196, 22, 4048, 0, 4823.565365, '{\"269\":\"22\"}', '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(1197, 239, 1197, 190, 20900, 0, 22722.580645, '{\"272\":\"190\"}', '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(1198, 239, 1198, 21, 8505, 0, 8371.477080, '{\"282\":\"21\"}', '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(1199, 240, 1199, 12, 12216, 0, 17878.787879, '{\"255\":\"12\"}', '2018-02-25 00:34:55', '2018-02-25 00:34:55'),
(1200, 240, 1200, 9, 9162, 0, 11621.212121, '{\"255\":\"9\"}', '2018-02-25 00:34:55', '2018-02-25 00:34:55'),
(1201, 241, 1201, 6, 18600, 0, 19800.000000, '{\"321\":\"6\"}', '2018-02-25 00:38:04', '2018-02-25 00:38:04'),
(1202, 242, 1202, 8, 880, 0, 1038.521677, '{\"272\":\"8\"}', '2018-02-25 00:46:56', '2018-02-25 00:46:56'),
(1203, 242, 1203, 18, 3312, 0, 3954.371002, '{\"269\":\"18\"}', '2018-02-25 00:46:56', '2018-02-25 00:46:56'),
(1204, 242, 1204, 4, 440, 0, 718.976546, '{\"272\":\"4\"}', '2018-02-25 00:46:56', '2018-02-25 00:46:56'),
(1205, 242, 1205, 5, 1310, 0, 1747.512438, '{\"270\":\"5\"}', '2018-02-25 00:46:56', '2018-02-25 00:46:56'),
(1206, 242, 1206, 2, 220, 0, 599.147122, '{\"272\":\"2\"}', '2018-02-25 00:46:56', '2018-02-25 00:46:56'),
(1207, 242, 1207, 3, 5100, 0, 5991.471215, '{\"320\":\"3\"}', '2018-02-25 00:46:56', '2018-02-25 00:46:56'),
(1208, 243, 1208, 15, 1650, 0, 1795.425667, '{\"272\":\"15\"}', '2018-02-25 00:54:36', '2018-02-25 00:54:36'),
(1209, 243, 1209, 1, 110, 0, 169.567980, '{\"272\":\"1\"}', '2018-02-25 00:54:36', '2018-02-25 00:54:36'),
(1210, 243, 1210, 10, 1840, 0, 2693.138501, '{\"269\":\"10\"}', '2018-02-25 00:54:36', '2018-02-25 00:54:36'),
(1211, 243, 1211, 2, 3452, 0, 3191.867853, '{\"302\":\"2\"}', '2018-02-25 00:54:36', '2018-02-25 00:54:36'),
(1212, 244, 1212, 1, 3000, 0, 3500.000000, '{\"332\":\"1\"}', '2018-02-25 01:05:44', '2018-02-25 01:05:44'),
(1213, 244, 1213, 2, 6000, 0, 7000.000000, '{\"247\":\"2\"}', '2018-02-25 01:05:44', '2018-02-25 01:05:44'),
(1214, 244, 1214, 1, 1500, 0, 2000.000000, '{\"328\":\"1\"}', '2018-02-25 01:05:44', '2018-02-25 01:05:44'),
(1215, 244, 1215, 2, 368, 0, 600.000000, '{\"269\":\"2\"}', '2018-02-25 01:05:44', '2018-02-25 01:05:44'),
(1216, 244, 1216, 2, 400, 0, 900.000000, '{\"271\":\"2\"}', '2018-02-25 01:05:44', '2018-02-25 01:05:44'),
(1217, 245, 1217, 4, 4400, 0, 5200.000000, '{\"262\":\"4\"}', '2018-02-25 18:52:33', '2018-02-25 18:52:33'),
(1218, 245, 1218, 3, 1413, 0, 2100.000000, '{\"252\":\"3\"}', '2018-02-25 18:52:33', '2018-02-25 18:52:33'),
(1219, 246, 1219, 2, 6000, 0, 6200.000000, '{\"247\":\"2\"}', '2018-02-25 18:59:13', '2018-02-25 18:59:13'),
(1220, 246, 1220, 2, 6800, 0, 7600.000000, '{\"315\":\"2\"}', '2018-02-25 18:59:13', '2018-02-25 18:59:13'),
(1221, 246, 1221, 1, 2900, 0, 3200.000000, '{\"248\":\"1\"}', '2018-02-25 18:59:13', '2018-02-25 18:59:13'),
(1222, 247, 1222, 9, 9450, 0, 10326.423690, '{\"298\":\"9\"}', '2018-02-25 19:02:44', '2018-02-25 19:02:44'),
(1223, 247, 1223, 2, 3452, 0, 3192.710706, '{\"302\":\"2\"}', '2018-02-25 19:02:44', '2018-02-25 19:02:44'),
(1224, 247, 1224, 7, 8043, 0, 8380.865604, '{\"337\":\"7\"}', '2018-02-25 19:02:44', '2018-02-25 19:02:44'),
(1225, 248, 1225, 25, 26250, 0, 28700.000000, '{\"298\":\"25\"}', '2018-02-25 19:08:08', '2018-02-25 19:08:08'),
(1226, 249, 1226, 5, 6115, 0, 6750.000000, '{\"299\":\"5\"}', '2018-02-25 19:14:46', '2018-02-25 19:14:46'),
(1227, 249, 1227, 2, 2298, 0, 2500.000000, '{\"337\":\"2\"}', '2018-02-25 19:14:46', '2018-02-25 19:14:46'),
(1228, 249, 1228, 4, 4400, 0, 5600.000000, '{\"262\":\"4\"}', '2018-02-25 19:14:46', '2018-02-25 19:14:46'),
(1229, 249, 1229, 3, 1413, 0, 2400.000000, '{\"252\":\"3\"}', '2018-02-25 19:14:46', '2018-02-25 19:14:46'),
(1230, 249, 1230, 7, 10500, 0, 12250.000000, '{\"328\":\"7\"}', '2018-02-25 19:14:46', '2018-02-25 19:14:46'),
(1231, 250, 1231, 10, 4710, 0, 7500.000000, '{\"252\":\"10\"}', '2018-02-25 19:19:58', '2018-02-25 19:19:58'),
(1232, 250, 1232, 3, 5397, 0, 6600.000000, '{\"263\":\"3\"}', '2018-02-25 19:19:58', '2018-02-25 19:19:58'),
(1233, 250, 1233, 8, 8800, 0, 10400.000000, '{\"262\":\"8\"}', '2018-02-25 19:19:58', '2018-02-25 19:19:58'),
(1234, 250, 1234, 6, 10356, 0, 11400.000000, '{\"302\":\"6\"}', '2018-02-25 19:19:58', '2018-02-25 19:19:58'),
(1235, 250, 1235, 72, 720, 0, 1440.000000, '{\"268\":\"72\"}', '2018-02-25 19:19:58', '2018-02-25 19:19:58'),
(1236, 251, 1236, 10, 4710, 0, 7000.000000, '{\"252\":\"10\"}', '2018-02-25 19:22:56', '2018-02-25 19:22:56'),
(1237, 251, 1237, 16, 2944, 0, 3600.000000, '{\"269\":\"16\"}', '2018-02-25 19:22:56', '2018-02-25 19:22:56'),
(1238, 252, 1238, 42, 420, 0, 1241.379310, '{\"268\":\"42\"}', '2018-02-25 19:25:18', '2018-02-25 19:25:18'),
(1239, 252, 1239, 56, 1008, 0, 2758.620690, '{\"267\":\"56\"}', '2018-02-25 19:25:18', '2018-02-25 19:25:18'),
(1240, 253, 1240, 5, 5090, 0, 7000.000000, '{\"255\":\"5\"}', '2018-02-25 19:27:12', '2018-02-25 19:27:12'),
(1241, 253, 1241, 4, 1884, 0, 3000.000000, '{\"252\":\"4\"}', '2018-02-25 19:27:12', '2018-02-25 19:27:12'),
(1242, 254, 1242, 6, 2826, 0, 4800.000000, '{\"252\":\"6\"}', '2018-02-25 19:46:47', '2018-02-25 19:46:47'),
(1243, 254, 1243, 1, 3000, 0, 3200.000000, '{\"332\":\"1\"}', '2018-02-25 19:46:47', '2018-02-25 19:46:47'),
(1244, 255, 1244, 1, 471, 0, 800.000000, '{\"252\":\"1\"}', '2018-02-25 19:49:55', '2018-02-25 19:49:55'),
(1245, 256, 1245, 5, 8995, 0, 11000.000000, '{\"263\":\"5\"}', '2018-02-25 19:54:16', '2018-02-25 19:54:16'),
(1246, 256, 1246, 2, 2036, 0, 2600.000000, '{\"255\":\"2\"}', '2018-02-25 19:54:16', '2018-02-25 19:54:16'),
(1247, 256, 1247, 4, 4072, 0, 5600.000000, '{\"255\":\"4\"}', '2018-02-25 19:54:16', '2018-02-25 19:54:16'),
(1248, 257, 1248, 4, 1884, 0, 2997.658080, '{\"252\":\"4\"}', '2018-02-25 20:02:35', '2018-02-25 20:02:35'),
(1249, 257, 1249, 2, 942, 0, 1598.750976, '{\"252\":\"2\"}', '2018-02-25 20:02:35', '2018-02-25 20:02:35'),
(1250, 257, 1250, 7, 7700, 0, 9092.896175, '{\"262\":\"7\"}', '2018-02-25 20:02:35', '2018-02-25 20:02:35'),
(1251, 257, 1251, 7, 7000, 0, 8393.442623, '{\"284\":\"7\"}', '2018-02-25 20:02:35', '2018-02-25 20:02:35'),
(1252, 257, 1252, 2, 1028, 0, 1598.750976, '{\"261\":\"2\"}', '2018-02-25 20:02:35', '2018-02-25 20:02:35'),
(1253, 257, 1253, 16, 400, 0, 1918.501171, '{\"264\":\"16\"}', '2018-02-25 20:02:35', '2018-02-25 20:02:35'),
(1254, 258, 1254, 6, 6108, 0, 7936.638655, '{\"255\":\"6\"}', '2018-02-25 20:05:47', '2018-02-25 20:05:47'),
(1255, 258, 1255, 2, 3452, 0, 3723.361345, '{\"302\":\"2\"}', '2018-02-25 20:05:47', '2018-02-25 20:05:47'),
(1256, 259, 1256, 16, 1760, 0, 1755.963303, '{\"272\":\"16\"}', '2018-02-25 20:10:56', '2018-02-25 20:10:56'),
(1257, 259, 1257, 4, 736, 0, 917.889908, '{\"269\":\"4\"}', '2018-02-25 20:10:56', '2018-02-25 20:10:56'),
(1258, 259, 1258, 7, 770, 0, 1187.270642, '{\"272\":\"7\"}', '2018-02-25 20:10:56', '2018-02-25 20:10:56'),
(1259, 259, 1259, 4, 440, 0, 798.165138, '{\"272\":\"4\"}', '2018-02-25 20:10:56', '2018-02-25 20:10:56'),
(1260, 259, 1260, 5, 1250, 0, 1247.133028, '{\"278\":\"5\"}', '2018-02-25 20:10:56', '2018-02-25 20:10:56'),
(1261, 259, 1261, 2, 670, 0, 848.050459, '{\"274\":\"2\"}', '2018-02-25 20:10:56', '2018-02-25 20:10:56'),
(1262, 259, 1262, 6, 1500, 0, 1945.527523, '{\"341\":\"6\"}', '2018-02-25 20:10:56', '2018-02-25 20:10:56'),
(1263, 260, 1263, 6, 6600, 0, 7800.000000, '{\"262\":\"6\"}', '2018-02-25 20:14:40', '2018-02-25 20:14:40'),
(1264, 260, 1264, 2, 942, 0, 1500.000000, '{\"252\":\"2\"}', '2018-02-25 20:14:40', '2018-02-25 20:14:40'),
(1265, 261, 1265, 2, 2036, 0, 2800.000000, '{\"255\":\"2\"}', '2018-02-25 20:21:01', '2018-02-25 20:21:01'),
(1266, 261, 1266, 3, 3054, 0, 3900.000000, '{\"255\":\"3\"}', '2018-02-25 20:21:01', '2018-02-25 20:21:01'),
(1267, 261, 1267, 2, 6500, 0, 7000.000000, '{\"331\":\"2\"}', '2018-02-25 20:21:01', '2018-02-25 20:21:01'),
(1268, 262, 1268, 7, 7700, 0, 9100.000000, '{\"262\":\"7\"}', '2018-02-25 20:52:12', '2018-02-25 20:52:12'),
(1269, 262, 1269, 2, 1028, 0, 1600.000000, '{\"261\":\"2\"}', '2018-02-25 20:52:12', '2018-02-25 20:52:12'),
(1270, 262, 1270, 1, 471, 0, 800.000000, '{\"252\":\"1\"}', '2018-02-25 20:52:12', '2018-02-25 20:52:12'),
(1271, 262, 1271, 2, 942, 0, 1500.000000, '{\"252\":\"2\"}', '2018-02-25 20:52:12', '2018-02-25 20:52:12'),
(1272, 263, 1272, 2, 2036, 0, 2600.000000, '{\"255\":\"2\"}', '2018-02-25 20:57:01', '2018-02-25 20:57:01'),
(1273, 263, 1273, 4, 4072, 0, 5600.000000, '{\"255\":\"4\"}', '2018-02-25 20:57:01', '2018-02-25 20:57:01'),
(1274, 263, 1274, 3, 1200, 0, 2400.000000, '{\"260\":\"3\"}', '2018-02-25 20:57:01', '2018-02-25 20:57:01'),
(1275, 264, 1275, 5, 5090, 0, 6250.000000, '{\"255\":\"5\"}', '2018-02-25 20:58:37', '2018-02-25 20:58:37'),
(1276, 265, 1276, 8, 8144, 0, 10400.000000, '{\"255\":\"8\"}', '2018-02-25 21:01:25', '2018-02-25 21:01:25'),
(1277, 265, 1277, 1, 1018, 0, 1400.000000, '{\"255\":\"1\"}', '2018-02-25 21:01:25', '2018-02-25 21:01:25'),
(1278, 266, 1278, 6, 3600, 0, 4800.000000, '{\"283\":\"6\"}', '2018-02-25 21:05:02', '2018-02-25 21:05:02'),
(1279, 266, 1279, 2, 500, 0, 700.000000, '{\"341\":\"2\"}', '2018-02-25 21:05:02', '2018-02-25 21:05:02'),
(1280, 266, 1280, 2, 1586, 0, 1800.000000, '{\"290\":\"2\"}', '2018-02-25 21:05:02', '2018-02-25 21:05:02'),
(1281, 267, 1281, 2, 2036, 0, 2600.000000, '{\"255\":\"2\"}', '2018-02-25 21:10:47', '2018-02-25 21:10:47'),
(1282, 267, 1282, 7, 7126, 0, 8400.000000, '{\"255\":\"7\"}', '2018-02-25 21:10:47', '2018-02-25 21:10:47'),
(1283, 267, 1283, 2, 2200, 0, 2400.000000, '{\"262\":\"2\"}', '2018-02-25 21:10:47', '2018-02-25 21:10:47'),
(1284, 267, 1284, 4, 2800, 0, 3200.000000, '{\"285\":\"4\"}', '2018-02-25 21:10:47', '2018-02-25 21:10:47'),
(1285, 268, 1285, 7, 4900, 0, 6300.000000, '{\"285\":\"7\"}', '2018-02-25 21:16:55', '2018-02-25 21:16:55'),
(1286, 268, 1286, 2, 2036, 0, 2700.000000, '{\"255\":\"2\"}', '2018-02-25 21:16:55', '2018-02-25 21:16:55'),
(1287, 269, 1287, 2, 6000, 0, 6400.000000, '{\"332\":\"2\"}', '2018-02-25 21:22:00', '2018-02-25 21:22:00'),
(1288, 269, 1288, 14, 3668, 0, 4900.000000, '{\"270\":\"14\"}', '2018-02-25 21:22:00', '2018-02-25 21:22:00'),
(1289, 269, 1289, 2, 368, 0, 500.000000, '{\"269\":\"2\"}', '2018-02-25 21:22:00', '2018-02-25 21:22:00'),
(1290, 270, 1290, 8, 9600, 0, 12000.000000, '{\"293\":\"8\"}', '2018-02-25 21:24:59', '2018-02-25 21:24:59'),
(1291, 270, 1291, 1, 200, 0, 250.000000, '{\"271\":\"1\"}', '2018-02-25 21:24:59', '2018-02-25 21:24:59'),
(1292, 271, 1292, 1, 1250, 0, 1600.000000, '{\"256\":\"1\"}', '2018-02-25 21:27:39', '2018-02-25 21:27:39'),
(1293, 272, 1293, 2, 944, 0, 1400.000000, '{\"286\":\"2\"}', '2018-02-25 21:29:40', '2018-02-25 21:29:40'),
(1294, 273, 1294, 3, 1413, 0, 1945.255474, '{\"252\":\"3\"}', '2018-02-25 21:32:15', '2018-02-25 21:32:15'),
(1295, 273, 1295, 12, 3720, 0, 5386.861314, '{\"253\":\"12\"}', '2018-02-25 21:32:15', '2018-02-25 21:32:15'),
(1296, 273, 1296, 11, 11198, 0, 13167.883212, '{\"255\":\"11\"}', '2018-02-25 21:32:15', '2018-02-25 21:32:15'),
(1297, 274, 1297, 9, 9162, 0, 10350.000000, '{\"255\":\"9\"}', '2018-02-25 21:35:05', '2018-02-25 21:35:05'),
(1298, 274, 1298, 1, 1018, 0, 1250.000000, '{\"255\":\"1\"}', '2018-02-25 21:35:05', '2018-02-25 21:35:05'),
(1299, 275, 1299, 18, 18324, 0, 21530.546624, '{\"255\":\"18\"}', '2018-02-25 21:40:10', '2018-02-25 21:40:10'),
(1300, 275, 1300, 1, 1018, 0, 1295.819936, '{\"255\":\"1\"}', '2018-02-25 21:40:10', '2018-02-25 21:40:10'),
(1301, 275, 1301, 7, 4900, 0, 5581.993569, '{\"285\":\"7\"}', '2018-02-25 21:40:10', '2018-02-25 21:40:10'),
(1302, 275, 1302, 8, 3240, 0, 2591.639871, '{\"282\":\"8\"}', '2018-02-25 21:40:10', '2018-02-25 21:40:10'),
(1303, 276, 1303, 6, 2826, 0, 4500.000000, '{\"252\":\"6\"}', '2018-02-25 21:44:03', '2018-02-25 21:44:03'),
(1304, 276, 1304, 7, 2170, 0, 2800.000000, '{\"253\":\"7\"}', '2018-02-25 21:44:03', '2018-02-25 21:44:03'),
(1305, 276, 1305, 1, 54, 0, 80.000000, '{\"287\":\"1\"}', '2018-02-25 21:44:04', '2018-02-25 21:44:04'),
(1306, 277, 1306, 6, 6108, 0, 6900.000000, '{\"255\":\"6\"}', '2018-02-25 21:48:34', '2018-02-25 21:48:34'),
(1307, 278, 1307, 2, 2400, 0, 3200.000000, '{\"293\":\"2\"}', '2018-02-25 22:16:13', '2018-02-25 22:16:13'),
(1308, 278, 1308, 2, 368, 0, 480.000000, '{\"269\":\"2\"}', '2018-02-25 22:16:13', '2018-02-25 22:16:13'),
(1309, 278, 1309, 2, 400, 0, 700.000000, '{\"271\":\"2\"}', '2018-02-25 22:16:13', '2018-02-25 22:16:13'),
(1310, 279, 1310, 5, 3500, 0, 3904.000000, '{\"285\":\"5\"}', '2018-02-25 22:19:46', '2018-02-25 22:19:46'),
(1311, 279, 1311, 10, 2330, 0, 2196.000000, '{\"280\":\"10\"}', '2018-02-25 22:19:46', '2018-02-25 22:19:46'),
(1312, 280, 1312, 16, 1760, 0, 1760.000000, '{\"272\":\"16\"}', '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(1313, 280, 1313, 7, 1288, 0, 1575.000000, '{\"269\":\"7\"}', '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(1314, 280, 1314, 6, 1500, 0, 1650.000000, '{\"278\":\"6\"}', '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(1315, 280, 1315, 7, 1631, 0, 1575.000000, '{\"280\":\"7\"}', '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(1316, 280, 1316, 6, 1200, 0, 1380.000000, '{\"271\":\"6\"}', '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(1317, 280, 1317, 10, 2000, 0, 2300.000000, '{\"279\":\"10\"}', '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(1318, 280, 1318, 2, 2036, 0, 2400.000000, '{\"255\":\"2\"}', '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(1319, 281, 1319, 6, 6108, 0, 7195.347835, '{\"255\":\"6\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1320, 281, 1320, 8, 3240, 0, 2598.320052, '{\"282\":\"8\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1321, 281, 1321, 27, 5400, 0, 6205.987508, '{\"279\":\"27\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1322, 281, 1322, 16, 2944, 0, 3517.725608, '{\"269\":\"16\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1323, 281, 1323, 12, 4020, 0, 4796.898557, '{\"274\":\"12\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1324, 281, 1324, 16, 4000, 0, 4796.898557, '{\"275\":\"16\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1325, 281, 1325, 12, 3000, 0, 2998.061598, '{\"278\":\"12\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1326, 281, 1326, 14, 1540, 0, 2238.552660, '{\"272\":\"14\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1327, 281, 1327, 47, 10951, 0, 10803.015292, '{\"280\":\"47\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1328, 281, 1328, 25, 1350, 0, 1249.192333, '{\"287\":\"25\"}', '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(1329, 282, 1329, 10, 3100, 0, 5000.000000, '{\"253\":\"10\"}', '2018-02-25 22:42:39', '2018-02-25 22:42:39'),
(1330, 283, 1330, 16, 3200, 0, 4800.000000, '{\"271\":\"16\"}', '2018-02-25 22:45:19', '2018-02-25 22:45:19'),
(1331, 284, 1339, 3, 3885, 0, 4200.000000, '{\"322\":\"3\"}', '2018-02-25 22:56:28', '2018-02-25 22:56:28'),
(1332, 285, 1340, 4, 440, 0, 479.480707, '{\"272\":\"4\"}', '2018-02-25 23:05:24', '2018-02-25 23:05:24'),
(1333, 285, 1341, 16, 4000, 0, 5194.374324, '{\"275\":\"16\"}', '2018-02-25 23:05:24', '2018-02-25 23:05:24'),
(1334, 285, 1342, 23, 5359, 0, 5743.779300, '{\"280\":\"23\"}', '2018-02-25 23:05:24', '2018-02-25 23:05:24'),
(1335, 285, 1343, 20, 4000, 0, 4994.590696, '{\"271\":\"20\"}', '2018-02-25 23:05:24', '2018-02-25 23:05:24'),
(1336, 285, 1344, 3, 2100, 0, 2397.403534, '{\"285\":\"3\"}', '2018-02-25 23:05:24', '2018-02-25 23:05:24'),
(1337, 285, 1345, 4, 4072, 0, 5194.374324, '{\"255\":\"4\"}', '2018-02-25 23:05:25', '2018-02-25 23:05:25'),
(1338, 285, 1346, 1, 1018, 0, 1498.377209, '{\"255\":\"1\"}', '2018-02-25 23:05:25', '2018-02-25 23:05:25'),
(1339, 285, 1347, 4, 1048, 0, 1398.485395, '{\"270\":\"4\"}', '2018-02-25 23:05:25', '2018-02-25 23:05:25'),
(1340, 285, 1348, 1, 600, 0, 799.134511, '{\"283\":\"1\"}', '2018-02-25 23:05:25', '2018-02-25 23:05:25'),
(1341, 286, 1360, 12, 300, 0, 1200.000000, '{\"264\":\"12\"}', '2018-02-25 23:28:02', '2018-02-25 23:28:02'),
(1342, 286, 1361, 34, 985, 0, 2720.000000, '{\"264\":\"25\",\"265\":9}', '2018-02-25 23:28:02', '2018-02-25 23:28:02'),
(1343, 286, 1362, 49, 2130, 0, 2450.000000, '{\"265\":\"32\",\"266\":17}', '2018-02-25 23:28:02', '2018-02-25 23:28:02'),
(1344, 286, 1363, 174, 1740, 0, 3480.000000, '{\"268\":\"174\"}', '2018-02-25 23:28:02', '2018-02-25 23:28:02'),
(1345, 287, 1364, 7, 2170, 0, 3500.000000, '{\"253\":\"7\"}', '2018-02-25 23:34:09', '2018-02-25 23:34:09'),
(1346, 287, 1365, 2, 500, 0, 600.000000, '{\"278\":\"2\"}', '2018-02-25 23:34:09', '2018-02-25 23:34:09'),
(1347, 287, 1366, 1, 200, 0, 270.000000, '{\"279\":\"1\"}', '2018-02-25 23:34:09', '2018-02-25 23:34:09'),
(1348, 295, 1367, 7, 1288, 0, 2149.000000, '{\"269\":\"7\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1349, 295, 1368, 47, 5170, 0, 7426.000000, '{\"272\":\"47\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1350, 295, 1369, 3, 600, 0, 1500.000000, '{\"271\":\"3\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1351, 295, 1370, 6, 6108, 0, 9198.000000, '{\"255\":\"6\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1352, 295, 1371, 1, 335, 0, 700.000000, '{\"274\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1353, 295, 1372, 2, 3000, 0, 4000.000000, '{\"328\":\"2\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1354, 295, 1373, 1, 405, 0, 500.000000, '{\"282\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1355, 295, 1374, 1, 200, 0, 500.000000, '{\"259\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1356, 295, 1375, 1, 1100, 0, 1300.000000, '{\"262\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1357, 295, 1376, 1, 1700, 0, 2000.000000, '{\"320\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1358, 295, 1377, 1, 3000, 0, 3500.000000, '{\"247\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1359, 295, 1378, 1, 3400, 0, 3500.000000, '{\"315\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1360, 295, 1379, 1, 471, 0, 700.000000, '{\"252\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1361, 295, 1380, 4, 4200, 0, 4400.000000, '{\"298\":\"4\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1362, 295, 1381, 1, 2100, 0, 2400.000000, '{\"336\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1363, 295, 1382, 1, 2000, 0, 2500.000000, '{\"324\":\"1\"}', '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(1364, 296, 1414, 6, 6600, 0, 8100.000000, '{\"262\":\"6\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1365, 296, 1415, 5, 6115, 0, 6350.000000, '{\"299\":\"5\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1366, 296, 1416, 15, 15270, 0, 23190.000000, '{\"255\":\"15\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1367, 296, 1417, 2, 3900, 0, 4400.000000, '{\"343\":\"2\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1368, 296, 1418, 4, 360, 0, 652.000000, '{\"273\":\"4\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1369, 296, 1419, 1, 1000, 0, 1100.000000, '{\"284\":\"1\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1370, 296, 1420, 1, 500, 0, 750.000000, '{\"258\":\"1\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1371, 296, 1421, 4, 1200, 0, 1200.000000, '{\"281\":\"4\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1372, 296, 1422, 9, 15534, 0, 20349.000000, '{\"302\":\"9\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1373, 296, 1423, 2, 5400, 0, 5800.000000, '{\"297\":\"2\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1374, 296, 1424, 1, 1613, 0, 1700.000000, '{\"296\":\"1\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1375, 296, 1425, 1, 550, 0, 600.000000, '{\"294\":\"1\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1376, 296, 1426, 2, 2298, 0, 3100.000000, '{\"337\":\"2\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1377, 296, 1427, 5, 12500, 0, 14800.000000, '{\"309\":\"5\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1378, 296, 1428, 1, 2700, 0, 3000.000000, '{\"326\":\"1\"}', '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(1379, 297, 1451, 21, 2310, 0, 2310.000000, '{\"272\":\"21\"}', '2018-02-27 01:21:11', '2018-02-27 01:21:11'),
(1380, 297, 1452, 11, 2750, 0, 3025.000000, '{\"278\":\"11\"}', '2018-02-27 01:21:11', '2018-02-27 01:21:11'),
(1381, 297, 1453, 4, 4072, 0, 5000.000000, '{\"255\":\"4\"}', '2018-02-27 01:21:11', '2018-02-27 01:21:11'),
(1382, 297, 1454, 1, 1018, 0, 1150.000000, '{\"255\":\"1\"}', '2018-02-27 01:21:11', '2018-02-27 01:21:11'),
(1383, 298, 1455, 1, 3050, 0, 3399.813197, '{\"325\":\"1\"}', '2018-02-27 01:26:27', '2018-02-27 01:26:27'),
(1384, 298, 1456, 3, 5178, 0, 7100.609857, '{\"302\":\"3\"}', '2018-02-27 01:26:27', '2018-02-27 01:26:27'),
(1385, 298, 1457, 1, 2000, 0, 2249.876380, '{\"324\":\"1\"}', '2018-02-27 01:26:27', '2018-02-27 01:26:27'),
(1386, 298, 1458, 1, 1900, 0, 2149.881875, '{\"327\":\"1\"}', '2018-02-27 01:26:28', '2018-02-27 01:26:28'),
(1387, 298, 1459, 1, 3000, 0, 3299.818691, '{\"247\":\"1\"}', '2018-02-27 01:26:28', '2018-02-27 01:26:28'),
(1388, 299, 1460, 40, 40720, 0, 48000.000000, '{\"255\":\"40\"}', '2018-02-27 01:30:52', '2018-02-27 01:30:52'),
(1389, 299, 1461, 8, 5600, 0, 6400.000000, '{\"285\":\"8\"}', '2018-02-27 01:30:52', '2018-02-27 01:30:52'),
(1390, 299, 1462, 2, 944, 0, 1400.000000, '{\"286\":\"2\"}', '2018-02-27 01:30:52', '2018-02-27 01:30:52'),
(1391, 299, 1463, 16, 5360, 0, 6400.000000, '{\"274\":\"16\"}', '2018-02-27 01:30:52', '2018-02-27 01:30:52'),
(1392, 299, 1464, 6, 1500, 0, 1800.000000, '{\"275\":\"6\"}', '2018-02-27 01:30:53', '2018-02-27 01:30:53'),
(1393, 304, 1349, 61, 11224, 0, 13420.000000, '{\"269\":\"61\"}', '2018-02-27 23:14:08', '2018-02-27 23:14:08'),
(1394, 304, 1350, 17, 3961, 0, 5525.000000, '{\"280\":\"17\"}', '2018-02-27 23:14:08', '2018-02-27 23:14:08'),
(1395, 304, 1351, 12, 3144, 0, 3600.000000, '{\"270\":\"12\"}', '2018-02-27 23:14:08', '2018-02-27 23:14:08'),
(1396, 304, 1352, 6, 1572, 0, 2100.000000, '{\"270\":\"6\"}', '2018-02-27 23:14:08', '2018-02-27 23:14:08'),
(1397, 304, 1353, 16, 4000, 0, 5200.000000, '{\"275\":\"16\"}', '2018-02-27 23:14:08', '2018-02-27 23:14:08'),
(1398, 304, 1354, 14, 4690, 0, 5950.000000, '{\"274\":\"14\"}', '2018-02-27 23:14:08', '2018-02-27 23:14:08'),
(1399, 304, 1355, 15, 3000, 0, 3375.000000, '{\"271\":\"15\"}', '2018-02-27 23:14:08', '2018-02-27 23:14:08'),
(1400, 304, 1356, 4, 1048, 0, 1300.000000, '{\"270\":\"4\"}', '2018-02-27 23:14:08', '2018-02-27 23:14:08'),
(1401, 304, 1357, 8, 5600, 0, 6400.000000, '{\"285\":\"8\"}', '2018-02-27 23:14:08', '2018-02-27 23:14:08'),
(1402, 304, 1358, 12, 3000, 0, 3300.000000, '{\"278\":\"12\"}', '2018-02-27 23:14:08', '2018-02-27 23:14:08'),
(1403, 304, 1359, 30, 2700, 0, 3600.000000, '{\"273\":\"30\"}', '2018-02-27 23:14:08', '2018-02-27 23:14:08'),
(1476, 311, 1331, 3, 600, 0, 809.410000, '{\"279\":\"3\"}', '2018-02-28 18:22:30', '2018-02-28 18:22:30'),
(1477, 311, 1332, 5, 1550, 0, 2498.190000, '{\"253\":\"5\"}', '2018-02-28 18:22:30', '2018-02-28 18:22:30'),
(1478, 311, 1333, 7, 2100, 0, 2098.480000, '{\"281\":\"7\"}', '2018-02-28 18:22:30', '2018-02-28 18:22:30'),
(1479, 311, 1334, 4, 932, 0, 1079.220000, '{\"280\":\"4\"}', '2018-02-28 18:22:30', '2018-02-28 18:22:30'),
(1480, 311, 1335, 4, 4072, 0, 5396.090000, '{\"255\":\"4\"}', '2018-02-28 18:22:30', '2018-02-28 18:22:30'),
(1481, 311, 1336, 4, 440, 0, 479.650000, '{\"272\":\"4\"}', '2018-02-28 18:22:30', '2018-02-28 18:22:30'),
(1482, 311, 1337, 2, 524, 0, 639.540000, '{\"270\":\"2\"}', '2018-02-28 18:22:30', '2018-02-28 18:22:30'),
(1483, 311, 1338, 1, 600, 0, 799.420000, '{\"283\":\"1\"}', '2018-02-28 18:22:30', '2018-02-28 18:22:30'),
(1484, 312, 1465, 22, 22396, 0, 25300.000000, '{\"255\":\"22\"}', '2018-02-28 18:47:13', '2018-02-28 18:47:13'),
(1485, 312, 1466, 3, 3054, 0, 3750.000000, '{\"255\":\"3\"}', '2018-02-28 18:47:13', '2018-02-28 18:47:13'),
(1486, 313, 1467, 5, 3500, 0, 4000.000000, '{\"285\":\"5\"}', '2018-02-28 18:51:12', '2018-02-28 18:51:12'),
(1487, 313, 1468, 8, 4112, 0, 4400.000000, '{\"261\":\"8\"}', '2018-02-28 18:51:12', '2018-02-28 18:51:12'),
(1488, 314, 1469, 4, 1200, 0, 1200.000000, '{\"281\":\"4\"}', '2018-02-28 18:56:18', '2018-02-28 18:56:18'),
(1489, 314, 1470, 1, 1018, 0, 1400.000000, '{\"255\":\"1\"}', '2018-02-28 18:56:18', '2018-02-28 18:56:18'),
(1490, 314, 1471, 3, 786, 0, 1050.000000, '{\"270\":\"3\"}', '2018-02-28 18:56:18', '2018-02-28 18:56:18'),
(1491, 314, 1472, 1, 250, 0, 300.000000, '{\"278\":\"1\"}', '2018-02-28 18:56:18', '2018-02-28 18:56:18'),
(1492, 315, 1473, 14, 28000, 0, 30800.000000, '{\"305\":\"14\"}', '2018-02-28 19:00:36', '2018-02-28 19:00:36'),
(1493, 315, 1474, 2, 2036, 0, 2800.000000, '{\"255\":\"2\"}', '2018-02-28 19:00:36', '2018-02-28 19:00:36'),
(1494, 316, 1475, 2, 5400, 0, 5000.000000, '{\"326\":\"2\"}', '2018-02-28 19:03:40', '2018-02-28 19:03:40'),
(1495, 316, 1476, 3, 5178, 0, 6000.000000, '{\"302\":\"3\"}', '2018-02-28 19:03:40', '2018-02-28 19:03:40'),
(1496, 317, 1477, 12, 15600, 0, 16800.000000, '{\"304\":\"12\"}', '2018-02-28 19:06:03', '2018-02-28 19:06:03'),
(1497, 318, 1478, 5, 5090, 0, 6000.000000, '{\"255\":\"5\"}', '2018-02-28 19:11:58', '2018-02-28 19:11:58'),
(1498, 318, 1479, 3, 3054, 0, 3900.000000, '{\"255\":\"3\"}', '2018-02-28 19:11:58', '2018-02-28 19:11:58'),
(1499, 318, 1480, 4, 932, 0, 920.000000, '{\"280\":\"4\"}', '2018-02-28 19:11:58', '2018-02-28 19:11:58'),
(1500, 318, 1481, 1, 200, 0, 230.000000, '{\"279\":\"1\"}', '2018-02-28 19:11:58', '2018-02-28 19:11:58'),
(1501, 319, 1482, 2, 368, 0, 488.505747, '{\"269\":\"2\"}', '2018-02-28 19:15:18', '2018-02-28 19:15:18'),
(1502, 319, 1483, 14, 1540, 0, 1641.379310, '{\"272\":\"14\"}', '2018-02-28 19:15:18', '2018-02-28 19:15:18'),
(1503, 319, 1484, 1, 1018, 0, 1270.114943, '{\"255\":\"1\"}', '2018-02-28 19:15:18', '2018-02-28 19:15:18'),
(1504, 320, 1485, 4, 6904, 0, 10522.627737, '{\"302\":\"4\"}', '2018-02-28 19:17:07', '2018-02-28 19:17:07'),
(1505, 320, 1486, 1, 3000, 0, 3077.372263, '{\"332\":\"1\"}', '2018-02-28 19:17:07', '2018-02-28 19:17:07'),
(1506, 321, 1487, 4, 4072, 0, 4800.000000, '{\"255\":\"4\"}', '2018-02-28 19:18:29', '2018-02-28 19:18:29'),
(1507, 322, 1488, 10, 5140, 0, 5500.000000, '{\"261\":\"10\"}', '2018-02-28 19:21:00', '2018-02-28 19:21:00'),
(1508, 322, 1489, 5, 3500, 0, 4000.000000, '{\"285\":\"5\"}', '2018-02-28 19:21:00', '2018-02-28 19:21:00');
INSERT INTO `inventory_sales_challan_item` (`id`, `fk_sales_challan_id`, `fk_sales_item_id`, `qty`, `cost_amount`, `small_qty`, `payable_amount`, `inventory_item_id`, `created_at`, `updated_at`) VALUES
(1509, 323, 1490, 4, 4072, 0, 5000.000000, '{\"255\":\"4\"}', '2018-02-28 19:25:04', '2018-02-28 19:25:04'),
(1510, 323, 1491, 40, 8000, 0, 9000.000000, '{\"279\":\"40\"}', '2018-02-28 19:25:04', '2018-02-28 19:25:04'),
(1511, 323, 1492, 14, 3262, 0, 3220.000000, '{\"280\":\"14\"}', '2018-02-28 19:25:04', '2018-02-28 19:25:04'),
(1512, 323, 1493, 3, 2100, 0, 2400.000000, '{\"285\":\"3\"}', '2018-02-28 19:25:04', '2018-02-28 19:25:04'),
(1513, 324, 1494, 3, 3150, 0, 3450.000000, '{\"298\":\"3\"}', '2018-02-28 19:27:53', '2018-02-28 19:27:53'),
(1514, 324, 1495, 1, 1149, 0, 1200.000000, '{\"337\":\"1\"}', '2018-02-28 19:27:53', '2018-02-28 19:27:53'),
(1515, 325, 1496, 8, 12904, 0, 14152.000000, '{\"296\":\"8\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1516, 325, 1497, 1, 2700, 0, 2900.000000, '{\"297\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1517, 325, 1498, 4, 1620, 0, 2000.000000, '{\"282\":\"4\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1518, 325, 1499, 3, 5178, 0, 5700.000000, '{\"302\":\"3\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1519, 325, 1500, 3, 2100, 0, 2700.000000, '{\"285\":\"3\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1520, 325, 1501, 3, 8550, 0, 10299.000000, '{\"329\":\"3\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1521, 325, 1502, 2, 3400, 0, 3900.000000, '{\"320\":\"2\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1522, 325, 1503, 1, 1700, 0, 3800.000000, '{\"320\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1523, 325, 1504, 8, 27200, 0, 28096.000000, '{\"315\":\"8\",\"333\":0}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1524, 325, 1505, 1, 300, 0, 400.000000, '{\"281\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1525, 325, 1506, 1, 310, 0, 250.000000, '{\"253\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1526, 325, 1507, 11, 16500, 0, 20350.000000, '{\"328\":\"11\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1527, 325, 1508, 2, 6000, 0, 6700.000000, '{\"247\":\"2\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1528, 325, 1509, 3, 9450, 0, 11700.000000, '{\"249\":\"3\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1529, 325, 1510, 1, 600, 0, 800.000000, '{\"283\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1530, 325, 1511, 11, 1210, 0, 2024.000000, '{\"272\":\"11\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1531, 325, 1512, 15, 15750, 0, 18210.000000, '{\"298\":\"15\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1532, 325, 1513, 3, 162, 0, 300.000000, '{\"287\":\"3\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1533, 325, 1514, 13, 15899, 0, 17953.000000, '{\"299\":\"13\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1534, 325, 1515, 2, 2298, 0, 3000.000000, '{\"337\":\"2\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1535, 325, 1516, 1, 1149, 0, 1200.000000, '{\"337\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1536, 325, 1517, 3, 5100, 0, 5301.000000, '{\"320\":\"3\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1537, 325, 1518, 4, 4072, 0, 6248.000000, '{\"255\":\"4\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1538, 325, 1519, 3, 9750, 0, 10902.000000, '{\"331\":\"3\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1539, 325, 1520, 2, 5800, 0, 6900.000000, '{\"248\":\"2\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1540, 325, 1521, 2, 5700, 0, 7400.000000, '{\"335\":\"2\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1541, 325, 1522, 2, 368, 0, 700.000000, '{\"269\":\"2\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1542, 325, 1523, 1, 2000, 0, 3900.000000, '{\"324\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1543, 325, 1524, 1, 335, 0, 650.000000, '{\"274\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1544, 325, 1525, 1, 200, 0, 500.000000, '{\"271\":\"1\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1545, 325, 1526, 6, 6894, 0, 9048.000000, '{\"337\":\"6\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1546, 325, 1527, 2, 4000, 0, 5300.000000, '{\"324\":\"2\"}', '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(1547, 326, 1528, 7, 2800, 0, 5600.000000, '{\"260\":\"7\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1548, 326, 1529, 8, 13450, 0, 13896.000000, '{\"320\":\"5\",\"323\":3}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1549, 326, 1530, 3, 9150, 0, 10500.000000, '{\"325\":\"3\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1550, 326, 1531, 3, 4500, 0, 5700.000000, '{\"328\":\"3\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1551, 326, 1532, 2, 500, 0, 900.000000, '{\"275\":\"2\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1552, 326, 1533, 10, 10500, 0, 12500.000000, '{\"298\":\"10\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1553, 326, 1534, 1, 3200, 0, 3700.000000, '{\"250\":\"1\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1554, 326, 1535, 8, 2400, 0, 2600.000000, '{\"281\":\"8\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1555, 326, 1536, 5, 2025, 0, 2500.000000, '{\"282\":\"5\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1556, 326, 1537, 1, 2900, 0, 3400.000000, '{\"248\":\"1\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1557, 326, 1538, 2, 4000, 0, 5400.000000, '{\"324\":\"2\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1558, 326, 1539, 5, 5500, 0, 6900.000000, '{\"262\":\"5\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1559, 326, 1540, 1, 793, 0, 1200.000000, '{\"290\":\"1\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1560, 326, 1541, 14, 22582, 0, 24696.000000, '{\"296\":\"14\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1561, 326, 1542, 6, 7338, 0, 7998.000000, '{\"299\":\"6\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1562, 326, 1543, 2, 942, 0, 1700.000000, '{\"252\":\"2\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1563, 326, 1544, 1, 1799, 0, 2500.000000, '{\"263\":\"1\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1564, 326, 1545, 5, 1550, 0, 2350.000000, '{\"253\":\"5\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1565, 326, 1546, 3, 54, 0, 300.000000, '{\"267\":\"3\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1566, 326, 1547, 12, 2400, 0, 5652.000000, '{\"271\":\"12\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1567, 326, 1548, 19, 19342, 0, 29507.000000, '{\"255\":\"19\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1568, 326, 1549, 9, 10341, 0, 14202.000000, '{\"337\":\"9\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1569, 326, 1550, 27, 2970, 0, 4401.000000, '{\"272\":\"27\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1570, 326, 1551, 4, 2400, 0, 3600.000000, '{\"283\":\"4\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1571, 326, 1552, 2, 6300, 0, 7000.000000, '{\"249\":\"2\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1572, 326, 1553, 1, 1149, 0, 1200.000000, '{\"337\":\"1\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1573, 326, 1554, 1, 3000, 0, 3500.000000, '{\"332\":\"1\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1574, 326, 1555, 5, 920, 0, 1400.000000, '{\"269\":\"5\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1575, 326, 1556, 1, 2900, 0, 3300.000000, '{\"248\":\"1\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1576, 326, 1557, 3, 3447, 0, 4299.000000, '{\"337\":\"3\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1577, 326, 1558, 2, 2000, 0, 2700.000000, '{\"284\":\"2\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1578, 326, 1559, 2, 1400, 0, 1900.000000, '{\"285\":\"2\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1579, 326, 1560, 2, 1028, 0, 1700.000000, '{\"261\":\"2\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1580, 326, 1561, 2, 368, 0, 500.000000, '{\"269\":\"2\"}', '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(1581, 327, 1562, 16, 11200, 0, 14496.000000, '{\"285\":\"16\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1582, 327, 1563, 1, 50, 0, 100.000000, '{\"266\":\"1\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1583, 327, 1564, 76, 8360, 0, 16264.000000, '{\"272\":\"76\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1584, 327, 1565, 16, 4800, 0, 5264.000000, '{\"281\":\"16\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1585, 327, 1566, 10, 4050, 0, 5250.000000, '{\"282\":\"10\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1586, 327, 1567, 6, 6894, 0, 7500.000000, '{\"337\":\"6\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1587, 327, 1568, 17, 8007, 0, 15657.000000, '{\"252\":\"17\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1588, 327, 1569, 2, 20, 0, 250.000000, '{\"268\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1589, 327, 1570, 2, 3452, 0, 4000.000000, '{\"302\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1590, 327, 1571, 8, 12904, 0, 13752.000000, '{\"296\":\"8\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1591, 327, 1572, 55, 14410, 0, 24255.000000, '{\"270\":\"55\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1592, 327, 1573, 40, 7360, 0, 11760.000000, '{\"269\":\"40\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1593, 327, 1574, 12, 4020, 0, 7200.000000, '{\"274\":\"12\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1594, 327, 1575, 3, 1542, 0, 3000.000000, '{\"261\":\"3\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1595, 327, 1576, 14, 11102, 0, 14196.000000, '{\"290\":\"14\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1596, 327, 1577, 4, 12800, 0, 14400.000000, '{\"333\":\"4\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1597, 327, 1578, 10, 12000, 0, 18200.000000, '{\"293\":\"10\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1598, 327, 1579, 2, 4200, 0, 4500.000000, '{\"336\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1599, 327, 1580, 2, 6500, 0, 7000.000000, '{\"331\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1600, 327, 1581, 1, 1100, 0, 1300.000000, '{\"262\":\"1\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1601, 327, 1582, 2, 5800, 0, 6700.000000, '{\"248\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1602, 327, 1583, 2, 2500, 0, 3550.000000, '{\"256\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1603, 327, 1584, 8, 4400, 0, 4944.000000, '{\"294\":\"8\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1604, 327, 1585, 1, 2950, 0, 3300.000000, '{\"330\":\"1\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1605, 327, 1586, 3, 7650, 0, 8301.000000, '{\"251\":\"3\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1606, 327, 1587, 10, 11000, 0, 15600.000000, '{\"262\":\"10\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1607, 327, 1588, 2, 3000, 0, 3500.000000, '{\"328\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1608, 327, 1589, 1, 793, 0, 1500.000000, '{\"290\":\"1\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1609, 327, 1590, 6, 1500, 0, 2046.000000, '{\"278\":\"6\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1610, 327, 1591, 26, 26468, 0, 41002.000000, '{\"255\":\"26\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1611, 327, 1592, 28, 1512, 0, 79800.000000, '{\"287\":\"28\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1612, 327, 1593, 16, 9600, 0, 13952.000000, '{\"283\":\"16\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1613, 327, 1594, 3, 3150, 0, 3498.000000, '{\"298\":\"3\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1614, 327, 1595, 17, 5270, 0, 10744.000000, '{\"253\":\"17\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1615, 327, 1596, 4, 11400, 0, 12800.000000, '{\"329\":\"4\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1616, 327, 1597, 5, 1250, 0, 2350.000000, '{\"275\":\"5\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1617, 327, 1598, 7, 19982, 0, 23646.000000, '{\"248\":\"1\",\"334\":6}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1618, 327, 1599, 3, 3669, 0, 4041.000000, '{\"299\":\"3\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1619, 327, 1600, 12, 2400, 0, 3408.000000, '{\"279\":\"12\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1620, 327, 1601, 2, 2000, 0, 2400.000000, '{\"284\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1621, 327, 1602, 2, 944, 0, 1600.000000, '{\"286\":\"2\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1622, 327, 1603, 6, 2010, 0, 4998.000000, '{\"274\":\"6\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1623, 327, 1604, 5, 920, 0, 1550.000000, '{\"269\":\"5\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1624, 327, 1605, 5, 1000, 0, 1950.000000, '{\"259\":\"5\"}', '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(1625, 328, 1606, 18, 1980, 0, 2970.000000, '{\"272\":\"18\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1626, 328, 1607, 3, 2379, 0, 2499.000000, '{\"290\":\"3\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1627, 328, 1608, 1, 1300, 0, 1600.000000, '{\"304\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1628, 328, 1609, 5, 8065, 0, 8500.000000, '{\"296\":\"5\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1629, 328, 1610, 4, 1240, 0, 2000.000000, '{\"253\":\"4\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1630, 328, 1611, 1, 1223, 0, 1300.000000, '{\"299\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1631, 328, 1612, 4, 4596, 0, 5200.000000, '{\"337\":\"4\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1632, 328, 1613, 1, 2100, 0, 2900.000000, '{\"303\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1633, 328, 1614, 4, 10200, 0, 13500.000000, '{\"251\":\"4\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1634, 328, 1615, 2, 3600, 0, 4100.000000, '{\"306\":\"2\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1635, 328, 1616, 1, 1295, 0, 1600.000000, '{\"322\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1636, 328, 1617, 4, 7600, 0, 9700.000000, '{\"327\":\"4\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1637, 328, 1618, 32, 5888, 0, 8064.000000, '{\"269\":\"32\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1638, 328, 1619, 18, 18324, 0, 27342.000000, '{\"255\":\"18\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1639, 328, 1620, 2, 3500, 0, 4800.000000, '{\"317\":\"2\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1640, 328, 1621, 8, 3240, 0, 4504.000000, '{\"282\":\"8\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1641, 328, 1622, 30, 6000, 0, 13800.000000, '{\"271\":\"30\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1642, 328, 1623, 20, 6700, 0, 11460.000000, '{\"274\":\"20\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1643, 328, 1624, 1, 2900, 0, 3200.000000, '{\"342\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1644, 328, 1625, 19, 4427, 0, 6764.000000, '{\"280\":\"19\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1645, 328, 1626, 1, 2847, 0, 3000.000000, '{\"334\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1646, 328, 1627, 1, 2250, 0, 3000.000000, '{\"347\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1647, 328, 1628, 26, 1404, 0, 2730.000000, '{\"287\":\"26\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1648, 328, 1629, 7, 4200, 0, 6552.000000, '{\"283\":\"7\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1649, 328, 1630, 4, 1200, 0, 1200.000000, '{\"281\":\"4\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1650, 328, 1631, 6, 1500, 0, 2148.000000, '{\"278\":\"6\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1651, 328, 1632, 13, 2600, 0, 4108.000000, '{\"279\":\"13\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1652, 328, 1633, 2, 1400, 0, 1950.000000, '{\"285\":\"2\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1653, 328, 1634, 9, 9450, 0, 11052.000000, '{\"298\":\"9\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1654, 328, 1635, 3, 600, 0, 999.000000, '{\"259\":\"3\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1655, 328, 1636, 2, 3100, 0, 4300.000000, '{\"316\":\"2\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1656, 328, 1637, 5, 2360, 0, 17000.000000, '{\"286\":\"5\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1657, 328, 1638, 2, 4000, 0, 5000.000000, '{\"305\":\"2\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1658, 328, 1639, 10, 900, 0, 1780.000000, '{\"273\":\"10\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1659, 328, 1640, 5, 7510, 0, 9100.000000, '{\"328\":\"4\",\"351\":1}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1660, 328, 1641, 1, 3000, 0, 3300.000000, '{\"344\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1661, 328, 1642, 2, 36, 0, 200.000000, '{\"267\":\"2\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1662, 328, 1643, 7, 12082, 0, 14000.000000, '{\"302\":\"7\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1663, 328, 1644, 2, 1028, 0, 1600.000000, '{\"261\":\"2\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1664, 328, 1645, 4, 1048, 0, 1800.000000, '{\"270\":\"4\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1665, 328, 1646, 1, 1650, 0, 1800.000000, '{\"323\":\"1\"}', '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(1666, 329, 1647, 5, 5250, 0, 5150.000000, '{\"298\":\"5\"}', '2018-03-04 01:04:33', '2018-03-04 01:04:33'),
(1667, 330, 1648, 5, 5090, 0, 6500.000000, '{\"255\":\"5\"}', '2018-03-04 01:07:46', '2018-03-04 01:07:46'),
(1668, 331, 1649, 140, 28000, 0, 28000.000000, '{\"100\":\"140\"}', '2018-03-04 16:58:34', '2018-03-04 16:58:34'),
(1669, 331, 1650, 20, 3200, 0, 2800.000000, '{\"219\":\"20\"}', '2018-03-04 16:58:34', '2018-03-04 16:58:34'),
(1670, 331, 1651, 48, 12000, 0, 12000.000000, '{\"103\":\"48\"}', '2018-03-04 16:58:34', '2018-03-04 16:58:34'),
(1671, 331, 1652, 1, 1200, 0, 1200.000000, '{\"197\":\"1\"}', '2018-03-04 16:58:34', '2018-03-04 16:58:34'),
(1672, 331, 1653, 5, 600, 0, 600.000000, '{\"356\":\"5\"}', '2018-03-04 16:58:34', '2018-03-04 16:58:34'),
(1673, 332, 1654, 190, 184480, 0, 172900.000000, '{\"194\":\"23\",\"218\":\"19\",\"355\":148}', '2018-03-04 17:06:46', '2018-03-04 17:06:46'),
(1674, 333, 1655, 2, 3900, 0, 3900.000000, '{\"236\":\"2\"}', '2018-03-04 17:16:43', '2018-03-04 17:16:43'),
(1675, 333, 1656, 1, 2250, 0, 2250.000000, '{\"354\":\"1\"}', '2018-03-04 17:16:43', '2018-03-04 17:16:43'),
(1676, 333, 1657, 160, 145600, 0, 145600.000000, '{\"355\":\"160\"}', '2018-03-04 17:16:43', '2018-03-04 17:16:43'),
(1685, 335, 1429, 1, 2700, 0, 3500.000000, '{\"311\":\"1\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1686, 335, 1430, 1, 1650, 0, 2000.000000, '{\"323\":\"1\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1687, 335, 1431, 1, 200, 0, 400.000000, '{\"259\":\"1\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1688, 335, 1432, 3, 3750, 0, 6201.000000, '{\"319\":\"3\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1689, 335, 1433, 3, 750, 0, 1449.000000, '{\"275\":\"3\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1690, 335, 1434, 3, 8250, 0, 8799.000000, '{\"312\":\"3\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1691, 335, 1435, 3, 6300, 0, 6501.000000, '{\"336\":\"3\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1692, 335, 1436, 3, 9750, 0, 11598.000000, '{\"331\":\"3\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1693, 335, 1437, 2, 5900, 0, 7200.000000, '{\"330\":\"2\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1694, 335, 1438, 5, 16000, 0, 20000.000000, '{\"333\":\"5\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1695, 335, 1439, 3, 4530, 0, 5700.000000, '{\"351\":\"3\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1696, 335, 1440, 1, 3550, 0, 4100.000000, '{\"313\":\"1\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1697, 335, 1441, 2, 5600, 0, 6400.000000, '{\"314\":\"2\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1698, 335, 1442, 1, 2600, 0, 2700.000000, '{\"308\":\"1\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1699, 335, 1443, 1, 2000, 0, 2600.000000, '{\"324\":\"1\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1700, 335, 1444, 3, 7500, 0, 9801.000000, '{\"309\":\"3\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1701, 335, 1445, 2, 3800, 0, 4700.000000, '{\"318\":\"2\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1702, 335, 1446, 1, 3000, 0, 3150.000000, '{\"332\":\"1\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1703, 335, 1447, 3, 9900, 0, 11499.000000, '{\"310\":\"3\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1704, 335, 1448, 3, 9450, 0, 12300.000000, '{\"249\":\"3\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1705, 335, 1449, 5, 9000, 0, 11300.000000, '{\"306\":\"5\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1706, 335, 1450, 1, 1750, 0, 2150.000000, '{\"317\":\"1\"}', '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(1707, 336, 1383, 4, 736, 0, 1300.000000, '{\"269\":\"4\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1708, 336, 1384, 26, 1404, 0, 2574.000000, '{\"287\":\"26\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1709, 336, 1385, 16, 7536, 0, 14048.000000, '{\"252\":\"16\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1710, 336, 1386, 3, 900, 0, 900.000000, '{\"281\":\"3\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1711, 336, 1387, 1, 405, 0, 500.000000, '{\"282\":\"1\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1712, 336, 1388, 60, 15720, 0, 26640.000000, '{\"270\":\"60\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1713, 336, 1389, 2, 400, 0, 1000.000000, '{\"271\":\"2\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1714, 336, 1390, 24, 8040, 0, 14640.000000, '{\"274\":\"24\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1715, 336, 1393, 24, 5592, 0, 8760.000000, '{\"280\":\"24\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1716, 336, 1394, 21, 12600, 0, 18102.000000, '{\"283\":\"21\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1717, 336, 1395, 5, 5250, 0, 6100.000000, '{\"298\":\"5\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1718, 336, 1396, 4, 4596, 0, 5652.000000, '{\"337\":\"4\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1719, 336, 1397, 5, 10000, 0, 12300.000000, '{\"305\":\"5\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1720, 336, 1398, 1, 4000, 0, 5000.000000, '{\"300\":\"1\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1721, 336, 1399, 25, 5000, 0, 8950.000000, '{\"279\":\"25\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1722, 336, 1400, 40, 4400, 0, 8320.000000, '{\"272\":\"40\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1723, 336, 1401, 33, 10230, 0, 16500.000000, '{\"253\":\"33\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1724, 336, 1402, 9, 6300, 0, 8046.000000, '{\"285\":\"9\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1725, 336, 1403, 50, 9200, 0, 15250.000000, '{\"269\":\"50\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1726, 336, 1404, 5, 250, 0, 600.000000, '{\"266\":\"5\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1727, 336, 1405, 1, 3200, 0, 3500.000000, '{\"333\":\"1\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1728, 336, 1406, 3, 900, 0, 1299.000000, '{\"257\":\"3\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1729, 336, 1407, 1, 1200, 0, 1900.000000, '{\"293\":\"1\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1730, 336, 1408, 1, 1295, 0, 1600.000000, '{\"322\":\"1\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1731, 336, 1409, 4, 5200, 0, 6900.000000, '{\"304\":\"4\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1732, 336, 1410, 6, 1500, 0, 2202.000000, '{\"278\":\"6\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1733, 336, 1411, 2, 1028, 0, 1700.000000, '{\"261\":\"2\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1734, 336, 1412, 10, 7930, 0, 9100.000000, '{\"290\":\"10\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1735, 336, 1413, 4, 5000, 0, 7100.000000, '{\"256\":\"4\"}', '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(1736, 337, 1658, 19, 342, 0, 1425.000000, '{\"267\":\"19\"}', '2018-03-04 21:42:03', '2018-03-04 21:42:03'),
(1737, 339, 1659, 3, 3186, 0, 3750.000000, '{\"358\":\"3\"}', '2018-03-04 21:53:46', '2018-03-04 21:53:46'),
(1738, 339, 1660, 2, 2124, 0, 2200.000000, '{\"358\":\"2\"}', '2018-03-04 21:53:46', '2018-03-04 21:53:46'),
(1739, 339, 1661, 5, 6475, 0, 7000.000000, '{\"322\":\"5\"}', '2018-03-04 21:53:46', '2018-03-04 21:53:46'),
(1740, 340, 1662, 23, 24150, 0, 25980.000000, '{\"298\":\"23\"}', '2018-03-05 00:38:14', '2018-03-05 00:38:14'),
(1741, 341, 1663, 1, 300, 0, 300.000000, '{\"281\":\"1\"}', '2018-03-05 00:58:33', '2018-03-05 00:58:33'),
(1742, 341, 1664, 6, 6300, 0, 6954.000000, '{\"298\":\"6\"}', '2018-03-05 00:58:33', '2018-03-05 00:58:33'),
(1743, 341, 1665, 1, 233, 0, 350.000000, '{\"280\":\"1\"}', '2018-03-05 00:58:33', '2018-03-05 00:58:33'),
(1744, 341, 1666, 4, 800, 0, 1900.000000, '{\"271\":\"4\"}', '2018-03-05 00:58:33', '2018-03-05 00:58:33'),
(1745, 341, 1667, 2, 180, 0, 400.000000, '{\"273\":\"2\"}', '2018-03-05 00:58:33', '2018-03-05 00:58:33'),
(1746, 341, 1668, 1, 110, 0, 250.000000, '{\"272\":\"1\"}', '2018-03-05 00:58:33', '2018-03-05 00:58:33'),
(1747, 341, 1669, 3, 1005, 0, 1698.000000, '{\"274\":\"3\"}', '2018-03-05 00:58:33', '2018-03-05 00:58:33'),
(1748, 341, 1670, 2, 108, 0, 200.000000, '{\"287\":\"2\"}', '2018-03-05 00:58:33', '2018-03-05 00:58:33'),
(1749, 341, 1671, 1, 514, 0, 800.000000, '{\"261\":\"1\"}', '2018-03-05 00:58:33', '2018-03-05 00:58:33'),
(1750, 341, 1672, 1, 472, 0, 700.000000, '{\"286\":\"1\"}', '2018-03-05 00:58:33', '2018-03-05 00:58:33'),
(1751, 341, 1673, 1, 600, 0, 900.000000, '{\"283\":\"1\"}', '2018-03-05 00:58:33', '2018-03-05 00:58:33'),
(1752, 341, 1674, 1, 2250, 0, 2500.000000, '{\"347\":\"1\"}', '2018-03-05 00:58:33', '2018-03-05 00:58:33'),
(1753, 342, 1675, 1, 150, 0, 300.000000, '{\"101\":\"1\"}', '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(1754, 342, 1676, 2, 1328, 0, 1600.000000, '{\"217\":\"2\"}', '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(1755, 342, 1677, 1, 1035, 0, 1300.000000, '{\"212\":\"1\"}', '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(1756, 342, 1678, 2, 452, 0, 600.000000, '{\"220\":\"2\"}', '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(1757, 342, 1679, 1, 410, 0, 500.000000, '{\"222\":\"1\"}', '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(1758, 342, 1680, 8, 720, 0, 960.000000, '{\"104\":\"8\"}', '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(1759, 342, 1681, 1, 410, 0, 600.000000, '{\"222\":\"1\"}', '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(1760, 343, 1682, 3, 480, 0, 549.000000, '{\"219\":\"3\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1761, 343, 1683, 1, 550, 0, 300.000000, '{\"206\":\"1\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1762, 343, 1684, 1, 250, 0, 400.000000, '{\"103\":\"1\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1763, 343, 1685, 2, 400, 0, 630.000000, '{\"100\":\"2\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1764, 343, 1686, 1, 175, 0, 500.000000, '{\"112\":\"1\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1765, 343, 1687, 3, 258, 0, 300.000000, '{\"208\":\"3\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1766, 343, 1688, 1, 226, 0, 300.000000, '{\"220\":\"1\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1767, 343, 1689, 2, 600, 0, 700.000000, '{\"114\":\"2\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1768, 343, 1690, 2, 430, 0, 700.000000, '{\"232\":\"2\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1769, 343, 1691, 1, 410, 0, 450.000000, '{\"222\":\"1\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1770, 343, 1692, 2, 452, 0, 600.000000, '{\"220\":\"2\"}', '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(1771, 344, 1693, 1, 1450, 0, 1500.000000, '{\"201\":\"1\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1772, 344, 1694, 1, 160, 0, 450.000000, '{\"219\":\"1\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1773, 344, 1695, 4, 1200, 0, 1500.000000, '{\"114\":\"4\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1774, 344, 1696, 1, 410, 0, 600.000000, '{\"222\":\"1\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1775, 344, 1697, 1, 86, 0, 100.000000, '{\"208\":\"1\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1776, 344, 1698, 1, 90, 0, 180.000000, '{\"104\":\"1\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1777, 344, 1699, 2, 452, 0, 600.000000, '{\"220\":\"2\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1778, 344, 1700, 2, 172, 0, 200.000000, '{\"208\":\"2\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1779, 344, 1701, 6, 1356, 0, 1752.000000, '{\"220\":\"6\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1780, 344, 1702, 4, 640, 0, 700.000000, '{\"219\":\"4\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1781, 344, 1703, 1, 712, 0, 800.000000, '{\"211\":\"1\"}', '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(1782, 345, 1704, 3, 600, 0, 900.000000, '{\"100\":\"3\"}', '2018-03-05 16:32:20', '2018-03-05 16:32:20'),
(1783, 345, 1705, 1, 175, 0, 400.000000, '{\"112\":\"1\"}', '2018-03-05 16:32:20', '2018-03-05 16:32:20'),
(1784, 345, 1706, 1, 226, 0, 300.000000, '{\"220\":\"1\"}', '2018-03-05 16:32:20', '2018-03-05 16:32:20'),
(1785, 345, 1707, 1, 410, 0, 600.000000, '{\"222\":\"1\"}', '2018-03-05 16:32:20', '2018-03-05 16:32:20'),
(1786, 346, 1708, 1, 1100, 0, 1300.000000, '{\"133\":\"1\"}', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(1787, 346, 1709, 1, 314, 0, 300.000000, '{\"221\":\"1\"}', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(1788, 346, 1710, 1, 215, 0, 300.000000, '{\"232\":\"1\"}', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(1789, 346, 1711, 2, 172, 0, 200.000000, '{\"208\":\"2\"}', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(1790, 346, 1712, 3, 1992, 0, 2700.000000, '{\"217\":\"3\"}', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(1791, 346, 1713, 4, 1640, 0, 1948.000000, '{\"222\":\"4\"}', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(1792, 346, 1714, 3, 1650, 0, 999.000000, '{\"206\":\"3\"}', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(1793, 346, 1715, 1, 1450, 0, 1450.000000, '{\"201\":\"1\"}', '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(1794, 347, 1716, 12, 3768, 0, 4188.445667, '{\"221\":\"12\"}', '2018-03-05 16:57:45', '2018-03-05 16:57:45'),
(1795, 347, 1717, 12, 1080, 0, 1316.368638, '{\"104\":\"12\"}', '2018-03-05 16:57:45', '2018-03-05 16:57:45'),
(1796, 347, 1718, 7, 1400, 0, 1745.185695, '{\"100\":\"7\"}', '2018-03-05 16:57:45', '2018-03-05 16:57:45'),
(1797, 348, 1719, 6, 1200, 0, 1500.000000, '{\"100\":\"6\"}', '2018-03-05 17:03:42', '2018-03-05 17:03:42'),
(1798, 348, 1720, 4, 860, 0, 1000.000000, '{\"232\":\"4\"}', '2018-03-05 17:03:42', '2018-03-05 17:03:42'),
(1799, 348, 1721, 1, 160, 0, 120.000000, '{\"219\":\"1\"}', '2018-03-05 17:03:42', '2018-03-05 17:03:42'),
(1800, 349, 1722, 5, 4550, 0, 5100.000000, '{\"355\":\"5\"}', '2018-03-05 17:09:19', '2018-03-05 17:09:19'),
(1801, 349, 1723, 1, 1120, 0, 1300.000000, '{\"227\":\"1\"}', '2018-03-05 17:09:19', '2018-03-05 17:09:19'),
(1802, 349, 1724, 1, 1120, 0, 1400.000000, '{\"227\":\"1\"}', '2018-03-05 17:09:19', '2018-03-05 17:09:19'),
(1803, 349, 1725, 11, 1232, 0, 1100.000000, '{\"207\":\"11\"}', '2018-03-05 17:09:19', '2018-03-05 17:09:19'),
(1804, 350, 1726, 3, 3360, 0, 3667.164179, '{\"227\":\"3\"}', '2018-03-05 17:12:09', '2018-03-05 17:12:09'),
(1805, 350, 1727, 2, 2240, 0, 2632.835821, '{\"227\":\"2\"}', '2018-03-05 17:12:09', '2018-03-05 17:12:09'),
(1806, 351, 1728, 1, 160, 0, 150.000000, '{\"219\":\"1\"}', '2018-04-01 05:14:14', '2018-04-01 05:14:14'),
(1807, 352, 1729, 1, 2847, 0, 3000.000000, '{\"334\":\"1\"}', '2020-10-02 14:54:49', '2020-10-02 14:54:49'),
(1808, 353, 1730, 1, 3200, 0, 4000.000000, '{\"250\":\"1\"}', '2020-10-02 14:55:43', '2020-10-02 14:55:43');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_sales_delivery_challan`
--

CREATE TABLE `inventory_sales_delivery_challan` (
  `id` int(11) NOT NULL,
  `fk_sales_id` int(11) UNSIGNED NOT NULL,
  `challan_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `shipping_address` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_amount` decimal(17,6) NOT NULL,
  `received_date` date NOT NULL,
  `created_by` int(11) UNSIGNED NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_sales_delivery_challan`
--

INSERT INTO `inventory_sales_delivery_challan` (`id`, `fk_sales_id`, `challan_id`, `shipping_address`, `total_amount`, `received_date`, `created_by`, `status`, `created_at`, `updated_at`) VALUES
(23, 23, '0302181', '', 12550.000000, '2017-07-09', 4, 1, '2018-02-03 14:29:59', '2018-02-03 14:29:59'),
(24, 24, '03021824', '', 4000.000000, '2017-07-12', 4, 1, '2018-02-03 15:09:35', '2018-02-03 15:09:35'),
(25, 25, '03021825', '', 20870.000000, '2017-07-10', 4, 1, '2018-02-03 15:28:38', '2018-02-03 15:28:38'),
(26, 26, '03021826', '', 223800.000000, '2017-08-01', 4, 1, '2018-02-03 17:32:04', '2018-02-03 17:32:04'),
(27, 32, '04021827', '', 23900.000000, '2017-07-02', 4, 1, '2018-02-04 10:06:04', '2018-02-04 10:06:04'),
(28, 34, '04021828', '', 13450.000000, '2017-07-05', 4, 1, '2018-02-04 11:07:09', '2018-02-04 11:07:09'),
(29, 35, '04021829', '', 157800.000000, '2017-08-14', 4, 1, '2018-02-04 11:19:36', '2018-02-04 11:19:36'),
(30, 36, '04021830', '', 87000.000000, '2017-09-23', 4, 1, '2018-02-04 11:35:41', '2018-02-04 11:35:41'),
(32, 45, '04021831', '', 1400.000000, '2017-07-12', 4, 1, '2018-02-04 16:36:24', '2018-02-04 16:36:24'),
(33, 46, '04021833', '', 18050.000000, '2017-07-18', 4, 1, '2018-02-04 16:44:22', '2018-02-04 16:44:22'),
(34, 47, '04021834', '', 2260.000000, '2017-07-19', 4, 1, '2018-02-04 16:50:08', '2018-02-10 15:31:43'),
(35, 48, '04021835', '', 16500.000000, '2017-07-21', 4, 1, '2018-02-04 17:01:14', '2018-02-04 17:01:14'),
(36, 49, '04021836', '', 16200.000000, '2017-07-21', 4, 1, '2018-02-04 17:04:08', '2018-02-04 17:04:08'),
(37, 50, '04021837', '', 1040.000000, '2017-07-22', 4, 1, '2018-02-04 17:06:46', '2018-02-04 17:06:46'),
(38, 51, '04021838', '', 10400.000000, '2017-07-28', 4, 1, '2018-02-04 17:35:40', '2018-02-04 17:35:40'),
(39, 52, '05021839', '', 110000.000000, '2018-02-05', 4, 1, '2018-02-05 14:25:45', '2018-02-05 14:25:45'),
(40, 53, '05021840', '', 1773543.000000, '2017-09-08', 4, 1, '2018-02-05 17:11:32', '2018-02-05 17:11:32'),
(41, 54, '05021841', '', 1706695.000000, '2017-09-09', 4, 1, '2018-02-05 19:11:08', '2018-02-05 19:11:08'),
(42, 55, '06021842', '', 140600.000000, '2017-09-09', 4, 1, '2018-02-06 11:06:26', '2018-02-06 11:06:26'),
(43, 56, '06021843', '', 881991.000000, '2017-09-10', 4, 1, '2018-02-06 12:45:52', '2018-02-06 12:45:52'),
(44, 57, '06021844', '', 5600.000000, '2017-09-15', 4, 1, '2018-02-06 14:10:38', '2018-02-06 14:10:38'),
(45, 58, '06021845', '', 6700.000000, '2017-09-19', 4, 1, '2018-02-06 14:15:06', '2018-02-06 14:15:06'),
(46, 59, '06021846', '', 5600.000000, '2017-09-22', 4, 1, '2018-02-06 14:17:32', '2018-02-06 14:17:32'),
(47, 60, '06021847', '', 2800.000000, '2017-09-23', 4, 1, '2018-02-06 14:20:00', '2018-02-06 14:20:00'),
(48, 61, '06021848', '', 26350.000000, '2017-10-08', 4, 1, '2018-02-06 14:36:11', '2018-02-06 14:36:11'),
(49, 62, '06021849', '', 16500.000000, '2017-09-25', 4, 1, '2018-02-06 14:46:29', '2018-02-06 14:46:29'),
(50, 63, '06021850', '', 23150.000000, '2017-09-26', 4, 1, '2018-02-06 15:00:31', '2018-02-06 15:00:31'),
(51, 64, '06021851', '', 115208.000000, '2017-09-26', 4, 1, '2018-02-06 15:47:30', '2018-02-06 15:47:30'),
(52, 65, '06021852', '', 13800.000000, '2017-09-29', 4, 1, '2018-02-06 15:57:12', '2018-02-06 15:57:12'),
(53, 66, '06021853', '', 13800.000000, '2017-09-29', 4, 1, '2018-02-06 15:59:50', '2018-02-06 15:59:50'),
(54, 67, '06021854', '', 8100.000000, '2017-09-29', 4, 1, '2018-02-06 16:01:43', '2018-02-06 16:01:43'),
(55, 68, '06021855', '', 4900.000000, '2017-09-30', 4, 1, '2018-02-06 16:07:23', '2018-02-06 16:07:23'),
(56, 69, '06021856', '', 2600.000000, '2017-09-30', 4, 1, '2018-02-06 16:09:32', '2018-02-06 16:09:32'),
(57, 70, '06021857', '', 47360.000000, '2017-10-03', 4, 1, '2018-02-06 16:25:10', '2018-02-06 16:25:10'),
(58, 71, '06021858', '', 7700.000000, '2017-10-03', 4, 1, '2018-02-06 16:31:48', '2018-02-06 16:31:48'),
(59, 72, '06021859', '', 7650.000000, '2017-10-03', 4, 1, '2018-02-06 16:34:30', '2018-02-06 16:34:30'),
(60, 73, '06021860', '', 5150.000000, '2017-10-04', 4, 1, '2018-02-06 16:37:39', '2018-02-06 16:37:39'),
(61, 74, '06021861', '', 5400.000000, '2017-10-04', 4, 1, '2018-02-06 16:40:14', '2018-02-06 16:40:14'),
(62, 75, '06021862', '', 2450.000000, '2017-10-04', 4, 1, '2018-02-06 16:42:20', '2018-02-06 16:42:20'),
(63, 76, '06021863', '', 1780.000000, '2017-10-06', 4, 1, '2018-02-06 16:44:57', '2018-02-06 16:44:57'),
(64, 77, '06021864', '', 900.000000, '2017-10-11', 4, 1, '2018-02-06 16:49:44', '2018-02-06 16:49:44'),
(65, 78, '06021865', '', 750.000000, '2017-10-14', 4, 1, '2018-02-06 16:52:04', '2018-02-06 16:52:04'),
(66, 79, '06021866', '', 5700.000000, '2017-10-20', 4, 1, '2018-02-06 16:53:58', '2018-02-06 16:53:58'),
(67, 80, '06021867', '', 11800.000000, '2017-10-22', 4, 1, '2018-02-06 16:56:09', '2018-02-06 16:56:09'),
(68, 81, '06021868', '', 80570.000000, '2017-10-23', 4, 1, '2018-02-06 17:07:18', '2018-02-06 17:07:18'),
(69, 82, '06021869', '', 3330.000000, '2017-10-27', 4, 1, '2018-02-06 17:12:21', '2018-02-06 17:12:21'),
(70, 83, '06021870', '', 8700.000000, '2017-10-30', 4, 1, '2018-02-06 17:14:51', '2018-02-06 17:14:51'),
(71, 84, '06021871', '', 186000.000000, '2017-10-30', 4, 1, '2018-02-06 17:19:15', '2018-02-06 17:19:15'),
(72, 85, '06021872', '', 16500.000000, '2017-11-01', 4, 1, '2018-02-06 18:06:12', '2018-02-06 18:06:12'),
(73, 86, '06021873', '', 350.000000, '2017-11-04', 4, 1, '2018-02-06 18:08:02', '2018-02-06 18:08:02'),
(74, 87, '06021874', '', 106100.000000, '2017-11-07', 4, 1, '2018-02-06 18:31:00', '2018-02-06 18:31:00'),
(75, 88, '06021875', '', 78300.000000, '2017-11-07', 4, 1, '2018-02-06 18:42:49', '2018-02-06 18:42:49'),
(76, 89, '06021876', '', 3950.000000, '2017-11-08', 4, 1, '2018-02-06 18:46:25', '2018-02-06 18:46:25'),
(77, 90, '06021877', '', 4120.000000, '2017-11-08', 4, 1, '2018-02-06 18:50:59', '2018-02-06 18:50:59'),
(78, 91, '07021878', '', 3400.000000, '2017-11-10', 4, 1, '2018-02-07 11:19:41', '2018-02-07 11:19:41'),
(79, 92, '07021879', '', 4200.000000, '2017-11-12', 4, 1, '2018-02-07 11:25:43', '2018-02-07 11:25:43'),
(80, 93, '07021880', '', 0.000000, '2017-07-02', 4, 1, '2018-02-07 11:52:18', '2018-02-07 15:17:57'),
(81, 94, '07021881', '', 0.000000, '2017-07-05', 4, 1, '2018-02-07 11:57:23', '2018-02-07 15:18:54'),
(82, 95, '07021882', '', 50100.000000, '2017-07-08', 4, 1, '2018-02-07 12:04:20', '2018-02-07 12:04:20'),
(83, 96, '07021883', '', 31500.000000, '2017-07-14', 4, 1, '2018-02-07 12:32:20', '2018-02-07 12:32:20'),
(84, 97, '07021884', '', 42550.000000, '2017-07-23', 4, 1, '2018-02-07 12:42:37', '2018-02-07 12:42:37'),
(85, 98, '07021885', '', 37300.000000, '2017-07-23', 4, 1, '2018-02-07 12:58:50', '2018-02-07 12:58:50'),
(86, 99, '07021886', '', 16000.000000, '2017-07-28', 4, 1, '2018-02-07 13:02:18', '2018-02-07 13:02:18'),
(87, 100, '07021887', '', 16000.000000, '2017-07-30', 4, 1, '2018-02-07 13:05:44', '2018-02-07 15:14:00'),
(88, 101, '07021888', '', 29850.000000, '2017-07-31', 4, 1, '2018-02-07 13:41:32', '2018-02-07 13:41:32'),
(89, 102, '07021889', '', 3780.000000, '2017-08-02', 4, 1, '2018-02-07 13:44:23', '2018-02-07 13:44:23'),
(90, 103, '07021890', '', 5600.000000, '2017-08-04', 4, 1, '2018-02-07 13:46:14', '2018-02-07 13:46:14'),
(91, 104, '07021891', '', 31800.000000, '2017-08-04', 4, 1, '2018-02-07 13:50:02', '2018-02-07 13:50:02'),
(92, 105, '07021892', '', 9100.000000, '2017-08-05', 4, 1, '2018-02-07 13:52:23', '2018-02-07 13:52:23'),
(93, 106, '07021893', '', 67800.000000, '2017-08-06', 4, 1, '2018-02-07 13:58:18', '2018-02-07 13:58:18'),
(94, 107, '07021894', '', 1460.000000, '2017-08-06', 4, 1, '2018-02-07 14:05:51', '2018-02-07 14:05:51'),
(95, 108, '07021895', '', 6280.000000, '2017-08-06', 4, 1, '2018-02-07 14:09:35', '2018-02-07 14:09:35'),
(96, 109, '07021896', '', 122385.000000, '2017-08-07', 4, 1, '2018-02-07 14:28:52', '2018-02-07 14:28:52'),
(97, 110, '07021897', '', 8100.000000, '2017-08-07', 4, 1, '2018-02-07 14:32:39', '2018-02-07 14:32:39'),
(98, 111, '07021898', '', 24000.000000, '2017-08-07', 4, 1, '2018-02-07 14:34:13', '2018-02-07 14:34:13'),
(99, 112, '07021899', '', 3700.000000, '2017-08-09', 4, 1, '2018-02-07 14:36:39', '2018-02-07 14:36:39'),
(100, 113, '070218100', '', 18825.000000, '2017-08-09', 4, 1, '2018-02-07 14:40:47', '2018-02-07 14:40:47'),
(101, 114, '070218101', '', 16485.000000, '2017-08-11', 4, 1, '2018-02-07 14:46:45', '2018-02-07 14:46:45'),
(102, 115, '070218102', '', 13700.000000, '2017-08-12', 4, 1, '2018-02-07 14:51:36', '2018-02-07 14:51:36'),
(103, 116, '070218103', '', 30200.000000, '2017-08-12', 4, 1, '2018-02-07 14:56:31', '2018-02-07 14:56:31'),
(104, 117, '070218104', '', 52930.000000, '2017-08-18', 4, 1, '2018-02-07 15:06:47', '2018-02-07 15:06:47'),
(105, 118, '070218105', '', 37200.000000, '2017-08-18', 4, 1, '2018-02-07 15:31:03', '2018-02-07 15:31:03'),
(106, 119, '070218106', '', 61100.000000, '2017-08-18', 4, 1, '2018-02-07 15:48:19', '2018-02-07 15:48:19'),
(107, 120, '070218107', '', 21150.000000, '2017-08-18', 4, 1, '2018-02-07 15:55:27', '2018-02-07 15:55:27'),
(108, 121, '070218108', '', 25500.000000, '2017-08-20', 4, 1, '2018-02-07 16:05:03', '2018-02-07 16:05:03'),
(109, 122, '070218109', '', 27300.000000, '2017-08-21', 4, 1, '2018-02-07 16:11:26', '2018-02-07 16:11:26'),
(110, 123, '070218110', '', 9150.000000, '2017-08-23', 4, 1, '2018-02-07 16:16:02', '2018-02-07 16:16:02'),
(111, 124, '070218111', '', 9260.000000, '2017-08-25', 4, 1, '2018-02-07 16:24:07', '2018-02-07 16:24:07'),
(112, 125, '070218112', '', 2400.000000, '2017-09-09', 4, 1, '2018-02-07 16:27:27', '2018-02-07 16:27:27'),
(113, 126, '070218113', '', 5300.000000, '2017-08-26', 4, 1, '2018-02-07 16:31:55', '2018-02-07 16:31:55'),
(114, 127, '070218114', '', 5950.000000, '2017-08-26', 4, 1, '2018-02-07 16:34:49', '2018-02-07 16:34:49'),
(115, 128, '070218115', '', 5200.000000, '2017-08-28', 4, 1, '2018-02-07 16:36:47', '2018-02-07 16:36:47'),
(116, 129, '070218116', '', 8300.000000, '2017-08-28', 4, 1, '2018-02-07 16:39:18', '2018-02-07 16:39:18'),
(117, 130, '070218117', '', 6300.000000, '2017-09-08', 4, 1, '2018-02-07 16:41:46', '2018-02-07 16:41:46'),
(118, 131, '070218118', '', 24800.000000, '2017-09-10', 4, 1, '2018-02-07 16:49:25', '2018-02-07 16:49:25'),
(119, 132, '070218119', '', 29000.000000, '2017-09-11', 4, 1, '2018-02-07 16:51:49', '2018-02-07 16:51:49'),
(120, 133, '070218120', '', 22000.000000, '2017-09-12', 4, 1, '2018-02-07 16:54:25', '2018-02-07 16:54:25'),
(121, 134, '070218121', '', 16600.000000, '2017-09-13', 4, 1, '2018-02-07 16:56:47', '2018-02-07 16:56:47'),
(122, 135, '070218122', '', 16900.000000, '2017-09-13', 4, 1, '2018-02-07 17:00:31', '2018-02-07 17:00:31'),
(123, 136, '070218123', '', 485281.000000, '2018-02-07', 4, 1, '2018-02-07 17:22:45', '2018-02-07 17:22:45'),
(124, 137, '090218124', '', 8760.000000, '2017-07-29', 4, 1, '2018-02-09 10:50:51', '2018-02-09 10:50:51'),
(125, 138, '090218125', '', 17480.000000, '2017-08-09', 4, 1, '2018-02-09 11:05:36', '2018-02-09 11:50:57'),
(126, 139, '090218126', '', 38950.000000, '2017-10-07', 4, 1, '2018-02-09 11:15:20', '2018-02-09 11:15:20'),
(127, 140, '090218127', '', 16550.000000, '2017-10-23', 4, 1, '2018-02-09 11:31:46', '2018-02-09 11:31:46'),
(128, 141, '090218128', '', 2600.000000, '2017-10-31', 4, 1, '2018-02-09 11:33:44', '2018-02-09 11:33:44'),
(129, 142, '090218129', '', 5600.000000, '2017-11-05', 4, 1, '2018-02-09 11:38:31', '2018-02-09 11:38:31'),
(130, 143, '090218130', '', 4500.000000, '2017-11-11', 4, 1, '2018-02-09 11:41:52', '2018-02-09 11:41:52'),
(131, 144, '090218131', '', 12300.000000, '2017-12-09', 4, 1, '2018-02-09 11:55:29', '2018-02-09 11:55:29'),
(132, 145, '090218132', '', 1840.000000, '2017-12-01', 4, 1, '2018-02-09 11:56:58', '2018-02-09 11:56:58'),
(133, 146, '090218133', '', 33000.000000, '2017-11-14', 4, 1, '2018-02-09 12:08:25', '2018-02-09 12:08:25'),
(134, 147, '090218134', '', 34500.000000, '2017-11-18', 4, 1, '2018-02-09 12:11:57', '2018-02-09 12:11:57'),
(135, 148, '090218135', '', 5900.000000, '2017-11-19', 4, 1, '2018-02-09 12:58:37', '2018-02-09 12:58:37'),
(136, 149, '090218136', '', 3180.000000, '2017-11-22', 4, 1, '2018-02-09 13:01:34', '2018-02-09 13:01:34'),
(137, 150, '090218137', '', 59570.000000, '2017-11-24', 4, 1, '2018-02-09 13:11:54', '2018-02-09 13:11:54'),
(138, 151, '090218138', '', 750.000000, '2017-11-27', 4, 1, '2018-02-09 13:38:04', '2018-02-09 13:38:04'),
(139, 152, '090218139', '', 7350.000000, '2017-12-02', 4, 1, '2018-02-09 13:42:18', '2018-02-09 13:42:18'),
(140, 153, '090218140', '', 3600.000000, '2017-12-02', 4, 1, '2018-02-09 13:44:20', '2018-02-09 13:44:20'),
(141, 154, '090218141', '', 3080.000000, '2017-12-02', 4, 1, '2018-02-09 14:08:24', '2018-02-09 14:08:24'),
(142, 155, '090218142', '', 1870.000000, '2017-12-04', 4, 1, '2018-02-09 14:10:30', '2018-02-09 14:10:30'),
(143, 156, '090218143', '', 25610.000000, '2017-12-05', 4, 1, '2018-02-09 14:16:40', '2018-02-09 14:16:40'),
(144, 157, '090218144', '', 20500.000000, '2017-12-08', 4, 1, '2018-02-09 14:24:09', '2018-02-09 14:24:09'),
(145, 158, '090218145', '', 8960.000000, '2017-12-08', 4, 1, '2018-02-09 14:35:03', '2018-02-09 14:35:03'),
(146, 159, '090218146', '', 6700.000000, '2017-12-08', 4, 1, '2018-02-09 14:36:52', '2018-02-09 14:36:52'),
(147, 160, '090218147', '', 34300.000000, '2017-12-09', 4, 1, '2018-02-09 14:43:44', '2018-02-09 14:43:44'),
(148, 161, '090218148', '', 4900.000000, '2017-12-09', 4, 1, '2018-02-09 14:45:41', '2018-02-09 14:45:41'),
(149, 162, '090218149', '', 35500.000000, '2017-12-13', 4, 1, '2018-02-09 14:48:50', '2018-02-09 14:48:50'),
(150, 163, '090218150', '', 8450.000000, '2017-12-13', 4, 1, '2018-02-09 14:50:58', '2018-02-09 14:50:58'),
(151, 164, '090218151', '', 12300.000000, '2017-12-18', 4, 1, '2018-02-09 14:54:14', '2018-02-09 14:54:14'),
(152, 165, '090218152', '', 28225.000000, '2017-12-18', 4, 1, '2018-02-09 15:03:56', '2018-02-09 15:03:56'),
(153, 166, '090218153', '', 8200.000000, '2017-12-23', 4, 1, '2018-02-09 15:07:25', '2018-02-09 15:07:25'),
(154, 167, '090218154', '', 15000.000000, '2017-12-24', 4, 1, '2018-02-09 15:09:42', '2018-02-09 15:09:42'),
(155, 168, '090218155', '', 11000.000000, '2017-12-24', 4, 1, '2018-02-09 15:13:17', '2018-02-09 15:13:17'),
(156, 169, '090218156', '', 62690.000000, '2017-12-26', 4, 1, '2018-02-09 15:24:42', '2018-02-09 15:24:42'),
(157, 170, '090218157', '', 44620.000000, '2017-12-31', 4, 1, '2018-02-09 15:34:39', '2018-02-09 15:34:39'),
(158, 171, '090218158', '', 7900.000000, '2017-12-31', 4, 1, '2018-02-09 15:39:17', '2018-02-09 15:39:17'),
(159, 172, '090218159', '', 42480.000000, '2017-12-31', 4, 1, '2018-02-09 15:56:54', '2018-02-09 15:56:54'),
(160, 173, '090218160', '', 33500.000000, '2018-01-06', 4, 1, '2018-02-09 16:01:25', '2018-02-09 16:01:25'),
(161, 174, '090218161', '', 22040.000000, '2018-01-14', 4, 1, '2018-02-09 16:07:02', '2018-02-09 16:07:02'),
(162, 175, '090218162', '', 15920.000000, '2018-01-15', 4, 1, '2018-02-09 16:23:25', '2018-02-09 16:23:25'),
(163, 176, '090218163', '', 3900.000000, '2018-01-21', 4, 1, '2018-02-09 16:26:28', '2018-02-09 16:26:28'),
(164, 177, '090218164', '', 19900.000000, '2018-01-27', 4, 1, '2018-02-09 16:41:08', '2018-02-09 16:41:08'),
(165, 178, '090218165', '', 6800.000000, '2017-12-27', 4, 1, '2018-02-09 16:43:02', '2018-02-09 16:43:02'),
(166, 179, '090218166', '', 16000.000000, '2018-01-31', 4, 1, '2018-02-09 16:47:49', '2018-02-09 16:47:49'),
(167, 180, '090218167', '', 20175.000000, '2018-01-31', 4, 1, '2018-02-09 16:50:37', '2018-02-09 16:50:37'),
(168, 181, '090218168', '', 26600.000000, '2018-02-02', 4, 1, '2018-02-09 16:57:13', '2018-02-09 16:57:13'),
(169, 182, '090218169', '', 37300.000000, '2018-02-02', 4, 1, '2018-02-09 17:03:06', '2018-02-09 17:03:06'),
(170, 183, '090218170', '', 96620.000000, '2018-02-04', 4, 1, '2018-02-09 17:12:48', '2018-02-09 17:12:48'),
(171, 184, '090218171', '', 19600.000000, '2018-02-07', 4, 1, '2018-02-09 17:17:10', '2018-02-09 17:17:10'),
(172, 185, '090218172', '', 17400.000000, '2018-02-07', 4, 1, '2018-02-09 17:22:06', '2018-02-09 17:22:06'),
(173, 186, '100218173', '', 3480.000000, '2017-08-06', 4, 1, '2018-02-10 10:24:30', '2018-02-10 10:24:30'),
(174, 187, '100218174', '', 19930.000000, '2017-08-14', 4, 1, '2018-02-10 10:40:58', '2018-02-10 10:40:58'),
(175, 188, '100218175', '', 1400.000000, '2017-08-28', 4, 1, '2018-02-10 10:44:26', '2018-02-10 10:44:26'),
(176, 189, '100218176', '', 2290.000000, '2017-11-07', 4, 1, '2018-02-10 10:48:32', '2018-02-10 10:48:32'),
(177, 190, '100218177', '', 850.000000, '2017-10-08', 4, 1, '2018-02-10 11:15:17', '2018-02-10 11:15:17'),
(178, 191, '100218178', '', 27600.000000, '2017-11-10', 4, 1, '2018-02-10 11:31:46', '2018-02-10 11:31:46'),
(179, 193, '110218179', '', 28350.000000, '2018-02-11', 4, 1, '2018-02-11 10:48:37', '2018-02-11 10:48:37'),
(180, 194, '110218180', '', 18700.000000, '2017-11-11', 4, 1, '2018-02-11 11:06:51', '2018-02-11 11:06:51'),
(181, 195, '110218181', '', 286994.000000, '2017-07-31', 4, 1, '2018-02-11 11:49:54', '2018-02-11 11:49:54'),
(182, 196, '110218182', '', 440126.000000, '2017-08-31', 3, 1, '2018-02-11 15:11:02', '2018-02-11 15:11:02'),
(183, 197, '110218183', '', 166884.000000, '2017-09-30', 3, 1, '2018-02-11 15:47:27', '2018-02-11 15:47:27'),
(184, 198, '110218184', '', 290966.000000, '2017-10-31', 3, 1, '2018-02-11 19:58:04', '2018-02-11 19:58:04'),
(185, 199, '120218185', '', 184366.000000, '2017-11-30', 3, 1, '2018-02-12 11:20:43', '2018-02-12 11:20:43'),
(186, 200, '120218186', '', 331573.000000, '2017-12-31', 3, 1, '2018-02-12 12:12:22', '2018-02-12 12:12:22'),
(187, 201, '120218187', '', 54733.000000, '2018-02-11', 3, 1, '2018-02-12 15:43:33', '2018-02-12 15:43:33'),
(188, 202, '120218188', '', 288016.000000, '2018-01-31', 3, 1, '2018-02-12 16:20:17', '2018-02-12 16:20:17'),
(189, 217, '160218189', '', 1500.000000, '2018-02-16', 5, 1, '2018-02-16 18:12:56', '2018-02-16 18:12:56'),
(190, 218, '160218190', '', 1500.000000, '2018-02-16', 5, 1, '2018-02-16 19:05:21', '2018-02-16 19:05:21'),
(191, 219, '160218191', '', 5100.000000, '2018-02-16', 5, 1, '2018-02-16 19:43:43', '2018-02-16 19:43:43'),
(192, 221, '160218192', '', 6100.000000, '2018-02-16', 5, 1, '2018-02-16 20:10:51', '2018-02-16 20:10:51'),
(193, 222, '160218193', '', 9600.000000, '2018-02-16', 5, 1, '2018-02-16 20:17:48', '2018-02-16 20:17:48'),
(194, 223, '160218194', '', 9170.000000, '2018-02-16', 5, 1, '2018-02-16 20:24:55', '2018-02-16 20:24:55'),
(195, 224, '160218195', '', 200.000000, '2018-02-16', 5, 1, '2018-02-16 20:27:23', '2018-02-16 20:27:23'),
(196, 226, '170218196', '', 11680.000000, '2018-02-17', 3, 1, '2018-02-17 21:00:27', '2018-02-17 21:00:27'),
(197, 227, '170218197', '', 8775.000000, '2018-02-17', 3, 1, '2018-02-17 21:13:57', '2018-02-17 21:13:57'),
(198, 228, '170218198', '', 205640.000000, '2018-02-17', 3, 1, '2018-02-17 21:20:00', '2018-02-17 21:20:00'),
(199, 229, '170218199', '', 12000.000000, '2018-02-17', 3, 1, '2018-02-17 22:39:51', '2018-02-17 22:39:51'),
(200, 230, '170218200', '', 9690.000000, '2018-02-17', 3, 1, '2018-02-17 22:48:02', '2018-02-17 22:48:02'),
(201, 231, '170218201', '', 9400.000000, '2018-02-17', 3, 1, '2018-02-17 22:53:28', '2018-02-17 22:53:28'),
(202, 232, '170218202', '', 2420.000000, '2018-02-17', 3, 1, '2018-02-17 22:55:57', '2018-02-17 22:55:57'),
(203, 233, '170218203', '', 6800.000000, '2018-02-17', 3, 1, '2018-02-17 22:58:51', '2018-02-17 22:58:51'),
(204, 234, '180218204', '', 12600.000000, '2018-02-13', 5, 1, '2018-02-18 21:17:59', '2018-02-18 21:17:59'),
(205, 235, '180218205', '', 350.000000, '2018-02-17', 5, 1, '2018-02-18 21:19:26', '2018-02-18 21:19:26'),
(206, 236, '180218206', '', 2850.000000, '2017-08-14', 5, 1, '2018-02-18 21:29:50', '2018-02-18 21:29:50'),
(207, 237, '180218207', '', 7650.000000, '2017-10-27', 5, 1, '2018-02-18 21:32:25', '2018-02-18 21:32:25'),
(208, 238, '180218208', '', 11500.000000, '2017-07-30', 5, 1, '2018-02-18 21:39:58', '2018-02-18 21:39:58'),
(209, 239, '180218209', '', 10700.000000, '2017-08-13', 5, 1, '2018-02-18 22:06:32', '2018-02-18 22:12:32'),
(210, 242, '180218210', '', 2000.000000, '2017-07-30', 5, 1, '2018-02-18 22:32:18', '2018-02-18 22:32:18'),
(211, 243, '180218211', '', 11250.000000, '2017-12-05', 5, 1, '2018-02-18 22:39:07', '2018-02-18 22:39:07'),
(212, 244, '180218212', '', 150.000000, '2017-12-05', 5, 1, '2018-02-18 22:42:00', '2018-02-18 22:42:00'),
(213, 249, '180218213', '', 1600.000000, '2017-07-05', 5, 1, '2018-02-18 23:13:45', '2018-02-18 23:13:45'),
(214, 250, '180218214', '', 5800.000000, '2017-08-23', 5, 1, '2018-02-18 23:16:17', '2018-02-18 23:16:17'),
(215, 251, '180218215', '', 300.000000, '2018-01-22', 5, 1, '2018-02-18 23:18:20', '2018-02-18 23:18:20'),
(216, 252, '180218216', '', 2600.000000, '2018-02-13', 5, 1, '2018-02-18 23:19:28', '2018-02-18 23:19:28'),
(217, 255, '180218217', '', 1700.000000, '2017-09-11', 5, 1, '2018-02-18 23:34:43', '2018-02-18 23:34:43'),
(218, 256, '180218218', '', 1900.000000, '2017-10-10', 5, 1, '2018-02-18 23:36:07', '2018-02-18 23:36:07'),
(219, 257, '190218219', '', 25800.000000, '2018-02-19', 3, 1, '2018-02-19 23:30:26', '2018-02-19 23:30:26'),
(220, 258, '190218220', '', 2760.000000, '2018-02-19', 3, 1, '2018-02-19 23:34:56', '2018-02-19 23:34:56'),
(221, 259, '190218221', '', 1340.000000, '2018-02-19', 3, 1, '2018-02-19 23:37:29', '2018-02-19 23:37:29'),
(222, 260, '200218222', '', 10350.000000, '2018-02-12', 5, 1, '2018-02-20 17:03:39', '2018-02-20 17:03:39'),
(223, 261, '230218223', '', 27000.000000, '2018-02-19', 3, 1, '2018-02-23 21:29:08', '2018-02-23 21:29:08'),
(224, 262, '230218224', '', 9200.000000, '2018-02-20', 3, 1, '2018-02-23 21:35:39', '2018-02-23 21:35:39'),
(225, 263, '230218225', '', 4000.000000, '2017-12-12', 3, 1, '2018-02-23 22:25:06', '2018-02-23 22:25:06'),
(226, 264, '230218226', '', 43400.000000, '2018-01-12', 3, 1, '2018-02-23 22:28:02', '2018-02-23 22:28:02'),
(227, 265, '230218227', '', 21400.000000, '2018-02-02', 3, 1, '2018-02-23 22:33:53', '2018-02-23 22:33:53'),
(228, 266, '230218228', '', 4000.000000, '2018-02-10', 3, 1, '2018-02-23 22:46:58', '2018-02-23 22:46:58'),
(229, 267, '230218229', '', 600.000000, '2018-02-17', 3, 1, '2018-02-23 22:50:12', '2018-02-23 22:50:12'),
(230, 268, '240218230', '', 2350.000000, '2018-02-13', 5, 1, '2018-02-24 15:58:37', '2018-02-24 15:58:37'),
(231, 269, '240218231', '', 16610.000000, '2018-02-14', 5, 1, '2018-02-24 16:13:26', '2018-02-24 16:13:26'),
(232, 270, '240218232', '', 5950.000000, '2018-02-16', 5, 1, '2018-02-24 16:23:12', '2018-02-24 16:23:12'),
(233, 271, '240218233', '', 15100.000000, '2018-02-17', 5, 1, '2018-02-24 16:31:11', '2018-02-24 16:31:11'),
(234, 272, '240218234', '', 4550.000000, '2018-02-18', 5, 1, '2018-02-24 16:34:23', '2018-02-24 16:34:23'),
(235, 273, '240218235', '', 6469.000000, '2018-02-19', 5, 1, '2018-02-24 16:43:57', '2018-02-24 16:43:57'),
(236, 274, '240218236', '', 20198.000000, '2018-02-20', 5, 1, '2018-02-24 17:10:49', '2018-02-24 17:10:49'),
(237, 275, '240218237', '', 7502.000000, '2018-02-23', 5, 1, '2018-02-24 17:19:25', '2018-02-24 17:19:25'),
(238, 276, '240218238', '', 3850.000000, '2017-09-27', 7, 1, '2018-02-25 00:16:54', '2018-02-25 00:16:54'),
(239, 277, '240218239', '', 58700.000000, '2017-09-15', 7, 1, '2018-02-25 00:29:18', '2018-02-25 00:29:18'),
(240, 278, '240218240', '', 29500.000000, '2017-09-19', 7, 1, '2018-02-25 00:34:55', '2018-02-25 00:34:55'),
(241, 279, '240218241', '', 19800.000000, '2017-09-19', 7, 1, '2018-02-25 00:38:04', '2018-02-25 00:38:04'),
(242, 280, '240218242', '', 14050.000000, '2017-09-22', 7, 1, '2018-02-25 00:46:56', '2018-02-25 00:46:56'),
(243, 281, '240218243', '', 7850.000000, '2017-09-30', 7, 1, '2018-02-25 00:54:36', '2018-02-25 00:54:36'),
(244, 282, '240218244', '', 14000.000000, '2017-09-30', 7, 1, '2018-02-25 01:05:44', '2018-02-25 01:05:44'),
(245, 283, '250218245', '', 7300.000000, '2017-10-07', 7, 1, '2018-02-25 18:52:33', '2018-02-25 18:52:33'),
(246, 284, '250218246', '', 17000.000000, '2017-10-07', 7, 1, '2018-02-25 18:59:13', '2018-02-25 18:59:13'),
(247, 285, '250218247', '', 21900.000000, '2017-10-16', 7, 1, '2018-02-25 19:02:44', '2018-02-25 19:02:44'),
(248, 286, '250218248', '', 28700.000000, '2017-10-20', 7, 1, '2018-02-25 19:08:08', '2018-02-25 19:08:08'),
(249, 287, '250218249', '', 29500.000000, '2017-11-03', 7, 1, '2018-02-25 19:14:46', '2018-02-25 19:14:46'),
(250, 288, '250218250', '', 37340.000000, '2017-11-03', 7, 1, '2018-02-25 19:19:58', '2018-02-25 19:19:58'),
(251, 289, '250218251', '', 10600.000000, '2017-11-05', 7, 1, '2018-02-25 19:22:56', '2018-02-25 19:22:56'),
(252, 290, '250218252', '', 4000.000000, '2017-11-06', 7, 1, '2018-02-25 19:25:18', '2018-02-25 19:25:18'),
(253, 291, '250218253', '', 10000.000000, '2017-11-06', 7, 1, '2018-02-25 19:27:12', '2018-02-25 19:27:12'),
(254, 292, '250218254', '', 8000.000000, '2017-11-08', 7, 1, '2018-02-25 19:46:47', '2018-02-25 19:46:47'),
(255, 293, '250218255', '', 800.000000, '2017-11-08', 7, 1, '2018-02-25 19:49:55', '2018-02-25 19:49:55'),
(256, 294, '250218256', '', 19200.000000, '2017-11-10', 7, 1, '2018-02-25 19:54:16', '2018-02-25 19:54:16'),
(257, 295, '250218257', '', 25600.000000, '2017-11-15', 7, 1, '2018-02-25 20:02:35', '2018-02-25 20:02:35'),
(258, 296, '250218258', '', 11660.000000, '2017-11-17', 7, 1, '2018-02-25 20:05:47', '2018-02-25 20:05:47'),
(259, 297, '250218259', '', 8700.000000, '2017-11-18', 7, 1, '2018-02-25 20:10:56', '2018-02-25 20:10:56'),
(260, 298, '250218260', '', 9300.000000, '2017-11-18', 7, 1, '2018-02-25 20:14:40', '2018-02-25 20:14:40'),
(261, 299, '250218261', '', 13700.000000, '2017-11-20', 7, 1, '2018-02-25 20:21:01', '2018-02-25 20:21:01'),
(262, 300, '250218262', '', 13000.000000, '2017-11-24', 7, 1, '2018-02-25 20:52:12', '2018-02-25 20:52:12'),
(263, 301, '250218263', '', 10600.000000, '2017-11-26', 7, 1, '2018-02-25 20:57:01', '2018-02-25 20:57:01'),
(264, 302, '250218264', '', 6250.000000, '2017-11-29', 7, 1, '2018-02-25 20:58:37', '2018-02-25 20:58:37'),
(265, 303, '250218265', '', 11800.000000, '2017-12-01', 7, 1, '2018-02-25 21:01:25', '2018-02-25 21:01:25'),
(266, 304, '250218266', '', 7300.000000, '2017-12-05', 7, 1, '2018-02-25 21:05:02', '2018-02-25 21:05:02'),
(267, 305, '250218267', '', 16600.000000, '2017-12-05', 7, 1, '2018-02-25 21:10:47', '2018-02-25 21:10:47'),
(268, 306, '250218268', '', 9000.000000, '2017-12-08', 7, 1, '2018-02-25 21:16:55', '2018-02-25 21:16:55'),
(269, 307, '250218269', '', 11800.000000, '2017-12-11', 7, 1, '2018-02-25 21:22:00', '2018-02-25 21:22:00'),
(270, 308, '250218270', '', 12250.000000, '2017-12-15', 7, 1, '2018-02-25 21:24:59', '2018-02-25 21:24:59'),
(271, 309, '250218271', '', 1600.000000, '2017-12-17', 7, 1, '2018-02-25 21:27:39', '2018-02-25 21:27:39'),
(272, 310, '250218272', '', 1400.000000, '2017-12-18', 7, 1, '2018-02-25 21:29:40', '2018-02-25 21:29:40'),
(273, 311, '250218273', '', 20500.000000, '2017-12-19', 7, 1, '2018-02-25 21:32:15', '2018-02-25 21:32:15'),
(274, 312, '250218274', '', 11600.000000, '2017-12-20', 7, 1, '2018-02-25 21:35:05', '2018-02-25 21:35:05'),
(275, 313, '250218275', '', 31000.000000, '2017-12-22', 7, 1, '2018-02-25 21:40:10', '2018-02-25 21:40:10'),
(276, 314, '250218276', '', 7380.000000, '2017-12-29', 7, 1, '2018-02-25 21:44:03', '2018-02-25 21:44:03'),
(277, 315, '250218277', '', 6900.000000, '2018-01-01', 7, 1, '2018-02-25 21:48:34', '2018-02-25 21:48:34'),
(278, 316, '250218278', '', 4380.000000, '2018-01-01', 7, 1, '2018-02-25 22:16:13', '2018-02-25 22:16:13'),
(279, 317, '250218279', '', 6100.000000, '2018-01-03', 7, 1, '2018-02-25 22:19:46', '2018-02-25 22:19:46'),
(280, 318, '250218280', '', 12640.000000, '2018-01-03', 7, 1, '2018-02-25 22:27:45', '2018-02-25 22:27:45'),
(281, 319, '250218281', '', 46400.000000, '2018-01-05', 7, 1, '2018-02-25 22:39:55', '2018-02-25 22:39:55'),
(282, 320, '250218282', '', 5000.000000, '2018-01-10', 7, 1, '2018-02-25 22:42:39', '2018-02-25 22:42:39'),
(283, 321, '250218283', '', 4800.000000, '2018-01-13', 7, 1, '2018-02-25 22:45:19', '2018-02-25 22:45:19'),
(284, 323, '250218284', '', 4200.000000, '2018-01-14', 7, 1, '2018-02-25 22:56:28', '2018-02-25 22:56:28'),
(285, 324, '250218285', '', 27700.000000, '2018-01-16', 7, 1, '2018-02-25 23:05:24', '2018-02-25 23:05:24'),
(286, 326, '250218286', '', 9850.000000, '2018-01-22', 7, 1, '2018-02-25 23:28:02', '2018-02-25 23:28:02'),
(287, 327, '250218287', '', 4370.000000, '2018-01-22', 7, 1, '2018-02-25 23:34:09', '2018-02-25 23:34:09'),
(295, 328, '260218288', '', 46273.000000, '2017-09-30', 7, 1, '2018-02-26 23:10:28', '2018-02-26 23:10:28'),
(296, 330, '260218296', '', 95091.000000, '2018-01-31', 7, 1, '2018-02-27 00:36:55', '2018-02-27 00:36:55'),
(297, 332, '260218297', '', 11485.000000, '2018-01-22', 7, 1, '2018-02-27 01:21:11', '2018-02-27 01:21:11'),
(298, 333, '260218298', '', 18200.000000, '2018-01-23', 7, 1, '2018-02-27 01:26:27', '2018-02-27 01:26:27'),
(299, 334, '260218299', '', 64000.000000, '2018-01-24', 7, 1, '2018-02-27 01:30:52', '2018-02-27 01:30:52'),
(304, 325, '270218300', NULL, 53770.000000, '2018-02-27', 5, 1, '2018-02-27 23:14:08', '2018-02-27 23:25:02'),
(311, 322, '280218305', '1/19-20 E P', 13800.000000, '2018-02-28', 5, 1, '2018-02-28 18:22:30', '2018-02-28 18:22:30'),
(312, 335, '280218312', '', 29050.000000, '2018-01-24', 5, 1, '2018-02-28 18:47:13', '2018-02-28 18:47:13'),
(313, 336, '280218313', '', 8400.000000, '2018-01-27', 5, 1, '2018-02-28 18:51:12', '2018-02-28 18:51:12'),
(314, 337, '280218314', '', 3950.000000, '2018-01-27', 5, 1, '2018-02-28 18:56:18', '2018-02-28 18:56:18'),
(315, 338, '280218315', '', 33600.000000, '2018-01-31', 5, 1, '2018-02-28 19:00:36', '2018-02-28 19:00:36'),
(316, 339, '280218316', '', 11000.000000, '2018-01-31', 5, 1, '2018-02-28 19:03:40', '2018-02-28 19:03:40'),
(317, 340, '280218317', '', 16800.000000, '2018-01-31', 5, 1, '2018-02-28 19:06:03', '2018-02-28 19:06:03'),
(318, 341, '280218318', '', 11050.000000, '2018-02-06', 5, 1, '2018-02-28 19:11:58', '2018-02-28 19:11:58'),
(319, 342, '280218319', '', 3400.000000, '2018-02-10', 5, 1, '2018-02-28 19:15:18', '2018-02-28 19:15:18'),
(320, 343, '280218320', '', 13600.000000, '2018-02-12', 5, 1, '2018-02-28 19:17:07', '2018-02-28 19:17:07'),
(321, 344, '280218321', '', 4800.000000, '2018-02-13', 5, 1, '2018-02-28 19:18:29', '2018-02-28 19:18:29'),
(322, 345, '280218322', '', 9500.000000, '2018-02-16', 5, 1, '2018-02-28 19:21:00', '2018-02-28 19:21:00'),
(323, 346, '280218323', '', 19620.000000, '2018-02-23', 5, 1, '2018-02-28 19:25:04', '2018-02-28 19:25:04'),
(324, 347, '280218324', '', 4650.000000, '2018-02-24', 5, 1, '2018-02-28 19:27:53', '2018-02-28 19:27:53'),
(325, 348, '280218325', '', 213283.000000, '2017-10-31', 5, 1, '2018-02-28 22:06:48', '2018-02-28 22:06:48'),
(326, 349, '280218326', '', 199201.000000, '2017-11-30', 5, 1, '2018-02-28 22:47:25', '2018-02-28 22:47:25'),
(327, 350, '030318327', '', 445524.000000, '2017-12-31', 6, 1, '2018-03-03 22:24:46', '2018-03-03 22:24:46'),
(328, 351, '030318328', '', 232422.000000, '2018-02-28', 6, 1, '2018-03-04 00:03:18', '2018-03-04 00:03:18'),
(329, 352, '030318329', '', 5150.000000, '2018-02-28', 6, 1, '2018-03-04 01:04:33', '2018-03-04 01:04:33'),
(330, 353, '030318330', '', 6500.000000, '2018-02-28', 6, 1, '2018-03-04 01:07:46', '2018-03-04 01:07:46'),
(331, 354, '040318331', '', 44600.000000, '2018-02-19', 5, 1, '2018-03-04 16:58:34', '2018-03-04 16:58:34'),
(332, 355, '040318332', '', 172900.000000, '2018-02-27', 5, 1, '2018-03-04 17:06:46', '2018-03-04 17:06:46'),
(333, 356, '040318333', '', 151750.000000, '2018-02-28', 5, 1, '2018-03-04 17:16:43', '2018-03-04 17:16:43'),
(335, 331, '040318334', NULL, 144048.000000, '2018-01-31', 5, 1, '2018-03-04 21:27:23', '2018-03-04 21:27:23'),
(336, 329, '040318336', NULL, 210483.000000, '2018-03-04', 6, 1, '2018-03-04 21:38:58', '2018-03-04 21:38:58'),
(337, 357, '040318337', '', 1425.000000, '2018-01-31', 6, 1, '2018-03-04 21:42:03', '2018-03-04 21:42:03'),
(339, 358, '040318338', '', 12950.000000, '2018-02-24', 6, 1, '2018-03-04 21:53:46', '2018-03-04 21:53:46'),
(340, 359, '040318340', '', 25980.000000, '2018-03-02', 6, 1, '2018-03-05 00:38:14', '2018-03-05 00:38:14'),
(341, 360, '040318341', NULL, 16952.000000, '2018-03-04', 6, 1, '2018-03-05 00:58:33', '2018-03-05 00:58:33'),
(342, 361, '050318342', '', 5860.000000, '2018-02-24', 5, 1, '2018-03-05 16:12:53', '2018-03-05 16:12:53'),
(343, 362, '050318343', '', 5429.000000, '2018-02-25', 5, 1, '2018-03-05 16:22:53', '2018-03-05 16:22:53'),
(344, 363, '050318344', '', 8382.000000, '2018-02-26', 5, 1, '2018-03-05 16:29:50', '2018-03-05 16:29:50'),
(345, 364, '050318345', '', 2200.000000, '2018-02-27', 5, 1, '2018-03-05 16:32:20', '2018-03-05 16:32:20'),
(346, 365, '050318346', '', 9197.000000, '2018-02-28', 5, 1, '2018-03-05 16:48:08', '2018-03-05 16:48:08'),
(347, 366, '050318347', '', 7250.000000, '2018-02-24', 5, 1, '2018-03-05 16:57:45', '2018-03-05 16:57:45'),
(348, 367, '050318348', '', 2620.000000, '2018-02-26', 5, 1, '2018-03-05 17:03:42', '2018-03-05 17:03:42'),
(349, 368, '050318349', '', 8900.000000, '2018-02-28', 5, 1, '2018-03-05 17:09:19', '2018-03-05 17:09:19'),
(350, 369, '050318350', '', 6300.000000, '2018-02-28', 5, 1, '2018-03-05 17:12:09', '2018-03-05 17:12:09'),
(351, 370, '010418351', '', 150.000000, '2018-04-01', 1, 1, '2018-04-01 05:14:13', '2018-04-01 05:14:13'),
(352, 371, '021020352', '', 3000.000000, '2020-10-02', 1, 1, '2020-10-02 14:54:49', '2020-10-02 14:54:49'),
(353, 372, '021020353', '', 4000.000000, '2020-10-02', 1, 1, '2020-10-02 14:55:43', '2020-10-02 14:55:43');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_small_unit`
--

CREATE TABLE `inventory_small_unit` (
  `id` int(10) UNSIGNED NOT NULL,
  `small_unit_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_small_unit`
--

INSERT INTO `inventory_small_unit` (`id`, `small_unit_name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Pcs', 1, '2017-12-02 10:10:04', '2017-12-14 00:30:55'),
(2, 'Kg', 1, '2017-12-14 00:31:05', '2017-12-14 00:31:05'),
(3, 'Bag', 1, '2017-12-14 00:31:15', '2017-12-14 00:31:15'),
(4, 'Bundle', 1, '2017-12-14 00:31:31', '2017-12-14 00:31:31');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_stock_position`
--

CREATE TABLE `inventory_stock_position` (
  `id` int(11) NOT NULL,
  `position_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fk_branch_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `fk_company_id` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_stock_position`
--

INSERT INTO `inventory_stock_position` (`id`, `position_name`, `status`, `created_at`, `updated_at`, `fk_branch_id`, `fk_company_id`) VALUES
(8, 'Chattogram', 1, '2018-01-23 18:36:10', '2020-10-02 14:53:10', 2, 1),
(10, 'Comilla', 1, '2018-01-23 21:59:28', '2020-10-02 14:52:57', 1, 1),
(11, 'Dhaka', 1, '2018-03-04 23:22:58', '2020-10-02 14:52:46', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `inventory_supplier`
--

CREATE TABLE `inventory_supplier` (
  `id` int(10) UNSIGNED NOT NULL,
  `supplier_id` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_company_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `fk_branch_id` int(10) UNSIGNED NOT NULL,
  `representative` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile_no` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `company_name` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `inventory_supplier`
--

INSERT INTO `inventory_supplier` (`id`, `supplier_id`, `fk_company_id`, `fk_branch_id`, `representative`, `mobile_no`, `address`, `email_id`, `status`, `company_name`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(7, 's4', 1, 2, 'MR. Asif', '8801754942679', 'Eastern Plus, Shantinagor, Dhaka.', NULL, 1, 'Ahmed Enterprice', 1, 3, '2018-01-16 11:12:55', '2018-01-23 15:29:23', NULL),
(8, 's8', 1, 2, 'MR. Santu', '919831690991', 'New Merket , Kolkata', NULL, 1, 'Roop Moheni', 1, 3, '2018-01-16 11:13:46', '2018-01-23 15:25:31', NULL),
(9, 's9', 1, 2, 'MR.  Pream', '918697509247', 'New Market, Kolkata, India', NULL, 1, 'Roop Singer', 1, 3, '2018-01-23 12:27:19', '2018-01-23 15:29:56', NULL),
(10, 's10', 1, 2, 'MR. Zaheer', '66957600885', 'Bangkok, Thailand', NULL, 1, 'RBY THAI', 3, 3, '2018-01-23 15:37:00', '2018-01-23 16:59:16', NULL),
(11, 's11', 1, 2, 'MD. Shamim', '15986382011', 'Guangzhou, China', NULL, 1, 'Arefin China', 3, 3, '2018-01-23 15:40:01', '2018-01-28 13:51:37', NULL),
(12, 's12', 1, 2, 'Ibrahim Mia', NULL, NULL, NULL, 1, 'Ibrahim', 3, NULL, '2018-01-23 17:16:42', '2018-01-23 17:16:42', NULL),
(13, 's13', 1, 2, 'Saleem Molla', '01709050889', 'Eastern plus shopping complex.Label # 3 ,Shop # 2/74-75', NULL, 1, 'Samina & Molla Fabrics', 4, NULL, '2018-01-29 17:47:35', '2018-01-29 17:47:35', NULL),
(14, 's14', 1, 2, 'Afzal Hossain', '01914232865', '1/25-26 ( 1st floor ) 145 shantinagar dhaka', NULL, 1, 'Lawn Gallery', 4, NULL, '2018-01-29 17:53:07', '2018-01-29 17:53:07', NULL),
(15, 's15', 1, 2, 'Sohel Rana', '01754417072', 'Shantinagar', NULL, 1, 'Red belbet', 4, NULL, '2018-01-30 18:33:35', '2018-01-30 18:33:35', NULL),
(16, 's16', 1, 2, 'Masum Mia', NULL, NULL, NULL, 1, 'Masum', 4, NULL, '2018-01-30 18:34:48', '2018-01-30 18:34:48', NULL),
(17, 's17', 1, 2, 'Shahidul Islam', NULL, NULL, NULL, 1, 'Shahid', 4, NULL, '2018-01-30 18:45:00', '2018-01-30 18:45:00', NULL),
(18, 's18', 1, 2, 'Haji Mithu', '01915536000', NULL, NULL, 1, 'Howlader Trading', 4, NULL, '2018-02-05 15:26:53', '2018-02-05 15:26:53', NULL),
(19, 's19', 1, 4, 'Kajol', '01869977131', NULL, NULL, 1, 'Kajol', 6, NULL, '2018-02-17 17:21:12', '2018-02-17 17:21:12', NULL),
(20, 's20', 1, 2, '', '', '', '', 1, 'S', 1, NULL, '2018-03-24 10:31:09', '2018-03-24 10:31:09', NULL),
(21, 's21', 1, 4, '', '', '', '', 1, 'Bd', 1, NULL, '2020-10-09 08:32:23', '2020-10-09 08:32:23', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `serial_num` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id`, `name`, `url`, `slug`, `serial_num`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Sales Management', '#', 'sales-management', 1, 1, '2018-02-13 10:20:36', '2018-02-14 09:19:54'),
(3, 'General Account', '#', 'general-account', 2, 1, '2018-02-13 12:53:00', '2018-02-13 12:53:00'),
(4, 'Reports', '#', 'reports', 7, 1, '2018-02-13 12:53:17', '2018-02-14 10:59:45'),
(6, 'Account Management', '#', 'account-management', 5, 1, '2018-02-13 12:54:11', '2018-02-14 10:51:36'),
(7, 'System Configuration', '#', 'system-configuration', 8, 1, '2018-02-13 12:54:20', '2018-02-14 11:00:36'),
(8, 'Employee Management', '#', 'employee-management', 6, 2, '2018-02-13 12:54:36', '2020-10-02 14:48:32'),
(9, 'My Profile', '#', 'my-profile', 7, 1, '2018-02-13 12:54:54', '2018-02-14 11:00:48'),
(10, 'Purchase Management', '#', 'purchase-management', 3, 1, '2018-02-14 10:06:07', '2018-02-14 10:06:07'),
(11, 'Inventory Management', '#', 'inventory-management', 4, 1, '2018-02-14 10:14:27', '2018-02-14 10:59:28'),
(12, 'SMS Communication', '#', 'sms-communication', 9, 2, '2018-02-25 23:50:39', '2020-10-02 14:48:18');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id` int(10) UNSIGNED NOT NULL,
  `invoice_no` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `t_date` date NOT NULL,
  `ref_id` int(11) DEFAULT NULL,
  `fk_client_id` int(11) UNSIGNED NOT NULL,
  `fk_account_id` int(11) UNSIGNED NOT NULL,
  `fk_method_id` int(11) UNSIGNED NOT NULL,
  `fk_company_id` int(11) UNSIGNED NOT NULL DEFAULT 1,
  `fk_branch_id` int(11) UNSIGNED NOT NULL,
  `amount` float NOT NULL,
  `total_paid` float DEFAULT NULL,
  `created_by` int(11) UNSIGNED NOT NULL,
  `updated_by` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`id`, `invoice_no`, `t_date`, `ref_id`, `fk_client_id`, `fk_account_id`, `fk_method_id`, `fk_company_id`, `fk_branch_id`, `amount`, `total_paid`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, '1802091', '2017-08-09', NULL, 2, 1, 3, 1, 2, 18000, 18000, 4, 4, '2018-02-09 19:25:52', '2018-02-09 19:27:01'),
(2, '1802092', '2017-09-27', NULL, 3, 1, 3, 1, 2, 18000, 18000, 4, NULL, '2018-02-09 19:31:04', '2018-02-09 19:31:04'),
(3, '1802093', '2017-10-29', NULL, 3, 1, 3, 1, 2, 18000, 18000, 4, NULL, '2018-02-09 19:34:25', '2018-02-09 19:34:25'),
(4, '1802094', '2017-08-12', NULL, 4, 1, 3, 1, 2, 10136, 10136, 4, 4, '2018-02-09 19:43:56', '2018-02-10 12:19:20'),
(5, '1802095', '2017-09-13', 25787, 4, 1, 3, 1, 2, 4295, 4295, 4, NULL, '2018-02-09 19:49:01', '2018-02-09 19:49:01'),
(6, '1802096', '2017-10-14', 26091, 4, 1, 3, 1, 2, 4017, 4017, 4, NULL, '2018-02-09 19:53:58', '2018-02-09 19:53:58'),
(7, '1802097', '2017-11-13', 26391, 4, 1, 3, 1, 2, 4467, 4467, 4, NULL, '2018-02-09 19:56:39', '2018-02-09 19:56:39'),
(8, '1802098', '2017-12-15', 26850, 4, 1, 3, 1, 2, 4374, 4374, 4, NULL, '2018-02-09 19:59:53', '2018-02-09 19:59:53'),
(9, '1802099', '2018-01-16', 27228, 4, 1, 3, 1, 2, 4136, 4136, 4, NULL, '2018-02-10 10:15:54', '2018-02-10 10:15:54'),
(10, '1802100', '2017-07-15', 25142, 4, 1, 3, 1, 2, 5408, 5408, 4, NULL, '2018-02-10 11:50:23', '2018-02-10 11:50:23'),
(11, '1802101', '2017-07-31', NULL, 5, 1, 3, 1, 2, 2644, 2644, 4, NULL, '2018-02-10 12:03:06', '2018-02-10 12:03:06'),
(12, '1802102', '2017-07-31', NULL, 5, 1, 3, 1, 2, 2185, 2185, 4, NULL, '2018-02-10 12:06:07', '2018-02-10 12:06:07'),
(13, '1802103', '2017-07-09', NULL, 6, 1, 3, 1, 2, 800, 800, 4, NULL, '2018-02-10 12:10:02', '2018-02-10 12:10:02'),
(14, '1802104', '2017-08-14', NULL, 6, 1, 3, 1, 2, 800, 800, 4, NULL, '2018-02-10 12:26:32', '2018-02-10 12:26:32'),
(15, '1802105', '2017-08-31', NULL, 5, 1, 3, 1, 2, 3605, 3605, 4, NULL, '2018-02-10 12:40:17', '2018-02-10 12:40:17'),
(16, '1802106', '2017-08-31', NULL, 5, 1, 3, 1, 2, 2415, 2415, 4, NULL, '2018-02-10 12:42:00', '2018-02-10 12:42:00'),
(17, '1802107', '2017-08-26', NULL, 5, 1, 3, 1, 2, 1470, 1470, 4, NULL, '2018-02-10 12:43:26', '2018-02-10 12:43:26'),
(18, '1802108', '2017-08-05', NULL, 7, 1, 3, 1, 2, 3000, 3000, 4, NULL, '2018-02-10 12:54:24', '2018-02-10 12:54:24'),
(19, '1802109', '2017-09-16', NULL, 6, 1, 3, 1, 2, 800, 800, 4, NULL, '2018-02-10 12:59:33', '2018-02-10 12:59:33'),
(20, '1802110', '2017-09-30', NULL, 5, 1, 3, 1, 2, 2840, 2840, 4, NULL, '2018-02-10 13:03:49', '2018-02-10 13:03:49'),
(21, '1802111', '2017-09-30', NULL, 5, 1, 3, 1, 2, 1200, 1200, 4, NULL, '2018-02-10 13:04:46', '2018-02-10 13:04:46'),
(22, '1802112', '2017-10-04', NULL, 5, 1, 3, 1, 2, 12000, 12000, 4, NULL, '2018-02-10 13:06:54', '2018-02-10 13:06:54'),
(23, '1802113', '2017-10-07', NULL, 6, 1, 3, 1, 2, 800, 800, 4, NULL, '2018-02-10 13:09:33', '2018-02-10 13:09:33'),
(24, '1802114', '2017-10-25', NULL, 7, 1, 3, 1, 2, 8000, 8000, 4, 4, '2018-02-10 13:15:56', '2018-02-10 13:16:34'),
(25, '1802115', '2017-10-31', NULL, 5, 1, 3, 1, 2, 3453, 3453, 4, NULL, '2018-02-10 13:21:01', '2018-02-10 13:21:01'),
(26, '1802116', '2017-10-31', NULL, 5, 1, 3, 1, 2, 3465, 3465, 4, NULL, '2018-02-10 13:21:57', '2018-02-10 13:21:57'),
(27, '1802117', '2017-11-01', NULL, 7, 1, 3, 1, 2, 5000, 5000, 4, NULL, '2018-02-10 13:41:28', '2018-02-10 13:41:28'),
(28, '1802118', '2017-11-07', NULL, 6, 1, 3, 1, 2, 800, 800, 4, NULL, '2018-02-10 13:44:40', '2018-02-10 13:44:40'),
(29, '1802119', '2017-11-29', NULL, 5, 1, 3, 1, 2, 100, 100, 4, NULL, '2018-02-10 13:50:59', '2018-02-10 13:50:59'),
(30, '1802120', '2017-11-30', NULL, 5, 1, 3, 1, 2, 2650, 2650, 4, NULL, '2018-02-10 13:52:11', '2018-02-10 13:52:11'),
(31, '1802121', '2017-11-30', NULL, 5, 1, 3, 1, 2, 5523, 5523, 4, NULL, '2018-02-10 13:53:32', '2018-02-10 13:53:32'),
(32, '1802122', '2017-12-11', NULL, 5, 1, 3, 1, 2, 800, 800, 4, NULL, '2018-02-10 13:58:07', '2018-02-10 13:58:07'),
(33, '1802123', '2017-12-31', NULL, 5, 1, 3, 1, 2, 470, 470, 4, NULL, '2018-02-10 14:02:39', '2018-02-10 14:02:39'),
(34, '1802124', '2017-12-31', NULL, 5, 1, 3, 1, 2, 2568, 2568, 4, NULL, '2018-02-10 14:03:34', '2018-02-10 14:03:34'),
(35, '1802125', '2017-12-31', NULL, 5, 1, 3, 1, 2, 255, 255, 4, NULL, '2018-02-10 14:04:58', '2018-02-10 14:04:58'),
(36, '1802126', '2018-01-07', NULL, 6, 1, 3, 1, 2, 800, 800, 4, NULL, '2018-02-10 14:07:27', '2018-02-10 14:07:27'),
(37, '1802127', '2018-01-31', NULL, 5, 1, 3, 1, 2, 1260, 1260, 4, NULL, '2018-02-10 14:14:59', '2018-02-10 14:14:59'),
(38, '1802128', '2018-01-29', NULL, 8, 1, 3, 1, 2, 2000, 2000, 4, NULL, '2018-02-10 14:16:40', '2018-02-10 14:16:40'),
(39, '1802129', '2018-01-31', NULL, 8, 1, 3, 1, 2, 20000, 20000, 4, NULL, '2018-02-10 14:17:47', '2018-02-10 14:17:47'),
(40, '1802130', '2018-01-31', NULL, 5, 1, 3, 1, 2, 2730, 2730, 4, NULL, '2018-02-10 14:21:46', '2018-02-10 14:21:46'),
(41, '1802131', '2018-01-31', NULL, 5, 1, 3, 1, 2, 2440, 2440, 4, NULL, '2018-02-10 14:22:44', '2018-02-10 14:22:44'),
(42, '1802132', '2017-07-10', NULL, 2, 1, 3, 1, 2, 1800, 1800, 4, 4, '2018-02-11 11:55:25', '2018-02-11 11:56:40'),
(43, '1802133', '2017-12-10', NULL, 2, 1, 3, 1, 2, 18000, 18000, 3, NULL, '2018-02-12 11:25:28', '2018-02-12 11:25:28'),
(44, '1802134', '2017-11-10', NULL, 2, 1, 3, 1, 2, 18000, 18000, 3, NULL, '2018-02-12 11:26:30', '2018-02-12 11:26:30'),
(45, '1802135', '2018-01-10', NULL, 2, 1, 3, 1, 2, 18000, 18000, 3, NULL, '2018-02-12 11:33:17', '2018-02-12 11:33:17'),
(46, '1802136', '2018-02-10', NULL, 2, 1, 3, 1, 2, 18000, 18000, 3, NULL, '2018-02-12 11:35:23', '2018-02-12 11:35:23'),
(47, '1802137', '2018-02-14', 27470, 4, 1, 3, 1, 2, 4321, 4321, 3, NULL, '2018-02-14 13:34:57', '2018-02-14 13:34:57'),
(48, '1802138', '2017-09-30', NULL, 9, 1, 3, 1, 4, 400, 400, 7, NULL, '2018-02-25 17:40:55', '2018-02-25 17:40:55'),
(49, '1802139', '2017-09-03', NULL, 10, 1, 3, 1, 4, 35000, 35000, 7, NULL, '2018-02-25 17:45:56', '2018-02-25 17:45:56'),
(50, '1802140', '2017-10-08', NULL, 10, 1, 3, 1, 4, 35000, 35000, 7, NULL, '2018-02-25 17:47:41', '2018-02-25 17:47:41'),
(51, '1802141', '2017-11-11', NULL, 10, 1, 3, 1, 4, 35000, 35000, 7, NULL, '2018-02-25 17:49:11', '2018-02-25 17:49:11'),
(52, '1802142', '2017-12-13', NULL, 10, 1, 3, 1, 4, 35000, 35000, 7, NULL, '2018-02-25 17:50:40', '2018-02-25 17:50:40'),
(53, '1802143', '2018-01-20', NULL, 10, 1, 3, 1, 4, 35000, 35000, 7, NULL, '2018-02-25 17:51:44', '2018-02-25 17:51:44'),
(54, '1802144', '2017-10-14', NULL, 11, 1, 3, 1, 4, 5568, 5568, 7, NULL, '2018-02-25 17:57:03', '2018-02-25 17:57:03'),
(55, '1802145', '2017-11-13', NULL, 11, 1, 3, 1, 4, 6033, 6033, 7, 7, '2018-02-25 18:00:19', '2018-02-25 18:01:29'),
(56, '1802146', '2017-12-15', NULL, 11, 1, 3, 1, 4, 6470, 6470, 7, NULL, '2018-02-25 18:04:16', '2018-02-25 18:04:16'),
(57, '1802147', '2018-01-16', NULL, 11, 1, 3, 1, 4, 6204, 6204, 7, NULL, '2018-02-25 18:07:44', '2018-02-25 18:07:44'),
(58, '1802148', '2018-02-14', NULL, 11, 1, 3, 1, 4, 6708, 6708, 7, NULL, '2018-02-25 18:09:32', '2018-02-25 18:09:32'),
(59, '1802149', '2017-09-30', NULL, 12, 1, 3, 1, 4, 3190, 3190, 7, NULL, '2018-02-25 18:12:34', '2018-02-25 18:12:34'),
(60, '1802150', '2017-09-30', NULL, 13, 1, 3, 1, 4, 30000, 30000, 7, NULL, '2018-02-25 18:18:09', '2018-02-25 18:18:09'),
(61, '1802151', '2017-10-31', NULL, 13, 1, 3, 1, 4, 25000, 25000, 7, NULL, '2018-02-25 18:28:33', '2018-02-25 18:28:33'),
(62, '1802152', '2017-10-31', NULL, 9, 1, 3, 1, 4, 2275, 2275, 7, NULL, '2018-02-25 18:29:44', '2018-02-25 18:29:44'),
(63, '1802153', '2017-10-31', NULL, 12, 1, 3, 1, 4, 300, 300, 7, NULL, '2018-02-25 18:31:07', '2018-02-25 18:31:07'),
(64, '1802154', '2017-11-30', NULL, 13, 1, 3, 1, 4, 25000, 25000, 7, NULL, '2018-02-25 18:32:48', '2018-02-25 18:32:48'),
(65, '1802155', '2017-11-30', NULL, 9, 1, 3, 1, 4, 2955, 2955, 7, NULL, '2018-02-25 18:34:07', '2018-02-25 18:34:07'),
(66, '1802156', '2017-11-30', NULL, 12, 1, 3, 1, 4, 1275, 1275, 7, NULL, '2018-02-25 18:35:22', '2018-02-25 18:35:22'),
(67, '1802157', '2017-12-31', NULL, 13, 1, 3, 1, 4, 25000, 25000, 7, NULL, '2018-02-25 18:37:31', '2018-02-25 18:37:31'),
(68, '1802158', '2017-12-31', NULL, 9, 1, 3, 1, 4, 2985, 2985, 7, NULL, '2018-02-25 18:38:34', '2018-02-25 18:38:34'),
(69, '1802159', '2017-12-31', NULL, 12, 1, 3, 1, 4, 1145, 1145, 7, NULL, '2018-02-25 18:39:37', '2018-02-25 18:39:37'),
(70, '1802160', '2018-01-31', NULL, 13, 1, 3, 1, 4, 25000, 25000, 7, NULL, '2018-02-25 18:41:27', '2018-02-25 18:41:27'),
(71, '1802161', '2018-01-31', NULL, 9, 1, 3, 1, 4, 3875, 3875, 7, NULL, '2018-02-25 18:42:52', '2018-02-25 18:42:52'),
(72, '1802162', '2018-01-31', NULL, 12, 1, 3, 1, 4, 1265, 1265, 7, NULL, '2018-02-25 18:44:02', '2018-02-25 18:44:02'),
(73, '1802163', '2018-02-28', NULL, 13, 1, 3, 1, 4, 25000, 25000, 5, NULL, '2018-02-28 19:32:01', '2018-02-28 19:32:01'),
(74, '1802164', '2018-02-28', NULL, 10, 1, 3, 1, 4, 35000, 35000, 5, NULL, '2018-02-28 19:33:12', '2018-02-28 19:33:12'),
(75, '1802165', '2018-02-28', NULL, 9, 1, 3, 1, 4, 3045, 3045, 6, NULL, '2018-03-01 00:32:51', '2018-03-01 00:32:51'),
(76, '1802166', '2018-02-28', NULL, 12, 1, 3, 1, 4, 3006, 3006, 6, NULL, '2018-03-01 00:33:44', '2018-03-01 00:33:44'),
(77, '1802167', '2018-02-02', NULL, 5, 1, 3, 1, 2, 160, 160, 5, NULL, '2018-03-04 17:37:51', '2018-03-04 17:37:51'),
(78, '1802168', '2018-02-03', NULL, 5, 1, 3, 1, 2, 60, 60, 5, NULL, '2018-03-04 17:41:00', '2018-03-04 17:41:00'),
(79, '1802169', '2018-02-04', NULL, 5, 1, 3, 1, 2, 160, 160, 5, NULL, '2018-03-04 17:42:22', '2018-03-04 17:42:22'),
(80, '1802170', '2018-02-05', NULL, 5, 1, 3, 1, 2, 90, 90, 5, NULL, '2018-03-04 17:43:15', '2018-03-04 17:43:15'),
(81, '1802171', '2018-02-06', NULL, 5, 1, 3, 1, 2, 100, 100, 5, NULL, '2018-03-04 17:44:09', '2018-03-04 17:44:09'),
(82, '1802172', '2018-02-07', NULL, 5, 1, 3, 1, 2, 60, 60, 5, NULL, '2018-03-04 17:45:22', '2018-03-04 17:45:22'),
(83, '1802173', '2018-02-07', NULL, 8, 1, 3, 1, 2, 10000, 10000, 5, NULL, '2018-03-04 17:46:39', '2018-03-04 17:46:39'),
(84, '1802174', '2018-02-09', NULL, 5, 1, 3, 1, 2, 90, 90, 5, NULL, '2018-03-04 17:47:42', '2018-03-04 17:47:42'),
(85, '1802175', '2018-02-10', NULL, 5, 1, 3, 1, 2, 90, 90, 5, NULL, '2018-03-04 17:48:59', '2018-03-04 17:48:59'),
(86, '1802176', '2018-02-11', NULL, 5, 1, 3, 1, 2, 230, 230, 5, NULL, '2018-03-04 20:16:31', '2018-03-04 20:16:31'),
(87, '1802177', '2018-02-14', NULL, 5, 1, 3, 1, 2, 60, 60, 5, NULL, '2018-03-04 20:17:58', '2018-03-04 20:17:58'),
(88, '1802178', '2018-02-16', NULL, 5, 1, 3, 1, 2, 230, 230, 5, NULL, '2018-03-04 20:19:15', '2018-03-04 20:19:15'),
(89, '1802179', '2018-02-17', NULL, 5, 1, 3, 1, 2, 60, 60, 5, NULL, '2018-03-04 20:19:58', '2018-03-04 20:19:58'),
(90, '1802180', '2018-02-18', NULL, 5, 1, 3, 1, 2, 60, 60, 5, NULL, '2018-03-04 20:20:57', '2018-03-04 20:20:57'),
(91, '1802181', '2018-02-19', NULL, 5, 1, 3, 1, 2, 220, 220, 5, NULL, '2018-03-04 20:22:10', '2018-03-04 20:22:10'),
(92, '1802182', '2018-02-19', NULL, 6, 1, 3, 1, 2, 800, 800, 5, NULL, '2018-03-04 20:23:26', '2018-03-04 20:23:26'),
(93, '1802183', '2018-02-20', NULL, 5, 1, 3, 1, 2, 60, 60, 5, NULL, '2018-03-04 20:24:55', '2018-03-04 20:24:55'),
(94, '1802184', '2018-02-20', NULL, 8, 1, 3, 1, 2, 10000, 10000, 5, NULL, '2018-03-04 20:26:00', '2018-03-04 20:26:00'),
(95, '1802185', '2018-02-23', NULL, 5, 1, 3, 1, 2, 80, 80, 5, NULL, '2018-03-04 20:28:30', '2018-03-04 20:28:30'),
(96, '1802186', '2018-02-24', NULL, 5, 1, 3, 1, 2, 30, 30, 5, NULL, '2018-03-04 20:29:07', '2018-03-04 20:29:07'),
(97, '1802187', '2018-02-25', NULL, 5, 1, 3, 1, 2, 180, 180, 5, NULL, '2018-03-04 20:30:02', '2018-03-04 20:30:02'),
(98, '1802188', '2018-02-26', NULL, 5, 1, 3, 1, 2, 115, 115, 5, NULL, '2018-03-04 20:31:17', '2018-03-04 20:31:17'),
(99, '1802189', '2018-02-27', NULL, 5, 1, 3, 1, 2, 60, 60, 5, NULL, '2018-03-04 20:32:31', '2018-03-04 20:32:31'),
(100, '1802190', '2018-02-27', NULL, 5, 1, 3, 1, 2, 600, 600, 5, NULL, '2018-03-04 20:34:49', '2018-03-04 20:34:49'),
(101, '1802191', '2018-03-04', NULL, 5, 1, 3, 1, 2, 130, 130, 5, NULL, '2018-03-04 20:36:10', '2018-03-04 20:36:10'),
(102, '1802192', '2018-02-28', NULL, 8, 1, 3, 1, 2, 5000, 5000, 5, NULL, '2018-03-04 20:36:53', '2018-03-04 20:36:53'),
(103, '1802193', '2020-10-09', 1221, 10, 1, 3, 1, 4, 1000, 1000, 1, NULL, '2020-10-09 04:36:20', '2020-10-09 04:36:20');

-- --------------------------------------------------------

--
-- Table structure for table `payment_cost_item`
--

CREATE TABLE `payment_cost_item` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_payment_id` int(10) UNSIGNED NOT NULL,
  `fk_sub_category_id` int(10) UNSIGNED NOT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_amount` decimal(10,0) NOT NULL,
  `paid_amount` decimal(10,0) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `payment_cost_item`
--

INSERT INTO `payment_cost_item` (`id`, `fk_payment_id`, `fk_sub_category_id`, `description`, `total_amount`, `paid_amount`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'July 2017', 18000, 18000, '2018-02-09 07:25:52', '2018-02-09 07:27:01'),
(2, 2, 2, 'August 2017 Shop Rent', 18000, 18000, '2018-02-09 07:31:04', NULL),
(3, 3, 2, 'September 2017 Shop Rent', 18000, 18000, '2018-02-09 07:34:25', NULL),
(4, 4, 3, 'July 2017.Electric Bill Add Bill', 6990, 6990, '2018-02-09 07:43:56', '2018-02-10 00:21:08'),
(5, 5, 3, 'August 2017', 4295, 4295, '2018-02-09 07:49:01', NULL),
(6, 6, 3, 'E & S Bill September 2017', 4017, 4017, '2018-02-09 07:53:58', NULL),
(7, 7, 3, 'E & S Bill October 2017', 4467, 4467, '2018-02-09 07:56:39', NULL),
(8, 8, 3, 'E & S Bill November 2017', 4374, 4374, '2018-02-09 07:59:53', NULL),
(9, 9, 3, 'E & S Bill December 2017', 4136, 4136, '2018-02-10 10:15:54', NULL),
(10, 10, 3, 'June 2017.Electric Bill', 5408, 5408, '2018-02-10 11:50:23', NULL),
(11, 11, 1, '1-31 July tee & nasta bill', 2644, 2644, '2018-02-10 00:03:06', NULL),
(12, 12, 5, 'July 2017 TADA', 2185, 2185, '2018-02-10 00:06:07', NULL),
(13, 13, 4, 'July 2017.Net Bill', 800, 800, '2018-02-10 00:10:02', NULL),
(14, 14, 4, 'August 2017 Net Bill', 800, 800, '2018-02-10 00:26:32', NULL),
(15, 15, 1, 'August 2017 Tee Bill', 3605, 3605, '2018-02-10 00:40:17', NULL),
(16, 16, 5, 'August 2017', 2415, 2415, '2018-02-10 00:42:00', NULL),
(17, 17, 6, 'August 2017', 1470, 1470, '2018-02-10 00:43:26', NULL),
(18, 18, 7, 'advance', 3000, 3000, '2018-02-10 00:54:24', NULL),
(19, 19, 4, 'September 2017', 800, 800, '2018-02-10 00:59:33', NULL),
(20, 20, 1, 'September 2017', 2840, 2840, '2018-02-10 01:03:49', NULL),
(21, 21, 5, 'September 2017', 1200, 1200, '2018-02-10 01:04:46', NULL),
(22, 22, 6, '2875 pics', 12000, 12000, '2018-02-10 01:06:54', NULL),
(23, 23, 4, 'October 2017', 800, 800, '2018-02-10 01:09:33', NULL),
(24, 24, 7, 'tax', 8580, 8580, '2018-02-10 01:15:56', '2018-02-10 01:16:34'),
(25, 25, 1, 'October 2017', 3453, 3453, '2018-02-10 01:21:01', NULL),
(26, 26, 5, 'October 2017', 3465, 3465, '2018-02-10 01:21:57', NULL),
(27, 27, 7, 'tax', 5000, 5000, '2018-02-10 01:41:28', NULL),
(28, 28, 4, 'November 2017', 800, 800, '2018-02-10 01:44:40', NULL),
(29, 29, 6, 'November 2017', 100, 100, '2018-02-10 01:50:59', NULL),
(30, 30, 1, 'November 2017', 2650, 2650, '2018-02-10 01:52:11', NULL),
(31, 31, 5, 'November 2017', 5523, 5523, '2018-02-10 01:53:32', NULL),
(32, 32, 4, 'December 2017', 800, 800, '2018-02-10 01:58:07', NULL),
(33, 33, 6, 'December 2017', 470, 470, '2018-02-10 02:02:39', NULL),
(34, 34, 1, 'December 2017', 2568, 2568, '2018-02-10 02:03:34', NULL),
(35, 35, 5, 'December 2017', 255, 255, '2018-02-10 02:04:58', NULL),
(36, 36, 4, 'january 2018', 800, 800, '2018-02-10 02:07:27', NULL),
(37, 37, 6, '260bag+1000 press', 1260, 1260, '2018-02-10 02:14:59', NULL),
(38, 38, 6, NULL, 2000, 2000, '2018-02-10 02:16:40', NULL),
(39, 39, 6, NULL, 20000, 20000, '2018-02-10 02:17:47', NULL),
(40, 40, 5, 'january 2018', 2730, 2730, '2018-02-10 02:21:46', NULL),
(41, 41, 1, 'january 2018', 2440, 2440, '2018-02-10 02:22:44', NULL),
(42, 42, 2, 'July 2017 Shop Rent', 18000, 18000, '2018-02-11 11:55:25', '2018-02-11 11:56:40'),
(43, 43, 2, 'December 2017', 18000, 18000, '2018-02-12 11:25:28', NULL),
(44, 44, 2, 'November 2017', 18000, 18000, '2018-02-12 11:26:30', NULL),
(45, 45, 2, 'january 2018', 18000, 18000, '2018-02-12 11:33:17', NULL),
(46, 46, 2, 'February 2018', 18000, 18000, '2018-02-12 11:35:23', NULL),
(47, 47, 3, 'February 2018', 4321, 4321, '2018-02-14 01:34:57', NULL),
(48, 48, 1, 'September 2017', 400, 400, '2018-02-25 17:40:55', NULL),
(49, 49, 2, 'September 2017 Shop Rent', 35000, 35000, '2018-02-25 17:45:56', NULL),
(50, 50, 2, 'October 2017', 35000, 35000, '2018-02-25 17:47:41', NULL),
(51, 51, 2, 'November 2017', 35000, 35000, '2018-02-25 17:49:11', NULL),
(52, 52, 2, 'December 2017', 35000, 35000, '2018-02-25 17:50:40', NULL),
(53, 53, 2, 'january 2018', 35000, 35000, '2018-02-25 17:51:44', NULL),
(54, 54, 3, 'shop #1/19-20', 5568, 5568, '2018-02-25 17:57:03', NULL),
(55, 55, 3, 'shop #1/19-20', 6033, 6033, '2018-02-25 06:00:19', '2018-02-25 06:01:29'),
(56, 56, 3, 'shop #1/19-20', 6470, 6470, '2018-02-25 06:04:16', NULL),
(57, 57, 3, 'shop #1/19-20', 6204, 6204, '2018-02-25 06:07:44', NULL),
(58, 58, 3, 'shop #1/19-20', 6708, 6708, '2018-02-25 06:09:32', NULL),
(59, 59, 5, 'September 2017', 3190, 3190, '2018-02-25 06:12:34', NULL),
(60, 60, 8, 'September 2017', 30000, 30000, '2018-02-25 06:18:09', NULL),
(61, 61, 8, 'October 2017', 25000, 25000, '2018-02-25 06:28:33', NULL),
(62, 62, 1, 'October 2017', 2275, 2275, '2018-02-25 06:29:44', NULL),
(63, 63, 5, 'October 2017', 300, 300, '2018-02-25 06:31:07', NULL),
(64, 64, 8, 'November 2017', 25000, 25000, '2018-02-25 06:32:48', NULL),
(65, 65, 1, 'November 2017', 2955, 2955, '2018-02-25 06:34:07', NULL),
(66, 66, 5, 'November 2017', 1275, 1275, '2018-02-25 06:35:22', NULL),
(67, 67, 8, 'December 2017', 25000, 25000, '2018-02-25 06:37:31', NULL),
(68, 68, 1, 'December 2017', 2985, 2985, '2018-02-25 06:38:34', NULL),
(69, 69, 5, 'December 2017', 1145, 1145, '2018-02-25 06:39:37', NULL),
(70, 70, 8, 'january 2018', 25000, 25000, '2018-02-25 06:41:27', NULL),
(71, 71, 1, 'january 2018', 3875, 3875, '2018-02-25 06:42:52', NULL),
(72, 72, 5, 'january 2018', 1265, 1265, '2018-02-25 06:44:02', NULL),
(73, 73, 8, 'February 2018', 25000, 25000, '2018-02-28 07:32:01', NULL),
(74, 74, 2, 'shop #1/19-20', 35000, 35000, '2018-02-28 07:33:12', NULL),
(75, 75, 1, 'February 2018', 3045, 3045, '2018-02-28 12:32:51', NULL),
(76, 76, 5, 'February 2018', 3006, 3006, '2018-02-28 12:33:44', NULL),
(77, 77, 1, 'Tea bill+nasta', 160, 160, '2018-03-04 17:37:51', NULL),
(78, 78, 1, 'Nasta', 60, 60, '2018-03-04 17:41:00', NULL),
(79, 79, 1, 'Nasta', 160, 160, '2018-03-04 17:42:22', NULL),
(80, 80, 1, 'Nasta', 90, 90, '2018-03-04 17:43:15', NULL),
(81, 81, 1, 'Nasta', 100, 100, '2018-03-04 17:44:09', NULL),
(82, 82, 1, 'Nasta', 60, 60, '2018-03-04 17:45:22', NULL),
(83, 83, 6, 'Bag', 10000, 10000, '2018-03-04 17:46:39', NULL),
(84, 84, 1, 'Nasta', 90, 90, '2018-03-04 17:47:42', NULL),
(85, 85, 1, 'Nasta', 90, 90, '2018-03-04 17:48:59', NULL),
(86, 86, 1, 'Nasta+ice cream', 230, 230, '2018-03-04 08:16:31', NULL),
(87, 87, 1, 'Nasta', 60, 60, '2018-03-04 08:17:58', NULL),
(88, 88, 1, 'Nasta Tea bill', 230, 230, '2018-03-04 08:19:15', NULL),
(89, 89, 1, 'Nasta', 60, 60, '2018-03-04 08:19:58', NULL),
(90, 90, 1, 'Nasta', 60, 60, '2018-03-04 08:20:57', NULL),
(91, 91, 1, 'Nasta+ice cream', 220, 220, '2018-03-04 08:22:10', NULL),
(92, 92, 4, 'Net bill', 800, 800, '2018-03-04 08:23:26', NULL),
(93, 93, 1, 'Nasta', 60, 60, '2018-03-04 08:24:55', NULL),
(94, 94, 6, 'Bag', 10000, 10000, '2018-03-04 08:26:00', NULL),
(95, 95, 1, 'Nasta', 80, 80, '2018-03-04 08:28:30', NULL),
(96, 96, 1, 'Nasta', 30, 30, '2018-03-04 08:29:07', NULL),
(97, 97, 1, 'Nasta Tea bill', 180, 180, '2018-03-04 08:30:02', NULL),
(98, 98, 1, 'Nasta lunch', 115, 115, '2018-03-04 08:31:17', NULL),
(99, 99, 1, 'Nasta', 60, 60, '2018-03-04 08:32:31', NULL),
(100, 100, 5, 'Khala.Jan-18,Feb-18', 600, 600, '2018-03-04 08:34:49', NULL),
(101, 101, 1, 'Nasta Tea bill', 130, 130, '2018-03-04 08:36:10', NULL),
(102, 102, 6, 'Bag', 5000, 5000, '2018-03-04 08:36:53', NULL),
(103, 103, 3, 'wfewd', 1000, 1000, '2020-10-09 04:36:20', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment_history`
--

CREATE TABLE `payment_history` (
  `id` int(11) NOT NULL,
  `invoice_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `fk_payment_item_id` int(11) UNSIGNED DEFAULT NULL,
  `last_due` float NOT NULL,
  `paid` float DEFAULT NULL,
  `payment_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `payment_history`
--

INSERT INTO `payment_history` (`id`, `invoice_id`, `created_by`, `fk_payment_item_id`, `last_due`, `paid`, `payment_date`, `created_at`, `updated_at`) VALUES
(1, '1802091', 4, 1, 18000, 18000, '2017-08-09', '2018-02-09 19:25:52', '2018-02-09 19:25:52'),
(2, '1802092', 4, 2, 18000, 18000, '2017-09-27', '2018-02-09 19:31:04', '2018-02-09 19:31:04'),
(3, '1802093', 4, 3, 18000, 18000, '2017-10-29', '2018-02-09 19:34:25', '2018-02-09 19:34:25'),
(4, '1802094', 4, 4, 10136, 10136, '2017-08-12', '2018-02-09 19:43:56', '2018-02-09 19:43:56'),
(5, '1802095', 4, 5, 4295, 4295, '2017-09-13', '2018-02-09 19:49:01', '2018-02-09 19:49:01'),
(6, '1802096', 4, 6, 4017, 4017, '2017-10-14', '2018-02-09 19:53:58', '2018-02-09 19:53:58'),
(7, '1802097', 4, 7, 4467, 4467, '2017-11-13', '2018-02-09 19:56:39', '2018-02-09 19:56:39'),
(8, '1802098', 4, 8, 4374, 4374, '2017-12-15', '2018-02-09 19:59:53', '2018-02-09 19:59:53'),
(9, '1802099', 4, 9, 4136, 4136, '2018-01-16', '2018-02-10 10:15:54', '2018-02-10 10:15:54'),
(10, '1802100', 4, 10, 5408, 5408, '2017-07-15', '2018-02-10 11:50:23', '2018-02-10 11:50:23'),
(11, '1802101', 4, 11, 2644, 2644, '2017-07-31', '2018-02-10 12:03:06', '2018-02-10 12:03:06'),
(12, '1802102', 4, 12, 2185, 2185, '2017-07-31', '2018-02-10 12:06:07', '2018-02-10 12:06:07'),
(13, '1802103', 4, 13, 800, 800, '2017-07-09', '2018-02-10 12:10:02', '2018-02-10 12:10:02'),
(14, '1802104', 4, 14, 800, 800, '2017-08-14', '2018-02-10 12:26:32', '2018-02-10 12:26:32'),
(15, '1802105', 4, 15, 3605, 3605, '2017-08-31', '2018-02-10 12:40:17', '2018-02-10 12:40:17'),
(16, '1802106', 4, 16, 2415, 2415, '2017-08-31', '2018-02-10 12:42:00', '2018-02-10 12:42:00'),
(17, '1802107', 4, 17, 1470, 1470, '2017-08-26', '2018-02-10 12:43:26', '2018-02-10 12:43:26'),
(18, '1802108', 4, 18, 3000, 3000, '2017-08-05', '2018-02-10 12:54:24', '2018-02-10 12:54:24'),
(19, '1802109', 4, 19, 800, 800, '2017-09-16', '2018-02-10 12:59:33', '2018-02-10 12:59:33'),
(20, '1802110', 4, 20, 2840, 2840, '2017-09-30', '2018-02-10 13:03:49', '2018-02-10 13:03:49'),
(21, '1802111', 4, 21, 1200, 1200, '2017-09-30', '2018-02-10 13:04:46', '2018-02-10 13:04:46'),
(22, '1802112', 4, 22, 12000, 12000, '2017-10-04', '2018-02-10 13:06:54', '2018-02-10 13:06:54'),
(23, '1802113', 4, 23, 800, 800, '2017-10-07', '2018-02-10 13:09:33', '2018-02-10 13:09:33'),
(24, '1802114', 4, 24, 8000, 8000, '2017-10-25', '2018-02-10 13:15:56', '2018-02-10 13:15:56'),
(25, '1802115', 4, 25, 3453, 3453, '2017-10-31', '2018-02-10 13:21:01', '2018-02-10 13:21:01'),
(26, '1802116', 4, 26, 3465, 3465, '2017-10-31', '2018-02-10 13:21:57', '2018-02-10 13:21:57'),
(27, '1802117', 4, 27, 5000, 5000, '2017-11-01', '2018-02-10 13:41:28', '2018-02-10 13:41:28'),
(28, '1802118', 4, 28, 800, 800, '2017-11-07', '2018-02-10 13:44:40', '2018-02-10 13:44:40'),
(29, '1802119', 4, 29, 100, 100, '2017-11-29', '2018-02-10 13:50:59', '2018-02-10 13:50:59'),
(30, '1802120', 4, 30, 2650, 2650, '2017-11-30', '2018-02-10 13:52:11', '2018-02-10 13:52:11'),
(31, '1802121', 4, 31, 5523, 5523, '2017-11-30', '2018-02-10 13:53:32', '2018-02-10 13:53:32'),
(32, '1802122', 4, 32, 800, 800, '2017-12-11', '2018-02-10 13:58:07', '2018-02-10 13:58:07'),
(33, '1802123', 4, 33, 470, 470, '2017-12-31', '2018-02-10 14:02:39', '2018-02-10 14:02:39'),
(34, '1802124', 4, 34, 2568, 2568, '2017-12-31', '2018-02-10 14:03:34', '2018-02-10 14:03:34'),
(35, '1802125', 4, 35, 255, 255, '2017-12-31', '2018-02-10 14:04:58', '2018-02-10 14:04:58'),
(36, '1802126', 4, 36, 800, 800, '2018-01-07', '2018-02-10 14:07:27', '2018-02-10 14:07:27'),
(37, '1802127', 4, 37, 1260, 1260, '2018-01-31', '2018-02-10 14:14:59', '2018-02-10 14:14:59'),
(38, '1802128', 4, 38, 2000, 2000, '2018-01-29', '2018-02-10 14:16:40', '2018-02-10 14:16:40'),
(39, '1802129', 4, 39, 20000, 20000, '2018-01-31', '2018-02-10 14:17:47', '2018-02-10 14:17:47'),
(40, '1802130', 4, 40, 2730, 2730, '2018-01-31', '2018-02-10 14:21:46', '2018-02-10 14:21:46'),
(41, '1802131', 4, 41, 2440, 2440, '2018-01-31', '2018-02-10 14:22:44', '2018-02-10 14:22:44'),
(42, '1802132', 4, 42, 1800, 1800, '2017-07-10', '2018-02-11 11:55:25', '2018-02-11 11:55:25'),
(43, '1802133', 3, 43, 18000, 18000, '2017-12-10', '2018-02-12 11:25:28', '2018-02-12 11:25:28'),
(44, '1802134', 3, 44, 18000, 18000, '2017-11-10', '2018-02-12 11:26:30', '2018-02-12 11:26:30'),
(45, '1802135', 3, 45, 18000, 18000, '2018-01-10', '2018-02-12 11:33:17', '2018-02-12 11:33:17'),
(46, '1802136', 3, 46, 18000, 18000, '2018-02-10', '2018-02-12 11:35:23', '2018-02-12 11:35:23'),
(47, '1802137', 3, 47, 4321, 4321, '2018-02-14', '2018-02-14 13:34:57', '2018-02-14 13:34:57'),
(48, '1802138', 7, 48, 400, 400, '2017-09-30', '2018-02-25 17:40:55', '2018-02-25 17:40:55'),
(49, '1802139', 7, 49, 35000, 35000, '2017-09-03', '2018-02-25 17:45:56', '2018-02-25 17:45:56'),
(50, '1802140', 7, 50, 35000, 35000, '2017-10-08', '2018-02-25 17:47:41', '2018-02-25 17:47:41'),
(51, '1802141', 7, 51, 35000, 35000, '2017-11-11', '2018-02-25 17:49:11', '2018-02-25 17:49:11'),
(52, '1802142', 7, 52, 35000, 35000, '2017-12-13', '2018-02-25 17:50:40', '2018-02-25 17:50:40'),
(53, '1802143', 7, 53, 35000, 35000, '2018-01-20', '2018-02-25 17:51:44', '2018-02-25 17:51:44'),
(54, '1802144', 7, 54, 5568, 5568, '2017-10-14', '2018-02-25 17:57:03', '2018-02-25 17:57:03'),
(55, '1802145', 7, 55, 6033, 6033, '2018-02-25', '2018-02-25 18:00:19', '2018-02-25 18:00:19'),
(56, '1802146', 7, 56, 6470, 6470, '2017-12-15', '2018-02-25 18:04:16', '2018-02-25 18:04:16'),
(57, '1802147', 7, 57, 6204, 6204, '2018-01-16', '2018-02-25 18:07:44', '2018-02-25 18:07:44'),
(58, '1802148', 7, 58, 6708, 6708, '2018-02-14', '2018-02-25 18:09:32', '2018-02-25 18:09:32'),
(59, '1802149', 7, 59, 3190, 3190, '2017-09-30', '2018-02-25 18:12:34', '2018-02-25 18:12:34'),
(60, '1802150', 7, 60, 30000, 30000, '2017-09-30', '2018-02-25 18:18:09', '2018-02-25 18:18:09'),
(61, '1802151', 7, 61, 25000, 25000, '2017-10-31', '2018-02-25 18:28:33', '2018-02-25 18:28:33'),
(62, '1802152', 7, 62, 2275, 2275, '2017-10-31', '2018-02-25 18:29:44', '2018-02-25 18:29:44'),
(63, '1802153', 7, 63, 300, 300, '2017-10-31', '2018-02-25 18:31:07', '2018-02-25 18:31:07'),
(64, '1802154', 7, 64, 25000, 25000, '2017-11-30', '2018-02-25 18:32:48', '2018-02-25 18:32:48'),
(65, '1802155', 7, 65, 2955, 2955, '2017-11-30', '2018-02-25 18:34:07', '2018-02-25 18:34:07'),
(66, '1802156', 7, 66, 1275, 1275, '2017-11-30', '2018-02-25 18:35:22', '2018-02-25 18:35:22'),
(67, '1802157', 7, 67, 25000, 25000, '2017-12-31', '2018-02-25 18:37:31', '2018-02-25 18:37:31'),
(68, '1802158', 7, 68, 2985, 2985, '2017-12-31', '2018-02-25 18:38:34', '2018-02-25 18:38:34'),
(69, '1802159', 7, 69, 1145, 1145, '2017-12-31', '2018-02-25 18:39:37', '2018-02-25 18:39:37'),
(70, '1802160', 7, 70, 25000, 25000, '2018-01-31', '2018-02-25 18:41:27', '2018-02-25 18:41:27'),
(71, '1802161', 7, 71, 3875, 3875, '2018-01-31', '2018-02-25 18:42:52', '2018-02-25 18:42:52'),
(72, '1802162', 7, 72, 1265, 1265, '2018-01-31', '2018-02-25 18:44:02', '2018-02-25 18:44:02'),
(73, '1802163', 5, 73, 25000, 25000, '2018-02-28', '2018-02-28 19:32:01', '2018-02-28 19:32:01'),
(74, '1802164', 5, 74, 35000, 35000, '2018-02-28', '2018-02-28 19:33:12', '2018-02-28 19:33:12'),
(75, '1802165', 6, 75, 3045, 3045, '2018-02-28', '2018-03-01 00:32:51', '2018-03-01 00:32:51'),
(76, '1802166', 6, 76, 3006, 3006, '2018-02-28', '2018-03-01 00:33:44', '2018-03-01 00:33:44'),
(77, '1802167', 5, 77, 160, 160, '2018-02-02', '2018-03-04 17:37:51', '2018-03-04 17:37:51'),
(78, '1802168', 5, 78, 60, 60, '2018-02-03', '2018-03-04 17:41:00', '2018-03-04 17:41:00'),
(79, '1802169', 5, 79, 160, 160, '2018-02-04', '2018-03-04 17:42:22', '2018-03-04 17:42:22'),
(80, '1802170', 5, 80, 90, 90, '2018-02-05', '2018-03-04 17:43:15', '2018-03-04 17:43:15'),
(81, '1802171', 5, 81, 100, 100, '2018-02-06', '2018-03-04 17:44:09', '2018-03-04 17:44:09'),
(82, '1802172', 5, 82, 60, 60, '2018-02-07', '2018-03-04 17:45:22', '2018-03-04 17:45:22'),
(83, '1802173', 5, 83, 10000, 10000, '2018-02-07', '2018-03-04 17:46:39', '2018-03-04 17:46:39'),
(84, '1802174', 5, 84, 90, 90, '2018-02-09', '2018-03-04 17:47:42', '2018-03-04 17:47:42'),
(85, '1802175', 5, 85, 90, 90, '2018-02-10', '2018-03-04 17:48:59', '2018-03-04 17:48:59'),
(86, '1802176', 5, 86, 230, 230, '2018-02-11', '2018-03-04 20:16:31', '2018-03-04 20:16:31'),
(87, '1802177', 5, 87, 60, 60, '2018-02-14', '2018-03-04 20:17:58', '2018-03-04 20:17:58'),
(88, '1802178', 5, 88, 230, 230, '2018-02-16', '2018-03-04 20:19:15', '2018-03-04 20:19:15'),
(89, '1802179', 5, 89, 60, 60, '2018-02-17', '2018-03-04 20:19:58', '2018-03-04 20:19:58'),
(90, '1802180', 5, 90, 60, 60, '2018-02-18', '2018-03-04 20:20:57', '2018-03-04 20:20:57'),
(91, '1802181', 5, 91, 220, 220, '2018-02-19', '2018-03-04 20:22:10', '2018-03-04 20:22:10'),
(92, '1802182', 5, 92, 800, 800, '2018-02-19', '2018-03-04 20:23:26', '2018-03-04 20:23:26'),
(93, '1802183', 5, 93, 60, 60, '2018-02-20', '2018-03-04 20:24:55', '2018-03-04 20:24:55'),
(94, '1802184', 5, 94, 10000, 10000, '2018-02-20', '2018-03-04 20:26:00', '2018-03-04 20:26:00'),
(95, '1802185', 5, 95, 80, 80, '2018-02-23', '2018-03-04 20:28:30', '2018-03-04 20:28:30'),
(96, '1802186', 5, 96, 30, 30, '2018-02-24', '2018-03-04 20:29:07', '2018-03-04 20:29:07'),
(97, '1802187', 5, 97, 180, 180, '2018-02-25', '2018-03-04 20:30:02', '2018-03-04 20:30:02'),
(98, '1802188', 5, 98, 115, 115, '2018-02-26', '2018-03-04 20:31:17', '2018-03-04 20:31:17'),
(99, '1802189', 5, 99, 60, 60, '2018-02-27', '2018-03-04 20:32:31', '2018-03-04 20:32:31'),
(100, '1802190', 5, 100, 600, 600, '2018-02-27', '2018-03-04 20:34:49', '2018-03-04 20:34:49'),
(101, '1802191', 5, 101, 130, 130, '2018-03-04', '2018-03-04 20:36:10', '2018-03-04 20:36:10'),
(102, '1802192', 5, 102, 5000, 5000, '2018-02-28', '2018-03-04 20:36:53', '2018-03-04 20:36:53'),
(103, '1802193', 1, 103, 1000, 1000, '2020-10-09', '2020-10-09 04:36:20', '2020-10-09 04:36:20');

-- --------------------------------------------------------

--
-- Table structure for table `payment_method`
--

CREATE TABLE `payment_method` (
  `id` int(10) UNSIGNED NOT NULL,
  `method_name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `method_description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `method_status` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `payment_method`
--

INSERT INTO `payment_method` (`id`, `method_name`, `method_description`, `method_status`, `company_name`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'bKash', 'Mobile Banking system', '1', 'xyz', NULL, NULL, '2017-03-09 22:32:13', '2017-03-09 22:45:45'),
(2, 'DBBL', '<p>Mobile Banking system</p>', '1', 'xyz', NULL, NULL, '2017-03-09 22:34:10', '2017-07-14 22:39:02'),
(3, 'Cash', '', '1', '', NULL, NULL, '2017-09-10 01:36:46', '2017-09-10 01:36:46');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `resource` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'System',
  `system` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `slug`, `resource`, `system`, `created_at`, `updated_at`) VALUES
(1, 'reports', 'reports', 'Product Sales', 1, '2017-12-05 15:26:42', '2018-01-11 09:41:27'),
(2, 'my-profile', 'my-profile', 'my-profile', 1, '2018-01-30 10:58:34', '2018-02-13 18:19:36'),
(3, 'Transaction Report', 'transaction-report', 'Transaction Report', 1, '2018-02-26 14:06:28', '2018-02-26 14:06:28'),
(4, 'Account Wise Transaction', 'account-wise-transaction', 'Account Wise Transac', 1, '2018-02-26 14:06:53', '2018-02-26 14:06:53'),
(5, 'Sales Management', 'sales-management', 'Sales Management', 1, '2018-02-26 14:12:09', '2018-02-26 14:12:09'),
(6, 'General Account', 'general-account', 'General Account', 1, '2018-02-26 14:12:18', '2018-02-26 14:12:18'),
(7, 'Purchase Management', 'purchase-management', 'Purchase Management', 1, '2018-02-26 14:12:31', '2018-02-26 14:12:31'),
(8, 'Inventory Management', 'inventory-management', 'Inventory Management', 1, '2018-02-26 14:12:41', '2018-02-26 14:12:41'),
(9, 'Account Management', 'account-management', 'Account Management', 1, '2018-02-26 14:12:48', '2018-02-26 14:12:48'),
(10, 'Employee Management', 'employee-management', 'Employee Management', 1, '2018-02-26 14:12:54', '2018-02-26 14:12:54'),
(11, 'System Configuration', 'system-configuration', 'System Configuration', 1, '2018-02-26 14:13:06', '2018-02-26 14:13:06'),
(12, 'SMS-Communication', 'sms-communication', 'SMS-Communication', 1, '2018-03-06 16:46:28', '2018-03-06 16:46:28');

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `permission_role`
--

INSERT INTO `permission_role` (`id`, `permission_id`, `role_id`, `created_at`, `updated_at`) VALUES
(12, 1, 2, NULL, NULL),
(13, 2, 2, NULL, NULL),
(14, 5, 2, NULL, NULL),
(27, 1, 1, NULL, NULL),
(28, 2, 1, NULL, NULL),
(29, 3, 1, NULL, NULL),
(30, 4, 1, NULL, NULL),
(31, 5, 1, NULL, NULL),
(32, 6, 1, NULL, NULL),
(33, 7, 1, NULL, NULL),
(34, 8, 1, NULL, NULL),
(35, 9, 1, NULL, NULL),
(36, 10, 1, NULL, NULL),
(37, 11, 1, NULL, NULL),
(38, 12, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pos_product_barcode`
--

CREATE TABLE `pos_product_barcode` (
  `id` int(11) NOT NULL,
  `fk_product_id` int(11) UNSIGNED NOT NULL,
  `fk_model_id` int(11) NOT NULL,
  `barcode` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `pos_product_barcode`
--

INSERT INTO `pos_product_barcode` (`id`, `fk_product_id`, `fk_model_id`, `barcode`, `created_at`, `updated_at`) VALUES
(1, 27, 31, '2731', '2018-03-24 10:50:31', '2018-03-24 10:50:31'),
(2, 28, 32, '123', '2020-10-02 11:44:40', '2020-10-02 11:44:40');

-- --------------------------------------------------------

--
-- Table structure for table `product_brand`
--

CREATE TABLE `product_brand` (
  `id` int(10) UNSIGNED NOT NULL,
  `brand_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `product_brand`
--

INSERT INTO `product_brand` (`id`, `brand_name`, `status`, `created_at`, `updated_at`) VALUES
(3, 'Borka & Avaya', 1, '2017-12-04 13:32:07', '2018-01-23 14:19:35'),
(4, 'Fardush', 1, '2018-01-16 10:50:07', '2018-01-23 12:56:58'),
(5, 'Rakhi', 1, '2018-01-23 12:22:25', '2018-01-23 12:22:25'),
(6, 'Sweater', 1, '2018-01-23 14:20:13', '2018-01-23 14:20:13'),
(7, 'Tops Cotton', 1, '2018-01-23 14:22:37', '2018-01-23 14:23:05'),
(8, 'Tops Georget', 1, '2018-01-23 14:26:28', '2018-01-23 14:26:28'),
(9, 'Scarf', 1, '2018-01-23 14:27:44', '2018-01-23 14:27:44'),
(10, 'Ten Tops', 1, '2018-01-23 14:28:14', '2018-01-23 14:28:14'),
(11, 'Skirt', 1, '2018-01-23 14:28:45', '2018-01-23 14:28:45'),
(12, 'Shawl', 1, '2018-01-23 14:30:06', '2018-01-23 14:30:06'),
(13, 'Plazu', 1, '2018-01-23 14:31:30', '2018-01-28 15:35:46'),
(14, 'One Pics', 1, '2018-01-23 14:32:33', '2018-01-23 14:32:33'),
(15, 'Esta', 1, '2018-01-23 14:38:09', '2018-01-26 13:49:45'),
(16, 'Ekta', 1, '2018-01-23 14:38:33', '2018-01-23 14:38:33'),
(17, 'Vivek', 1, '2018-01-23 14:39:00', '2018-01-23 14:39:00'),
(18, 'Gonga', 1, '2018-01-23 14:39:28', '2018-01-23 14:39:28'),
(19, 'Sajjan', 1, '2018-01-23 14:40:17', '2018-01-23 14:40:17'),
(20, 'Omtex', 1, '2018-01-23 14:40:36', '2018-01-23 14:40:36'),
(21, 'LT Fabrics', 1, '2018-01-23 14:42:13', '2018-01-23 14:42:13'),
(22, 'Sadhana', 1, '2018-01-23 14:42:50', '2018-01-23 14:42:50');

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE `product_category` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `product_category`
--

INSERT INTO `product_category` (`id`, `category_name`, `status`, `created_at`, `updated_at`) VALUES
(2, 'India', 1, '2017-12-09 12:56:37', '2018-01-16 16:47:40'),
(3, 'China', 1, '2018-01-16 16:48:00', '2018-01-16 16:48:00'),
(4, 'Pakistan', 1, '2018-01-23 18:55:20', '2018-01-23 18:55:20'),
(5, 'Thailand', 1, '2018-01-23 18:55:39', '2018-01-23 18:55:39'),
(6, 'Bangladesh', 1, '2018-01-23 18:56:04', '2018-01-23 18:56:04');

-- --------------------------------------------------------

--
-- Table structure for table `product_invoice`
--

CREATE TABLE `product_invoice` (
  `id` int(11) NOT NULL,
  `invoice_date` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `invoice_no` int(11) DEFAULT NULL,
  `notes` int(11) DEFAULT NULL,
  `total_amount` int(11) DEFAULT NULL,
  `paid_amount` int(11) DEFAULT NULL,
  `due_amount` int(11) DEFAULT NULL,
  `vat` int(11) DEFAULT NULL,
  `delivery_charge` int(11) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_invoice_item`
--

CREATE TABLE `product_invoice_item` (
  `id` int(11) NOT NULL,
  `fk_product_invoice_id` int(11) DEFAULT NULL,
  `fk_product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `sales_amount` int(11) DEFAULT NULL,
  `sales_paid_amount` int(11) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_item`
--

CREATE TABLE `project_item` (
  `id` int(10) UNSIGNED NOT NULL,
  `project_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `project_description` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `project_status` int(11) DEFAULT NULL,
  `company_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `system` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `slug`, `description`, `system`, `created_at`, `updated_at`) VALUES
(1, 'Administrator', 'administrator', 'Admin Area', 1, '2017-12-05 10:39:39', NULL),
(2, 'Branch Admin', 'branch-admin', 'Modarator Area', 1, '2017-12-05 10:40:16', NULL),
(3, 'Sales', 'Sales', 'Worker Area', 1, '2017-12-05 10:40:34', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_user`
--

CREATE TABLE `role_user` (
  `id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `role_user`
--

INSERT INTO `role_user` (`id`, `role_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2017-12-10 14:43:12', NULL),
(2, 1, 2, NULL, NULL),
(3, 1, 3, NULL, NULL),
(4, 2, 4, NULL, NULL),
(5, 1, 5, NULL, NULL),
(6, 1, 6, NULL, NULL),
(7, 3, 7, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sms`
--

CREATE TABLE `sms` (
  `id` int(11) NOT NULL,
  `number` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `fk_client_id` int(11) UNSIGNED DEFAULT NULL,
  `message` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `message_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `error` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sms`
--

INSERT INTO `sms` (`id`, `number`, `fk_client_id`, `message`, `message_id`, `error`, `status`, `created_at`, `updated_at`) VALUES
(1, '01811951215', NULL, 'hello nmb, whats up?', '1518534377459952', '', 0, '2018-02-13 15:06:15', '2018-02-13 15:06:15'),
(2, '01811951215', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took.', '1518584064238714', '', 0, '2018-02-14 04:54:22', '2018-02-14 04:54:22'),
(3, '01811951215', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has su', '1518584885943692', '', 0, '2018-02-14 05:08:04', '2018-02-14 05:08:04'),
(4, '01811951215', NULL, 'আজ এই বসন্তের রাতে\r\nঘুমে চোখ চায় না জড়াতে;\r\nওই দিকে শোনা যায় সমুদ্রের স্বর,\r\nস্কাইলাইট মাথার উপর,\r\nআকাশে পাখিরা কথা কয় পরস্পর।', '1518586322753498', '', 0, '2018-02-14 05:32:01', '2018-02-14 05:32:01'),
(5, '8801811951215', NULL, 'এককালে তোর লাইজ্ঞা স্কুল পলাইতাম\r\nতোর লাইজ্ঞা গঞ্জ থাইক্কা চুড়ি আনিতাম\r\n\r\nতোর কথা মনে হলে গান ধরিতাম আমি\r\nতোর কথা মনে হলে গান ধরিতাম\r\nও ছেরি ও ছেরি ও ছেরি\r\nতোরে এককালে ভালোবাসিতাম\r\n\r\nএককালে তোর মায়ের বকা খাইতাম\r\nএককালে তোর বাপের দৌড়ানি খাইতাম\r\nএককালে তো', '1518588242512561', '', 0, '2018-02-14 06:04:00', '2018-02-14 06:04:00'),
(6, '01716488661', NULL, 'fdgfghfhfh', '1519568464232607', '', 2, '2018-02-26 01:21:06', '2018-02-26 01:21:06'),
(7, '8801869977131', NULL, 'well come mahee fabrics', '1519714637509425', '', 2, '2018-02-27 17:57:19', '2018-02-27 17:57:19');

-- --------------------------------------------------------

--
-- Table structure for table `sms_config`
--

CREATE TABLE `sms_config` (
  `id` int(11) NOT NULL,
  `sms_quantity` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `user_name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `from` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sms_config`
--

INSERT INTO `sms_config` (`id`, `sms_quantity`, `user_name`, `password`, `from`, `created_at`, `updated_at`) VALUES
(1, 'WEEvaENpL3VyK3BxTER3cTFYYVJqUT09', 'bnF3WjZ0Z0dJSU03NjB4YmwrSlVtQT09', 'eGd5QkcxWFgyWm5tb1p1ZVBnQnFJdz09', 'dFNhck0rNjBzdW9sUjdncFlZbFE0dz09', '2017-11-27 23:36:33', '2018-02-27 17:57:17');

-- --------------------------------------------------------

--
-- Table structure for table `sub_category`
--

CREATE TABLE `sub_category` (
  `id` int(10) UNSIGNED NOT NULL,
  `sub_category_name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `sub_category_type` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sub_category_status` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `company_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sub_category`
--

INSERT INTO `sub_category` (`id`, `sub_category_name`, `sub_category_type`, `sub_category_status`, `company_name`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Tea bill', 'Payment', '1', NULL, 1, 4, '2017-12-25 18:31:11', '2018-02-07 11:12:55'),
(2, 'Shop Rent', NULL, '1', NULL, 3, NULL, '2018-01-23 13:04:29', '2018-01-23 13:04:29'),
(3, 'Electric Bill & Service charg', NULL, '1', NULL, 3, 4, '2018-01-23 13:04:49', '2018-02-07 11:15:37'),
(4, 'Internet Bill', NULL, '1', NULL, 4, NULL, '2018-02-07 10:08:22', '2018-02-07 10:08:22'),
(5, 'Transport Bill & Other', NULL, '1', NULL, 4, 4, '2018-02-07 10:12:43', '2018-02-10 12:48:52'),
(6, 'Shopping Bag', NULL, '1', NULL, 4, NULL, '2018-02-10 12:33:34', '2018-02-10 12:33:34'),
(7, 'Income Tax', NULL, '1', NULL, 4, NULL, '2018-02-10 12:52:01', '2018-02-10 12:52:01'),
(8, 'Bank Interest', NULL, '1', NULL, 7, NULL, '2018-02-25 18:15:56', '2018-02-25 18:15:56');

-- --------------------------------------------------------

--
-- Table structure for table `sub_menu`
--

CREATE TABLE `sub_menu` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `serial_num` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `fk_menu_id` int(11) UNSIGNED NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sub_menu`
--

INSERT INTO `sub_menu` (`id`, `name`, `url`, `slug`, `serial_num`, `fk_menu_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'New Sales', 'inventory-product-sales/create', 'new-sales', '1', 1, 1, '2018-02-13 10:59:06', '2018-02-14 09:24:07'),
(5, 'View Profile', 'my-profile', 'view-profile', '1', 9, 1, '2018-02-13 12:55:14', '2018-02-13 12:55:14'),
(6, 'Update Profile', 'my-profile/1/edit', 'update-profile', '2', 9, 1, '2018-02-13 12:55:42', '2018-02-13 12:55:42'),
(7, 'All Sales', 'inventory-product-sales', 'all-sales', '2', 1, 1, '2018-02-14 09:27:12', '2018-02-14 09:27:12'),
(8, 'Payment Receive', 'inventory-sales-payment/crate', 'payment-receive', '3', 1, 1, '2018-02-14 09:40:13', '2018-02-14 09:40:13'),
(9, 'Customer Information', 'inventory-client', 'customer-information', '4', 1, 1, '2018-02-14 10:02:31', '2018-02-14 10:02:31'),
(10, 'Product Purchase', 'inventory-product-add/create', 'product-purchase', '1', 10, 1, '2018-02-14 10:07:06', '2018-02-14 10:07:06'),
(11, 'Supplier Information', 'inventory-supplier', 'supplier-information', '3', 10, 1, '2018-02-14 10:07:57', '2018-02-27 17:55:00'),
(12, 'Supplier Payment', 'inventory-order-payment/create', 'supplier-payment', '4', 10, 1, '2018-02-14 10:09:26', '2018-02-27 17:55:07'),
(13, 'Customer Opening Due', 'inventory-client-opening-due', 'customer-opening-due', '5', 1, 1, '2018-02-14 10:13:10', '2018-02-14 10:13:10'),
(14, 'Create Product', 'inventory-product/create', 'create-product', '1', 11, 1, '2018-02-14 10:15:52', '2018-02-14 10:15:52'),
(15, 'Product Categories', 'inventory-categories', 'product-categories', '2', 11, 1, '2018-02-14 10:16:31', '2018-02-14 10:16:31'),
(16, 'Create Brand', 'inventory-brand', 'create-brand', '3', 11, 1, '2018-02-14 10:17:13', '2018-02-14 10:17:13'),
(17, 'Unit Management', 'inventory-small-unit', 'unit-management', '4', 11, 1, '2018-02-14 10:18:12', '2018-02-14 10:18:12'),
(18, 'Stock Position', 'inventory-stock-position', 'stock-position', '5', 11, 1, '2018-02-14 10:18:51', '2018-02-14 10:18:51'),
(19, 'Damage Product', 'inventory-product-damage/create', 'damage-product', '6', 11, 1, '2018-02-14 10:19:33', '2018-02-14 10:19:33'),
(20, 'Prepare Salary', 'employe-salary/create', 'prepare-salary', '1', 8, 1, '2018-02-14 10:31:50', '2018-02-14 10:31:50'),
(21, 'All Prepared Salary', 'employe-salary', 'all-prepared-salary', '2', 8, 1, '2018-02-14 10:32:22', '2018-02-14 10:32:22'),
(22, 'Employe information', 'employe-information', 'employe-information', '3', 8, 1, '2018-02-14 10:32:50', '2018-02-14 10:32:50'),
(23, 'Employe Section Setting', 'employe-section', 'employe-section-setting', '4', 8, 1, '2018-02-14 10:33:32', '2018-02-14 10:33:32'),
(24, 'Extra Allowance Set', 'employe-salary-allowance', 'extra-allowance-set', '5', 8, 1, '2018-02-14 10:34:10', '2018-02-14 10:34:10'),
(25, 'General Expense', 'payment/create', 'general-expense', '1', 3, 1, '2018-02-14 10:35:39', '2018-02-14 10:35:39'),
(26, 'All General Expense', 'payment', 'all-general-expense', '2', 3, 1, '2018-02-14 10:36:13', '2018-02-14 10:36:13'),
(27, 'Due Payment (Expense)', 'due-payment', 'due-payment-(expense)', '3', 3, 1, '2018-02-14 10:42:47', '2018-02-14 10:42:47'),
(28, 'General Income', 'deposit/create', 'general-income', '4', 3, 1, '2018-02-14 10:43:56', '2018-02-14 10:43:56'),
(29, 'All General Income', 'deposit', 'all-general-income', '5', 3, 1, '2018-02-14 10:44:21', '2018-02-14 10:44:21'),
(30, 'Due Receive (General)', 'due-deposit', 'due-receive-(general)', '6', 3, 1, '2018-02-14 10:45:11', '2018-02-14 10:45:11'),
(31, 'General Client', 'client', 'general-client', '7', 3, 1, '2018-02-14 10:47:09', '2018-02-14 10:47:09'),
(32, 'Set Account Sector', 'sub-category/create', 'set-account-sector', '8', 3, 1, '2018-02-14 10:48:59', '2018-02-14 10:48:59'),
(33, 'Balance Transfer (To Account)', 'bill/create', 'balance-transfer-(to-account)', '1', 6, 1, '2018-02-14 10:53:34', '2018-02-14 11:25:04'),
(34, 'All Balance Transfer', 'bill', 'all-balance-transfer', '2', 6, 1, '2018-02-14 10:54:06', '2018-02-14 10:54:06'),
(35, 'Set Payment Method', 'payment-method', 'set-payment-method', '3', 6, 1, '2018-02-14 10:54:44', '2018-02-14 10:54:44'),
(36, 'Account', 'account', 'account', '4', 6, 1, '2018-02-14 10:57:16', '2018-02-14 10:57:16'),
(37, 'Sales Report', 'inventory-daily-sales', 'sales-report', '1', 4, 1, '2018-02-14 11:03:17', '2018-02-14 11:03:17'),
(38, 'Purchase Report', 'inventory-report-purchase', 'purchase-report', '2', 4, 1, '2018-02-14 11:03:55', '2018-02-14 11:03:55'),
(39, 'Receivable Due', 'inventory-report-receivable', 'receivable-due', '3', 4, 1, '2018-02-14 11:05:18', '2018-02-14 11:05:18'),
(40, 'Client Account', 'inventory-client-account', 'client-account', '4', 4, 1, '2018-02-14 11:07:03', '2018-02-14 11:07:03'),
(41, 'Cash Reports', 'report-cash', 'cash-reports', '5', 4, 1, '2018-02-14 11:09:35', '2018-04-01 09:10:46'),
(42, 'Account Wise Transaction', 'inventory-account-report', 'account-wise-transaction', '6', 4, 1, '2018-02-14 11:12:46', '2018-02-14 11:12:46'),
(43, 'Inventory Reports', 'inventory', 'inventory-reports', '7', 4, 1, '2018-02-14 11:13:14', '2018-02-14 11:13:14'),
(44, 'Gross Profit', 'inventory-gross-profit', 'gross-profit', '8', 4, 1, '2018-02-14 11:13:45', '2018-02-14 11:13:45'),
(45, 'Income Expense Report', 'report-deposit', 'income-expense-report', '9', 4, 1, '2018-02-14 11:14:52', '2018-02-14 11:14:52'),
(46, 'Branch Setting', 'inventory-branch', 'branch-setting', '1', 7, 1, '2018-02-14 11:16:35', '2018-02-14 11:16:35'),
(47, 'Users Setting', 'users', 'users-setting', '2', 7, 1, '2018-02-14 11:17:07', '2018-02-14 11:17:07'),
(49, 'Cache  Clear', 'clear-cache', 'cache--clear', '4', 7, 1, '2018-02-14 11:19:14', '2018-02-14 11:19:14'),
(50, 'Product Transfer', 'inventory-transfer/create', 'product-transfer', '7', 11, 1, '2018-02-14 11:23:02', '2018-02-14 11:23:02'),
(51, 'Money Transfer(To Branch)', 'account-money-transfer', 'money-transfer(to-branch)', '5', 6, 1, '2018-02-14 11:24:41', '2018-02-14 11:24:41'),
(52, 'Bar-code Set', 'barcode/create', 'bar-code-set', '8', 11, 1, '2018-02-14 11:26:51', '2018-02-14 11:26:51'),
(53, 'SMS Sending', 'sms/create', 'sms-sending', '1', 12, 1, '2018-02-25 23:51:45', '2018-02-26 00:07:53'),
(54, 'Manual SMS', 'new-sms', 'manual-sms', '2', 12, 1, '2018-02-26 00:09:11', '2018-02-26 00:09:11'),
(55, 'All Purchase', 'inventory-product-add', 'all-purchase', '2', 10, 1, '2018-02-27 17:54:49', '2018-02-27 17:54:49'),
(56, 'Supplier Account', 'inventory-supplier-report', 'supplier-account', '10', 4, 1, '2018-02-27 22:06:02', '2018-02-27 22:06:02'),
(57, 'Pos Sales', 'pos-sales/create', 'pos-sales', '1', 1, 1, '2018-02-27 22:24:36', '2018-02-27 22:24:52');

-- --------------------------------------------------------

--
-- Table structure for table `sub_sub_menu`
--

CREATE TABLE `sub_sub_menu` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `serial_num` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `fk_sub_menu_id` int(11) NOT NULL,
  `fk_menu_id` int(11) UNSIGNED NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tems_condition`
--

CREATE TABLE `tems_condition` (
  `id` int(10) UNSIGNED NOT NULL,
  `details` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tems_condition`
--

INSERT INTO `tems_condition` (`id`, `details`, `created_at`, `updated_at`) VALUES
(1, '*demo condition', NULL, '2017-03-24 13:10:32');

-- --------------------------------------------------------

--
-- Table structure for table `unit_of_measurement`
--

CREATE TABLE `unit_of_measurement` (
  `id` int(10) UNSIGNED NOT NULL,
  `uom_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `unit_of_measurement`
--

INSERT INTO `unit_of_measurement` (`id`, `uom_name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Pics', 1, '2017-12-02 10:10:27', '2017-12-02 10:10:27');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `profile_image` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phone_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `gender` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `type` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1=admin,2=Modarator, 3=Worker',
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_branch_id` int(11) UNSIGNED DEFAULT NULL,
  `fk_company_id` int(11) UNSIGNED DEFAULT 1,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `profile_image`, `phone_number`, `gender`, `address`, `status`, `type`, `remember_token`, `created_at`, `created_by`, `fk_branch_id`, `fk_company_id`, `updated_at`, `updated_by`) VALUES
(1, 'Administrator', 'admin@codeplanners.com', '$2y$10$hwHEwd55x9V2uDCqQFXq0ObKcSKVUvjO/YoFMOEuFVmLJBNRijR/m', '26210817010253.png', '01********', 'Male', '1', 1, 1, 'aOsE56Y6Vj8xHhiszYGmoomkMQDlHDMFxwTXJ1GyLUqaei1V6vUcoDnQ5Vdq', NULL, NULL, 1, 1, '2021-02-04 09:36:49', NULL),
(2, 'Mohammad Kazi Sabbir Uddin', 'kazisabbir43@gmail.com', '$2y$10$Eq6aHCG0xCt2gfxnIohD6esN92DWF0EELr3fkp.GQUC8Bckh2VDUi', '', '01839328321', 'Male', '26/1-A,Becharam Dewry,Dhaka', 1, 1, 'AiwKq8SP6VW10Zf0oP6JD3nKNifrXJ9enaAVICVFotWoRNYGc9xQbkSwVzdW', '2017-12-14 00:25:03', '1', 1, 1, '2018-01-20 22:23:58', NULL),
(3, 'Shahidul Islam', 'admin@maheelifestyle.com', '$2y$10$OZT3.3MUNXKxLmGSaR8SlOoNu7RStCsGij2AKc/ytuhKUdXFi888u', '217230118064646.jpeg', '01918201201', 'Male', 'Dhaka', 1, 1, 'OFTFSzGxCfaCyJoHav67sxuF323mgrYsKMUlp8xG9JR7kB6GFAMIr7wytlpQ', '2017-12-31 22:44:18', '1', 2, 1, '2018-02-17 20:14:48', NULL),
(4, 'Sabbir', 'sabbir@gmail.com', '$2y$10$o00yqKioBJNzzeqmMiK4tOsPoly5VDx/vnGkGQg0FHyXWczaAnuya', '', '01811951215', NULL, 'Dhaka', 1, 2, 'Vb6a8crVPL7zZ6R9nesqOoYAlQarRaamtTykd0DhTnpwE3pmwB71eXJcgDas', '2018-02-11 10:17:38', '1', 3, 1, '2018-02-11 10:17:38', NULL),
(5, 'Md:Monir hossain', 'monir@maheefabrics.com', '$2y$10$7rFtutIwO.TpoD0MC7kvS.guhj3s0c2QYm9lwxSoECN4hrzz39HuW', '', '01869977131', NULL, 'Dhaka', 1, 1, 'ZnBNjNVU7eEG4HCAhgBwfeMBa1GAPgjj4j0Cf8dWuNcTSrgECqgkzXRWbet9', '2018-02-16 17:24:26', '3', 2, 1, '2018-03-05 16:02:37', NULL),
(6, 'Dehan', 'admin@dehan.com', '$2y$10$FoB0FOCNoQoul86N3xKUEeUSdQIM5zAFNcyMh0BejVpJqS/iwq1ha', '', '01733299993', NULL, '1/19-20 Eastern Plus', 1, 1, 'N6Cj4octc7J0aQiYCctZIeeNUAdrM5GLfrWm7hlbXqWhVfOM3qFjZ6h9Y1QJ', '2018-02-16 21:18:33', '3', 4, 1, '2018-02-26 21:31:34', NULL),
(7, 'Azizul Hakim', 'admin@azizul.com', '$2y$10$FCxRIcoJ.LY7i8xcz79FTu5O7oJAflvPjR6jbRUjXkbRqpALPZfcq', '', '01680683180', NULL, '1/19-20', 1, 3, 'rhTSrSg0KK2UfAsKCAqbrTs8wgpeGhBXM3ZPVyqQew4jMZvMZuiLZWTM5zqb', '2018-02-17 22:17:33', '6', 4, 1, '2018-02-17 22:17:33', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_type`
--

CREATE TABLE `user_type` (
  `id` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `type_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_type`
--

INSERT INTO `user_type` (`id`, `type`, `type_name`, `created_at`, `updated_at`) VALUES
(1, 0, 'Super Admin', '2017-10-15 08:04:48', NULL),
(2, 1, 'Worker', '2017-10-15 08:04:59', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_account_inventory_branch` (`fk_branch_id`),
  ADD KEY `FK_account_company_info` (`fk_company_id`);

--
-- Indexes for table `account_money_transfer`
--
ALTER TABLE `account_money_transfer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_account_money_transfer_account` (`transfer_from`),
  ADD KEY `FK_account_money_transfer_account_2` (`transfer_to`),
  ADD KEY `FK_account_money_transfer_payment_method` (`fk_method_id`),
  ADD KEY `FK_account_money_transfer_users` (`created_by`),
  ADD KEY `FK_account_money_transfer_users_2` (`updated_by`);

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bill_transaction`
--
ALTER TABLE `bill_transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_bill_transaction_account` (`from_account`),
  ADD KEY `FK_bill_transaction_account_2` (`to_account`),
  ADD KEY `FK_bill_transaction_payment_method` (`method`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `client_id` (`client_id`),
  ADD KEY `FK_clients_inventory_branch` (`fk_branch_id`),
  ADD KEY `FK_clients_company_info` (`fk_company_id`);

--
-- Indexes for table `company_info`
--
ALTER TABLE `company_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposit`
--
ALTER TABLE `deposit`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invoice_no` (`invoice_no`),
  ADD KEY `FK1_client_id_from_client_table` (`fk_client_id`),
  ADD KEY `FK4_account_id_from_account_table` (`fk_account_id`),
  ADD KEY `FK5_method_id_from_payment_method_table` (`fk_method_id`),
  ADD KEY `FK_deposit_inventory_branch` (`fk_branch_id`),
  ADD KEY `FK_deposit_company_info` (`fk_company_id`),
  ADD KEY `FK_deposit_users` (`created_by`);

--
-- Indexes for table `deposit_cost_item`
--
ALTER TABLE `deposit_cost_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1_deposit_id_from_deposit_table` (`fk_deposit_id`),
  ADD KEY `FK2_sub_category_id_from_sub_category_table` (`fk_sub_category_id`);

--
-- Indexes for table `deposit_history`
--
ALTER TABLE `deposit_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_deposit_history_deposit_cost_item` (`fk_deposit_item_id`),
  ADD KEY `FK_deposit_history_users` (`created_by`);

--
-- Indexes for table `email_config`
--
ALTER TABLE `email_config`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employe_information`
--
ALTER TABLE `employe_information`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_employe_information_users` (`created_by`),
  ADD KEY `FK_employe_information_users_2` (`updated_by`),
  ADD KEY `FK_employe_information_employe_section` (`fk_section_id`),
  ADD KEY `employee_branch_id` (`fk_branch_id`),
  ADD KEY `employee_company_id` (`fk_company_id`);

--
-- Indexes for table `employe_salary_allowance`
--
ALTER TABLE `employe_salary_allowance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_employe_salary_allowance_users` (`created_by`);

--
-- Indexes for table `employe_salary_sheet`
--
ALTER TABLE `employe_salary_sheet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_employe_salary_sheet_employe_information` (`fk_employe_id`),
  ADD KEY `FK_employe_salary_sheet_users` (`created_by`),
  ADD KEY `FK_employe_salary_sheet_users_2` (`updated_by`),
  ADD KEY `FK_employe_salary_sheet_account` (`fk_account_id`),
  ADD KEY `FK_employe_salary_sheet_payment_method` (`fk_method_id`);

--
-- Indexes for table `employe_salary_sheet_extra_allowance`
--
ALTER TABLE `employe_salary_sheet_extra_allowance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_employe_salary_sheet_extra_allowance_employe_salary_sheet` (`fk_salary_sheet_id`),
  ADD KEY `FK_employe_salary_sheet_extra_allowance_employe_salary_allowance` (`fk_salary_allowance_id`);

--
-- Indexes for table `employe_section`
--
ALTER TABLE `employe_section`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_employe_section_users` (`created_by`);

--
-- Indexes for table `execl`
--
ALTER TABLE `execl`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_inventory_inventory_product` (`fk_product_id`),
  ADD KEY `FK_inventory_inventory_branch` (`fk_branch_id`),
  ADD KEY `FK_inventory_company_info` (`fk_company_id`),
  ADD KEY `FK_inventory_inventory_product_model` (`fk_model_id`);

--
-- Indexes for table `inventory_branch`
--
ALTER TABLE `inventory_branch`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory_clients`
--
ALTER TABLE `inventory_clients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `client_id` (`client_id`),
  ADD KEY `FK_inventory_clients_inventory_branch` (`fk_branch_id`),
  ADD KEY `FK_inventory_clients_company_info` (`fk_company_id`);

--
-- Indexes for table `inventory_item`
--
ALTER TABLE `inventory_item`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `brach_no` (`brach_no`),
  ADD KEY `FK_inventory_item_inventory` (`fk_inventory_id`),
  ADD KEY `FK_inventory_item_inventory_branch` (`fk_branch_id`);

--
-- Indexes for table `inventory_order_payment`
--
ALTER TABLE `inventory_order_payment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_id` (`invoice_id`),
  ADD KEY `FK_inventory_order_history_inventory_product_order` (`fk_supplier_id`),
  ADD KEY `FK_inventory_order_history_users` (`created_by`);

--
-- Indexes for table `inventory_order_payment_item`
--
ALTER TABLE `inventory_order_payment_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_inventory_order_payment_item_inventory_product_add` (`fk_order_id`),
  ADD KEY `FK_inventory_order_payment_item_inventory_order_payment` (`fk_order_payment_id`);

--
-- Indexes for table `inventory_payment_history`
--
ALTER TABLE `inventory_payment_history`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invoice_id` (`invoice_id`),
  ADD KEY `FK_inventory_payment_history_users` (`created_by`),
  ADD KEY `FK_inventory_payment_history_account` (`fk_account_id`),
  ADD KEY `FK_inventory_payment_history_payment_method` (`fk_method_id`),
  ADD KEY `FK_inventory_payment_history_inventory_clients` (`fk_client_id`),
  ADD KEY `FK_inventory_payment_history_inventory_branch` (`fk_branch_id`),
  ADD KEY `FK_inventory_payment_history_company_info` (`fk_company_id`),
  ADD KEY `FK_inventory_payment_history_users_2` (`fk_received_id`);

--
-- Indexes for table `inventory_payment_history_item`
--
ALTER TABLE `inventory_payment_history_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_inventory_payment_history_item_inventory_product_sales` (`fk_sales_id`),
  ADD KEY `FK_inventory_payment_history_item_inventory_payment_history` (`fk_payment_id`);

--
-- Indexes for table `inventory_product`
--
ALTER TABLE `inventory_product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_id` (`product_id`),
  ADD KEY `FK1_category_id_from_product_category_table` (`fk_category_id`),
  ADD KEY `FK2_brand_id_from_product_brand_table` (`fk_brand_id`),
  ADD KEY `FK_inventory_product_inventory_small_unit` (`fk_small_unit_id`);

--
-- Indexes for table `inventory_product_add`
--
ALTER TABLE `inventory_product_add`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inventory_order_id` (`inventory_order_id`),
  ADD KEY `FK_inventory_product_add_users` (`created_by`),
  ADD KEY `FK_inventory_product_add_inventory_supplier` (`fk_supplier_id`);

--
-- Indexes for table `inventory_product_add_item`
--
ALTER TABLE `inventory_product_add_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_inventory_product_add_item_inventory_product_add` (`fk_product_add_id`),
  ADD KEY `FK_inventory_product_add_item_inventory_product` (`fk_product_id`),
  ADD KEY `FK_inventory_product_add_item_inventory_item` (`fk_inventory_id`),
  ADD KEY `FK_inventory_product_add_item_inventory_product_model` (`fk_model_id`),
  ADD KEY `FK_inventory_product_add_item_inventory_branch` (`fk_branch_id`);

--
-- Indexes for table `inventory_product_model`
--
ALTER TABLE `inventory_product_model`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_inventory_product_model_inventory_product` (`fk_product_id`);

--
-- Indexes for table `inventory_product_order`
--
ALTER TABLE `inventory_product_order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inventory_order_id` (`inventory_order_id`),
  ADD KEY `FK_inventory_product_order_inventory_supplier` (`fk_supplier_id`),
  ADD KEY `FK_inventory_product_order_account` (`fk_account_id`),
  ADD KEY `FK_inventory_product_order_payment_method` (`fk_method_id`);

--
-- Indexes for table `inventory_product_order_challan`
--
ALTER TABLE `inventory_product_order_challan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_inventory_product_order_challan_inventory_product_order` (`fk_order_id`);

--
-- Indexes for table `inventory_product_order_challan_item`
--
ALTER TABLE `inventory_product_order_challan_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_inventory_product_order_challan_item_order_challan` (`fk_order_challan_id`),
  ADD KEY `FK_inventory_product_order_challan_item_order_item` (`fk_order_item_id`);

--
-- Indexes for table `inventory_product_order_expenses_list`
--
ALTER TABLE `inventory_product_order_expenses_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory_product_order_item`
--
ALTER TABLE `inventory_product_order_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1_product_order_id_from_inventroy_product_order_table` (`fk_product_order_id`),
  ADD KEY `FK2_product_id_from_inventory_product_table` (`fk_product_id`);

--
-- Indexes for table `inventory_product_order_other_expenses`
--
ALTER TABLE `inventory_product_order_other_expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_inventory_product_order_other_expenses_product_order` (`fk_order_id`);

--
-- Indexes for table `inventory_product_return`
--
ALTER TABLE `inventory_product_return`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory_product_sales`
--
ALTER TABLE `inventory_product_sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invoice_id` (`invoice_id`),
  ADD KEY `FK_inventory_product_sales_inventory_clients` (`fk_client_id`),
  ADD KEY `FK_inventory_product_sales_users` (`created_by`),
  ADD KEY `FK_inventory_product_sales_users_2` (`fk_user_id`),
  ADD KEY `FK_inventory_product_sales_inventory_branch` (`fk_branch_id`),
  ADD KEY `FK_inventory_product_sales_company_info` (`fk_company_id`);

--
-- Indexes for table `inventory_product_sales_item`
--
ALTER TABLE `inventory_product_sales_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1_sales_id` (`fk_sales_id`),
  ADD KEY `FK2_product_id` (`fk_product_id`),
  ADD KEY `FK_inventory_product_sales_item_inventory_product_model` (`fk_model_id`);

--
-- Indexes for table `inventory_product_sale_price`
--
ALTER TABLE `inventory_product_sale_price`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_inventory_product_sale_price_inventory_clients` (`fk_client_id`),
  ADD KEY `FK_inventory_product_sale_price_inventory_product` (`fk_product_id`),
  ADD KEY `FK_inventory_product_sale_price_users` (`created_by`),
  ADD KEY `FK_inventory_product_sale_price_users_2` (`updated_by`);

--
-- Indexes for table `inventory_product_transfer`
--
ALTER TABLE `inventory_product_transfer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_inventory_product_transfer_inventory_branch` (`transfer_from`),
  ADD KEY `FK_inventory_product_transfer_inventory_branch_2` (`transfer_to`),
  ADD KEY `FK_inventory_product_transfer_users` (`created_by`);

--
-- Indexes for table `inventory_product_transfer_item`
--
ALTER TABLE `inventory_product_transfer_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_inventory_product_transfer_item_inventory_product` (`fk_product_id`),
  ADD KEY `FK_inventory_product_transfer_item_inventory_product_model` (`fk_model_id`),
  ADD KEY `FK_inventory_product_transfer_item_inventory_item` (`fk_inventory_item_id`),
  ADD KEY `FK_inventory_product_transfer_item_inventory_product_transfer` (`fk_transfer_id`);

--
-- Indexes for table `inventory_receive_executive`
--
ALTER TABLE `inventory_receive_executive`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_receive_executive_users` (`created_by`);

--
-- Indexes for table `inventory_sales_challan_item`
--
ALTER TABLE `inventory_sales_challan_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_inventory_sales_challan_item_inventory_sales_delivery_challan` (`fk_sales_challan_id`),
  ADD KEY `FK_inventory_sales_challan_item_inventory_product_sales_item` (`fk_sales_item_id`);

--
-- Indexes for table `inventory_sales_delivery_challan`
--
ALTER TABLE `inventory_sales_delivery_challan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_inventory_sales_delivery_challan_inventory_product_sales` (`fk_sales_id`);

--
-- Indexes for table `inventory_small_unit`
--
ALTER TABLE `inventory_small_unit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory_stock_position`
--
ALTER TABLE `inventory_stock_position`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_inventory_stock_position_inventory_branch` (`fk_branch_id`),
  ADD KEY `FK_inventory_stock_position_company_info` (`fk_company_id`);

--
-- Indexes for table `inventory_supplier`
--
ALTER TABLE `inventory_supplier`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_inventory_supplier_users` (`created_by`),
  ADD KEY `FK_inventory_supplier_users_2` (`updated_by`),
  ADD KEY `FK_inventory_supplier_company_info` (`fk_company_id`),
  ADD KEY `FK_inventory_supplier_inventory_branch` (`fk_branch_id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1_payment_client_id_from_client_table_` (`fk_client_id`),
  ADD KEY `FK3_payment_account_id_from_account_table` (`fk_account_id`),
  ADD KEY `FK4_payment_method_id_from_payment_method_table` (`fk_method_id`),
  ADD KEY `FK_payment_company_info` (`fk_company_id`),
  ADD KEY `FK_payment_inventory_branch` (`fk_branch_id`),
  ADD KEY `FK_payment_users` (`created_by`);

--
-- Indexes for table `payment_cost_item`
--
ALTER TABLE `payment_cost_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1_payment_id_from_payment_table` (`fk_payment_id`),
  ADD KEY `FK2_payment_sub_category_id_from_sub_category_table` (`fk_sub_category_id`);

--
-- Indexes for table `payment_history`
--
ALTER TABLE `payment_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_payment_history_payment` (`fk_payment_item_id`),
  ADD KEY `FK_payment_history_users` (`created_by`);

--
-- Indexes for table `payment_method`
--
ALTER TABLE `payment_method`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_permission_role_permissions` (`permission_id`),
  ADD KEY `FK_permission_role_roles` (`role_id`);

--
-- Indexes for table `pos_product_barcode`
--
ALTER TABLE `pos_product_barcode`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `barcode` (`barcode`),
  ADD KEY `FK_pos_product_barcode_inventory_product` (`fk_product_id`),
  ADD KEY `FK_pos_product_barcode_inventory_product_model` (`fk_model_id`);

--
-- Indexes for table `product_brand`
--
ALTER TABLE `product_brand`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_invoice`
--
ALTER TABLE `product_invoice`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_invoice_item`
--
ALTER TABLE `product_invoice_item`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_item`
--
ALTER TABLE `project_item`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_role_user_roles` (`role_id`),
  ADD KEY `FK_role_user_users` (`user_id`);

--
-- Indexes for table `sms`
--
ALTER TABLE `sms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sms_config`
--
ALTER TABLE `sms_config`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sub_category`
--
ALTER TABLE `sub_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sub_menu`
--
ALTER TABLE `sub_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_sub_menu_menu` (`fk_menu_id`);

--
-- Indexes for table `sub_sub_menu`
--
ALTER TABLE `sub_sub_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_sub_sub_menu_sub_menu` (`fk_sub_menu_id`),
  ADD KEY `FK_sub_sub_menu_menu` (`fk_menu_id`);

--
-- Indexes for table `tems_condition`
--
ALTER TABLE `tems_condition`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `unit_of_measurement`
--
ALTER TABLE `unit_of_measurement`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `FK_users_inventory_branch` (`fk_branch_id`),
  ADD KEY `FK_users_company_info` (`fk_company_id`);

--
-- Indexes for table `user_type`
--
ALTER TABLE `user_type`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `account_money_transfer`
--
ALTER TABLE `account_money_transfer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `bill_transaction`
--
ALTER TABLE `bill_transaction`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `company_info`
--
ALTER TABLE `company_info`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `deposit`
--
ALTER TABLE `deposit`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deposit_cost_item`
--
ALTER TABLE `deposit_cost_item`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deposit_history`
--
ALTER TABLE `deposit_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_config`
--
ALTER TABLE `email_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `employe_information`
--
ALTER TABLE `employe_information`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `employe_salary_allowance`
--
ALTER TABLE `employe_salary_allowance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `employe_salary_sheet`
--
ALTER TABLE `employe_salary_sheet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `employe_salary_sheet_extra_allowance`
--
ALTER TABLE `employe_salary_sheet_extra_allowance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=373;

--
-- AUTO_INCREMENT for table `employe_section`
--
ALTER TABLE `employe_section`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `execl`
--
ALTER TABLE `execl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=253;

--
-- AUTO_INCREMENT for table `inventory_branch`
--
ALTER TABLE `inventory_branch`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `inventory_clients`
--
ALTER TABLE `inventory_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `inventory_item`
--
ALTER TABLE `inventory_item`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=370;

--
-- AUTO_INCREMENT for table `inventory_order_payment`
--
ALTER TABLE `inventory_order_payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `inventory_order_payment_item`
--
ALTER TABLE `inventory_order_payment_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `inventory_payment_history`
--
ALTER TABLE `inventory_payment_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=287;

--
-- AUTO_INCREMENT for table `inventory_payment_history_item`
--
ALTER TABLE `inventory_payment_history_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=495;

--
-- AUTO_INCREMENT for table `inventory_product`
--
ALTER TABLE `inventory_product`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `inventory_product_add`
--
ALTER TABLE `inventory_product_add`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `inventory_product_add_item`
--
ALTER TABLE `inventory_product_add_item`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=367;

--
-- AUTO_INCREMENT for table `inventory_product_model`
--
ALTER TABLE `inventory_product_model`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=167;

--
-- AUTO_INCREMENT for table `inventory_product_order`
--
ALTER TABLE `inventory_product_order`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory_product_order_challan`
--
ALTER TABLE `inventory_product_order_challan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory_product_order_challan_item`
--
ALTER TABLE `inventory_product_order_challan_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory_product_order_expenses_list`
--
ALTER TABLE `inventory_product_order_expenses_list`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `inventory_product_order_item`
--
ALTER TABLE `inventory_product_order_item`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory_product_order_other_expenses`
--
ALTER TABLE `inventory_product_order_other_expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory_product_return`
--
ALTER TABLE `inventory_product_return`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory_product_sales`
--
ALTER TABLE `inventory_product_sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=376;

--
-- AUTO_INCREMENT for table `inventory_product_sales_item`
--
ALTER TABLE `inventory_product_sales_item`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1732;

--
-- AUTO_INCREMENT for table `inventory_product_sale_price`
--
ALTER TABLE `inventory_product_sale_price`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory_product_transfer`
--
ALTER TABLE `inventory_product_transfer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inventory_product_transfer_item`
--
ALTER TABLE `inventory_product_transfer_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `inventory_receive_executive`
--
ALTER TABLE `inventory_receive_executive`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `inventory_sales_challan_item`
--
ALTER TABLE `inventory_sales_challan_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1809;

--
-- AUTO_INCREMENT for table `inventory_sales_delivery_challan`
--
ALTER TABLE `inventory_sales_delivery_challan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=355;

--
-- AUTO_INCREMENT for table `inventory_small_unit`
--
ALTER TABLE `inventory_small_unit`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `inventory_stock_position`
--
ALTER TABLE `inventory_stock_position`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `inventory_supplier`
--
ALTER TABLE `inventory_supplier`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `payment_cost_item`
--
ALTER TABLE `payment_cost_item`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `payment_history`
--
ALTER TABLE `payment_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `permission_role`
--
ALTER TABLE `permission_role`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `pos_product_barcode`
--
ALTER TABLE `pos_product_barcode`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_brand`
--
ALTER TABLE `product_brand`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `product_category`
--
ALTER TABLE `product_category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `project_item`
--
ALTER TABLE `project_item`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `role_user`
--
ALTER TABLE `role_user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sms`
--
ALTER TABLE `sms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sms_config`
--
ALTER TABLE `sms_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sub_category`
--
ALTER TABLE `sub_category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `sub_menu`
--
ALTER TABLE `sub_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `sub_sub_menu`
--
ALTER TABLE `sub_sub_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tems_condition`
--
ALTER TABLE `tems_condition`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `unit_of_measurement`
--
ALTER TABLE `unit_of_measurement`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_type`
--
ALTER TABLE `user_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `FK_account_company_info` FOREIGN KEY (`fk_company_id`) REFERENCES `company_info` (`id`),
  ADD CONSTRAINT `FK_account_inventory_branch` FOREIGN KEY (`fk_branch_id`) REFERENCES `inventory_branch` (`id`);

--
-- Constraints for table `account_money_transfer`
--
ALTER TABLE `account_money_transfer`
  ADD CONSTRAINT `FK_account_money_transfer_account` FOREIGN KEY (`transfer_from`) REFERENCES `account` (`id`),
  ADD CONSTRAINT `FK_account_money_transfer_account_2` FOREIGN KEY (`transfer_to`) REFERENCES `account` (`id`),
  ADD CONSTRAINT `FK_account_money_transfer_payment_method` FOREIGN KEY (`fk_method_id`) REFERENCES `payment_method` (`id`),
  ADD CONSTRAINT `FK_account_money_transfer_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FK_account_money_transfer_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `bill_transaction`
--
ALTER TABLE `bill_transaction`
  ADD CONSTRAINT `FK_bill_transaction_account` FOREIGN KEY (`from_account`) REFERENCES `account` (`id`),
  ADD CONSTRAINT `FK_bill_transaction_account_2` FOREIGN KEY (`to_account`) REFERENCES `account` (`id`),
  ADD CONSTRAINT `FK_bill_transaction_payment_method` FOREIGN KEY (`method`) REFERENCES `payment_method` (`id`);

--
-- Constraints for table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `FK_clients_company_info` FOREIGN KEY (`fk_company_id`) REFERENCES `company_info` (`id`),
  ADD CONSTRAINT `FK_clients_inventory_branch` FOREIGN KEY (`fk_branch_id`) REFERENCES `inventory_branch` (`id`);

--
-- Constraints for table `deposit`
--
ALTER TABLE `deposit`
  ADD CONSTRAINT `FK_deposit_account` FOREIGN KEY (`fk_account_id`) REFERENCES `account` (`id`),
  ADD CONSTRAINT `FK_deposit_clients` FOREIGN KEY (`fk_client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `FK_deposit_company_info` FOREIGN KEY (`fk_company_id`) REFERENCES `company_info` (`id`),
  ADD CONSTRAINT `FK_deposit_inventory_branch` FOREIGN KEY (`fk_branch_id`) REFERENCES `inventory_branch` (`id`),
  ADD CONSTRAINT `FK_deposit_payment_method` FOREIGN KEY (`fk_method_id`) REFERENCES `payment_method` (`id`),
  ADD CONSTRAINT `FK_deposit_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `deposit_history`
--
ALTER TABLE `deposit_history`
  ADD CONSTRAINT `FK_deposit_history_deposit_cost_item` FOREIGN KEY (`fk_deposit_item_id`) REFERENCES `deposit_cost_item` (`id`),
  ADD CONSTRAINT `FK_deposit_history_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `employe_information`
--
ALTER TABLE `employe_information`
  ADD CONSTRAINT `FK_employe_information_employe_section` FOREIGN KEY (`fk_section_id`) REFERENCES `employe_section` (`id`),
  ADD CONSTRAINT `FK_employe_information_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FK_employe_information_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `employee_branch_id` FOREIGN KEY (`fk_branch_id`) REFERENCES `inventory_branch` (`id`),
  ADD CONSTRAINT `employee_company_id` FOREIGN KEY (`fk_company_id`) REFERENCES `company_info` (`id`);

--
-- Constraints for table `employe_salary_allowance`
--
ALTER TABLE `employe_salary_allowance`
  ADD CONSTRAINT `FK_employe_salary_allowance_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `employe_salary_sheet`
--
ALTER TABLE `employe_salary_sheet`
  ADD CONSTRAINT `FK_employe_salary_sheet_account` FOREIGN KEY (`fk_account_id`) REFERENCES `account` (`id`),
  ADD CONSTRAINT `FK_employe_salary_sheet_employe_information` FOREIGN KEY (`fk_employe_id`) REFERENCES `employe_information` (`id`),
  ADD CONSTRAINT `FK_employe_salary_sheet_payment_method` FOREIGN KEY (`fk_method_id`) REFERENCES `payment_method` (`id`),
  ADD CONSTRAINT `FK_employe_salary_sheet_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FK_employe_salary_sheet_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `employe_salary_sheet_extra_allowance`
--
ALTER TABLE `employe_salary_sheet_extra_allowance`
  ADD CONSTRAINT `FK_employe_salary_sheet_extra_allowance_employe_salary_allowance` FOREIGN KEY (`fk_salary_allowance_id`) REFERENCES `employe_salary_allowance` (`id`),
  ADD CONSTRAINT `FK_employe_salary_sheet_extra_allowance_employe_salary_sheet` FOREIGN KEY (`fk_salary_sheet_id`) REFERENCES `employe_salary_sheet` (`id`);

--
-- Constraints for table `employe_section`
--
ALTER TABLE `employe_section`
  ADD CONSTRAINT `FK_employe_section_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `FK_inventory_company_info` FOREIGN KEY (`fk_company_id`) REFERENCES `company_info` (`id`),
  ADD CONSTRAINT `FK_inventory_inventory_branch` FOREIGN KEY (`fk_branch_id`) REFERENCES `inventory_branch` (`id`),
  ADD CONSTRAINT `FK_inventory_inventory_product` FOREIGN KEY (`fk_product_id`) REFERENCES `inventory_product` (`id`),
  ADD CONSTRAINT `FK_inventory_inventory_product_model` FOREIGN KEY (`fk_model_id`) REFERENCES `inventory_product_model` (`id`);

--
-- Constraints for table `inventory_clients`
--
ALTER TABLE `inventory_clients`
  ADD CONSTRAINT `FK_inventory_clients_company_info` FOREIGN KEY (`fk_company_id`) REFERENCES `company_info` (`id`),
  ADD CONSTRAINT `FK_inventory_clients_inventory_branch` FOREIGN KEY (`fk_branch_id`) REFERENCES `inventory_branch` (`id`);

--
-- Constraints for table `inventory_item`
--
ALTER TABLE `inventory_item`
  ADD CONSTRAINT `FK_inventory_item_inventory` FOREIGN KEY (`fk_inventory_id`) REFERENCES `inventory` (`id`),
  ADD CONSTRAINT `FK_inventory_item_inventory_branch` FOREIGN KEY (`fk_branch_id`) REFERENCES `inventory_branch` (`id`);

--
-- Constraints for table `inventory_order_payment`
--
ALTER TABLE `inventory_order_payment`
  ADD CONSTRAINT `FK_inventory_order_history_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FK_inventory_order_payment_inventory_supplier` FOREIGN KEY (`fk_supplier_id`) REFERENCES `inventory_supplier` (`id`);

--
-- Constraints for table `inventory_order_payment_item`
--
ALTER TABLE `inventory_order_payment_item`
  ADD CONSTRAINT `FK_inventory_order_payment_item_inventory_order_payment` FOREIGN KEY (`fk_order_payment_id`) REFERENCES `inventory_order_payment` (`id`),
  ADD CONSTRAINT `FK_inventory_order_payment_item_inventory_product_add` FOREIGN KEY (`fk_order_id`) REFERENCES `inventory_product_add` (`id`);

--
-- Constraints for table `inventory_payment_history`
--
ALTER TABLE `inventory_payment_history`
  ADD CONSTRAINT `FK_inventory_payment_history_account` FOREIGN KEY (`fk_account_id`) REFERENCES `account` (`id`),
  ADD CONSTRAINT `FK_inventory_payment_history_company_info` FOREIGN KEY (`fk_company_id`) REFERENCES `company_info` (`id`),
  ADD CONSTRAINT `FK_inventory_payment_history_inventory_branch` FOREIGN KEY (`fk_branch_id`) REFERENCES `inventory_branch` (`id`),
  ADD CONSTRAINT `FK_inventory_payment_history_inventory_clients` FOREIGN KEY (`fk_client_id`) REFERENCES `inventory_clients` (`id`),
  ADD CONSTRAINT `FK_inventory_payment_history_payment_method` FOREIGN KEY (`fk_method_id`) REFERENCES `payment_method` (`id`),
  ADD CONSTRAINT `FK_inventory_payment_history_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FK_inventory_payment_history_users_2` FOREIGN KEY (`fk_received_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `inventory_payment_history_item`
--
ALTER TABLE `inventory_payment_history_item`
  ADD CONSTRAINT `FK_inventory_payment_history_item_inventory_payment_history` FOREIGN KEY (`fk_payment_id`) REFERENCES `inventory_payment_history` (`id`),
  ADD CONSTRAINT `FK_inventory_payment_history_item_inventory_product_sales` FOREIGN KEY (`fk_sales_id`) REFERENCES `inventory_product_sales` (`id`);

--
-- Constraints for table `inventory_product`
--
ALTER TABLE `inventory_product`
  ADD CONSTRAINT `FK_inventory_product_inventory_small_unit` FOREIGN KEY (`fk_small_unit_id`) REFERENCES `inventory_small_unit` (`id`),
  ADD CONSTRAINT `FK_inventory_product_product_brand` FOREIGN KEY (`fk_brand_id`) REFERENCES `product_brand` (`id`),
  ADD CONSTRAINT `FK_inventory_product_product_category` FOREIGN KEY (`fk_category_id`) REFERENCES `product_category` (`id`);

--
-- Constraints for table `inventory_product_add`
--
ALTER TABLE `inventory_product_add`
  ADD CONSTRAINT `FK_inventory_product_add_inventory_supplier` FOREIGN KEY (`fk_supplier_id`) REFERENCES `inventory_supplier` (`id`),
  ADD CONSTRAINT `FK_inventory_product_add_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `inventory_product_add_item`
--
ALTER TABLE `inventory_product_add_item`
  ADD CONSTRAINT `FK_inventory_product_add_item_inventory_branch` FOREIGN KEY (`fk_branch_id`) REFERENCES `inventory_branch` (`id`),
  ADD CONSTRAINT `FK_inventory_product_add_item_inventory_item` FOREIGN KEY (`fk_inventory_id`) REFERENCES `inventory_item` (`id`),
  ADD CONSTRAINT `FK_inventory_product_add_item_inventory_product` FOREIGN KEY (`fk_product_id`) REFERENCES `inventory_product` (`id`),
  ADD CONSTRAINT `FK_inventory_product_add_item_inventory_product_add` FOREIGN KEY (`fk_product_add_id`) REFERENCES `inventory_product_add` (`id`),
  ADD CONSTRAINT `FK_inventory_product_add_item_inventory_product_model` FOREIGN KEY (`fk_model_id`) REFERENCES `inventory_product_model` (`id`);

--
-- Constraints for table `inventory_product_order`
--
ALTER TABLE `inventory_product_order`
  ADD CONSTRAINT `FK_inventory_product_order_account` FOREIGN KEY (`fk_account_id`) REFERENCES `account` (`id`),
  ADD CONSTRAINT `FK_inventory_product_order_inventory_supplier` FOREIGN KEY (`fk_supplier_id`) REFERENCES `inventory_supplier` (`id`),
  ADD CONSTRAINT `FK_inventory_product_order_payment_method` FOREIGN KEY (`fk_method_id`) REFERENCES `payment_method` (`id`);

--
-- Constraints for table `inventory_product_order_challan`
--
ALTER TABLE `inventory_product_order_challan`
  ADD CONSTRAINT `FK_inventory_product_order_challan_inventory_product_order` FOREIGN KEY (`fk_order_id`) REFERENCES `inventory_product_order` (`id`);

--
-- Constraints for table `inventory_product_order_challan_item`
--
ALTER TABLE `inventory_product_order_challan_item`
  ADD CONSTRAINT `FK_inventory_product_order_challan_item_order_challan` FOREIGN KEY (`fk_order_challan_id`) REFERENCES `inventory_product_order_challan` (`id`),
  ADD CONSTRAINT `FK_inventory_product_order_challan_item_order_item` FOREIGN KEY (`fk_order_item_id`) REFERENCES `inventory_product_order_item` (`id`);

--
-- Constraints for table `inventory_product_order_item`
--
ALTER TABLE `inventory_product_order_item`
  ADD CONSTRAINT `FK_inventory_product_order_item_inventory_product` FOREIGN KEY (`fk_product_id`) REFERENCES `inventory_product` (`id`),
  ADD CONSTRAINT `FK_inventory_product_order_item_inventory_product_order` FOREIGN KEY (`fk_product_order_id`) REFERENCES `inventory_product_order` (`id`);

--
-- Constraints for table `inventory_product_order_other_expenses`
--
ALTER TABLE `inventory_product_order_other_expenses`
  ADD CONSTRAINT `FK_inventory_product_order_other_expenses_product_order` FOREIGN KEY (`fk_order_id`) REFERENCES `inventory_product_order` (`id`);

--
-- Constraints for table `inventory_product_sales`
--
ALTER TABLE `inventory_product_sales`
  ADD CONSTRAINT `FK_inventory_product_sales_company_info` FOREIGN KEY (`fk_company_id`) REFERENCES `company_info` (`id`),
  ADD CONSTRAINT `FK_inventory_product_sales_inventory_branch` FOREIGN KEY (`fk_branch_id`) REFERENCES `inventory_branch` (`id`),
  ADD CONSTRAINT `FK_inventory_product_sales_inventory_clients` FOREIGN KEY (`fk_client_id`) REFERENCES `inventory_clients` (`id`),
  ADD CONSTRAINT `FK_inventory_product_sales_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FK_inventory_product_sales_users_2` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `inventory_product_sales_item`
--
ALTER TABLE `inventory_product_sales_item`
  ADD CONSTRAINT `FK_inventory_product_sales_item_inventory_product` FOREIGN KEY (`fk_product_id`) REFERENCES `inventory_product` (`id`),
  ADD CONSTRAINT `FK_inventory_product_sales_item_inventory_product_model` FOREIGN KEY (`fk_model_id`) REFERENCES `inventory_product_model` (`id`),
  ADD CONSTRAINT `FK_inventory_product_sales_item_inventory_product_sales` FOREIGN KEY (`fk_sales_id`) REFERENCES `inventory_product_sales` (`id`);

--
-- Constraints for table `inventory_product_sale_price`
--
ALTER TABLE `inventory_product_sale_price`
  ADD CONSTRAINT `FK_inventory_product_sale_price_inventory_clients` FOREIGN KEY (`fk_client_id`) REFERENCES `inventory_clients` (`id`),
  ADD CONSTRAINT `FK_inventory_product_sale_price_inventory_product` FOREIGN KEY (`fk_product_id`) REFERENCES `inventory_product` (`id`),
  ADD CONSTRAINT `FK_inventory_product_sale_price_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FK_inventory_product_sale_price_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `inventory_product_transfer`
--
ALTER TABLE `inventory_product_transfer`
  ADD CONSTRAINT `FK_inventory_product_transfer_inventory_branch` FOREIGN KEY (`transfer_from`) REFERENCES `inventory_branch` (`id`),
  ADD CONSTRAINT `FK_inventory_product_transfer_inventory_branch_2` FOREIGN KEY (`transfer_to`) REFERENCES `inventory_branch` (`id`),
  ADD CONSTRAINT `FK_inventory_product_transfer_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `inventory_product_transfer_item`
--
ALTER TABLE `inventory_product_transfer_item`
  ADD CONSTRAINT `FK_inventory_product_transfer_item_inventory_item` FOREIGN KEY (`fk_inventory_item_id`) REFERENCES `inventory_item` (`id`),
  ADD CONSTRAINT `FK_inventory_product_transfer_item_inventory_product` FOREIGN KEY (`fk_product_id`) REFERENCES `inventory_product` (`id`),
  ADD CONSTRAINT `FK_inventory_product_transfer_item_inventory_product_model` FOREIGN KEY (`fk_model_id`) REFERENCES `inventory_product_model` (`id`),
  ADD CONSTRAINT `FK_inventory_product_transfer_item_inventory_product_transfer` FOREIGN KEY (`fk_transfer_id`) REFERENCES `inventory_product_transfer` (`id`);

--
-- Constraints for table `inventory_receive_executive`
--
ALTER TABLE `inventory_receive_executive`
  ADD CONSTRAINT `FK_receive_executive_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `inventory_sales_challan_item`
--
ALTER TABLE `inventory_sales_challan_item`
  ADD CONSTRAINT `FK_inventory_sales_challan_item_inventory_product_sales_item` FOREIGN KEY (`fk_sales_item_id`) REFERENCES `inventory_product_sales_item` (`id`),
  ADD CONSTRAINT `FK_inventory_sales_challan_item_inventory_sales_delivery_challan` FOREIGN KEY (`fk_sales_challan_id`) REFERENCES `inventory_sales_delivery_challan` (`id`);

--
-- Constraints for table `inventory_sales_delivery_challan`
--
ALTER TABLE `inventory_sales_delivery_challan`
  ADD CONSTRAINT `FK_inventory_sales_delivery_challan_inventory_product_sales` FOREIGN KEY (`fk_sales_id`) REFERENCES `inventory_product_sales` (`id`);

--
-- Constraints for table `inventory_stock_position`
--
ALTER TABLE `inventory_stock_position`
  ADD CONSTRAINT `FK_inventory_stock_position_company_info` FOREIGN KEY (`fk_company_id`) REFERENCES `company_info` (`id`),
  ADD CONSTRAINT `FK_inventory_stock_position_inventory_branch` FOREIGN KEY (`fk_branch_id`) REFERENCES `inventory_branch` (`id`);

--
-- Constraints for table `inventory_supplier`
--
ALTER TABLE `inventory_supplier`
  ADD CONSTRAINT `FK_inventory_supplier_company_info` FOREIGN KEY (`fk_company_id`) REFERENCES `company_info` (`id`),
  ADD CONSTRAINT `FK_inventory_supplier_inventory_branch` FOREIGN KEY (`fk_branch_id`) REFERENCES `inventory_branch` (`id`),
  ADD CONSTRAINT `FK_inventory_supplier_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FK_inventory_supplier_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `FK_payment_account` FOREIGN KEY (`fk_account_id`) REFERENCES `account` (`id`),
  ADD CONSTRAINT `FK_payment_clients` FOREIGN KEY (`fk_client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `FK_payment_company_info` FOREIGN KEY (`fk_company_id`) REFERENCES `company_info` (`id`),
  ADD CONSTRAINT `FK_payment_inventory_branch` FOREIGN KEY (`fk_branch_id`) REFERENCES `inventory_branch` (`id`),
  ADD CONSTRAINT `FK_payment_payment_method` FOREIGN KEY (`fk_method_id`) REFERENCES `payment_method` (`id`),
  ADD CONSTRAINT `FK_payment_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `payment_history`
--
ALTER TABLE `payment_history`
  ADD CONSTRAINT `FK_payment_history_payment` FOREIGN KEY (`fk_payment_item_id`) REFERENCES `payment_cost_item` (`id`),
  ADD CONSTRAINT `FK_payment_history_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `FK_permission_role_permissions` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`),
  ADD CONSTRAINT `FK_permission_role_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `pos_product_barcode`
--
ALTER TABLE `pos_product_barcode`
  ADD CONSTRAINT `FK_pos_product_barcode_inventory_product` FOREIGN KEY (`fk_product_id`) REFERENCES `inventory_product` (`id`),
  ADD CONSTRAINT `FK_pos_product_barcode_inventory_product_model` FOREIGN KEY (`fk_model_id`) REFERENCES `inventory_product_model` (`id`);

--
-- Constraints for table `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `FK_role_user_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `FK_role_user_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `sub_menu`
--
ALTER TABLE `sub_menu`
  ADD CONSTRAINT `FK_sub_menu_menu` FOREIGN KEY (`fk_menu_id`) REFERENCES `menu` (`id`);

--
-- Constraints for table `sub_sub_menu`
--
ALTER TABLE `sub_sub_menu`
  ADD CONSTRAINT `FK_sub_sub_menu_menu` FOREIGN KEY (`fk_menu_id`) REFERENCES `menu` (`id`),
  ADD CONSTRAINT `FK_sub_sub_menu_sub_menu` FOREIGN KEY (`fk_sub_menu_id`) REFERENCES `sub_menu` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FK_users_company_info` FOREIGN KEY (`fk_company_id`) REFERENCES `company_info` (`id`),
  ADD CONSTRAINT `FK_users_inventory_branch` FOREIGN KEY (`fk_branch_id`) REFERENCES `inventory_branch` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
