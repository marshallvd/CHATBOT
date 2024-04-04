/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 10.4.32-MariaDB : Database - banagobot
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`banagobot` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `banagobot`;

/*Table structure for table `tb_dosen` */

DROP TABLE IF EXISTS `tb_dosen`;

CREATE TABLE `tb_dosen` (
  `nip` varchar(25) NOT NULL,
  `nidn` varchar(25) NOT NULL,
  `nama_dosen` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`nip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tb_dosen` */

LOCK TABLES `tb_dosen` WRITE;

insert  into `tb_dosen`(`nip`,`nidn`,`nama_dosen`,`email`) values 
('197510242003121010	','0024107505	','Dr. I Made Sukarsa, ST.,MT	','sukarsa@unud.ac.id');

UNLOCK TABLES;

/*Table structure for table `tb_inbox` */

DROP TABLE IF EXISTS `tb_inbox`;

CREATE TABLE `tb_inbox` (
  `id_inbox` int(11) NOT NULL AUTO_INCREMENT,
  `message_content` text DEFAULT NULL,
  `chat_id` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `message_type` enum('private','group') DEFAULT 'private',
  PRIMARY KEY (`id_inbox`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tb_inbox` */

LOCK TABLES `tb_inbox` WRITE;

insert  into `tb_inbox`(`id_inbox`,`message_content`,`chat_id`,`timestamp`,`message_type`) values 
(1,'halo',2147483647,'2024-04-02 00:07:09','private'),
(2,'hai',2147483647,'2024-04-02 00:07:16','private'),
(3,'test',2147483647,'2024-04-02 00:58:38','private'),
(4,'test halo',2147483647,'2024-04-02 22:21:35','private'),
(5,'test',2147483647,'2024-04-02 22:28:05','private'),
(6,'1',2147483647,'2024-04-02 22:28:08','private'),
(7,'halo',2147483647,'2024-04-02 22:31:58','private'),
(8,'halo banago',2147483647,'2024-04-02 22:34:42','private'),
(9,'halo',2147483647,'2024-04-02 22:34:43','private'),
(10,'test',2147483647,'2024-04-02 22:42:24','private'),
(11,'halo',2147483647,'2024-04-02 22:45:17','private'),
(12,'w',2147483647,'2024-04-02 22:45:31','private'),
(13,'1.',2147483647,'2024-04-02 22:45:41','private'),
(14,'1. Daftar Mata Kuliah',2147483647,'2024-04-02 22:46:10','private'),
(15,'test',2147483647,'2024-04-02 22:48:49','private'),
(16,'1',2147483647,'2024-04-02 22:48:52','private'),
(17,'test',2147483647,'2024-04-02 22:55:04','private'),
(18,'1',2147483647,'2024-04-02 22:55:12','private'),
(19,'alsjlakjdlas',2147483647,'2024-04-02 22:59:16','private'),
(20,'halo',2147483647,'2024-04-02 23:02:33','private'),
(21,'test',2147483647,'2024-04-02 23:03:10','private'),
(22,'test',2147483647,'2024-04-02 23:05:24','private'),
(23,'kjhaksha',2147483647,'2024-04-02 23:12:01','private'),
(24,'sdfsdfsdf',2147483647,'2024-04-02 23:17:10','private'),
(25,'test',2147483647,'2024-04-02 23:19:46','private'),
(26,'test',2147483647,'2024-04-02 23:34:20','private'),
(27,'test',2147483647,'2024-04-02 23:36:12','private'),
(28,'teasd',2147483647,'2024-04-02 23:37:52','private'),
(29,'asda',2147483647,'2024-04-02 23:38:22','private'),
(30,'asdad',2147483647,'2024-04-02 23:44:47','private'),
(31,'asdasd',2147483647,'2024-04-02 23:44:54','private'),
(32,'asasd',2147483647,'2024-04-02 23:45:02','private'),
(33,'ahsgjhas',2147483647,'2024-04-02 23:53:00','private'),
(34,'asdasd',2147483647,'2024-04-02 23:56:43','private'),
(35,'Button 1 clicked',2147483647,'2024-04-02 23:56:47',''),
(36,'testttt',2147483647,'2024-04-03 00:04:17','private'),
(37,'Button 1 clicked',2147483647,'2024-04-03 00:04:20',''),
(38,'as',2147483647,'2024-04-03 00:06:15','private'),
(39,'Button 1 clicked',2147483647,'2024-04-03 00:06:19',''),
(40,'asdasdas',2147483647,'2024-04-03 00:06:41','private'),
(41,'Button 2 clicked',2147483647,'2024-04-03 00:06:45',''),
(42,'asasda',2147483647,'2024-04-03 00:08:40','private'),
(43,'Button 1 clicked',2147483647,'2024-04-03 00:08:44',''),
(44,'qweqwqw',2147483647,'2024-04-03 00:11:47','private'),
(45,'Button 2 clicked',2147483647,'2024-04-03 00:11:54',''),
(46,'asdaww',2147483647,'2024-04-03 00:12:07','private'),
(47,'Button 2 clicked',2147483647,'2024-04-03 00:12:12',''),
(48,'qasdawqe',2147483647,'2024-04-03 00:18:36','private'),
(49,'Button 2 clicked',2147483647,'2024-04-03 00:18:46',''),
(50,'sdfsdf',2147483647,'2024-04-03 00:18:58','private'),
(51,'Button 1 clicked',2147483647,'2024-04-03 00:19:01',''),
(52,'Button 1 clicked',2147483647,'2024-04-03 00:29:42',''),
(53,'asdas',2147483647,'2024-04-03 00:30:11','private'),
(54,'Button 1 clicked',2147483647,'2024-04-03 00:30:14',''),
(55,'qweqweqw',2147483647,'2024-04-03 00:34:51','private'),
(56,'Button 2 clicked',2147483647,'2024-04-03 00:34:56',''),
(57,'dasdasd',2147483647,'2024-04-03 00:37:11','private'),
(58,'Button 1 clicked',2147483647,'2024-04-03 00:37:52',''),
(59,'sdfsdfsd',2147483647,'2024-04-03 00:40:17','private'),
(60,'Button 1 clicked',2147483647,'2024-04-03 00:40:42','private'),
(61,'ewrwerwe',2147483647,'2024-04-03 00:46:50','private'),
(62,'cxcxcvxcv',2147483647,'2024-04-03 00:53:14','private'),
(63,'asdawdqeqw',2147483647,'2024-04-03 01:00:06','private'),
(64,'Button 1 clicked',2147483647,'2024-04-03 01:00:11','private'),
(65,'Button 4 clicked',2147483647,'2024-04-03 01:00:19','private'),
(66,'sxcvxcv',2147483647,'2024-04-03 01:03:18','private'),
(67,'Button 1 clicked',2147483647,'2024-04-03 01:03:22','private'),
(68,'sdfsdfsdf',2147483647,'2024-04-03 01:05:11','private'),
(69,'Button 2 clicked',2147483647,'2024-04-03 01:05:15','private'),
(70,'aszxcasd',2147483647,'2024-04-03 01:07:43','private'),
(71,'Button 2 clicked',2147483647,'2024-04-03 01:07:51','private'),
(72,'Button 1 clicked',2147483647,'2024-04-03 01:08:00','private'),
(73,'halo',2147483647,'2024-04-03 10:13:04','private'),
(74,'Button 1 clicked',2147483647,'2024-04-03 10:13:11','private'),
(75,'testt',2147483647,'2024-04-03 10:44:32','private'),
(76,'Button 1 clicked',2147483647,'2024-04-03 10:44:35','private'),
(77,'testtt',2147483647,'2024-04-03 10:50:20','private'),
(78,'Button 4 clicked',2147483647,'2024-04-03 10:50:24','private'),
(79,'Button 1 clicked',2147483647,'2024-04-03 10:51:25','private'),
(80,'Button 4 clicked',2147483647,'2024-04-03 10:51:35','private'),
(81,'Button 1 clicked',2147483647,'2024-04-03 10:52:18','private'),
(82,'test',2147483647,'2024-04-03 11:28:08','private'),
(83,'Button 1 clicked',2147483647,'2024-04-03 11:28:12','private'),
(84,'Button 4 clicked',2147483647,'2024-04-03 11:28:43','private'),
(85,'Button 2 clicked',2147483647,'2024-04-03 11:28:46','private'),
(86,'3',2147483647,'2024-04-03 11:39:30','private'),
(87,'3',2147483647,'2024-04-03 11:39:33','private'),
(88,'2105551093',2147483647,'2024-04-03 11:39:44','private'),
(89,'test',2147483647,'2024-04-03 11:48:42','private'),
(90,'12344',2147483647,'2024-04-03 11:48:53','private'),
(91,'test',2147483647,'2024-04-03 12:07:24','private'),
(92,'halo',2147483647,'2024-04-03 12:07:36','private'),
(93,'test',2147483647,'2024-04-03 12:07:40','private'),
(94,'Button 1 clicked',2147483647,'2024-04-03 12:07:50','private'),
(95,'2105551093',2147483647,'2024-04-03 12:07:58','private'),
(96,'2105551093',2147483647,'2024-04-03 12:08:16','private'),
(97,'halo',2147483647,'2024-04-03 12:08:56','private'),
(98,'Button 1 clicked',2147483647,'2024-04-03 12:09:00','private'),
(99,'Button 2 clicked',2147483647,'2024-04-03 12:09:03','private'),
(100,'Button 4 clicked',2147483647,'2024-04-03 12:09:06','private'),
(101,'test',2147483647,'2024-04-03 12:18:00','private'),
(102,'halo',2147483647,'2024-04-03 12:18:03','private'),
(103,'halo',2147483647,'2024-04-03 12:18:34','private'),
(104,'ajshkjahsd',2147483647,'2024-04-03 12:21:04','private'),
(105,'Button 4 clicked',2147483647,'2024-04-03 12:21:07','private'),
(106,'Button 1 clicked',2147483647,'2024-04-03 12:21:18','private'),
(107,'testttt',2147483647,'2024-04-03 12:32:16','private'),
(108,';ask;ad',2147483647,'2024-04-03 12:32:39','private'),
(109,'test',2147483647,'2024-04-03 12:34:54','private'),
(110,'Button 1 clicked',2147483647,'2024-04-03 12:34:58','private'),
(111,'alksjlad',2147483647,'2024-04-03 12:35:05','private'),
(112,'Button 1 clicked',2147483647,'2024-04-03 12:35:09','private'),
(113,'test',2147483647,'2024-04-03 12:39:56','private'),
(114,'Button 1 clicked',2147483647,'2024-04-03 12:40:57','private'),
(115,'testtt',2147483647,'2024-04-03 13:32:47','private'),
(116,'Button 1 clicked',2147483647,'2024-04-03 13:32:57','private'),
(117,'sjhdgjhsd',2147483647,'2024-04-03 13:33:29','private'),
(118,'Button 2 clicked',2147483647,'2024-04-03 13:33:33','private'),
(119,'test',2147483647,'2024-04-03 20:56:12','private'),
(120,'asasdasdas',2147483647,'2024-04-03 20:56:38','private'),
(121,'Button 4 clicked',2147483647,'2024-04-03 20:56:43','private'),
(122,'halo',2147483647,'2024-04-03 20:57:50','private'),
(123,'test',2147483647,'2024-04-03 20:58:19','private'),
(124,'Button 4 clicked',2147483647,'2024-04-03 20:58:23','private'),
(125,'test',2147483647,'2024-04-03 21:01:05','private'),
(126,'Button 2 clicked',2147483647,'2024-04-03 21:01:10','private'),
(127,'ahsgjah',2147483647,'2024-04-03 21:22:22','private'),
(128,'2105551093',2147483647,'2024-04-03 21:22:30','private'),
(129,'asda',2147483647,'2024-04-03 21:23:17','private'),
(130,'2105551093',2147483647,'2024-04-03 21:23:26','private'),
(131,'testt',2147483647,'2024-04-03 21:34:42','private'),
(132,'asdas',2147483647,'2024-04-03 21:36:28','private'),
(133,'Button 1 clicked',2147483647,'2024-04-03 21:36:32','private'),
(134,'asddas',2147483647,'2024-04-03 21:36:36','private'),
(135,'Button 2 clicked',2147483647,'2024-04-03 21:36:39','private'),
(136,'fsdfsdf',2147483647,'2024-04-03 21:36:43','private'),
(137,'Button 4 clicked',2147483647,'2024-04-03 21:36:47','private'),
(138,'asasd',2147483647,'2024-04-03 21:36:53','private'),
(139,'2105551093',2147483647,'2024-04-03 21:37:01','private'),
(140,'adasdasd',2147483647,'2024-04-03 21:39:57','private'),
(141,'Button 1 clicked',2147483647,'2024-04-03 21:40:01','private'),
(142,'asdasd',2147483647,'2024-04-03 21:40:04','private'),
(143,'Button 2 clicked',2147483647,'2024-04-03 21:40:08','private'),
(144,'asasas',2147483647,'2024-04-03 21:40:11','private'),
(145,'Button 4 clicked',2147483647,'2024-04-03 21:40:15','private'),
(146,'asdasdqweqwe',2147483647,'2024-04-03 21:40:19','private'),
(147,'2105551093',2147483647,'2024-04-03 21:40:27','private'),
(148,'asdasdas',2147483647,'2024-04-03 21:42:45','private'),
(149,'Button 1 clicked',2147483647,'2024-04-03 21:42:50','private'),
(150,'asdasdasasd',2147483647,'2024-04-03 21:42:54','private'),
(151,'Button 2 clicked',2147483647,'2024-04-03 21:42:59','private'),
(152,'iii',2147483647,'2024-04-03 21:43:23','private'),
(153,'2105551093',2147483647,'2024-04-03 21:43:35','private'),
(154,'hkhkh',2147483647,'2024-04-03 21:47:48','private'),
(155,'2105551093',2147483647,'2024-04-03 21:47:57','private'),
(156,'sdfsdfsd',2147483647,'2024-04-03 21:50:44','private'),
(157,'Button 1 clicked',2147483647,'2024-04-03 21:50:48','private'),
(158,'sdffsdfds',2147483647,'2024-04-03 21:50:51','private'),
(159,'Button 4 clicked',2147483647,'2024-04-03 21:50:55','private'),
(160,'asdasdas',2147483647,'2024-04-03 22:13:09','private'),
(161,'Button 1 clicked',2147483647,'2024-04-03 22:13:13','private');

UNLOCK TABLES;

/*Table structure for table `tb_mahasiswa` */

DROP TABLE IF EXISTS `tb_mahasiswa`;

CREATE TABLE `tb_mahasiswa` (
  `nim` varchar(20) NOT NULL,
  `nama_mahasiswa` varchar(255) NOT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `telepon` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`nim`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tb_mahasiswa` */

LOCK TABLES `tb_mahasiswa` WRITE;

insert  into `tb_mahasiswa`(`nim`,`nama_mahasiswa`,`alamat`,`telepon`) values 
('2105551093','Made Marshall Vira Deva','Jalan Gandapura III K no 12','085155426099');

UNLOCK TABLES;

/*Table structure for table `tb_matakuliah` */

DROP TABLE IF EXISTS `tb_matakuliah`;

CREATE TABLE `tb_matakuliah` (
  `kode_matakuliah` varchar(255) NOT NULL,
  `nama_matakuliah` varchar(255) NOT NULL,
  `semester` int(11) NOT NULL,
  `jumlah_sks` int(11) NOT NULL,
  PRIMARY KEY (`kode_matakuliah`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tb_matakuliah` */

LOCK TABLES `tb_matakuliah` WRITE;

insert  into `tb_matakuliah`(`kode_matakuliah`,`nama_matakuliah`,`semester`,`jumlah_sks`) values 
('TIU046339','Big Data	',6,3);

UNLOCK TABLES;

/*Table structure for table `tb_menu` */

DROP TABLE IF EXISTS `tb_menu`;

CREATE TABLE `tb_menu` (
  `id_menu` int(11) NOT NULL AUTO_INCREMENT,
  `no_menu` int(11) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `deskripsi` longtext DEFAULT NULL,
  PRIMARY KEY (`id_menu`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tb_menu` */

LOCK TABLES `tb_menu` WRITE;

insert  into `tb_menu`(`id_menu`,`no_menu`,`label`,`deskripsi`) values 
(1,1,'Daftar Mata Kuliah',''),
(2,2,'Daftar Mahasiswa',''),
(3,3,'Cari Mahasiswa',''),
(4,4,'Daftar Dosen','');

UNLOCK TABLES;

/*Table structure for table `tb_menu_query` */

DROP TABLE IF EXISTS `tb_menu_query`;

CREATE TABLE `tb_menu_query` (
  `id_menu` int(10) NOT NULL AUTO_INCREMENT,
  `query` varchar(255) DEFAULT NULL,
  `is_used` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id_menu`),
  CONSTRAINT `tb_menu_query_ibfk_1` FOREIGN KEY (`id_menu`) REFERENCES `tb_menu` (`id_menu`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tb_menu_query` */

LOCK TABLES `tb_menu_query` WRITE;

insert  into `tb_menu_query`(`id_menu`,`query`,`is_used`) values 
(1,'SELECT * FROM tb_matakuliah',0),
(2,'SELECT * FROM tb_mahasiswa',0),
(3,'SELECT * FROM tb_mahasiswa WHERE nim =\"\"',0),
(4,'select * from tb_dosen',1);

UNLOCK TABLES;

/*Table structure for table `tb_outbox` */

DROP TABLE IF EXISTS `tb_outbox`;

CREATE TABLE `tb_outbox` (
  `id_outbox` int(11) NOT NULL AUTO_INCREMENT,
  `response_content` text DEFAULT NULL,
  `chat_id` int(11) DEFAULT NULL,
  `id_inbox` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_outbox`),
  KEY `message_id` (`id_inbox`),
  CONSTRAINT `tb_outbox_ibfk_1` FOREIGN KEY (`id_inbox`) REFERENCES `tb_inbox` (`id_inbox`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tb_outbox` */

LOCK TABLES `tb_outbox` WRITE;

insert  into `tb_outbox`(`id_outbox`,`response_content`,`chat_id`,`id_inbox`,`timestamp`) values 
(1,'Silakan pilih salah satu opsi:',2147483647,1,'2024-04-02 00:07:09'),
(2,'Silakan pilih salah satu opsi:',2147483647,2,'2024-04-02 00:07:16'),
(5,'Silakan pilih salah satu opsi:',2147483647,3,'2024-04-02 00:58:38'),
(8,'Silakan pilih salah satu opsi:',2147483647,4,'2024-04-02 22:21:35'),
(12,'halo',2147483647,20,'2024-04-02 23:02:33'),
(13,'Silakan pilih salah satu opsi:',2147483647,26,'2024-04-02 23:34:20'),
(20,'Silakan pilih salah satu opsi:',2147483647,27,'2024-04-02 23:36:12'),
(22,'Silakan pilih salah satu opsi:',2147483647,28,'2024-04-02 23:37:52'),
(23,'Silakan pilih salah satu opsi:',2147483647,29,'2024-04-02 23:38:22'),
(25,'Silakan pilih salah satu opsi:',2147483647,30,'2024-04-02 23:44:47'),
(27,'Silakan pilih salah satu opsi:',2147483647,31,'2024-04-02 23:44:54'),
(29,'Silakan pilih salah satu opsi:',2147483647,32,'2024-04-02 23:45:02'),
(33,'Silakan pilih salah satu opsi:',2147483647,33,'2024-04-02 23:53:00'),
(38,'Silakan pilih salah satu opsi:',2147483647,34,'2024-04-02 23:56:43'),
(40,'Silakan pilih salah satu opsi:',2147483647,36,'2024-04-03 00:04:17'),
(42,'Silakan pilih salah satu opsi:',2147483647,38,'2024-04-03 00:06:15'),
(44,'Silakan pilih salah satu opsi:',2147483647,40,'2024-04-03 00:06:41'),
(46,'Silakan pilih salah satu opsi:',2147483647,42,'2024-04-03 00:08:40'),
(48,'Silakan pilih salah satu opsi:',2147483647,44,'2024-04-03 00:11:47'),
(50,'Silakan pilih salah satu opsi:',2147483647,46,'2024-04-03 00:12:07'),
(52,'Silakan pilih salah satu opsi:',2147483647,48,'2024-04-03 00:18:36'),
(54,'Silakan pilih salah satu opsi:',2147483647,50,'2024-04-03 00:18:58'),
(57,'Silakan pilih salah satu opsi:',2147483647,53,'2024-04-03 00:30:11'),
(59,'Silakan pilih salah satu opsi:',2147483647,55,'2024-04-03 00:34:51'),
(61,'Silakan pilih salah satu opsi:',2147483647,57,'2024-04-03 00:37:12'),
(63,'Silakan pilih salah satu opsi:',2147483647,59,'2024-04-03 00:40:18'),
(65,'Silakan pilih salah satu opsi:',2147483647,63,'2024-04-03 01:00:07'),
(68,'Silakan pilih salah satu opsi:',2147483647,66,'2024-04-03 01:03:19'),
(69,'Silakan pilih salah satu opsi:',2147483647,68,'2024-04-03 01:05:11'),
(70,'Silakan pilih salah satu opsi:',2147483647,70,'2024-04-03 01:07:44'),
(71,'Silakan pilih salah satu opsi:',2147483647,73,'2024-04-03 10:13:05'),
(72,'Silakan pilih salah satu opsi:',2147483647,75,'2024-04-03 10:44:32'),
(74,'Silakan pilih salah satu opsi:',2147483647,77,'2024-04-03 10:50:20'),
(75,'Silakan pilih salah satu opsi:',2147483647,82,'2024-04-03 11:28:08'),
(76,'Silakan pilih salah satu opsi:',2147483647,86,'2024-04-03 11:39:31'),
(77,'Silakan pilih salah satu opsi:',2147483647,87,'2024-04-03 11:39:34'),
(78,'Silakan pilih salah satu opsi:',2147483647,88,'2024-04-03 11:39:44'),
(79,'Silakan pilih salah satu opsi:',2147483647,89,'2024-04-03 11:48:44'),
(80,'Silakan pilih salah satu opsi:',2147483647,90,'2024-04-03 11:48:53'),
(81,'Silakan pilih salah satu opsi:',2147483647,97,'2024-04-03 12:08:57'),
(82,'Silakan pilih salah satu opsi:',2147483647,101,'2024-04-03 12:18:01'),
(83,'Silakan pilih salah satu opsi:',2147483647,102,'2024-04-03 12:18:04'),
(84,'Silakan pilih salah satu opsi:',2147483647,103,'2024-04-03 12:18:35'),
(85,'Silakan pilih salah satu opsi:',2147483647,104,'2024-04-03 12:21:04'),
(86,'Silakan pilih salah satu opsi:',2147483647,107,'2024-04-03 12:32:17'),
(87,'Silakan pilih salah satu opsi:',2147483647,108,'2024-04-03 12:32:40'),
(88,'Silakan pilih salah satu opsi:',2147483647,109,'2024-04-03 12:34:55'),
(89,'Silakan pilih salah satu opsi:',2147483647,111,'2024-04-03 12:35:06'),
(90,'Silakan pilih salah satu opsi:',2147483647,113,'2024-04-03 12:39:58'),
(91,'Silakan pilih salah satu opsi:',2147483647,115,'2024-04-03 13:32:48'),
(92,'Silakan pilih salah satu opsi:',2147483647,117,'2024-04-03 13:33:30'),
(93,'Silakan pilih salah satu opsi:',2147483647,120,'2024-04-03 20:56:38'),
(94,'Silakan pilih salah satu opsi:',2147483647,123,'2024-04-03 20:58:20'),
(95,'Silakan pilih salah satu opsi:',2147483647,125,'2024-04-03 21:01:07'),
(96,'Silakan pilih salah satu opsi:',2147483647,127,'2024-04-03 21:22:22'),
(97,'Silakan pilih salah satu opsi:',2147483647,128,'2024-04-03 21:22:30'),
(98,'Silakan pilih salah satu opsi:',2147483647,129,'2024-04-03 21:23:18'),
(99,'Silakan pilih salah satu opsi:',2147483647,130,'2024-04-03 21:23:27'),
(100,'Silakan pilih salah satu opsi:',2147483647,131,'2024-04-03 21:34:42'),
(101,'Silakan pilih salah satu opsi:',2147483647,132,'2024-04-03 21:36:29'),
(102,'Silakan pilih salah satu opsi:',2147483647,134,'2024-04-03 21:36:36'),
(103,'Silakan pilih salah satu opsi:',2147483647,136,'2024-04-03 21:36:44'),
(104,'Silakan pilih salah satu opsi:',2147483647,138,'2024-04-03 21:36:53'),
(105,'Silakan pilih salah satu opsi:',2147483647,140,'2024-04-03 21:39:57'),
(106,'Silakan pilih salah satu opsi:',2147483647,142,'2024-04-03 21:40:05'),
(107,'Silakan pilih salah satu opsi:',2147483647,144,'2024-04-03 21:40:12'),
(108,'Silakan pilih salah satu opsi:',2147483647,146,'2024-04-03 21:40:20'),
(109,'Silakan pilih salah satu opsi:',2147483647,148,'2024-04-03 21:42:46'),
(110,'Silakan pilih salah satu opsi:',2147483647,150,'2024-04-03 21:42:55'),
(111,'Silakan pilih salah satu opsi:',2147483647,152,'2024-04-03 21:43:26'),
(112,'Silakan pilih salah satu opsi:',2147483647,154,'2024-04-03 21:47:50'),
(113,'Silakan pilih salah satu opsi:',2147483647,155,'2024-04-03 21:47:57'),
(114,'Silakan pilih salah satu opsi:',2147483647,156,'2024-04-03 21:50:45'),
(115,'Silakan pilih salah satu opsi:',2147483647,158,'2024-04-03 21:50:52'),
(116,'Silakan pilih salah satu opsi:',2147483647,160,'2024-04-03 22:13:11');

UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
