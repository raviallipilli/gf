-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 26, 2024 at 07:07 AM
-- Server version: 8.3.0
-- PHP Version: 8.1.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `givingforce`
--

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
CREATE TABLE IF NOT EXISTS `applications` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `charity_id` bigint UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `stage` enum('Organisation Approval','Allow to Proceed','Paid') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `applications`
--

INSERT INTO `applications` (`id`, `user_id`, `charity_id`, `date_created`, `stage`, `created_at`, `updated_at`) VALUES
(3, 2, 3, '2024-05-25 12:41:53', 'Organisation Approval', '2024-05-25 11:41:53', '2024-05-25 11:41:53'),
(4, 1, 3, '2024-05-25 13:05:25', 'Allow to Proceed', '2024-05-25 12:05:25', '2024-05-25 15:37:47'),
(5, 1, 4, '2024-05-25 13:05:33', 'Organisation Approval', '2024-05-25 12:05:33', '2024-05-25 12:05:33'),
(6, 1, 5, '2024-05-25 13:05:38', 'Organisation Approval', '2024-05-25 12:05:38', '2024-05-25 12:05:38'),
(7, 1, 6, '2024-05-25 13:05:44', 'Organisation Approval', '2024-05-25 12:05:44', '2024-05-25 12:05:44'),
(8, 1, 7, '2024-05-25 13:05:48', 'Organisation Approval', '2024-05-25 12:05:48', '2024-05-25 12:05:48'),
(9, 1, 8, '2024-05-25 13:05:53', 'Organisation Approval', '2024-05-25 12:05:53', '2024-05-25 12:05:53'),
(10, 2, 4, '2024-05-25 13:06:14', 'Organisation Approval', '2024-05-25 12:06:14', '2024-05-25 12:06:14'),
(11, 3, 5, '2024-05-25 13:06:18', 'Organisation Approval', '2024-05-25 12:06:18', '2024-05-25 12:06:18'),
(12, 4, 4, '2024-05-25 13:06:22', 'Organisation Approval', '2024-05-25 12:06:22', '2024-05-25 14:08:07'),
(13, 5, 3, '2024-05-25 13:06:26', 'Organisation Approval', '2024-05-25 12:06:26', '2024-05-25 12:06:26'),
(28, 2, 8, '2024-05-25 14:43:00', 'Organisation Approval', '2024-05-25 13:43:00', '2024-05-25 13:43:00'),
(29, 2, 7, '2024-05-25 21:06:39', 'Organisation Approval', '2024-05-25 20:06:39', '2024-05-25 20:06:39');

-- --------------------------------------------------------

--
-- Table structure for table `charities`
--

DROP TABLE IF EXISTS `charities`;
CREATE TABLE IF NOT EXISTS `charities` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `charity_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `country_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `charities`
--

