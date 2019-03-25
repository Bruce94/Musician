-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: dbMusician
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.16.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add group',4,'add_group'),(11,'Can change group',4,'change_group'),(12,'Can delete group',4,'delete_group'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add musician profile',7,'add_musicianprofile'),(20,'Can change musician profile',7,'change_musicianprofile'),(21,'Can delete musician profile',7,'delete_musicianprofile'),(22,'Can add message',8,'add_message'),(23,'Can change message',8,'change_message'),(24,'Can delete message',8,'delete_message'),(25,'Can add has skill',9,'add_hasskill'),(26,'Can change has skill',9,'change_hasskill'),(27,'Can delete has skill',9,'delete_hasskill'),(28,'Can add friend',10,'add_friend'),(29,'Can change friend',10,'change_friend'),(30,'Can delete friend',10,'delete_friend'),(31,'Can add skill',11,'add_skill'),(32,'Can change skill',11,'change_skill'),(33,'Can delete skill',11,'delete_skill'),(34,'Can add post',12,'add_post'),(35,'Can change post',12,'change_post'),(36,'Can delete post',12,'delete_post'),(37,'Can add comment',13,'add_comment'),(38,'Can change comment',13,'change_comment'),(39,'Can delete comment',13,'delete_comment'),(40,'Can add tag',14,'add_tag'),(41,'Can change tag',14,'change_tag'),(42,'Can delete tag',14,'delete_tag');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$yWVRCjpTtUCa$S88Rqtoab8iwRDH5FFVwLri3CrCJFhAW1t1igCA5Woo=','2019-03-25 00:59:13.482624',0,'Rocker_n_roller','Luca','Betti','betti.luca94@gmail.com',0,1,'2019-03-10 13:17:44.783314'),(2,'pbkdf2_sha256$36000$U9sa1xviKy5q$Swrt+Gw6m+ypdscFGI6qm0Xj9Ftn8agbUZo8/VbdUCo=','2019-03-25 00:58:50.715782',0,'thebigMamba','Kuwa','Uwawei','svnjrpv@gmail.com',0,1,'2019-03-10 13:32:46.942739'),(4,'pbkdf2_sha256$36000$VrI8nw9yOpgv$frf4R62e6/xXq8HZi9gwg9ccT25o8ahZ6TCW6wDz7jc=','2019-03-25 00:41:51.834414',1,'lucabruno','lucabru','BettiGhion','betti.luca94@gmail.com',1,1,'2019-03-11 08:10:24.000000'),(6,'pbkdf2_sha256$36000$lvhrsZESA5aq$E+Z88MV/pyPkk3MZtMFMpwTYu4D/tXfJ6/YQCXXWmAI=','2019-03-12 11:10:27.067021',0,'Gigi_dag','Gigi','D\'Agostino','emailprova@gmail.com',0,1,'2019-03-11 10:09:45.869977'),(8,'pbkdf2_sha256$36000$2ErNdWSqqJbZ$CwO/gP4EzV8qSeE24Ses33nVLYhbukmgQ4ifv/sbmcM=','2019-03-14 08:50:04.565761',0,'essenzaRock','Riget','Swagertinwer','provaemail@gmail.com',0,1,'2019-03-11 10:17:45.205680');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (5,'2019-03-11 10:14:49.740405','7','essenzaRock',3,'',3,4),(6,'2019-03-21 18:28:35.445469','13','Post object',3,'',12,4),(7,'2019-03-21 18:28:35.454959','12','Post object',3,'',12,4),(8,'2019-03-21 18:28:35.459897','11','Post object',3,'',12,4),(9,'2019-03-21 18:28:35.464511','10','Post object',3,'',12,4),(10,'2019-03-21 18:28:35.467621','9','Post object',3,'',12,4),(11,'2019-03-21 18:28:35.472057','8','Post object',3,'',12,4),(12,'2019-03-21 18:28:35.475460','7','Post object',3,'',12,4),(13,'2019-03-21 18:28:35.478409','6','Post object',3,'',12,4),(14,'2019-03-21 18:28:35.481533','5','Post object',3,'',12,4),(15,'2019-03-21 18:28:35.483775','4','Post object',3,'',12,4),(16,'2019-03-21 18:28:35.486498','3','Post object',3,'',12,4),(17,'2019-03-21 18:28:35.489426','2','Post object',3,'',12,4),(18,'2019-03-21 18:35:24.513506','15','Post object',3,'',12,4),(19,'2019-03-21 18:55:16.986816','18','Post object',3,'',12,4),(20,'2019-03-21 18:55:16.990388','17','Post object',3,'',12,4),(21,'2019-03-21 18:55:16.996087','16','Post object',3,'',12,4),(22,'2019-03-21 18:55:42.494586','4','Comment object',3,'',13,4),(23,'2019-03-24 12:15:23.706028','7','Tag object',3,'',14,4),(24,'2019-03-24 12:15:23.716694','6','Tag object',3,'',14,4),(25,'2019-03-24 12:15:23.720432','5','Tag object',3,'',14,4),(26,'2019-03-24 12:15:23.727537','4','Tag object',3,'',14,4),(27,'2019-03-24 12:15:23.731428','3','Tag object',3,'',14,4),(28,'2019-03-24 12:15:23.734992','2','Tag object',3,'',14,4),(29,'2019-03-24 12:15:23.738186','1','Tag object',3,'',14,4),(30,'2019-03-24 12:15:39.321503','10','Tag object',2,'[{\"changed\": {\"fields\": [\"tag_text\"]}}]',14,4),(31,'2019-03-24 12:15:45.764934','9','Tag object',2,'[{\"changed\": {\"fields\": [\"tag_text\"]}}]',14,4),(32,'2019-03-24 12:15:51.250219','8','Tag object',2,'[{\"changed\": {\"fields\": [\"tag_text\"]}}]',14,4),(33,'2019-03-25 00:36:09.247253','21','Post object',3,'',12,4),(34,'2019-03-25 00:36:09.254999','20','Post object',3,'',12,4),(35,'2019-03-25 00:36:09.258765','19','Post object',3,'',12,4),(36,'2019-03-25 00:36:09.261891','14','Post object',3,'',12,4),(37,'2019-03-25 00:40:05.133048','14','Tag object',3,'',14,4),(38,'2019-03-25 00:40:10.074942','13','Tag object',3,'',14,4),(39,'2019-03-25 00:40:15.126076','12','Tag object',3,'',14,4),(40,'2019-03-25 00:40:19.522571','11','Tag object',3,'',14,4),(41,'2019-03-25 00:40:33.075180','9','Tag object',3,'',14,4),(42,'2019-03-25 00:40:37.206184','8','Tag object',3,'',14,4);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(4,'auth','group'),(2,'auth','permission'),(3,'auth','user'),(5,'contenttypes','contenttype'),(13,'musician','comment'),(10,'musician','friend'),(9,'musician','hasskill'),(8,'musician','message'),(7,'musician','musicianprofile'),(12,'musician','post'),(11,'musician','skill'),(14,'musician','tag'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-03-08 09:04:26.481849'),(2,'auth','0001_initial','2019-03-08 09:04:27.345517'),(3,'admin','0001_initial','2019-03-08 09:04:27.626523'),(4,'admin','0002_logentry_remove_auto_add','2019-03-08 09:04:27.701113'),(5,'contenttypes','0002_remove_content_type_name','2019-03-08 09:04:27.840081'),(6,'auth','0002_alter_permission_name_max_length','2019-03-08 09:04:27.855898'),(7,'auth','0003_alter_user_email_max_length','2019-03-08 09:04:27.915307'),(8,'auth','0004_alter_user_username_opts','2019-03-08 09:04:27.961707'),(9,'auth','0005_alter_user_last_login_null','2019-03-08 09:04:28.049998'),(10,'auth','0006_require_contenttypes_0002','2019-03-08 09:04:28.060102'),(11,'auth','0007_alter_validators_add_error_messages','2019-03-08 09:04:28.078003'),(12,'auth','0008_alter_user_username_max_length','2019-03-08 09:04:28.109143'),(13,'musician','0001_initial','2019-03-08 09:04:28.578801'),(14,'musician','0002_auto_20190308_0903','2019-03-08 09:04:30.163750'),(15,'sessions','0001_initial','2019-03-08 09:04:30.223531'),(16,'musician','0003_tag','2019-03-21 15:07:33.927833'),(17,'musician','0004_auto_20190321_1834','2019-03-21 18:34:48.998462');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('5egao2zgpq979cm1sivdevww2wz3gpqj','NWU2NDdhOGI2MjMyMzJlNjJlMDkyZGY1NzZmYjdlMGFhNTE5YjA1MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmYjY5OWQ3YzM5NGUxYWY0OWE3OGU1MWJmZDNhNjg1OTU5MTgxMjVhIn0=','2019-04-08 00:59:13.488840'),('gpx40sbgxyvq8bpdapmn573npco5k5vn','NTE5YzY0ZWE0YjNlY2M4NDYyY2I4YjE5ZDY0NDliNGFkNWQ0NWMxZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImZiNjk5ZDdjMzk0ZTFhZjQ5YTc4ZTUxYmZkM2E2ODU5NTkxODEyNWEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2019-04-01 16:09:31.160977');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musician_comment`
--

DROP TABLE IF EXISTS `musician_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `musician_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pub_date` datetime(6) NOT NULL,
  `comment_text` varchar(255) NOT NULL,
  `seen` tinyint(1) NOT NULL,
  `musician_profile_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `musician_comment_musician_profile_id_e60ed1ef_fk_musician_` (`musician_profile_id`),
  KEY `musician_comment_post_id_286f4d19_fk_musician_post_id` (`post_id`),
  CONSTRAINT `musician_comment_musician_profile_id_e60ed1ef_fk_musician_` FOREIGN KEY (`musician_profile_id`) REFERENCES `musician_musicianprofile` (`id`),
  CONSTRAINT `musician_comment_post_id_286f4d19_fk_musician_post_id` FOREIGN KEY (`post_id`) REFERENCES `musician_post` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_comment`
--

LOCK TABLES `musician_comment` WRITE;
/*!40000 ALTER TABLE `musician_comment` DISABLE KEYS */;
INSERT INTO `musician_comment` VALUES (1,'2019-03-10 14:03:28.728850','And open bar was an awesome idea !',1,2,1),(5,'2019-03-21 18:57:29.594512','weee bellawaioone @happytobeyourfriend',1,1,1),(12,'2019-03-24 12:11:36.237720','nuovo asctaaagg #AWM',1,1,1),(13,'2019-03-25 00:58:58.091203','bravissimo!',1,2,23);
/*!40000 ALTER TABLE `musician_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musician_friend`
--

DROP TABLE IF EXISTS `musician_friend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `musician_friend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL,
  `seen` tinyint(1) NOT NULL,
  `data_request` date NOT NULL,
  `reciver_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `musician_friend_sender_id_reciver_id_2252f974_uniq` (`sender_id`,`reciver_id`),
  KEY `musician_friend_reciver_id_e57f8ea5_fk_auth_user_id` (`reciver_id`),
  CONSTRAINT `musician_friend_reciver_id_e57f8ea5_fk_auth_user_id` FOREIGN KEY (`reciver_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `musician_friend_sender_id_a29c8966_fk_auth_user_id` FOREIGN KEY (`sender_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_friend`
--

LOCK TABLES `musician_friend` WRITE;
/*!40000 ALTER TABLE `musician_friend` DISABLE KEYS */;
INSERT INTO `musician_friend` VALUES (1,2,1,'2019-03-10',1,2),(3,2,1,'2019-03-12',2,6),(4,1,1,'2019-03-16',2,8);
/*!40000 ALTER TABLE `musician_friend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musician_hasskill`
--

DROP TABLE IF EXISTS `musician_hasskill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `musician_hasskill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `musicianprofile_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `musician_hasskill_musicianprofile_id_skill_id_25adb4c5_uniq` (`musicianprofile_id`,`skill_id`),
  KEY `musician_hasskill_skill_id_37f7667f_fk_musician_skill_id` (`skill_id`),
  CONSTRAINT `musician_hasskill_musicianprofile_id_f71c19c9_fk_musician_` FOREIGN KEY (`musicianprofile_id`) REFERENCES `musician_musicianprofile` (`id`),
  CONSTRAINT `musician_hasskill_skill_id_37f7667f_fk_musician_skill_id` FOREIGN KEY (`skill_id`) REFERENCES `musician_skill` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_hasskill`
--

LOCK TABLES `musician_hasskill` WRITE;
/*!40000 ALTER TABLE `musician_hasskill` DISABLE KEYS */;
INSERT INTO `musician_hasskill` VALUES (1,1,1),(3,1,2),(2,1,6),(4,1,10),(5,2,2),(6,2,4),(8,2,8),(7,2,10),(9,4,1),(11,4,2),(10,4,5),(12,5,3),(13,5,7),(16,5,8),(14,5,9),(15,5,11);
/*!40000 ALTER TABLE `musician_hasskill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musician_hasskill_endorse_user`
--

DROP TABLE IF EXISTS `musician_hasskill_endorse_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `musician_hasskill_endorse_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hasskill_id` int(11) NOT NULL,
  `musicianprofile_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `musician_hasskill_endors_hasskill_id_musicianprof_50809656_uniq` (`hasskill_id`,`musicianprofile_id`),
  KEY `musician_hasskill_en_musicianprofile_id_c79c8f27_fk_musician_` (`musicianprofile_id`),
  CONSTRAINT `musician_hasskill_en_hasskill_id_245aabda_fk_musician_` FOREIGN KEY (`hasskill_id`) REFERENCES `musician_hasskill` (`id`),
  CONSTRAINT `musician_hasskill_en_musicianprofile_id_c79c8f27_fk_musician_` FOREIGN KEY (`musicianprofile_id`) REFERENCES `musician_musicianprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_hasskill_endorse_user`
--

LOCK TABLES `musician_hasskill_endorse_user` WRITE;
/*!40000 ALTER TABLE `musician_hasskill_endorse_user` DISABLE KEYS */;
INSERT INTO `musician_hasskill_endorse_user` VALUES (1,2,2),(2,8,1);
/*!40000 ALTER TABLE `musician_hasskill_endorse_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musician_message`
--

DROP TABLE IF EXISTS `musician_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `musician_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seen` tinyint(1) NOT NULL,
  `data_request` datetime(6) NOT NULL,
  `text` longtext,
  `reciver_message_id` int(11) NOT NULL,
  `sender_message_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `musician_message_reciver_message_id_80bacbad_fk_auth_user_id` (`reciver_message_id`),
  KEY `musician_message_sender_message_id_21c645b0_fk_auth_user_id` (`sender_message_id`),
  CONSTRAINT `musician_message_reciver_message_id_80bacbad_fk_auth_user_id` FOREIGN KEY (`reciver_message_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `musician_message_sender_message_id_21c645b0_fk_auth_user_id` FOREIGN KEY (`sender_message_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_message`
--

LOCK TABLES `musician_message` WRITE;
/*!40000 ALTER TABLE `musician_message` DISABLE KEYS */;
INSERT INTO `musician_message` VALUES (1,1,'2019-03-10 13:38:43.971921','good morning, what a pleasure!',2,1),(2,1,'2019-03-11 08:32:55.081261','How are you?',2,1),(3,1,'2019-03-11 08:33:10.436277','what\'s up?!',2,1),(4,1,'2019-03-12 11:08:11.215128','FIne bro',1,2),(5,1,'2019-03-16 11:24:01.697191','we',2,1),(6,1,'2019-03-16 11:28:39.551629','bene bene',1,2),(7,1,'2019-03-16 11:59:02.452177','ops',2,1),(8,1,'2019-03-16 12:26:11.427410','figurati',2,1),(9,1,'2019-03-16 12:56:11.288212','isisisisis',1,2),(10,1,'2019-03-16 13:05:29.365773','come stai?',2,1),(11,1,'2019-03-18 15:44:53.486479','bene',2,1),(12,1,'2019-03-18 16:02:06.941208','benone',1,2),(13,1,'2019-03-18 16:09:15.906631','bastaaa',1,2);
/*!40000 ALTER TABLE `musician_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musician_musicianprofile`
--

DROP TABLE IF EXISTS `musician_musicianprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `musician_musicianprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bio` longtext,
  `img` varchar(100) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `gender` varchar(1) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `country` varchar(2) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `musician_musicianprofile_user_id_d40e48e3_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_musicianprofile`
--

LOCK TABLES `musician_musicianprofile` WRITE;
/*!40000 ALTER TABLE `musician_musicianprofile` DISABLE KEYS */;
INSERT INTO `musician_musicianprofile` VALUES (1,'Esperto decennale nella batteria, ho affrontato concerti e tour anche come chitarrista e strumenti a fiato.','profile/lucabatterista.jpg','1994-09-08','M','3663513224','Modena','IT',1),(2,'Grande conoscenza dei suoni Subsahariani, amante del Blues e sassofonista dall\'età di 14 anni.','profile/sassofonista.jpg','1966-05-20','M','3122998776','Kindu','CD',2),(3,'Administrators','profile/administrator_photo.jpeg','1994-03-16','M','3663513223','Modena','IT',4),(4,'Let\'s do it','profile/GigiDag.png','1967-12-17','M','9998767898','Torino','IT',6),(5,'Przy kazdej kolizji harfy natura eksploduje','profile/polacco_5rExgZ1.jpeg','1974-01-14','M','8332673112','Cracovia','PL',8);
/*!40000 ALTER TABLE `musician_musicianprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musician_post`
--

DROP TABLE IF EXISTS `musician_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `musician_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_text` varchar(255) NOT NULL,
  `pub_date` datetime(6) NOT NULL,
  `musician_profile_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `musician_post_musician_profile_id_6479917a_fk_musician_` (`musician_profile_id`),
  CONSTRAINT `musician_post_musician_profile_id_6479917a_fk_musician_` FOREIGN KEY (`musician_profile_id`) REFERENCES `musician_musicianprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_post`
--

LOCK TABLES `musician_post` WRITE;
/*!40000 ALTER TABLE `musician_post` DISABLE KEYS */;
INSERT INTO `musician_post` VALUES (1,'I\'m surprised about what happened last night in \"Coconut & milk\" club, wonderful technical music team organization and Sublime\'s frontman prove his musician knowledge!','2019-03-10 13:52:42.825830',2),(22,' Oggi è un giorno speciale #maimollare #AWM','2019-03-25 00:41:17.000288',1),(23,' Penso','2019-03-25 00:58:39.843909',1);
/*!40000 ALTER TABLE `musician_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musician_skill`
--

DROP TABLE IF EXISTS `musician_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `musician_skill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_skill` varchar(20) NOT NULL,
  `image_skill` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_skill` (`name_skill`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_skill`
--

LOCK TABLES `musician_skill` WRITE;
/*!40000 ALTER TABLE `musician_skill` DISABLE KEYS */;
INSERT INTO `musician_skill` VALUES (1,'Acoustic Guitar','skill/acoustic-guitar-icon.png'),(2,'Electric Guitar','skill/guitar-icon.png'),(3,'Bass Guitar','skill/bass-guitar-icon.png'),(4,'Percussion','skill/conga-icon.png'),(5,'DJ','skill/dj-icon.png'),(6,'Drum','skill/drum-set-icon.png'),(7,'Harp','skill/harp-icon.png'),(8,'Voice','skill/microphone-icon.png'),(9,'Piano','skill/piano-icon.png'),(10,'Saxophone','skill/saxophone-icon.png'),(11,'Violin','skill/violin-icon.png');
/*!40000 ALTER TABLE `musician_skill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musician_tag`
--

DROP TABLE IF EXISTS `musician_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `musician_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_text` varchar(50) NOT NULL,
  `pub_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag_text` (`tag_text`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_tag`
--

LOCK TABLES `musician_tag` WRITE;
/*!40000 ALTER TABLE `musician_tag` DISABLE KEYS */;
INSERT INTO `musician_tag` VALUES (10,'AWM','2019-03-23 11:24:31.143379'),(15,'maimollare','2019-03-25 00:41:17.018306');
/*!40000 ALTER TABLE `musician_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musician_tag_comment`
--

DROP TABLE IF EXISTS `musician_tag_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `musician_tag_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) NOT NULL,
  `comment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `musician_tag_comment_tag_id_comment_id_316c9897_uniq` (`tag_id`,`comment_id`),
  KEY `musician_tag_comment_comment_id_2327b175_fk_musician_comment_id` (`comment_id`),
  CONSTRAINT `musician_tag_comment_comment_id_2327b175_fk_musician_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `musician_comment` (`id`),
  CONSTRAINT `musician_tag_comment_tag_id_344353ec_fk_musician_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `musician_tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_tag_comment`
--

LOCK TABLES `musician_tag_comment` WRITE;
/*!40000 ALTER TABLE `musician_tag_comment` DISABLE KEYS */;
INSERT INTO `musician_tag_comment` VALUES (7,10,12);
/*!40000 ALTER TABLE `musician_tag_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musician_tag_post`
--

DROP TABLE IF EXISTS `musician_tag_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `musician_tag_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `musician_tag_post_tag_id_post_id_a7c82059_uniq` (`tag_id`,`post_id`),
  KEY `musician_tag_post_post_id_407fc706_fk_musician_post_id` (`post_id`),
  CONSTRAINT `musician_tag_post_post_id_407fc706_fk_musician_post_id` FOREIGN KEY (`post_id`) REFERENCES `musician_post` (`id`),
  CONSTRAINT `musician_tag_post_tag_id_5e3a1ad8_fk_musician_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `musician_tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_tag_post`
--

LOCK TABLES `musician_tag_post` WRITE;
/*!40000 ALTER TABLE `musician_tag_post` DISABLE KEYS */;
INSERT INTO `musician_tag_post` VALUES (14,10,22),(13,15,22);
/*!40000 ALTER TABLE `musician_tag_post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-25  2:01:39
