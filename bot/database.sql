/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 10.4.32-MariaDB : Database - db_banagobot
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_banagobot` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `db_banagobot`;

/*Table structure for table `tb_dosen` */

DROP TABLE IF EXISTS `tb_dosen`;

CREATE TABLE `tb_dosen` (
  `nip` varchar(100) DEFAULT NULL,
  `nidn` varchar(100) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tb_dosen` */

LOCK TABLES `tb_dosen` WRITE;

UNLOCK TABLES;

/*Table structure for table `tb_inbox` */

DROP TABLE IF EXISTS `tb_inbox`;

CREATE TABLE `tb_inbox` (
  `id_inbox` varchar(100) NOT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `flag` varchar(100) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id_inbox`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tb_inbox` */

LOCK TABLES `tb_inbox` WRITE;

insert  into `tb_inbox`(`id_inbox`,`user_id`,`message`,`type`,`flag`,`create_date`) values 
('60b2391d-e9a0-4cb9-9e86-76396cc50c76','6090906462','halo','private',NULL,'2024-04-14 17:34:57'),
('77a4b147-15ca-4abb-9529-72b17621c3ff','6090906462','test','private',NULL,'2024-04-14 17:33:47');

UNLOCK TABLES;

/*Table structure for table `tb_mahasiswa` */

DROP TABLE IF EXISTS `tb_mahasiswa`;

CREATE TABLE `tb_mahasiswa` (
  `nim` varchar(100) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `telepon` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tb_mahasiswa` */

LOCK TABLES `tb_mahasiswa` WRITE;

UNLOCK TABLES;

/*Table structure for table `tb_matakuliah` */

DROP TABLE IF EXISTS `tb_matakuliah`;

CREATE TABLE `tb_matakuliah` (
  `kode_mk` int(11) NOT NULL AUTO_INCREMENT,
  `nama_mk` varchar(100) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `sks` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`kode_mk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tb_matakuliah` */

LOCK TABLES `tb_matakuliah` WRITE;

UNLOCK TABLES;

/*Table structure for table `tb_menu` */

DROP TABLE IF EXISTS `tb_menu`;

CREATE TABLE `tb_menu` (
  `id_menu` int(10) NOT NULL AUTO_INCREMENT,
  `no` varchar(200) DEFAULT NULL,
  `label` varchar(200) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  PRIMARY KEY (`id_menu`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tb_menu` */

LOCK TABLES `tb_menu` WRITE;

insert  into `tb_menu`(`id_menu`,`no`,`label`,`deskripsi`) values 
(1,'1','DAFTAR MAHASISWA',NULL),
(2,'2','CARI MAHASISWA',NULL),
(3,'3','DAFTAR MATA KULIAH',NULL),
(4,'4','CARI MATA KULIAH',NULL),
(5,'5','DAFTAR DOSEN',NULL),
(6,'6','CARI DOSEN',NULL);

UNLOCK TABLES;

/*Table structure for table `tb_outbox` */

DROP TABLE IF EXISTS `tb_outbox`;

CREATE TABLE `tb_outbox` (
  `id_outbox` varchar(100) NOT NULL,
  `id_inbox` varchar(100) DEFAULT NULL,
  `id_user` varchar(100) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id_outbox`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tb_outbox` */

LOCK TABLES `tb_outbox` WRITE;

UNLOCK TABLES;

/*Table structure for table `tb_query_menu` */

DROP TABLE IF EXISTS `tb_query_menu`;

CREATE TABLE `tb_query_menu` (
  `id_query_menu` int(11) NOT NULL AUTO_INCREMENT,
  `id_menu` int(11) DEFAULT NULL,
  `query` text DEFAULT NULL,
  PRIMARY KEY (`id_query_menu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tb_query_menu` */

LOCK TABLES `tb_query_menu` WRITE;

UNLOCK TABLES;

/*Table structure for table `tb_query_menu_param` */

DROP TABLE IF EXISTS `tb_query_menu_param`;

CREATE TABLE `tb_query_menu_param` (
  `id_menu_param` int(11) NOT NULL AUTO_INCREMENT,
  `id_query_menu` int(11) DEFAULT NULL,
  `param` varchar(200) DEFAULT NULL,
  `type` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_menu_param`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tb_query_menu_param` */

LOCK TABLES `tb_query_menu_param` WRITE;

UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
