/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.0.22-community-nt : Database - hyq_exam
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`hyq_exam` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;

USE `hyq_exam`;

/*Table structure for table `t_dict` */

DROP TABLE IF EXISTS `t_dict`;

CREATE TABLE `t_dict` (
  `id` varchar(64) collate utf8_bin NOT NULL COMMENT '字典主键',
  `name` varchar(100) collate utf8_bin default NULL COMMENT '字典名称',
  `value` varchar(30) collate utf8_bin default NULL COMMENT '字典值',
  `type` varchar(20) collate utf8_bin default NULL COMMENT '字典类型',
  `description` varchar(200) collate utf8_bin default NULL COMMENT '字典描述',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `t_dict` */

insert  into `t_dict`(`id`,`name`,`value`,`type`,`description`) values ('1','专科','1','dict_edu','学历'),('2','本科','2','dict_edu','学历'),('3','研究生','3','dict_edu','学历'),('4','博士','4','dict_edu','学历');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