INSERT INTO `charities` (`id`, `charity_name`, `is_approved`, `country_id`, `created_at`, `updated_at`) VALUES
(3, 'My Giving Account', 1, 223, '2024-05-25 12:27:28', '2024-05-25 15:32:58'),
(4, 'Oxford Kidney Unit Trust Fund', 1, 223, '2024-05-25 12:27:28', '2024-05-25 17:03:15'),
(5, 'Human Values Foundation', 0, 221, '2024-05-25 12:27:28', '2024-05-25 12:27:28'),
(6, 'Mudlarks Community Garden', 0, 150, '2024-05-25 12:27:28', '2024-05-25 12:27:28'),
(7, 'Belfast Bible College', 0, 223, '2024-05-25 12:27:28', '2024-05-25 12:27:28'),
(8, 'CILIP Career Development Group', 0, 223, '2024-05-25 12:27:28', '2024-05-25 12:27:28'),
(9, 'The Inga Foundation', 0, 223, '2024-05-25 12:27:28', '2024-05-25 12:27:28'),
(10, 'GMGA1', 0, 100, '2024-05-25 12:27:28', '2024-05-25 12:27:28'),
(11, 'GMGA2', 0, 223, '2024-05-25 12:27:28', '2024-05-25 12:27:28'),
(12, 'Amigos Worldwide', 0, 211, '2024-05-25 12:27:28', '2024-05-25 12:27:28'),
(13, 'CAF charity account', 0, 223, '2024-05-25 12:27:28', '2024-05-25 12:27:28');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
CREATE TABLE IF NOT EXISTS `countries` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `country_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `country_name`, `country_code`, `created_at`, `updated_at`) VALUES
(1, 'AFGHANISTAN', 'AFG', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(2, 'ALBANIA', 'ALB', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(3, 'ALGERIA', 'DZA', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(4, 'AMERICAN SAMOA', 'ASM', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(5, 'ANDORRA', 'AND', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(6, 'ANGOLA', 'AGO', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(7, 'ANGUILLA', 'AIA', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(8, 'ANTARCTICA', 'ATA', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(9, 'ANTIGUA AND BARBUDA', 'ATG', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(10, 'ARGENTINA', 'ARG', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(11, 'ARMENIA', 'ARM', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(12, 'ARUBA', 'ABW', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(13, 'AUSTRALIA', 'AUS', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(14, 'AUSTRIA', 'AUT', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(15, 'AZERBAIJAN', 'AZE', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(16, 'BAHAMAS', 'BHS', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(17, 'BAHRAIN', 'BHR', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(18, 'BANGLADESH', 'BGD', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(19, 'BARBADOS', 'BRB', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(20, 'BELARUS', 'BLR', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(21, 'BELGIUM', 'BEL', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(22, 'BELIZE', 'BLZ', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(23, 'BENIN', 'BEN', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(24, 'BERMUDA', 'BMU', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(25, 'BHUTAN', 'BTN', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(26, 'BOLIVIA', 'BOL', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(27, 'BOSNIA AND HERZEGOVINA', 'BIH', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(28, 'BOTSWANA', 'BWA', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(29, 'BOUVET ISLAND', 'BVT', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(30, 'BRAZIL', 'BRA', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(31, 'BRITISH INDIAN OCEAN TERRITORY', 'IOT', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(32, 'BRUNEI DARUSSALAM', 'BRN', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(33, 'BULGARIA', 'BGR', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(34, 'BURKINA FASO', 'BFA', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(35, 'BURUNDI', 'BDI', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(36, 'CAMBODIA', 'KHM', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(37, 'CAMEROON', 'CMR', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(38, 'CANADA', 'CAN', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(39, 'CAPE VERDE', 'CPV', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(40, 'CAYMAN ISLANDS', 'CYM', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(41, 'CENTRAL AFRICAN REPUBLIC', 'CAF', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(42, 'CHAD', 'TCD', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(43, 'CHILE', 'CHL', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(44, 'CHINA', 'CHN', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(45, 'CHRISTMAS ISLAND', 'CXR', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(46, 'COCOS (KEELING) ISLANDS', 'CCK', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(47, 'COLOMBIA', 'COL', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(48, 'COMOROS', 'COM', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(49, 'CONGO', 'COG', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(50, 'CONGO, THE DEMOCRATIC REPUBLIC OF THE', 'COD', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(51, 'COOK ISLANDS', 'COK', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(52, 'COSTA RICA', 'CRI', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(53, 'COTE D\'IVOIRE', 'CIV', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(54, 'CROATIA', 'HRV', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(55, 'CUBA', 'CUB', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(56, 'CYPRUS', 'CYP', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(57, 'CZECH REPUBLIC', 'CZE', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(58, 'DENMARK', 'DNK', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(59, 'DJIBOUTI', 'DJI', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(60, 'DOMINICA', 'DMA', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(61, 'DOMINICAN REPUBLIC', 'DOM', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(62, 'ECUADOR', 'ECU', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(63, 'EGYPT', 'EGY', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(64, 'EL SALVADOR', 'SLV', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(65, 'EQUATORIAL GUINEA', 'GNQ', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(66, 'ERITREA', 'ERI', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(67, 'ESTONIA', 'EST', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(68, 'ETHIOPIA', 'ETH', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(69, 'FALKLAND ISLANDS (MALVINAS)', 'FLK', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(70, 'FAROE ISLANDS', 'FRO', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(71, 'FIJI', 'FJI', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(72, 'FINLAND', 'FIN', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(73, 'FRANCE', 'FRA', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(74, 'FRENCH GUIANA', 'GUF', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(75, 'FRENCH POLYNESIA', 'PYF', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(76, 'FRENCH SOUTHERN TERRITORIES', 'ATF', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(77, 'GABON', 'GAB', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(78, 'GAMBIA', 'GMB', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(79, 'GEORGIA', 'GEO', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(80, 'GERMANY', 'DEU', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(81, 'GHANA', 'GHA', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(82, 'GIBRALTAR', 'GIB', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(83, 'GREECE', 'GRC', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(84, 'GREENLAND', 'GRL', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(85, 'GRENADA', 'GRD', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(86, 'GUADELOUPE', 'GLP', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(87, 'GUAM', 'GUM', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(88, 'GUATEMALA', 'GTM', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(89, 'GUINEA', 'GIN', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(90, 'GUINEA-BISSAU', 'GNB', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(91, 'GUYANA', 'GUY', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(92, 'HAITI', 'HTI', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(93, 'HEARD ISLAND AND MCDONALD ISLANDS', 'HMD', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(94, 'HOLY SEE (VATICAN CITY STATE)', 'VAT', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(95, 'HONDURAS', 'HND', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(96, 'HONG KONG', 'HKG', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(97, 'HUNGARY', 'HUN', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(98, 'ICELAND', 'ISL', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(99, 'INDIA', 'IND', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(100, 'INDONESIA', 'IDN', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(101, 'IRAN, ISLAMIC REPUBLIC OF', 'IRN', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(102, 'IRAQ', 'IRQ', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(103, 'IRELAND', 'IRL', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(104, 'ISRAEL', 'ISR', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(105, 'ITALY', 'ITA', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(106, 'JAMAICA', 'JAM', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(107, 'JAPAN', 'JPN', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(108, 'JORDAN', 'JOR', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(109, 'KAZAKHSTAN', 'KAZ', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(110, 'KENYA', 'KEN', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(111, 'KIRIBATI', 'KIR', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(112, 'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF', 'PRK', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(113, 'KOREA, REPUBLIC OF', 'KOR', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(114, 'KUWAIT', 'KWT', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(115, 'KYRGYZSTAN', 'KGZ', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(116, 'LAO PEOPLE\'S DEMOCRATIC REPUBLIC', 'LAO', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(117, 'LATVIA', 'LVA', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(118, 'LEBANON', 'LBN', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(119, 'LESOTHO', 'LSO', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(120, 'LIBERIA', 'LBR', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(121, 'LIBYAN ARAB JAMAHIRIYA', 'LBY', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(122, 'LIECHTENSTEIN', 'LIE', '2024-05-25 12:28:05', '2024-05-25 12:28:05'),
(123, 'LITHUANIA', 'LTU', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(124, 'LUXEMBOURG', 'LUX', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(125, 'MACAO', 'MAC', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(126, 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF', 'MKD', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(127, 'MADAGASCAR', 'MDG', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(128, 'MALAWI', 'MWI', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(129, 'MALAYSIA', 'MYS', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(130, 'MALDIVES', 'MDV', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(131, 'MALI', 'MLI', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(132, 'MALTA', 'MLT', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(133, 'MARSHALL ISLANDS', 'MHL', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(134, 'MARTINIQUE', 'MTQ', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(135, 'MAURITANIA', 'MRT', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(136, 'MAURITIUS', 'MUS', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(137, 'MAYOTTE', 'MYT', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(138, 'MEXICO', 'MEX', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(139, 'MICRONESIA, FEDERATED STATES OF', 'FSM', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(140, 'MOLDOVA, REPUBLIC OF', 'MDA', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(141, 'MONACO', 'MCO', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(142, 'MONGOLIA', 'MNG', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(143, 'MONTSERRAT', 'MSR', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(144, 'MOROCCO', 'MAR', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(145, 'MOZAMBIQUE', 'MOZ', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(146, 'MYANMAR', 'MMR', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(147, 'NAMIBIA', 'NAM', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(148, 'NAURU', 'NRU', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(149, 'NEPAL', 'NPL', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(150, 'NETHERLANDS', 'NLD', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(151, 'NETHERLANDS ANTILLES', 'ANT', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(152, 'NEW CALEDONIA', 'NCL', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(153, 'NEW ZEALAND', 'NZL', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(154, 'NICARAGUA', 'NIC', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(155, 'NIGER', 'NER', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(156, 'NIGERIA', 'NGA', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(157, 'NIUE', 'NIU', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(158, 'NORFOLK ISLAND', 'NFK', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(159, 'NORTHERN MARIANA ISLANDS', 'MNP', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(160, 'NORWAY', 'NOR', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(161, 'OMAN', 'OMN', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(162, 'PAKISTAN', 'PAK', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(163, 'PALAU', 'PLW', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(164, 'PANAMA', 'PAN', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(165, 'PAPUA NEW GUINEA', 'PNG', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(166, 'PARAGUAY', 'PRY', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(167, 'PERU', 'PER', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(168, 'PHILIPPINES', 'PHL', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(169, 'PITCAIRN', 'PCN', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(170, 'POLAND', 'POL', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(171, 'PORTUGAL', 'PRT', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(172, 'PUERTO RICO', 'PRI', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(173, 'QATAR', 'QAT', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(174, 'REUNION', 'REU', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(175, 'ROMANIA', 'ROU', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(176, 'RUSSIAN FEDERATION', 'RUS', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(177, 'RWANDA', 'RWA', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(178, 'SAINT HELENA', 'SHN', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(179, 'SAINT KITTS AND NEVIS', 'KNA', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(180, 'SAINT LUCIA', 'LCA', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(181, 'SAINT PIERRE AND MIQUELON', 'SPM', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(182, 'SAINT VINCENT AND THE GRENADINES', 'VCT', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(183, 'SAMOA', 'WSM', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(184, 'SAN MARINO', 'SMR', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(185, 'SAO TOME AND PRINCIPE', 'STP', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(186, 'SAUDI ARABIA', 'SAU', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(187, 'SENEGAL', 'SEN', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(188, 'SEYCHELLES', 'SYC', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(189, 'SIERRA LEONE', 'SLE', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(190, 'SINGAPORE', 'SGP', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(191, 'SLOVAKIA', 'SVK', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(192, 'SLOVENIA', 'SVN', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(193, 'SOLOMON ISLANDS', 'SLB', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(194, 'SOMALIA', 'SOM', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(195, 'SOUTH AFRICA', 'ZAF', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(196, 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', 'SGS', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(197, 'SPAIN', 'ESP', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(198, 'SRI LANKA', 'LKA', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(199, 'SUDAN', 'SDN', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(200, 'SURINAME', 'SUR', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(201, 'SVALBARD AND JAN MAYEN', 'SJM', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(202, 'SWAZILAND', 'SWZ', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(203, 'SWEDEN', 'SWE', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(204, 'SWITZERLAND', 'CHE', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(205, 'SYRIAN ARAB REPUBLIC', 'SYR', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(206, 'TAIWAN, PROVINCE OF CHINA', 'TWN', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(207, 'TAJIKISTAN', 'TJK', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(208, 'TANZANIA, UNITED REPUBLIC OF', 'TZA', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(209, 'THAILAND', 'THA', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(210, 'TIMOR-LESTE', 'TLS', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(211, 'TOGO', 'TGO', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(212, 'TOKELAU', 'TKL', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(213, 'TONGA', 'TON', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(214, 'TRINIDAD AND TOBAGO', 'TTO', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(215, 'TUNISIA', 'TUN', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(216, 'TURKEY', 'TUR', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(217, 'TURKMENISTAN', 'TKM', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(218, 'TURKS AND CAICOS ISLANDS', 'TCA', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(219, 'TUVALU', 'TUV', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(220, 'UGANDA', 'UGA', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(221, 'UKRAINE', 'UKR', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(222, 'UNITED ARAB EMIRATES', 'ARE', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(223, 'UNITED KINGDOM', 'GBR', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(224, 'UNITED STATES', 'USA', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(225, 'URUGUAY', 'URY', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(226, 'UZBEKISTAN', 'UZB', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(227, 'VANUATU', 'VUT', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(228, 'VENEZUELA', 'VEN', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(229, 'VIET NAM', 'VNM', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(230, 'VIRGIN ISLANDS, BRITISH', 'VGB', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(231, 'VIRGIN ISLANDS, U.S.', 'VIR', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(232, 'WALLIS AND FUTUNA', 'WLF', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(233, 'WESTERN SAHARA', 'ESH', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(234, 'YEMEN', 'YEM', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(235, 'ZAMBIA', 'ZMB', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(236, 'ZIMBABWE', 'ZWE', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(237, 'JERSEY', 'JEY', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(238, 'GUERNSEY', 'GGY', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(239, 'UNKNOWN', 'UNK', '2024-05-25 12:28:06', '2024-05-25 12:28:06'),
(240, 'ISLE OF MAN', 'IMN', '2024-05-25 12:28:06', '2024-05-25 12:28:06');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2024_05_23_091311_create_user_roles_table', 1),
(6, '2024_05_23_091523_create_charities_table', 1),
(7, '2024_05_23_091908_create_countries_table', 1),
(8, '2024_05_23_092011_create_applications_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 4, 'API Token', 'fb40ebef2992c7429f856640803d6df63f961e08b9201173058a2e97b468263b', '[\"*\"]', '2024-05-25 15:20:00', '2024-05-25 13:49:07', '2024-05-25 15:20:00'),
(2, 'App\\Models\\User', 3, 'API Token', '94f3d22ce9ba0da628133ba77cad810fd95cc628b224f138e5ba3b64d05f2658', '[\"*\"]', '2024-05-25 17:03:46', '2024-05-25 15:29:53', '2024-05-25 17:03:46'),
(3, 'App\\Models\\User', 5, 'API Token', '7ecc997276b008f1a70b67b00eff1f7076e001e78bf195d92d4efdf0e258c9f2', '[\"*\"]', '2024-05-25 19:20:34', '2024-05-25 15:33:44', '2024-05-25 19:20:34'),
(4, 'App\\Models\\User', 5, 'API Token', '132eeda283540f58e6df62980715a8cefb6e5308c8a96e2baa0691c959a60864', '[\"*\"]', '2024-05-25 21:14:59', '2024-05-25 19:23:34', '2024-05-25 21:14:59'),
(5, 'App\\Models\\User', 5, 'API Token', 'd5f5ade579c907d79c95a7af0ab848a259288a8d191a53a74835ab1eab009f1f', '[\"*\"]', NULL, '2024-05-25 20:44:38', '2024-05-25 20:44:38');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Employee 1', 'employee1@givingforce.com', '2024-05-25 12:31:25', 'password', '2024-05-25 12:31:25', '2024-05-25 12:31:25', '2024-05-25 12:31:25'),
(2, 'Employee 2', 'employee2@givingforce.com', '2024-05-25 12:31:25', 'password', '2024-05-25 12:31:25', '2024-05-25 12:31:25', '2024-05-25 12:31:25'),
(3, 'Admin 1', 'admin1@givingforce.com', '2024-05-25 12:31:25', 'password', '2024-05-25 12:31:25', '2024-05-25 12:31:25', '2024-05-25 12:31:25'),
(4, 'Admin 2', 'admin2@givingforce.com', '2024-05-25 12:31:25', 'password', '2024-05-25 12:31:25', '2024-05-25 12:31:25', '2024-05-25 12:31:25'),
(5, 'Admin 3', 'admin3@givingforce.com', '2024-05-25 12:31:25', 'password', '2024-05-25 12:31:25', '2024-05-25 12:31:25', '2024-05-25 12:31:25');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE IF NOT EXISTS `user_roles` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `role` enum('employee','admin','admin_applications','admin_reports') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`id`, `user_id`, `role`, `created_at`, `updated_at`) VALUES
(1, 1, 'employee', '2024-05-25 12:28:29', '2024-05-25 12:28:29'),
(2, 2, 'employee', '2024-05-25 12:28:29', '2024-05-25 12:28:29'),
(3, 3, 'admin', '2024-05-25 12:28:29', '2024-05-25 12:28:29'),
(4, 5, 'admin_applications', '2024-05-25 12:28:29', '2024-05-25 12:28:29'),
(5, 5, 'admin_reports', '2024-05-25 12:28:29', '2024-05-25 12:28:29'),
(6, 4, 'admin', '2024-05-25 12:28:29', '2024-05-25 12:28:29'),
(7, 3, 'admin', '2024-05-25 12:28:29', '2024-05-25 12:28:29'),
(8, 4, 'admin_applications', '2024-05-25 12:28:29', '2024-05-25 12:28:29');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
