-- Generation time: Thu, 24 Dec 2020 09:35:14 +0000
-- Host: mysql.hostinger.ro
-- DB name: u574849695_22
/*!40030 SET NAMES UTF8 */;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `calendar_user`;
CREATE TABLE `calendar_user` (
  `user_id` bigint(20) unsigned NOT NULL,
  `event_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`event_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `calendar_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `calendar_user_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='События в календаре пользователя';



DROP TABLE IF EXISTS `communities`;
CREATE TABLE `communities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `admin_user_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `communities_name_idx` (`name`),
  KEY `admin_user_id` (`admin_user_id`),
  CONSTRAINT `communities_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

INSERT INTO `communities` VALUES ('1','rerum','2'),
('2','expedita','3'),
('3','molestiae','4'),
('4','consectetur','5'),
('5','veritatis','6'),
('6','ea','7'),
('7','ducimus','8'),
('8','vel','9'),
('9','voluptatibus','10'),
('10','non','11'); 


DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  `event_datetime` datetime NOT NULL,
  `event_date` date DEFAULT NULL COMMENT 'Для операций с календарем',
  `coord` point DEFAULT NULL COMMENT 'Коодинаты события',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `event_date` (`event_date`),
  KEY `user_id` (`user_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `events_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='События привязанные к локации и времени';



DROP TABLE IF EXISTS `friend_requests`;
CREATE TABLE `friend_requests` (
  `initiator_user_id` bigint(20) unsigned NOT NULL,
  `target_user_id` bigint(20) unsigned NOT NULL,
  `status` enum('requested','approved','declined','unfriended') DEFAULT NULL,
  `requested_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `likes_fk` (`media_id`),
  KEY `likes_fk_1` (`user_id`),
  CONSTRAINT `likes_fk` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`),
  CONSTRAINT `likes_fk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



DROP TABLE IF EXISTS `media`;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `media_type_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` text DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;



DROP TABLE IF EXISTS `media_types`;
CREATE TABLE `media_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=latin1;

INSERT INTO `media_types` VALUES ('2','quo','2011-04-06 17:36:39','1999-04-29 13:20:30'),
('3','distinctio','1997-08-05 07:04:24','1993-08-26 07:01:45'),
('4','voluptatum','1987-05-30 10:18:13','2006-05-14 06:28:09'),
('5','pariatur','2012-02-11 11:19:45','2015-07-02 00:08:02'),
('6','velit','1972-10-17 17:20:27','1999-09-15 16:54:03'),
('7','et','1990-05-04 19:13:57','1980-09-05 16:11:20'),
('8','laborum','1998-08-06 09:31:06','2006-07-01 21:57:32'),
('9','aut','2014-01-26 01:22:16','2009-06-27 05:28:36'),
('10','est','2011-07-14 06:14:46','2010-11-08 05:10:02'),
('11','corrupti','1980-04-27 05:09:39','2000-09-20 23:01:12'),
('12','provident','2020-10-10 04:36:32','2015-09-12 03:44:33'),
('13','suscipit','2013-02-06 22:45:58','2011-03-23 02:40:21'),
('14','laboriosam','2002-05-16 21:31:53','2008-08-23 11:52:22'),
('15','recusandae','1981-02-23 10:13:52','1975-09-04 09:38:04'),
('16','omnis','1983-09-23 03:58:16','1985-07-07 14:37:09'),
('17','earum','2016-03-19 14:19:14','1978-07-09 04:28:40'),
('18','et','1974-04-02 08:38:15','1998-05-03 08:22:18'),
('19','consequatur','2006-06-01 05:08:00','1991-02-10 05:33:05'),
('20','dolor','1978-10-13 10:15:17','2006-02-10 18:35:36'),
('21','illo','1985-12-23 06:13:30','1988-07-03 11:27:45'),
('22','quis','1995-06-05 02:19:15','2003-09-28 04:46:00'),
('23','enim','2000-01-14 11:15:47','1975-07-16 22:49:57'),
('24','deleniti','1987-04-30 14:29:47','2012-11-07 09:41:13'),
('25','numquam','2008-12-20 05:49:01','1976-06-24 12:44:03'),
('26','possimus','2015-11-21 03:12:00','1991-09-14 13:35:30'),
('27','quibusdam','2015-01-06 20:51:38','2020-02-06 19:20:59'),
('28','sequi','2019-05-29 08:19:20','2019-11-08 17:15:50'),
('29','error','2007-02-24 00:45:52','1984-05-30 11:13:39'),
('30','in','1997-04-16 12:36:15','1994-04-11 19:44:29'),
('31','impedit','1974-09-10 00:40:00','2020-05-21 02:01:57'),
('32','sit','1998-07-13 15:52:23','2014-07-21 09:52:26'),
('33','quia','1972-04-27 00:29:38','2019-11-18 15:21:15'),
('34','culpa','1990-05-31 14:39:16','1987-04-14 22:57:48'),
('35','laudantium','1989-02-02 20:06:01','1990-01-23 15:12:29'),
('36','repellat','2005-08-20 00:47:14','2015-09-19 00:00:27'),
('37','qui','1995-08-26 11:35:07','1997-04-02 08:39:24'),
('38','qui','2001-01-07 00:51:18','1982-07-12 11:16:46'),
('39','voluptatibus','1975-08-22 15:34:57','1970-01-12 15:19:32'),
('40','laboriosam','2004-06-20 06:04:13','1999-04-18 07:44:06'),
('41','animi','1976-01-26 20:13:54','1991-05-14 22:52:43'),
('42','itaque','1976-01-19 10:04:17','1983-01-11 04:52:36'),
('43','dolores','1984-03-21 07:21:12','2009-04-14 22:25:32'),
('44','id','1972-05-11 22:18:30','1974-06-10 07:18:59'),
('45','officiis','2015-02-03 12:54:08','1992-11-30 16:54:46'),
('46','doloribus','1983-11-28 21:13:04','2018-08-25 11:53:04'),
('47','dolor','1981-08-02 13:10:48','2014-06-23 21:42:15'),
('48','deserunt','2014-01-27 22:59:40','2016-02-11 11:56:53'),
('49','esse','1992-10-24 11:12:14','2000-05-04 22:02:17'),
('50','minus','2018-09-02 16:16:34','2017-06-12 18:03:26'),
('51','eum','1981-04-23 21:08:01','1990-04-09 04:31:31'),
('52','ipsum','2018-03-13 10:05:33','1974-02-19 10:44:14'),
('53','et','2014-09-06 20:01:43','1983-08-21 00:23:34'),
('54','porro','1976-07-21 12:57:38','2016-08-14 06:12:42'),
('55','ullam','2006-11-09 04:11:25','1980-05-16 16:04:05'),
('56','rerum','2011-02-03 23:44:53','1996-03-28 20:48:12'),
('57','voluptas','1978-08-19 11:58:50','2016-08-05 03:42:46'),
('58','quo','1971-07-16 01:32:03','1978-05-16 14:22:56'),
('59','placeat','2017-10-04 07:00:44','1988-07-31 18:35:03'),
('60','dolorum','1971-01-21 05:11:32','1997-09-06 17:10:23'),
('61','labore','1972-06-14 09:48:12','1996-08-05 15:09:53'),
('62','ea','2016-03-22 20:57:43','1980-08-15 09:51:51'),
('63','ipsam','1994-12-29 00:51:49','2008-10-11 21:15:48'),
('64','quaerat','2003-06-08 02:04:20','2006-10-26 09:16:26'),
('65','sunt','1974-06-09 18:43:19','1980-11-05 15:09:20'),
('66','similique','1995-01-18 00:31:00','1987-11-01 23:25:44'),
('67','exercitationem','1983-07-09 12:22:26','2010-12-25 02:56:42'),
('68','eum','1999-01-12 12:01:24','2013-05-20 03:48:28'),
('69','et','2019-02-04 22:11:27','1994-03-18 16:49:35'),
('70','voluptates','1972-10-23 11:15:49','1996-03-06 02:43:17'),
('71','qui','1984-03-19 08:35:55','1992-10-09 19:19:25'),
('72','dignissimos','2016-06-03 01:14:35','1995-08-31 21:48:36'),
('73','ut','2020-01-01 00:49:18','1995-09-09 16:04:48'),
('74','illo','2004-01-26 11:33:18','2009-01-03 22:54:06'),
('75','minima','2006-07-12 06:50:41','1988-06-13 04:48:04'),
('76','accusamus','1976-10-09 03:03:26','2003-01-29 18:41:24'),
('77','libero','2007-01-17 00:22:48','1996-06-23 06:01:00'),
('78','ut','1995-04-16 22:47:02','2017-12-27 05:14:05'),
('79','distinctio','2000-07-29 05:56:57','1993-11-17 20:43:51'),
('80','id','1993-10-06 17:32:51','1997-04-03 14:00:03'),
('81','deleniti','1976-04-23 02:34:19','1987-08-19 20:48:10'),
('82','est','1979-10-03 14:56:19','1996-10-09 10:51:42'),
('83','excepturi','1977-11-21 11:53:42','1990-10-13 01:24:49'),
('84','ratione','1986-11-09 15:13:56','1996-04-24 11:26:17'),
('85','doloremque','1977-11-23 12:10:16','1983-04-28 07:10:36'),
('86','dicta','1982-11-27 00:33:21','2007-01-24 07:39:32'),
('87','iste','2001-01-09 21:19:18','1976-09-29 01:16:41'),
('88','rerum','2016-01-02 13:45:43','1999-04-17 05:49:30'),
('89','veniam','1980-03-02 00:15:34','1987-06-10 10:47:24'),
('90','ut','1999-11-23 07:20:39','2003-12-31 14:19:47'),
('91','voluptas','2017-10-03 22:22:13','1995-12-30 13:04:26'),
('92','omnis','2016-12-29 17:18:22','1992-05-01 12:24:02'),
('93','sunt','1986-09-15 11:10:23','2016-10-16 18:54:46'),
('94','exercitationem','2008-08-03 19:19:54','2006-02-27 12:13:02'),
('95','sit','1982-02-21 11:49:19','1975-01-01 05:15:55'),
('96','recusandae','2017-06-24 20:37:06','2011-04-10 03:54:03'),
('97','iste','2003-06-05 12:23:13','1979-11-05 10:00:15'),
('98','sunt','1992-03-26 17:33:04','2018-01-02 10:46:27'),
('99','corrupti','1987-02-19 01:07:43','1992-04-01 09:27:42'),
('100','qui','2012-03-07 23:18:12','1983-03-21 21:40:23'),
('101','tenetur','2011-07-26 15:53:09','2013-12-28 18:39:55'); 


DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `body` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photo_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) unsigned DEFAULT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `album_id` (`album_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`),
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `photo_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `hometown` varchar(100) DEFAULT NULL,
  UNIQUE KEY `user_id` (`user_id`),
  KEY `profiles_fk_1` (`photo_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `profiles_fk_1` FOREIGN KEY (`photo_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `profiles` VALUES ('2','m','2020-10-17',NULL,'2010-01-25 19:21:20','North Jerrell'),
('3','f','2018-04-04',NULL,'1998-01-15 01:05:45','Jaylenhaven'),
('4','f','1977-07-20',NULL,'2009-11-02 13:26:26','Aleenfurt'),
('5','f','1988-09-26',NULL,'2001-12-11 23:48:49','West Charley'),
('6','m','2019-06-30',NULL,'2001-09-20 12:30:43','Lake Edgardoburgh'),
('7','m','1990-04-10',NULL,'2010-05-15 09:17:31','Arnoshire'),
('8','m','2014-07-11',NULL,'1970-11-08 08:08:10','Christinaburgh'),
('9','m','1994-06-27',NULL,'2001-05-13 09:15:53','New Norwood'),
('10','m','2005-07-06',NULL,'2007-10-23 01:42:31','New Lavina'),
('11','f','1987-02-13',NULL,'1972-07-31 05:40:39','Port Tracehaven'),
('12','f','2002-05-07',NULL,'2000-09-10 03:59:36','Robertsmouth'),
('13','m','1991-05-26',NULL,'1981-02-01 07:29:52','New Josephborough'),
('14','m','1998-11-11',NULL,'2003-08-29 04:52:55','Antonettaview'),
('15','m','1985-02-23',NULL,'1997-09-21 08:03:11','Leliafort'),
('16','f','2015-02-13',NULL,'1978-02-10 06:20:15','Cobytown'),
('17','f','2012-03-29',NULL,'1978-10-09 15:12:59','Port Mossieborough'),
('18','m','1983-09-23',NULL,'1976-10-21 13:03:28','Geoffreyberg'),
('19','m','2017-08-05',NULL,'2001-01-08 05:38:46','Jonathanbury'),
('20','f','2015-05-12',NULL,'2007-10-26 04:20:43','West Lila'),
('21','m','1990-02-13',NULL,'2019-09-27 08:37:52','Blockmouth'),
('22','m','1971-08-03',NULL,'1994-11-20 17:09:10','Nicoleview'),
('23','f','2004-01-30',NULL,'1991-01-06 08:35:49','Sengertown'),
('24','f','2007-10-31',NULL,'1995-02-14 11:12:11','Frederikland'),
('25','f','2001-06-13',NULL,'2018-02-13 19:16:18','Port Jennyfermouth'),
('26','m','2016-06-04',NULL,'2011-03-23 19:32:36','South Eino'),
('27','m','1986-05-27',NULL,'2003-12-19 13:16:03','Unatown'),
('28','m','1986-09-27',NULL,'2006-11-29 06:55:58','Nicolasfurt'),
('29','f','2002-07-09',NULL,'2008-04-29 04:14:23','Lake Arnulfo'),
('30','f','1989-10-17',NULL,'1974-07-08 05:06:55','North Kaylaborough'),
('31','f','1977-05-10',NULL,'1985-07-21 04:53:34','Lake Julesmouth'),
('32','f','1979-11-23',NULL,'1980-01-20 10:32:23','Rutherfordmouth'),
('33','m','2017-07-01',NULL,'2006-04-19 11:28:51','New Norene'),
('34','m','1998-07-19',NULL,'2015-02-13 05:06:38','Port Camylle'),
('35','m','2000-07-05',NULL,'2014-12-05 20:42:51','Hillsfurt'),
('36','m','1993-06-17',NULL,'1970-10-07 01:57:09','Merlefurt'),
('37','m','1997-08-08',NULL,'2020-05-31 00:26:57','Port Cierra'),
('38','f','2013-01-09',NULL,'1975-01-20 04:31:33','Gavinland'),
('39','m','2011-07-20',NULL,'2017-09-11 14:19:56','Dibbertfort'),
('40','f','1988-04-26',NULL,'2002-02-28 01:44:52','Port Addison'),
('41','m','1984-09-01',NULL,'2000-05-18 08:59:00','South Horaciofurt'),
('42','m','1981-10-04',NULL,'1993-08-03 16:31:21','South Barrett'),
('43','f','2014-07-07',NULL,'2004-04-12 18:41:58','Metzfurt'),
('44','m','2007-04-12',NULL,'1990-01-30 03:58:34','Lake Darrel'),
('45','m','2017-01-18',NULL,'1973-02-17 09:56:27','New Myah'),
('46','f','1997-09-01',NULL,'1972-04-22 14:54:09','Yoshikoborough'),
('47','m','2017-12-06',NULL,'1976-09-13 11:50:03','West Chloeport'),
('48','f','1986-10-24',NULL,'2010-06-26 15:12:25','Port Briana'),
('49','f','1992-04-29',NULL,'1980-11-29 11:37:46','South Hectortown'),
('50','f','1970-12-25',NULL,'1984-05-09 15:22:58','East Veda'),
('51','m','2002-06-15',NULL,'2012-02-29 01:32:24','North Elizabethchester'),
('52','f','2017-12-02',NULL,'2015-06-07 02:09:27','Zechariahchester'),
('53','m','1996-10-04',NULL,'2005-06-15 07:36:40','Lake Athena'),
('54','m','1988-11-28',NULL,'1982-05-20 23:05:30','West Erik'),
('55','f','1987-03-18',NULL,'1985-02-19 01:12:43','Aldaton'),
('56','m','1990-05-13',NULL,'2014-10-29 01:48:01','Jalenport'),
('57','m','2011-03-20',NULL,'1984-07-06 04:51:29','North Cullen'),
('58','f','1992-07-30',NULL,'1978-10-09 23:30:02','Myleneport'),
('59','m','2009-09-08',NULL,'1972-04-01 17:35:45','South Emmett'),
('60','m','1977-11-11',NULL,'1998-07-03 19:20:38','North Kieratown'),
('61','m','2010-07-10',NULL,'1972-11-07 05:05:32','Champlinburgh'),
('62','f','2012-09-26',NULL,'1995-02-06 01:47:23','Lake Genesismouth'),
('63','f','1995-04-02',NULL,'1991-01-16 14:39:44','South Alanis'),
('64','f','1989-01-04',NULL,'1974-01-22 00:29:31','Bellaside'),
('65','m','2018-12-21',NULL,'2019-12-14 12:42:20','Rodriguezfurt'),
('66','f','1978-12-16',NULL,'1971-03-26 10:57:30','Port Jessyhaven'),
('67','f','2018-10-11',NULL,'2020-10-02 17:57:21','New Saul'),
('68','m','1988-05-19',NULL,'2012-08-02 00:42:12','Joesphhaven'),
('69','f','1994-10-06',NULL,'2002-07-26 23:39:30','Lake Montana'),
('70','f','2003-01-10',NULL,'1995-04-12 07:19:28','Martinchester'),
('71','f','2012-06-29',NULL,'1972-02-22 06:41:05','Trompview'),
('72','m','2017-04-10',NULL,'1974-03-15 17:15:57','Cassinfort'),
('73','m','2014-03-25',NULL,'2002-01-12 06:04:51','Boganhaven'),
('74','f','1991-12-17',NULL,'1994-02-20 10:09:35','Port Brando'),
('75','f','1972-09-17',NULL,'1977-10-25 16:32:26','Sigridchester'),
('76','f','2013-06-22',NULL,'1986-08-02 06:52:01','Deondrestad'),
('77','f','1984-05-19',NULL,'1996-08-21 10:11:10','Aufderharstad'),
('78','m','1983-07-07',NULL,'2005-03-15 06:16:00','Lake Lutherberg'),
('79','f','1989-03-23',NULL,'2000-12-28 08:20:40','North Eliane'),
('80','m','1979-04-11',NULL,'2018-07-14 08:10:21','Ginaville'),
('81','f','1998-07-07',NULL,'1971-02-28 20:26:43','Alfredaton'),
('82','m','2000-10-02',NULL,'1977-06-19 17:36:27','North Travis'),
('83','m','1980-06-03',NULL,'1985-03-09 00:25:25','Johnschester'),
('84','f','2006-05-05',NULL,'1970-12-26 17:46:18','Kautzerbury'),
('85','m','1994-04-08',NULL,'1996-02-09 04:47:34','Tessview'),
('86','f','1983-06-14',NULL,'2012-07-30 11:47:33','Medhurstmouth'),
('87','f','1992-03-10',NULL,'1970-04-21 15:07:56','East Rachelbury'),
('88','m','2013-08-03',NULL,'1976-12-09 07:36:30','New Gianni'),
('89','m','2006-03-09',NULL,'1978-04-02 05:42:43','New Jaydaport'),
('90','f','1971-09-21',NULL,'1979-01-20 18:22:43','South Johnpaul'),
('91','f','1980-03-11',NULL,'2009-03-25 12:43:56','Sheilaport'),
('92','m','1994-06-07',NULL,'2000-05-03 06:12:21','Nedshire'),
('93','m','1970-11-08',NULL,'1975-11-07 00:39:04','Doloresstad'),
('94','m','1982-03-11',NULL,'2000-06-18 18:56:02','Port Brigitte'),
('95','f','1988-10-11',NULL,'1982-10-30 22:16:53','Port Lurline'),
('96','f','1994-11-03',NULL,'2016-09-03 00:27:51','South Adalineside'),
('97','f','1980-04-07',NULL,'1977-08-08 08:38:46','Archibaldborough'),
('98','f','2012-01-30',NULL,'2012-05-08 04:17:50','Blockview'),
('99','m','1975-07-01',NULL,'2007-02-20 13:59:58','Considinemouth'),
('100','m','2002-07-26',NULL,'2002-09-15 22:09:30','South Flaviemouth'),
('101','f','1986-06-23',NULL,'2003-12-04 03:27:49','South Jerel'); 


DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `code` char(6) NOT NULL COMMENT 'код тега, натуральный ключ',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Теги для быстрого поиска';

INSERT INTO `tags` VALUES ('abmab'),
('bbyua'),
('dcian'),
('kgcpc'),
('lfbxw'),
('lmuvs'),
('lxule'),
('mckbh'),
('pvmkg'),
('zreyv'); 


DROP TABLE IF EXISTS `tags_media`;
CREATE TABLE `tags_media` (
  `code` char(6) NOT NULL COMMENT 'код тега, натуральный ключ',
  `media_id` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`code`,`media_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `tags_media_ibfk_1` FOREIGN KEY (`code`) REFERENCES `tags` (`code`),
  CONSTRAINT `tags_media_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Теги на медиа для быстрого поиска';



DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL COMMENT 'Фамиль',
  `email` varchar(120) DEFAULT NULL,
  `password_hash` varchar(100) DEFAULT NULL,
  `phone` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=latin1 COMMENT='юзеры';

INSERT INTO `users` VALUES ('2','Jaclyn','Okuneva','donnell02@example.org','d20501f2f7938819d8a598bcc453334b226fe503','89111967547'),
('3','Flavie','Hyatt','bernadette31@example.org','2c9e9bfde2972a252eece0b5f3e2a0cadd94e8bf','89151397375'),
('4','Casimir','Murazik','bonita69@example.org','8641f3b422f6f565904ffb816da073e468681b53','89074197622'),
('5','Irving','Treutel','albina07@example.com','40e4fb6f407e5ea5a9b3dfb8ff99bb4398d153ec','89070905362'),
('6','Brycen','Osinski','jedidiah.schneider@example.org','9e8ee65fb92388c9f970e27510258fdb9285dbb8','89158111180'),
('7','Sibyl','Bins','ucole@example.net','a3a714df465266b45f4e4373b83b37c91e64183c','89233382499'),
('8','Marian','Kovacek','laurel66@example.com','621f5d80f64bbb4f5b97284ef7ed876f7deaaac0','89152211621'),
('9','Markus','Durgan','maurice.bartoletti@example.org','49328f0d78ca89472b4f4df0de02f847d2dc666b','89088409408'),
('10','Armando','Jacobi','karson39@example.net','1ddfc3d02fffe1fb9aa18977bd2ddfe0cb645fb4','89084127251'),
('11','Samson','Conroy','addie88@example.org','bd867566e39ee6d351ca5952f1ad956795286ee8','89057653129'),
('12','Myra','Reynolds','madeline48@example.com','42b60b86d21718928019b366a001e3b684d2deb9','89042800980'),
('13','Ricky','Sporer','autumn.ziemann@example.com','89b4e5f2619741cf51996fe7bbbe35ce6644eeef','89250693951'),
('14','Zoila','O\'Kon','lgislason@example.org','c94f5afc0527a9252d16734196ba7d10f9c976d6','89250428149'),
('15','Terry','Kihn','shana.schroeder@example.net','ccef32bcc93afae91edc95c56374cdd30fd6f910','89219820085'),
('16','Marilyne','Deckow','elenor.kirlin@example.org','a5d2420d4a4127d88acb6d26142d9b5db40759db','89226424292'),
('17','Brian','Carter','bwisozk@example.org','1b7fb9748a61a677635e9b5c96caa5f05aa779ec','89147589266'),
('18','Casandra','Hahn','kyla88@example.net','b74c41bf49d5d416ed66592372813fcd4e77d9a5','89185182966'),
('19','Name','Zboncak','maria84@example.com','f473b841882d94e6dc9154fdac9697531c527b21','89227533184'),
('20','Rubye','Bailey','becker.audie@example.net','429eac5d43d0ec5bc0595d6fb6900013f92f1b22','89031455527'),
('21','Allen','Mante','colt.gibson@example.org','bd061c4c2356c0f1a7a0e915d4c3d523d40b9c14','89079808862'),
('22','Kenyon','Jaskolski','harley.keebler@example.org','d7ab0483ea5bf00822de0883ee6ed5c54eb25b83','89216513236'),
('23','Jarret','Kiehn','daniel.jennifer@example.org','de90cf8c7f0420cfdda129a460b1b9fa96fb3141','89112063233'),
('24','Yoshiko','Schuster','kira47@example.org','d8d56b89f0d35202798d915ffbffc6e2520fb5fe','89049747337'),
('25','Jacques','Wunsch','wruecker@example.org','103e39d82459a5808cd075640a37270c45aa76b5','89180476676'),
('26','Sabrina','Hilpert','haley.nitzsche@example.net','4b47174a7bc10f92e37452485956a7f837548938','89249533317'),
('27','Cayla','Balistreri','doyle.emily@example.com','cbdcb5c5130025dd06e4ee4aeea42a234e049cf8','89102578397'),
('28','Sophie','Schuster','gordon46@example.org','b2a1270cba6581e3af9e8cdc74447c1b37127bd0','89130751474'),
('29','Dorcas','Gulgowski','xosinski@example.net','1d2426d2ca88a755289f55be136ba70e1d1929de','89149854944'),
('30','Kamron','Stamm','graham.thompson@example.com','88b82437ef877643aaf07dd0cb8dea250dc909e8','89043757718'),
('31','Conrad','Rodriguez','king.rath@example.net','f9734e2f9b98ea0ca3505be0403e5e40de7ea1e0','89144269010'),
('32','Charlie','Christiansen','abby19@example.net','d477cec36271f83d7fac567a2f3e89aa8fdfc86f','89193826322'),
('33','Carlie','Raynor','gcrooks@example.org','7e6df886a88920995b47b8a0ab5114bd00eb04f1','89249642110'),
('34','Josianne','Altenwerth','prohaska.ned@example.com','fb76e5b8277c0662bcb0e51f8e83a919956fd332','89202250630'),
('35','Griffin','Osinski','jpadberg@example.org','981985cffc1f7d48bbcb969f4b594af045d06228','89206561224'),
('36','London','Roob','berta26@example.com','68eb0c479e14a20aa71a0f75b51d47d0ba8c0347','89193156361'),
('37','Aaliyah','Adams','wilton54@example.net','408c7005ad374930ef88be72870905dfbc9fbe45','89068150469'),
('38','Richie','Langworth','mschiller@example.com','04a06b34f999611c5ddf1fe483b25a0c592d1789','89056617003'),
('39','Jamison','Gleichner','jimmy.aufderhar@example.com','fb99dbb68f8ef4bb20048541d35d873c95d53317','89151008977'),
('40','Virgie','Berge','balistreri.vito@example.net','ce59c280c51d6b0f5b809477747326e6544132e5','89090976282'),
('41','Martine','Welch','jamarcus.hegmann@example.org','03a05c36a1038d17f3b16398aee0e9eeb71c4497','89247697993'),
('42','Raegan','Prosacco','veum.easton@example.net','f73ba2231a09bde4e7189034e00e4f3d59048334','89059624468'),
('43','Emie','Schumm','shanie97@example.com','c7fcf9e3dea59e9de4961bb410c9718c4a7f19cc','89239699789'),
('44','Dangelo','Cassin','lea90@example.org','db9b0e8532d3991e60780cb93bb4b6036dc7b626','89126930548'),
('45','Jordon','Hirthe','sasha.daniel@example.net','406b8e02ea8caa2b25d539b97611f4651084bef0','89029863652'),
('46','Wendell','Gerhold','kylee85@example.com','04d043ea2814b6e5ee26d927eed5a1a1dede4f43','89080199078'),
('47','Stacy','Rowe','reba37@example.net','dbeaa52d883e23dee95e10770e35f56ba8e1c703','89164044519'),
('48','Al','Deckow','david.hackett@example.org','0bffa7c358f4b8080bdde06973318191394cc678','89154367423'),
('49','Denis','Carroll','alize07@example.net','fd881fb7d3f2d3e3633033c5cb53ef25ca195bd7','89180583572'),
('50','Geraldine','Bode','xgislason@example.net','6f55a62cac7e13093a298172c83841436ecd700f','89114199721'),
('51','Laurine','O\'Keefe','estell.douglas@example.net','8ee2a2a3fb8cc25056bd1b5765b4dfb5f37d69af','89160755150'),
('52','Myrl','Stark','kling.alice@example.com','7ce5e4101f3c30c34c186ae955ac6e457929af62','89100598947'),
('53','Brian','Beahan','yasmeen.adams@example.com','658bc546df0287a56955127fefd57942e6a3b1ce','89106488116'),
('54','Jordyn','Rohan','malinda65@example.org','3061e41cf9197bbd34a06b121c4eb0fab6b265d7','89044277644'),
('55','Howell','Kuphal','zhoeger@example.com','ff956d8fbc2c81ef34926566b121d3202c420edb','89131086155'),
('56','Buster','Veum','ho\'keefe@example.net','dd17542bf5c898a6f10c42edd404cb047a56016c','89051182231'),
('57','Jesse','Harvey','flatley.kyra@example.com','99cc3b61a34700ff93861803cfb43d87adac936e','89098136597'),
('58','Melyna','Grimes','d\'amore.lesly@example.org','da3a818d08113bbeb708d296456a926abe12f8ed','89150828819'),
('59','Shaniya','Rosenbaum','fiona.barrows@example.org','edbc3be32c6f63b15ab38672dd9b42e4c5e60b4b','89244199662'),
('60','Salvatore','Parisian','haleigh45@example.net','15907b5f7cff5869d486546f27fc746eecde466b','89076389156'),
('61','Kevin','Ullrich','bartell.taylor@example.net','50d2ba591abea36c011ea12830b18fa61c671b5f','89072671081'),
('62','Barney','Muller','eldridge08@example.org','93cc148f2f87002f24a6e81b0cead85e53925fd7','89054820975'),
('63','Lilyan','Barrows','keegan88@example.com','3336aa9146479917c725570866a969ebb8956479','89241365344'),
('64','Quinton','Klocko','leora29@example.net','b5afe17abfac3ecfa76eca72be49fd9f153c4d1b','89068921628'),
('65','Cecil','Block','ncasper@example.com','1a412184c93aaa19b0b0a79cec756bd9dc2282d7','89078580929'),
('66','Ethan','Terry','stiedemann.madaline@example.com','405943bf7a0372bb73a41447bca0d550f18e699d','89096493826'),
('67','Allison','Ruecker','sunny.bradtke@example.net','f912fafd06252c7fe948aa6ac3903443d3ff53f9','89097137982'),
('68','Morgan','Toy','mafalda.mccullough@example.org','7556cd787813e9fdb6f3be1aa092326542d2d9e6','89042362777'),
('69','Maida','Kautzer','kaia31@example.net','1cbeb69fc09565f419fc36371c269a64f765f0da','89077170801'),
('70','Nels','Botsford','colby72@example.org','bc90c9a46e9cb81d33b907ea05e1a64480202c8a','89089606472'),
('71','Candelario','Stark','ritchie.melisa@example.net','8ce30a1e8614b4ed70cbea47392f8044674b8e2e','89080016876'),
('72','Noemie','O\'Connell','bode.sasha@example.com','771fa46324e8c400c944735cad3f23c77d78e472','89234914713'),
('73','Faye','Sawayn','ruecker.alyce@example.net','aecf2b1bdb8300db9838cb036ebfe2eda5c3f379','89248182434'),
('74','Shanon','Kub','arvid82@example.com','8c109bd87608aa98bb80f828deafd2d01162ad19','89147888576'),
('75','Treva','Berge','ohowe@example.org','856c439dae190311bb4a9faad6d4bd9c861e5166','89253735294'),
('76','Trinity','Stamm','darmstrong@example.com','2a6ea866676102ace9e499c1f8df4a8b2856b585','89053688464'),
('77','Kylie','Bergnaum','cbarrows@example.com','bab0849e87a2d0dc2e5790807931400abf000449','89233136421'),
('78','Braxton','Bartell','mills.kelly@example.net','8e4e4bb6d9456745c6d285ef856a4971c8cf2bcf','89247683385'),
('79','Brent','Konopelski','khegmann@example.net','5fb572df3a8d686345fc72dc837dec9bfe2e4311','89061027063'),
('80','Clotilde','Boyer','gorczany.daisha@example.com','1f7e6979149224995e2bcac8fd452f31a54ae7bb','89154762799'),
('81','Modesto','Hettinger','jewell41@example.net','61db0f4cc4ed373162cd913192781fb791e42828','89248828965'),
('82','Jamaal','Beatty','hessel.sammy@example.net','e6d2173aa5e0856211136661e9b406ae09134395','89077046436'),
('83','Lyda','Robel','edward69@example.net','0459aa5ed83a0c7d117103e9b4ade27c6fc52ac0','89083715308'),
('84','Ashley','Hintz','verla.bosco@example.com','fa5da0d4697316c3d0b7933a4d2984c120e9c19d','89091681124'),
('85','Michel','Brekke','kprohaska@example.org','c7f3a16530973d73bf72721a20b6ce35f120afbc','89121194796'),
('86','Elise','Eichmann','mathias17@example.net','ca166e3441df26830c128e1a3fcf873c14fce755','89091602345'),
('87','Rashad','Koss','zmorissette@example.org','122554df9e2cf77f49472e32ddf114181474bc1f','89088487175'),
('88','Richie','Kautzer','dickinson.kaitlin@example.org','86bb9b718233a077eb8c52670777b1743953bcd8','89073725494'),
('89','Fatima','Haag','diego.labadie@example.org','eefe162657fe03316d5a76d080c8f8f99ec15552','89037879663'),
('90','Margarita','Crona','tate43@example.org','37537be750bd2212563a4a0e6e07f8604dfb28df','89012612393'),
('91','Bryon','Green','reyna.brakus@example.com','255589874af77c49644ea4b7fa293f2b69eb5249','89224215661'),
('92','Deontae','Weimann','breanna55@example.com','195bfd70705831967727d959db37fa45e72a9522','89023594207'),
('93','Rachelle','Nader','christop.rohan@example.org','0596f48cdc8bb81a1d42c8514ac063785d55bb9d','89238437920'),
('94','Annie','Collier','janiya.hane@example.org','7956855f6c3dac805456e5fa3db927d0b4444daf','89242530176'),
('95','Brandon','Abbott','borer.dakota@example.org','4d740aa378189664727813833f7f48716934253b','89044156274'),
('96','Demetris','Kuhic','mschumm@example.net','6f7ade8299f0c9a72466df2d203d7a96dd1518c4','89021030774'),
('97','Dixie','Jerde','gstiedemann@example.net','d37b2b4a6a72709bd277e9aa9df0bf5ad7559652','89056984269'),
('98','Marjorie','Bogisich','reinger.lorine@example.org','d3455f10f888bb6c6902ef11ac8662934cdf7471','89074471453'),
('99','Genoveva','Welch','kertzmann.lorenzo@example.net','6ca8b182588eadf4ff6ee291c08a9651114789d9','89212440691'),
('100','Edgar','Hodkiewicz','okeeling@example.org','635e133bc473ac78db077a9c962b3594dc6b4932','89176157478'),
('101','Cheyenne','Kub','jaron89@example.net','27e35a10015a0d46e790535ef434d3ebe6e03558','89254621197'); 


DROP TABLE IF EXISTS `users_communities`;
CREATE TABLE `users_communities` (
  `user_id` bigint(20) unsigned NOT NULL,
  `community_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `users_communities` VALUES ('2','2'),
('3','3'),
('4','4'),
('5','5'),
('6','6'),
('7','7'),
('8','8'),
('9','9'),
('10','10'); 




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

