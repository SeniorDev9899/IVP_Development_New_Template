-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 14, 2022 at 05:57 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `identity_verification`
--

-- --------------------------------------------------------

--
-- Table structure for table `avatars`
--

CREATE TABLE `avatars` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `avatars`
--

INSERT INTO `avatars` (`id`, `created_at`, `updated_at`, `user_id`, `name`, `path`) VALUES
(1, '2022-03-29 10:32:37', '2022-03-29 10:32:37', '9', '1648582357_Photo.jpeg', '/storage/uploads/1648582357_Photo.jpeg'),
(2, '2022-03-29 10:51:25', '2022-03-29 10:51:25', '10', '1648583485_Photo.jpeg', '/storage/uploads/1648583485_Photo.jpeg'),
(3, '2022-03-29 10:56:14', '2022-04-12 03:07:21', '1', '1649765241_profile_logo_.jpg', '/storage/uploads/1649765241_profile_logo_.jpg'),
(4, '2022-03-29 11:06:57', '2022-03-29 11:06:57', '11', '1648584417_Vladislav P.jpg', '/storage/uploads/1648584417_Vladislav P.jpg'),
(5, '2022-03-29 21:22:06', '2022-04-03 18:06:26', '13', '1649041586_myPicture3.PNG', '/storage/uploads/1649041586_myPicture3.PNG'),
(6, '2022-03-29 21:32:08', '2022-04-03 18:06:35', '14', '1649041595_Photo.jpeg', '/storage/uploads/1649041595_Photo.jpeg'),
(7, '2022-03-29 21:34:46', '2022-04-03 18:06:12', '16', '1649041572_images (5).jpg', '/storage/uploads/1649041572_images (5).jpg'),
(8, '2022-03-29 21:37:20', '2022-04-03 18:05:48', '17', '1649041548_profile_logo_ROALO_d9f9e833dfa2ab2cdeebd91393d9ea01.jpeg', '/storage/uploads/1649041548_profile_logo_ROALO_d9f9e833dfa2ab2cdeebd91393d9ea01.jpeg'),
(9, '2022-03-29 23:18:14', '2022-04-03 18:06:05', '18', '1649041565_image-original.jpg', '/storage/uploads/1649041565_image-original.jpg'),
(10, '2022-03-30 03:01:47', '2022-04-03 18:05:37', '19', '1649041537_Vladislav P.jpg', '/storage/uploads/1649041537_Vladislav P.jpg'),
(11, '2022-03-30 03:54:25', '2022-04-03 18:05:57', '25', '1649041557_85980370.jpg', '/storage/uploads/1649041557_85980370.jpg'),
(12, '2022-03-30 04:34:41', '2022-04-03 18:05:16', '26', '1649041516_Ivan Pinteley.jpg', '/storage/uploads/1649041516_Ivan Pinteley.jpg'),
(13, '2022-03-30 06:41:06', '2022-04-03 18:04:54', '30', '1649041494_Angely.jpg', '/storage/uploads/1649041494_Angely.jpg'),
(14, '2022-03-30 06:47:09', '2022-04-03 18:04:18', '31', '1649041458_Ashraf.png', '/storage/uploads/1649041458_Ashraf.png'),
(15, '2022-04-01 07:30:26', '2022-04-03 18:04:00', '32', '1649041440_avatar6.png', '/storage/uploads/1649041440_avatar6.png'),
(16, '2022-04-02 01:22:49', '2022-04-03 18:03:28', '33', '1649041408_avatar3.png', '/storage/uploads/1649041407_avatar3.png'),
(17, '2022-04-02 02:26:35', '2022-04-02 02:26:35', '34', '1648898795_avatar3.png', '/storage/uploads/1648898795_avatar3.png'),
(18, '2022-04-02 03:15:58', '2022-04-02 03:16:14', '35', '1648901774_sss.jpg', '/storage/uploads/1648901774_sss.jpg'),
(19, '2022-04-03 18:19:46', '2022-04-12 04:17:57', '38', '1649769477_123 (2).jpg', '/storage/uploads/1649769477_123 (2).jpg'),
(20, '2022-04-04 00:44:49', '2022-04-04 00:44:49', '39', '1649065489_Ivan Pinteley.jpg', '/storage/uploads/1649065489_Ivan Pinteley.jpg'),
(21, '2022-04-04 11:31:34', '2022-04-04 11:31:34', '40', '1649104294_avatar6.png', '/storage/uploads/1649104293_avatar6.png'),
(22, '2022-04-06 02:45:36', '2022-04-06 02:45:36', '86', '1649245536_profile_logo_.jpg', '/storage/uploads/1649245536_profile_logo_.jpg'),
(23, '2022-04-06 22:03:29', '2022-04-06 22:04:45', '99', '1649315085_avatar3.png', '/storage/uploads/1649315085_avatar3.png'),
(24, '2022-04-08 00:39:32', '2022-04-08 00:43:42', '100', '1649411022_avatar1.png', '/storage/uploads/1649411022_avatar1.png');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_05_13_060834_create_settings_table', 1),
(4, '2018_05_22_084901_create_todos_table', 1),
(5, '2022_03_28_120705_add_new_columns_to_users_table', 1),
(6, '2022_03_28_181458_create_avatars_table', 1),
(7, '2022_03_28_181645_add_user_id_to_avatars_table', 1),
(8, '2022_04_06_051644_add_email_verification_status_to_users_table', 2),
(9, '2022_04_10_112759_create_regions_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `regions`
--

CREATE TABLE `regions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `companies` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `regions`
--

INSERT INTO `regions` (`id`, `name`, `companies`, `created_at`, `updated_at`) VALUES
(3, 'region_1', NULL, '2022-04-10 16:38:56', '2022-04-10 16:38:56'),
(4, 'region_2', NULL, '2022-04-10 16:39:04', '2022-04-10 16:39:04'),
(5, 'region_3', NULL, '2022-04-10 16:39:09', '2022-04-10 16:39:09'),
(6, 'region_4', NULL, '2022-04-10 16:39:13', '2022-04-10 16:39:13'),
(7, 'region_5', NULL, '2022-04-10 16:39:19', '2022-04-10 16:39:19'),
(8, 'region_6', NULL, '2022-04-10 16:39:23', '2022-04-10 16:39:23'),
(9, 'region_7', NULL, '2022-04-10 16:39:28', '2022-04-10 16:39:28'),
(10, 'region_8', NULL, '2022-04-10 16:39:33', '2022-04-10 16:39:33'),
(11, 'region_9', NULL, '2022-04-10 16:39:37', '2022-04-10 16:39:37'),
(12, 'region_10', NULL, '2022-04-10 16:39:42', '2022-04-10 16:39:42'),
(13, 'region_11', NULL, '2022-04-10 19:41:18', '2022-04-10 19:41:18'),
(14, 'region_12', NULL, '2022-04-10 20:37:44', '2022-04-10 20:37:44'),
(17, 'region_13', NULL, '2022-04-13 18:54:41', '2022-04-13 18:54:41');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `option` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `todos`
--

CREATE TABLE `todos` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `completed` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'practitioner',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `picture` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '...',
  `id_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '...',
  `serial_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '...',
  `validity_period` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '...',
  `company` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '...',
  `region` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '...',
  `verification_result` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'nonactivated',
  `health_status` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'normal',
  `remark_information` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_verification_status` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `role`, `created_at`, `updated_at`, `gender`, `picture`, `id_number`, `serial_number`, `validity_period`, `company`, `region`, `verification_result`, `health_status`, `remark_information`, `email_verification_status`) VALUES
