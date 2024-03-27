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

/*Table structure for table `bot_responses` */

DROP TABLE IF EXISTS `bot_responses`;

CREATE TABLE `bot_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `response_content` text DEFAULT NULL,
  `chat_id` int(11) DEFAULT NULL,
  `message_id` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `message_id` (`message_id`),
  CONSTRAINT `bot_responses_ibfk_1` FOREIGN KEY (`message_id`) REFERENCES `chat_messages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `bot_responses` */

LOCK TABLES `bot_responses` WRITE;

insert  into `bot_responses`(`id`,`response_content`,`chat_id`,`message_id`,`timestamp`) values 
(1,'Saya adalah asisten virtual yang bisa membantu dengan berbagai pertanyaanmu. Apa yang bisa saya bantu?',2147483647,23,'2024-03-27 22:42:22'),
(2,'Cuaca memang tidak bisa diprediksi, tetapi mari kita cari tahu bagaimana kita bisa tetap bahagia di hari yang mendung ini.',2147483647,24,'2024-03-27 22:44:07');

UNLOCK TABLES;

/*Table structure for table `chat_messages` */

DROP TABLE IF EXISTS `chat_messages`;

CREATE TABLE `chat_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_content` text DEFAULT NULL,
  `chat_id` bigint(20) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `message_type` enum('private','group') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `chat_messages` */

LOCK TABLES `chat_messages` WRITE;

insert  into `chat_messages`(`id`,`message_content`,`chat_id`,`timestamp`,`message_type`) values 
(1,'apa kabar',6090906462,'2024-03-27 21:53:27','private'),
(2,'halo bang',1916380362,'2024-03-27 21:56:55','private'),
(3,'aku sayang kamu',1916380362,'2024-03-27 21:57:16','private'),
(4,'halo',1916380362,'2024-03-27 21:57:26','private'),
(5,'Halo',1916380362,'2024-03-27 21:57:33','private'),
(6,'apa kabar',1916380362,'2024-03-27 21:57:43','private'),
(7,'Halo',1916380362,'2024-03-27 21:58:00','private'),
(8,'halo',6090906462,'2024-03-27 22:07:00','private'),
(9,'kenapa',6090906462,'2024-03-27 22:07:03','private'),
(10,'siapa kamu',6090906462,'2024-03-27 22:07:35','private'),
(11,'halo',6090906462,'2024-03-27 22:09:06','private'),
(12,'kenapa',6090906462,'2024-03-27 22:09:10','private'),
(13,'siapa anda',6090906462,'2024-03-27 22:09:13','private'),
(14,'/stop',6090906462,'2024-03-27 22:09:34','private'),
(15,'halo',6090906462,'2024-03-27 22:25:43','private'),
(16,'apa kabar',6090906462,'2024-03-27 22:25:47','private'),
(17,'kamu siapa',6090906462,'2024-03-27 22:25:50','private'),
(18,'siapa anda',6090906462,'2024-03-27 22:25:54','private'),
(19,'halo',6090906462,'2024-03-27 22:29:55','private'),
(20,'siapa anda',6090906462,'2024-03-27 22:30:00','private'),
(21,'halo',6090906462,'2024-03-27 22:38:47','private'),
(22,'apa kabar',6090906462,'2024-03-27 22:39:45','private'),
(23,'siapa anda',6090906462,'2024-03-27 22:42:22','private'),
(24,'kenapa',6090906462,'2024-03-27 22:44:07','private');

UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