(1, 'System', 'Admin', 'tenochbush@gmail.com', '$2y$10$Cl901ni4fGuKjIJeY3XOneiJvtKqEzwmplzV1x17X8wJrl0EfTIB6', 'admin', '2022-03-29 07:37:26', '2022-04-13 07:56:09', 'male', '...', '330226199602074114', '202204101107', '2022-05-28', 'Alibaba Group Holding Ltd.', '...', 'nonactivated', 'bad', '{\"time\":\"2022-4-8 0:43:28\",\"type\":\"email_verification\",\"result\":true}/{\"time\":\"2022-4-10 11:7:21\",\"type\":\"id_number\",\"result\":\"330226199602074114\"}/{\"time\":\"2022-4-10 11:7:35\",\"type\":\"serial_number\",\"result\":\"202204101107\"}/{\"time\":\"2022-4-10 18:53:16\",\"type\":\"id_number\",\"result\":\"330226199602074114333333\"}/{\"time\":\"2022-4-10 18:53:31\",\"type\":\"company\",\"result\":\"Alibaba Group Holding Ltd. fdsf\"}/{\"time\":\"2022-4-10 18:53:49\",\"type\":\"company\",\"result\":\"Alibaba Group Holding Ltd.\"}/{\"time\":\"2022-4-12 17:38:9\",\"type\":\"first_name\",\"result\":\"System fsdfasdf\"}/{\"time\":\"2022-4-12 17:39:5\",\"type\":\"first_name\",\"result\":\"System\"}/{\"time\":\"2022-4-12 19:13:37\",\"type\":\"first_name\",\"result\":\"System fdsfsdf\"}/{\"time\":\"2022-4-12 19:22:19\",\"type\":\"first_name\",\"result\":\"System\"}/{\"time\":\"2022-4-12 19:22:40\",\"type\":\"id_number\",\"result\":\"330226199602074114\"}/{\"time\":\"2022-4-12 19:23:12\",\"type\":\"first_name\",\"result\":\"System fsdf\"}/{\"time\":\"2022-4-12 19:23:29\",\"type\":\"first_name\",\"result\":\"System\"}/{\"time\":\"2022-4-12 19:25:13\",\"type\":\"first_name\",\"result\":\"System dd\"}/{\"time\":\"2022-4-13 22:12:7\",\"type\":\"validity_period\",\"result\":\"2023|01|01\"}/{\"time\":\"2022-4-14 1:55:51\",\"type\":\"first_name\",\"result\":\"System\"}/{\"time\":\"2022-4-14 1:56:6\",\"type\":\"validity_period\",\"result\":\"2022-05-28\"}', 1),
(13, 'Ivan', 'Petrovich', 'IvanPetrovich199899@gmail.com', '$2y$10$H4ooTwCALmsBv./llWYVre9Edw0F/UY57Cn8g0RcoE9PixUWtwFTW', 'practitioner', '2022-03-29 21:21:43', '2022-04-10 20:10:31', 'male', '...', '511600197503035391', '202204111954', '...', 'China National Chemical Engineering Co., Ltd.', 'region_1', 'nonactivated', 'bad', '{\"time\":\"2022-4-11 14:6:58\",\"type\":\"id_number\",\"result\":\"210422197007038118\"}/{\"time\":\"2022-4-11 14:7:6\",\"type\":\"serial_number\",\"result\":\"202204111954\"}/{\"time\":\"2022-4-11 14:7:11\",\"type\":\"validity_period\",\"result\":\"2023|01|01\"}/{\"time\":\"2022-4-11 14:7:44\",\"type\":\"company\",\"result\":\"China Communications Construction Co. Ltd.\"}/{\"time\":\"2022-4-11 14:9:53\",\"type\":\"company\",\"result\":\"China Grand Automotive Services Group Co., Ltd.\"}/{\"time\":\"2022-4-11 14:10:1\",\"type\":\"id_number\",\"result\":\"450722198106166874\"}/{\"time\":\"2022-4-11 14:10:25\",\"type\":\"id_number\",\"result\":\"511600197503035391\"}/{\"time\":\"2022-4-11 14:10:30\",\"type\":\"company\",\"result\":\"China National Chemical Engineering Co., Ltd.\"}', 1),
(14, 'Okcana', 'Deshura', 'oxankaorb@gmail.com', '$2y$10$n8kKSKjrgfJP1bAPINb2h.32eHwl6yv6B/3kI4voalComBf5fkH66', 'practitioner', '2022-03-29 21:25:21', '2022-04-08 01:27:42', 'female', '...', '371301197906269583', '202205150917', '...', 'Baoshan Iron & Steel Co., Ltd.', 'region_2', 'nonactivated', 'good', '{\"time\":\"2022-4-8 19:27:17\",\"type\":\"id_number\",\"result\":\"371301197906269583\"}/{\"time\":\"2022-4-8 19:27:30\",\"type\":\"serial_number\",\"result\":\"202205150917\"}/{\"time\":\"2022-4-8 19:27:35\",\"type\":\"validity_period\",\"result\":\"2023|01|01\"}/{\"time\":\"2022-4-8 19:27:41\",\"type\":\"company\",\"result\":\"Baoshan Iron & Steel Co., Ltd.\"}', 1),
(16, 'Alex', 'Rossi', 'stanojevicognjen30@gmail.com', '$2y$10$ZDT36ijaPimV2CfzYJYPzuGdIxii5Y2VeKXkmDnypmm0HCAbF3yJu', 'practitioner', '2022-03-29 21:34:28', '2022-04-08 01:08:13', 'male', '...', '330211199811255611', '202204081608', '...', 'Baoshan Iron & Steel Co., Ltd.', 'region_2', 'nonactivated', 'normal', '{\"time\":\"2022-4-8 19:7:46\",\"type\":\"id_number\",\"result\":\"\\t330211199811255611\"}/{\"time\":\"2022-4-8 19:8:0\",\"type\":\"serial_number\",\"result\":\"202204081608\"}/{\"time\":\"2022-4-8 19:8:11\",\"type\":\"validity_period\",\"result\":\"2023|01|01\"}/{\"time\":\"2022-4-8 19:8:13\",\"type\":\"company\",\"result\":\"Baoshan Iron & Steel Co., Ltd.\"}', 1),
(17, 'Anastasia', 'Dorisela', 'anastasia9899@gmail.com', '$2y$10$1h.PWMV9/aGCi64TOWE/S.9ECYAXobqVhTr0skTYCU15ubvg1Q9Ee', 'practitioner', '2022-03-29 21:37:05', '2022-03-29 22:48:06', 'female', '...', '...', '...', '...', '...', 'region_3', 'nonactivated', 'good', '', 1),
(18, 'Sergey', 'Petrov', 'sergeyle199585@gmail.com', '$2y$10$AVydFiWwbFNcGj2s2F7n7ePB9yVpcsaHXGR6b0T8zV9xTpF89ffX2', 'practitioner', '2022-03-29 23:17:58', '2022-03-29 23:21:07', 'male', '...', '...', '...', '...', '...', 'region_3', 'nonactivated', 'bad', '', 1),
(19, 'Alexandr', 'Oblask', 'Alexandr@gmail.com', '$2y$10$sADGMEQZbmAYDGecjkeqxeXT7c0mfW08DLr5QisvxQ9YSrEi44TPu', 'practitioner', '2022-03-30 01:30:48', '2022-04-08 01:08:52', 'male', '...', '350782197303145253', '20220408140928', '...', 'BOE Technology Group Co., Ltd.', 'region_2', 'nonactivated', 'normal', '{\"time\":\"2022-4-8 19:8:28\",\"type\":\"id_number\",\"result\":\"350782197303145253\"}/{\"time\":\"2022-4-8 19:8:39\",\"type\":\"serial_number\",\"result\":\"20220408140928\"}/{\"time\":\"2022-4-8 19:8:46\",\"type\":\"validity_period\",\"result\":\"2023|01|01\"}/{\"time\":\"2022-4-8 19:8:51\",\"type\":\"company\",\"result\":\"BOE Technology Group Co., Ltd.\"}', 1),
(25, 'Olga', 'Angely', 'angelyolga@gmail.com', '$2y$10$7PO/QHYQgVhsXQjLFljbAuV6vSwUcud8bmLtfkJy3c21GknJMvm3S', 'practitioner', '2022-03-30 03:52:51', '2022-04-08 01:28:25', 'female', '...', '362400199009107469', '202205170918', '...', 'BAIC Motor Corp. Ltd.', 'region_2', 'nonactivated', 'normal', '{\"time\":\"2022-4-8 19:28:7\",\"type\":\"id_number\",\"result\":\"362400199009107469\"}/{\"time\":\"2022-4-8 19:28:14\",\"type\":\"serial_number\",\"result\":\"202205170918\"}/{\"time\":\"2022-4-8 19:28:18\",\"type\":\"validity_period\",\"result\":\"2023|01|01\"}/{\"time\":\"2022-4-8 19:28:24\",\"type\":\"company\",\"result\":\"BAIC Motor Corp. Ltd.\"}', 1),
(26, 'Jackson', 'Starksss', 'jackson.stark@gmail.com', '$2y$10$IWIbf1fOsBCNzzRKFKqiqO2ZwOkekEbVvKsuilSXGFB3QzPSoYfd2', 'regional_admin', '2022-03-30 04:34:27', '2022-04-01 23:52:14', 'male', '...', '...', '...', '...', '...', 'region_1', 'nonactivated', 'good', '', 1),
(30, 'Reem', 'Ashraf', 'reem.ashraf@gmail.com', '$2y$10$eQzIk8CtBtF1bGwhEwJUdOVdCNCzEVHgCktuTNxwyPOtDUrAxWT26', 'regional_admin', '2022-03-30 06:40:51', '2022-03-30 06:40:51', 'female', '...', '...', '...', '...', '...', 'region_3', 'nonactivated', 'normal', '', 1),
(31, 'Nathalia', 'Indigo', 'natalia.indigo@gmail.com', '$2y$10$pF9UsM6ZkUhOzLgqY7chje291LDUpzkdiDBEDmrPA91JVGGpdAgs.', 'practitioner', '2022-03-30 06:46:51', '2022-04-08 01:25:57', 'female', '...', '450324197809221709', '202204091903', '...', 'China CITIC Bank Corp. Ltd.', 'region_2', 'nonactivated', 'bad', '{\"time\":\"2022-4-8 19:25:35\",\"type\":\"id_number\",\"result\":\"450324197809221709\"}/{\"time\":\"2022-4-8 19:25:45\",\"type\":\"serial_number\",\"result\":\"202204091903\"}/{\"time\":\"2022-4-8 19:25:54\",\"type\":\"validity_period\",\"result\":\"2023|01|01\"}/{\"time\":\"2022-4-8 19:25:56\",\"type\":\"company\",\"result\":\"China CITIC Bank Corp. Ltd.\"}', 0),
(32, 'Jamess', 'Potterr', 'potter.james@gmail.com', '$2y$10$Dxg3yrlpBz1qxsxlh1r.rekN8TttsI8yml0GY98565OXxUGvppGNm', 'regional_admin', '2022-04-01 07:30:10', '2022-04-08 01:00:18', 'male', '...', '652824197109146572', '202204082010', '...', 'China CITIC Bank Corp. Ltd.', 'region_2', 'nonactivated', 'normal', '{\"time\":\"2022-4-8 18:59:54\",\"type\":\"id_number\",\"result\":\"652824197109146572\"}/{\"time\":\"2022-4-8 19:0:5\",\"type\":\"serial_number\",\"result\":\"202204082010\"}/{\"time\":\"2022-4-8 19:0:10\",\"type\":\"validity_period\",\"result\":\"2023|01|01\"}/{\"time\":\"2022-4-8 19:0:18\",\"type\":\"company\",\"result\":\"China CITIC Bank Corp. Ltd.\"}', 1),
(33, 'Eli', 'Kunkka', 'Eli.Kunkka@gmail.com', '$2y$10$RCIUpJ3er72r3x9yTAhElO5IFywVovhpFTUWQ976tKPvT2G.71NfW', 'practitioner', '2022-04-02 01:22:39', '2022-04-12 01:06:35', 'male', '...', '445281198812126728', '202204081855', '...', 'BOE Technology Group Co., Ltd.', 'region_2', 'nonactivated', 'normal', '', 1),
(38, 'Daniel', 'Dashe', 'Test@gmail.com', '$2y$10$TrORiy26gd.hEHWiJNHfDuDYYIKl53oMRaSVyQRuKthfNMDe1O4By', 'regional_admin', '2022-04-03 18:19:35', '2022-04-13 07:10:58', 'female', '...', '110221199003043217', '202204081251', '2022-04-30', 'BAIC Motor Corp. Ltd.', 'region_1', 'nonactivated', 'normal', ' {\"time\":\"2022-4-8 0:34:19\",\"type\":\"first_name\",\"result\":\"Daniell\"}/{\"time\":\"2022-4-8 0:38:11\",\"type\":\"password\",\"result\":\"IvanP.9899\"}/{\"time\":\"2022-4-8 1:19:59\",\"type\":\"id_number\",\"result\":\"110221199003043217\"}/{\"time\":\"2022-4-8 1:20:26\",\"type\":\"serial_number\",\"result\":\"202204081251\"}/{\"time\":\"2022-4-8 1:20:33\",\"type\":\"validity_period\",\"result\":\"2023|01|01\"}/{\"time\":\"2022-4-8 1:21:23\",\"type\":\"company\",\"result\":\"BAIC Motor Corp. Ltd.\"}/{\"time\":\"2022-4-8 1:26:1\",\"type\":\"first_name\",\"result\":\"Daniel\"}/{\"time\":\"2022-4-8 1:29:24\",\"type\":\"password\",\"result\":\"IvanP.989999\"}/{\"time\":\"2022-4-10 11:25:46\",\"type\":\"last_name\",\"result\":\"Dashe\"}/{\"time\":\"2022-4-10 11:39:40\",\"type\":\"last_name\",\"result\":\"Dashee\"}/{\"time\":\"2022-4-10 11:40:35\",\"type\":\"last_name\",\"result\":\"Dashe\"}/{\"time\":\"2022-4-10 11:42:35\",\"type\":\"last_name\",\"result\":\"Dashee\"}/{\"time\":\"2022-4-10 11:42:42\",\"type\":\"last_name\",\"result\":\"Dashe\"}/{\"time\":\"2022-4-10 18:58:47\",\"type\":\"company\",\"result\":\"BAIC Motor Corp. Ltd. fdsfsadfsda\"}/{\"time\":\"2022-4-10 18:58:57\",\"type\":\"company\",\"result\":\"BAIC Motor Corp. Ltd.\"}/{\"time\":\"2022-4-10 19:2:8\",\"type\":\"company\",\"result\":\"BAIC Motor Corp. Ltd. fdsfsdafsd\"}/{\"time\":\"2022-4-10 19:2:23\",\"type\":\"validity_period\",\"result\":\"2023|01|01 fdsfsdafsads\"}/{\"time\":\"2022-4-10 19:2:32\",\"type\":\"serial_number\",\"result\":\"202204081251 fsdfsdafsdafsd\"}/{\"time\":\"2022-4-10 19:2:48\",\"type\":\"serial_number\",\"result\":\"202204081251\"}/{\"time\":\"2022-4-10 19:2:50\",\"type\":\"validity_period\",\"result\":\"2023|01|01\"}/{\"time\":\"2022-4-10 19:2:53\",\"type\":\"company\",\"result\":\"BAIC Motor Corp. Ltd.\"}/{\"time\":\"2022-4-11 14:14:57\",\"type\":\"serial_number\",\"result\":\"202204081251 fdsfsdafasd\"}/{\"time\":\"2022-4-11 14:15:9\",\"type\":\"serial_number\",\"result\":\"202204081251\"}/{\"time\":\"2022-4-11 14:15:55\",\"type\":\"serial_number\",\"result\":\"202204081251 fdssdafdsf\"}/{\"time\":\"2022-4-11 14:16:5\",\"type\":\"serial_number\",\"result\":\"202204081251\"}/{\"time\":\"2022-4-11 15:14:30\",\"type\":\"company\",\"result\":\"BAIC Motor Corp. Ltd. fdsfsdfsd\"}/{\"time\":\"2022-4-11 15:14:40\",\"type\":\"company\",\"result\":\"BAIC Motor Corp. Ltd.fd f\"}/{\"time\":\"2022-4-11 15:14:51\",\"type\":\"company\",\"result\":\"BAIC Motor Corp. Ltd.\"}/{\"time\":\"2022-4-11 16:29:51\",\"type\":\"first_name\",\"result\":\"Daniel ddd\"}/{\"time\":\"2022-4-11 16:29:52\",\"type\":\"last_name\",\"result\":\"Dashe ddd\"}/{\"time\":\"2022-4-11 16:29:53\",\"type\":\"email\",\"result\":\"Test@gmail.com ddd\"}/{\"time\":\"2022-4-11 16:30:1\",\"type\":\"id_number\",\"result\":\"110221199003043217 ddd\"}/{\"time\":\"2022-4-11 16:30:2\",\"type\":\"serial_number\",\"result\":\"202204081251 ddd\"}/{\"time\":\"2022-4-11 16:30:2\",\"type\":\"validity_period\",\"result\":\"2023|01|01 ddd\"}/{\"time\":\"2022-4-11 16:30:3\",\"type\":\"company\",\"result\":\"BAIC Motor Corp. Ltd. ddd\"}/{\"time\":\"2022-4-11 16:30:5\",\"type\":\"region\",\"result\":\"region_2\"}/{\"time\":\"2022-4-11 16:30:6\",\"type\":\"health_status\",\"result\":\"bad\"}/{\"time\":\"2022-4-11 16:31:28\",\"type\":\"first_name\",\"result\":\"Daniel ddd\"}/{\"time\":\"2022-4-11 16:31:29\",\"type\":\"last_name\",\"result\":\"Dashe ddd\"}/{\"time\":\"2022-4-11 16:31:30\",\"type\":\"email\",\"result\":\"Test@gmail.com ddd\"}/{\"time\":\"2022-4-11 16:31:31\",\"type\":\"gender\",\"result\":\"female\"}/{\"time\":\"2022-4-11 16:31:33\",\"type\":\"id_number\",\"result\":\"110221199003043217 ddd\"}/{\"time\":\"2022-4-11 16:31:34\",\"type\":\"serial_number\",\"result\":\"202204081251 ddd\"}/{\"time\":\"2022-4-11 16:31:35\",\"type\":\"validity_period\",\"result\":\"2023|01|01 ddd\"}/{\"time\":\"2022-4-11 16:31:36\",\"type\":\"company\",\"result\":\"BAIC Motor Corp. Ltd. ddd\"}/{\"time\":\"2022-4-11 16:31:38\",\"type\":\"region\",\"result\":\"region_2\"}/{\"time\":\"2022-4-11 16:31:39\",\"type\":\"health_status\",\"result\":\"bad\"}/{\"time\":\"2022-4-11 16:33:10\",\"type\":\"first_name\",\"result\":\"Daniel ddd\"}/{\"time\":\"2022-4-11 16:33:11\",\"type\":\"last_name\",\"result\":\"Dashe ddd\"}/{\"time\":\"2022-4-11 16:33:11\",\"type\":\"email\",\"result\":\"Test@gmail.com ddd\"}/{\"time\":\"2022-4-11 16:33:12\",\"type\":\"gender\",\"result\":\"female\"}/{\"time\":\"2022-4-11 16:33:15\",\"type\":\"id_number\",\"result\":\"110221199003043217 ddd\"}/{\"time\":\"2022-4-11 16:33:17\",\"type\":\"serial_number\",\"result\":\"202204081251 ddd\"}/{\"time\":\"2022-4-11 16:33:18\",\"type\":\"validity_period\",\"result\":\"2023|01|01 ddd\"}/{\"time\":\"2022-4-11 16:33:19\",\"type\":\"company\",\"result\":\"BAIC Motor Corp. Ltd. ddd\"}/{\"time\":\"2022-4-11 16:33:21\",\"type\":\"region\",\"result\":\"region_2\"}/{\"time\":\"2022-4-11 16:33:22\",\"type\":\"health_status\",\"result\":\"bad\"}/{\"time\":\"2022-4-11 16:34:9\",\"type\":\"first_name\",\"result\":\"Daniel ddd\"}/{\"time\":\"2022-4-11 16:34:10\",\"type\":\"last_name\",\"result\":\"Dashe ddd\"}/{\"time\":\"2022-4-11 16:34:12\",\"type\":\"gender\",\"result\":\"female\"}/{\"time\":\"2022-4-11 16:34:15\",\"type\":\"id_number\",\"result\":\"110221199003043217 ddd\"}/{\"time\":\"2022-4-11 16:34:16\",\"type\":\"serial_number\",\"result\":\"202204081251 ddd\"}/{\"time\":\"2022-4-11 16:34:19\",\"type\":\"validity_period\",\"result\":\"2023|01|01 ddd\"}/{\"time\":\"2022-4-11 16:34:20\",\"type\":\"company\",\"result\":\"BAIC Motor Corp. Ltd. ddd\"}/{\"time\":\"2022-4-11 16:34:21\",\"type\":\"region\",\"result\":\"region_2\"}/{\"time\":\"2022-4-11 16:34:22\",\"type\":\"health_status\",\"result\":\"bad\"}/{\"time\":\"2022-4-11 16:34:36\",\"type\":\"first_name\",\"result\":\"Daniel\"}/{\"time\":\"2022-4-11 16:34:38\",\"type\":\"last_name\",\"result\":\"Dashe\"}/{\"time\":\"2022-4-11 16:34:39\",\"type\":\"gender\",\"result\":\"male\"}/{\"time\":\"2022-4-11 16:34:40\",\"type\":\"role\",\"result\":\"regional_admin\"}/{\"time\":\"2022-4-11 16:34:43\",\"type\":\"id_number\",\"result\":\"110221199003043217\"}/{\"time\":\"2022-4-11 16:34:44\",\"type\":\"serial_number\",\"result\":\"202204081251\"}/{\"time\":\"2022-4-11 16:34:46\",\"type\":\"validity_period\",\"result\":\"2023|01|01\"}/{\"time\":\"2022-4-11 16:34:48\",\"type\":\"region\",\"result\":\"region_1\"}/{\"time\":\"2022-4-11 16:34:50\",\"type\":\"company\",\"result\":\"BAIC Motor Corp. Ltd.\"}/{\"time\":\"2022-4-11 16:34:51\",\"type\":\"health_status\",\"result\":\"normal\"}/{\"time\":\"2022-4-12 17:32:21\",\"type\":\"first_name\",\"result\":\"Daniel dfsdfsdf\"}/{\"time\":\"2022-4-12 17:32:30\",\"type\":\"first_name\",\"result\":\"Daniel\"}/{\"time\":\"2022-4-12 17:38:32\",\"type\":\"first_name\",\"result\":\"System\"}/{\"time\":\"2022-4-12 17:39:27\",\"type\":\"first_name\",\"result\":\"Daniel fsdfsd\"}/{\"time\":\"2022-4-12 17:39:50\",\"type\":\"first_name\",\"result\":\"Daniel\"}/{\"time\":\"2022-4-12 19:13:58\",\"type\":\"first_name\",\"result\":\"Daniel fsdfsda\"}/{\"time\":\"2022-4-12 19:14:10\",\"type\":\"first_name\",\"result\":\"System\"}/{\"time\":\"2022-4-12 19:22:58\",\"type\":\"first_name\",\"result\":\"Daniel\"}/{\"time\":\"2022-4-12 19:24:29\",\"type\":\"first_name\",\"result\":\"Daniel dd\"}/{\"time\":\"2022-4-13 22:10:52\",\"type\":\"validity_period\",\"result\":\"2023|01|01\"}/{\"time\":\"2022-4-13 23:41:14\",\"type\":\"first_name\",\"result\":\"Daniel\"}/{\"time\":\"2022-4-13 23:45:32\",\"type\":\"gender\",\"result\":\"female\"}/{\"time\":\"2022-4-13 23:45:59\",\"type\":\"validity_period\",\"result\":\"2023|01|01\"}/{\"time\":\"2022-4-14 0:45:47\",\"type\":\"validity_period\",\"result\":\"2022-04-23\"}/{\"time\":\"2022-4-14 0:49:11\",\"type\":\"validity_period\",\"result\":\"2022-04-30\"}/{\"time\":\"2022-4-14 1:10:6\",\"type\":\"region\",\"result\":\"region_2\"}/{\"time\":\"2022-4-14 1:10:57\",\"type\":\"region\",\"result\":\"region_1\"}', 1),
(99, 'Tenoch', 'Bush', 'daniel.dashe@gmail.com', '$2y$10$Ah4QxaQn1Orjq9ezLGEpcOt2KtNH6AxtC8TJNOKvly/3sK5yyRtpS', 'practitioner', '2022-04-06 06:35:35', '2022-04-08 01:01:02', 'male', '...', '522728199109014780', '202204082045', '...', 'Bank of Jiangsu Co., Ltd.', 'region_2', 'nonactivated', 'normal', '{\"time\":\"2022-4-8 19:0:44\",\"type\":\"id_number\",\"result\":\"\\t522728199109014780\"}/{\"time\":\"2022-4-8 19:0:56\",\"type\":\"serial_number\",\"result\":\"202204082045\"}/{\"time\":\"2022-4-8 19:1:1\",\"type\":\"company\",\"result\":\"Bank of Jiangsu Co., Ltd.\"}', 0),
(100, 'Daniell', 'Domingoo', 'daniel.domingo@gmail.com', '$2y$10$E65AriQlpPOgtOVT0t4PUuJqKwYcoTHAKD2ZN/lBGjLKS97/p/SNq', 'practitioner', '2022-04-07 20:54:50', '2022-04-13 06:47:55', 'male', '...', '410922197903017694', '202204081905', '2022-04-29', 'China CITIC Bank Corp. Ltd.', 'region_1', 'nonactivated', 'normal', '{\"time\":\"2022-4-8 18:39:1\",\"type\":\"first_name\",\"result\":\"Daniell\"}/{\"time\":\"2022-4-8 18:41:43\",\"type\":\"last_name\",\"result\":\"Domingoo\"}/{\"time\":\"2022-4-8 18:48:20\",\"type\":\"password\",\"result\":\"IvanP.989999\"}/{\"time\":\"2022-4-8 18:51:42\",\"type\":\"id_number\",\"result\":\"\\t410922197903017694\"}/{\"time\":\"2022-4-8 18:51:57\",\"type\":\"serial_number\",\"result\":\"202204081905\"}/{\"time\":\"2022-4-8 18:52:3\",\"type\":\"validity_period\",\"result\":\"2023|01|01\"}/{\"time\":\"2022-4-8 18:52:13\",\"type\":\"company\",\"result\":\"China CITIC Bank Corp. Ltd.\"}/{\"time\":\"2022-4-11 15:45:22\",\"type\":\"email_verification\",\"result\":true}/{\"time\":\"2022-4-12 17:19:12\",\"type\":\"validity_period\",\"result\":\"2023|01|01 fdsfsdafsfdsf\"}/{\"time\":\"2022-4-12 17:19:29\",\"type\":\"validity_period\",\"result\":\"2023|01|01\"}/{\"time\":\"2022-4-14 0:47:52\",\"type\":\"validity_period\",\"result\":\"2022-04-29\"}', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `avatars`
--
ALTER TABLE `avatars`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indexes for table `regions`
--
ALTER TABLE `regions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `todos`
--
ALTER TABLE `todos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `avatars`
--
ALTER TABLE `avatars`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `regions`
--
ALTER TABLE `regions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `todos`
--
ALTER TABLE `todos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
