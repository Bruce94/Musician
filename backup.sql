-- MySQL dump 10.13  Distrib 5.7.17, for osx10.12 (x86_64)
--
-- Host: localhost    Database: dbMusician
-- ------------------------------------------------------
-- Server version	5.7.17

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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add group',4,'add_group'),(11,'Can change group',4,'change_group'),(12,'Can delete group',4,'delete_group'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add musician profile',7,'add_musicianprofile'),(20,'Can change musician profile',7,'change_musicianprofile'),(21,'Can delete musician profile',7,'delete_musicianprofile'),(22,'Can add message',8,'add_message'),(23,'Can change message',8,'change_message'),(24,'Can delete message',8,'delete_message'),(25,'Can add has skill',9,'add_hasskill'),(26,'Can change has skill',9,'change_hasskill'),(27,'Can delete has skill',9,'delete_hasskill'),(28,'Can add friend',10,'add_friend'),(29,'Can change friend',10,'change_friend'),(30,'Can delete friend',10,'delete_friend'),(31,'Can add skill',11,'add_skill'),(32,'Can change skill',11,'change_skill'),(33,'Can delete skill',11,'delete_skill'),(34,'Can add post',12,'add_post'),(35,'Can change post',12,'change_post'),(36,'Can delete post',12,'delete_post'),(37,'Can add comment',13,'add_comment'),(38,'Can change comment',13,'change_comment'),(39,'Can delete comment',13,'delete_comment'),(40,'Can add tag',14,'add_tag'),(41,'Can change tag',14,'change_tag'),(42,'Can delete tag',14,'delete_tag'),(43,'Can add preference',15,'add_preference'),(44,'Can change preference',15,'change_preference'),(45,'Can delete preference',15,'delete_preference');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$yWVRCjpTtUCa$S88Rqtoab8iwRDH5FFVwLri3CrCJFhAW1t1igCA5Woo=','2019-04-10 10:46:35.000393',0,'Rocker_n_roller','Luca','Betti','betti.luca94@gmail.com',0,1,'2019-03-10 13:17:44.783314'),(2,'pbkdf2_sha256$36000$U9sa1xviKy5q$Swrt+Gw6m+ypdscFGI6qm0Xj9Ftn8agbUZo8/VbdUCo=','2019-04-05 20:26:33.209758',0,'thebigMamba','Kuwa','Uwawei','svnjrpv@gmail.com',0,1,'2019-03-10 13:32:46.942739'),(4,'pbkdf2_sha256$36000$VrI8nw9yOpgv$frf4R62e6/xXq8HZi9gwg9ccT25o8ahZ6TCW6wDz7jc=','2019-04-10 09:14:15.082905',1,'lucabruno','lucabru','BettiGhion','betti.luca94@gmail.com',1,1,'2019-03-11 08:10:24.000000'),(6,'pbkdf2_sha256$36000$lvhrsZESA5aq$E+Z88MV/pyPkk3MZtMFMpwTYu4D/tXfJ6/YQCXXWmAI=','2019-03-31 11:21:25.780475',0,'Gigi_dag','Gigi','D\'Agostino','emailprova@gmail.com',0,1,'2019-03-11 10:09:45.869977'),(8,'pbkdf2_sha256$36000$2ErNdWSqqJbZ$CwO/gP4EzV8qSeE24Ses33nVLYhbukmgQ4ifv/sbmcM=','2019-03-31 11:40:14.986505',0,'essenzaRock','Riget','Swagertinwer','provaemail@gmail.com',0,1,'2019-03-11 10:17:45.205680'),(9,'pbkdf2_sha256$36000$iNtXpUv2xY4l$53Arm6vsUu6pAbVJOhcSRpb/EvKPPDeNQVAFjGVQdrk=','2019-03-31 10:20:35.837627',0,'DaveGrohl','Dave','Grohl','davegrohl@gmail.com',0,1,'2019-03-31 09:39:05.435041'),(10,'pbkdf2_sha256$36000$g9piMbVckgAA$TThR0Fif6c2smPwwFzJI6VCI9ADhJW2+N56gOYrj2TA=','2019-04-10 06:47:41.643198',0,'brion','Bruno','Ghion','ghion.g94@gmail.com',0,1,'2019-03-31 09:43:51.956384'),(11,'pbkdf2_sha256$36000$KngqQLYmZqPm$TJK97pX2Go4CWavNR9a4dkJ9MXepyEqFo4swXcOiUx4=','2019-03-31 10:05:27.093358',0,'JacoPastorius','Jaco','Pastorius','JacoPastorius@email.com',0,1,'2019-03-31 10:05:12.838404'),(12,'pbkdf2_sha256$36000$8rUJiaDXS88H$mNVvBzZ0s1n0573tbo4aDX7l3prZoZyO26j26IEZ3DQ=','2019-03-31 10:59:45.802329',0,'fleaBass','Michael Peter','Balzary','flea@gmail.com',0,1,'2019-03-31 10:18:50.409671'),(13,'pbkdf2_sha256$36000$J2loyrFqWueF$vOcZY3xzvAJ3d1xVoXwiYzQNeii+vRq2W0rbP6xbZmk=','2019-04-10 10:45:49.842244',0,'slash','Saul','Hudson','slash@email.com',0,1,'2019-03-31 10:25:34.306000'),(14,'pbkdf2_sha256$36000$wFdv2YHopVcd$/+JIfQFbusSPHZUkJOIOHDCcyq/l4fkEnn52SGEAVyQ=','2019-03-31 10:51:57.560925',0,'BennyGolson','Benny','Golson','BennyGolson@email.com',0,1,'2019-03-31 10:46:59.809163'),(15,'pbkdf2_sha256$36000$yCLg9H6Uzonq$j1EjhE8mNb78sNzDKyoRktpD3/ZMAX9tubfEdso7qtA=','2019-03-31 10:51:02.438519',0,'sting','Gordon Matthew Thomas','Sumner','sting@gmail.com',0,1,'2019-03-31 10:50:52.361309'),(16,'pbkdf2_sha256$36000$wIOBx1Cj4JWv$B8u0C2o2yGfj/uu1V4Fr0r5xnqUAF0s7a2JLfOclrrY=','2019-03-31 11:19:50.507241',0,'robertTrujillo','Roberto Agustín Miguel Santiag','Trujillo Veracruz','robertTrujillo@email.com',0,1,'2019-03-31 10:56:52.706753'),(17,'pbkdf2_sha256$36000$RrZfzL2ZYrDt$yigmQjEauuy2Y1+SbCu40HoTTZETWExpAcWy9Fc23nY=','2019-03-31 11:27:13.978696',0,'AxlRose','William Bruce','Rose','AxlRose@gmail.com',0,1,'2019-03-31 11:03:12.326216'),(18,'pbkdf2_sha256$36000$bJIbU2tZRSts$8iaGGR6/iANRlTcWbNaJ7YirN84Psg8xSSk+OtfFzn0=','2019-03-31 11:11:49.626882',0,'BrianMay','Brian Harold','May','BrianMay@gmail.com',0,1,'2019-03-31 11:11:38.925830'),(19,'pbkdf2_sha256$36000$AHqNcoHeI1g7$h5UQeBv8iDNS/U4NzYHpz6T0/AjgXZe1XfQ+59ugG8U=','2019-03-31 15:37:01.042248',0,'Caparezza','Michele','Salvemini','caparezza@gmail.com',0,1,'2019-03-31 11:19:08.526562'),(20,'pbkdf2_sha256$36000$u1K4TDTjKNUM$WBeolTT/6Ct51rpGiFUuzekeloFGclJ2oF9I3nvHSzs=','2019-03-31 11:38:24.556909',0,'BillieJoe','Billie Joe','Armstrong','BillieJoe@email.com',0,1,'2019-03-31 11:26:48.476829'),(21,'pbkdf2_sha256$36000$ek6aGWIyFQVG$9KVE5jFdfy0hieps/QZ5lW4FwKF+JTsn/VW2FvQHXUI=','2019-03-31 11:38:57.751416',0,'MarkTremonti','Mark Thomas','Tremonti','MarkTremonti@gmail.com',0,1,'2019-03-31 11:32:59.746572'),(22,'pbkdf2_sha256$36000$QJAVFRUM81Vv$4PaYlKOOtdzRfzTfYXmbtYmDRB/Qrc85bqHN6zFedQI=','2019-03-31 11:37:55.491455',0,'OzzyOsbourne','Ozzy','Osbourne','OzzyOsbourne@gmail.com',0,1,'2019-03-31 11:37:38.984126');
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
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (5,'2019-03-11 10:14:49.740405','7','essenzaRock',3,'',3,4),(6,'2019-03-21 18:28:35.445469','13','Post object',3,'',12,4),(7,'2019-03-21 18:28:35.454959','12','Post object',3,'',12,4),(8,'2019-03-21 18:28:35.459897','11','Post object',3,'',12,4),(9,'2019-03-21 18:28:35.464511','10','Post object',3,'',12,4),(10,'2019-03-21 18:28:35.467621','9','Post object',3,'',12,4),(11,'2019-03-21 18:28:35.472057','8','Post object',3,'',12,4),(12,'2019-03-21 18:28:35.475460','7','Post object',3,'',12,4),(13,'2019-03-21 18:28:35.478409','6','Post object',3,'',12,4),(14,'2019-03-21 18:28:35.481533','5','Post object',3,'',12,4),(15,'2019-03-21 18:28:35.483775','4','Post object',3,'',12,4),(16,'2019-03-21 18:28:35.486498','3','Post object',3,'',12,4),(17,'2019-03-21 18:28:35.489426','2','Post object',3,'',12,4),(18,'2019-03-21 18:35:24.513506','15','Post object',3,'',12,4),(19,'2019-03-21 18:55:16.986816','18','Post object',3,'',12,4),(20,'2019-03-21 18:55:16.990388','17','Post object',3,'',12,4),(21,'2019-03-21 18:55:16.996087','16','Post object',3,'',12,4),(22,'2019-03-21 18:55:42.494586','4','Comment object',3,'',13,4),(23,'2019-03-24 12:15:23.706028','7','Tag object',3,'',14,4),(24,'2019-03-24 12:15:23.716694','6','Tag object',3,'',14,4),(25,'2019-03-24 12:15:23.720432','5','Tag object',3,'',14,4),(26,'2019-03-24 12:15:23.727537','4','Tag object',3,'',14,4),(27,'2019-03-24 12:15:23.731428','3','Tag object',3,'',14,4),(28,'2019-03-24 12:15:23.734992','2','Tag object',3,'',14,4),(29,'2019-03-24 12:15:23.738186','1','Tag object',3,'',14,4),(30,'2019-03-24 12:15:39.321503','10','Tag object',2,'[{\"changed\": {\"fields\": [\"tag_text\"]}}]',14,4),(31,'2019-03-24 12:15:45.764934','9','Tag object',2,'[{\"changed\": {\"fields\": [\"tag_text\"]}}]',14,4),(32,'2019-03-24 12:15:51.250219','8','Tag object',2,'[{\"changed\": {\"fields\": [\"tag_text\"]}}]',14,4),(33,'2019-03-25 00:36:09.247253','21','Post object',3,'',12,4),(34,'2019-03-25 00:36:09.254999','20','Post object',3,'',12,4),(35,'2019-03-25 00:36:09.258765','19','Post object',3,'',12,4),(36,'2019-03-25 00:36:09.261891','14','Post object',3,'',12,4),(37,'2019-03-25 00:40:05.133048','14','Tag object',3,'',14,4),(38,'2019-03-25 00:40:10.074942','13','Tag object',3,'',14,4),(39,'2019-03-25 00:40:15.126076','12','Tag object',3,'',14,4),(40,'2019-03-25 00:40:19.522571','11','Tag object',3,'',14,4),(41,'2019-03-25 00:40:33.075180','9','Tag object',3,'',14,4),(42,'2019-03-25 00:40:37.206184','8','Tag object',3,'',14,4),(43,'2019-03-28 12:46:04.111984','35','Post object',3,'',12,4),(44,'2019-03-28 12:46:04.118910','34','Post object',3,'',12,4),(45,'2019-03-28 12:46:04.124188','33','Post object',3,'',12,4),(46,'2019-03-28 12:46:04.128666','32','Post object',3,'',12,4),(47,'2019-03-28 12:46:04.132301','31','Post object',3,'',12,4),(48,'2019-03-28 12:46:04.139050','30','Post object',3,'',12,4),(49,'2019-03-28 12:46:04.146598','29','Post object',3,'',12,4),(50,'2019-03-28 12:46:04.153972','28','Post object',3,'',12,4),(51,'2019-03-28 12:46:04.158073','27','Post object',3,'',12,4),(52,'2019-03-28 12:46:04.161349','26','Post object',3,'',12,4),(53,'2019-03-28 12:46:04.165269','25','Post object',3,'',12,4),(54,'2019-03-28 12:46:04.168443','24','Post object',3,'',12,4),(55,'2019-03-28 21:02:02.095047','44','Post object',3,'',12,4),(56,'2019-03-28 21:02:02.106073','43','Post object',3,'',12,4),(57,'2019-03-28 21:02:02.112937','42','Post object',3,'',12,4),(58,'2019-03-28 21:02:02.119009','41','Post object',3,'',12,4),(59,'2019-03-28 21:02:02.123696','40','Post object',3,'',12,4),(60,'2019-03-28 21:02:02.126508','39','Post object',3,'',12,4),(61,'2019-03-28 21:02:02.128508','38','Post object',3,'',12,4),(62,'2019-03-28 21:02:02.131140','37','Post object',3,'',12,4),(63,'2019-03-28 21:02:02.133051','36','Post object',3,'',12,4),(64,'2019-03-28 21:15:39.481712','51','Post object',3,'',12,4),(65,'2019-03-28 21:15:39.488353','50','Post object',3,'',12,4),(66,'2019-03-28 21:15:39.491744','49','Post object',3,'',12,4),(67,'2019-03-28 21:15:39.495334','48','Post object',3,'',12,4),(68,'2019-03-28 21:15:39.498551','47','Post object',3,'',12,4),(69,'2019-03-28 21:15:39.500685','46','Post object',3,'',12,4),(70,'2019-03-28 21:15:39.504014','45','Post object',3,'',12,4),(71,'2019-03-28 22:38:14.480784','71','Post object',3,'',12,4),(72,'2019-03-28 22:38:14.494444','70','Post object',3,'',12,4),(73,'2019-03-28 22:38:14.499080','69','Post object',3,'',12,4),(74,'2019-03-28 22:38:14.501075','68','Post object',3,'',12,4),(75,'2019-03-28 22:38:14.504141','67','Post object',3,'',12,4),(76,'2019-03-28 22:38:14.508213','66','Post object',3,'',12,4),(77,'2019-03-28 22:38:14.510993','65','Post object',3,'',12,4),(78,'2019-03-28 22:38:14.513625','64','Post object',3,'',12,4),(79,'2019-03-28 22:38:14.515474','63','Post object',3,'',12,4),(80,'2019-03-28 22:38:14.518069','62','Post object',3,'',12,4),(81,'2019-03-28 22:38:14.520128','61','Post object',3,'',12,4),(82,'2019-03-28 22:38:14.524639','60','Post object',3,'',12,4),(83,'2019-03-28 22:38:14.527315','59','Post object',3,'',12,4),(84,'2019-03-28 22:38:14.530447','58','Post object',3,'',12,4),(85,'2019-03-28 22:38:14.532589','57','Post object',3,'',12,4),(86,'2019-03-28 22:38:14.535384','56','Post object',3,'',12,4),(87,'2019-03-28 22:38:14.539405','55','Post object',3,'',12,4),(88,'2019-03-28 22:38:14.542439','54','Post object',3,'',12,4),(89,'2019-03-28 22:38:14.545010','53','Post object',3,'',12,4),(90,'2019-03-28 22:38:14.555707','52','Post object',3,'',12,4),(91,'2019-03-28 23:35:05.737582','98','Post object',3,'',12,4),(92,'2019-03-28 23:35:05.747828','97','Post object',3,'',12,4),(93,'2019-03-28 23:35:05.752175','96','Post object',3,'',12,4),(94,'2019-03-28 23:35:05.761307','95','Post object',3,'',12,4),(95,'2019-03-28 23:35:05.766877','94','Post object',3,'',12,4),(96,'2019-03-28 23:35:05.769818','93','Post object',3,'',12,4),(97,'2019-03-28 23:35:05.772329','92','Post object',3,'',12,4),(98,'2019-03-28 23:35:05.775602','91','Post object',3,'',12,4),(99,'2019-03-28 23:35:05.778633','90','Post object',3,'',12,4),(100,'2019-03-28 23:35:05.780940','89','Post object',3,'',12,4),(101,'2019-03-28 23:35:05.784871','88','Post object',3,'',12,4),(102,'2019-03-28 23:35:05.791039','87','Post object',3,'',12,4),(103,'2019-03-28 23:35:05.793821','86','Post object',3,'',12,4),(104,'2019-03-28 23:35:05.795755','85','Post object',3,'',12,4),(105,'2019-03-28 23:35:05.798337','84','Post object',3,'',12,4),(106,'2019-03-28 23:35:05.800444','83','Post object',3,'',12,4),(107,'2019-03-28 23:35:05.803600','82','Post object',3,'',12,4),(108,'2019-03-28 23:35:05.806643','81','Post object',3,'',12,4),(109,'2019-03-28 23:35:05.809536','80','Post object',3,'',12,4),(110,'2019-03-28 23:35:05.812505','79','Post object',3,'',12,4),(111,'2019-03-28 23:35:05.816101','78','Post object',3,'',12,4),(112,'2019-03-28 23:35:05.819125','77','Post object',3,'',12,4),(113,'2019-03-28 23:35:05.822272','76','Post object',3,'',12,4),(114,'2019-03-28 23:35:05.828307','75','Post object',3,'',12,4),(115,'2019-03-28 23:35:05.832543','74','Post object',3,'',12,4),(116,'2019-03-28 23:35:05.838856','73','Post object',3,'',12,4),(117,'2019-03-28 23:35:05.842685','72','Post object',3,'',12,4),(118,'2019-03-29 15:06:18.233944','116','Post object',3,'',12,4),(119,'2019-03-29 15:06:18.246306','115','Post object',3,'',12,4),(120,'2019-03-29 15:06:18.250823','114','Post object',3,'',12,4),(121,'2019-03-29 15:06:18.253929','113','Post object',3,'',12,4),(122,'2019-03-29 15:06:18.256910','112','Post object',3,'',12,4),(123,'2019-03-29 15:06:18.260243','111','Post object',3,'',12,4),(124,'2019-03-29 15:06:18.263579','110','Post object',3,'',12,4),(125,'2019-03-29 15:06:18.265757','109','Post object',3,'',12,4),(126,'2019-03-29 15:06:18.269280','108','Post object',3,'',12,4),(127,'2019-03-29 15:06:18.272417','107','Post object',3,'',12,4),(128,'2019-03-29 15:06:18.274380','106','Post object',3,'',12,4),(129,'2019-03-29 15:06:18.277287','105','Post object',3,'',12,4),(130,'2019-03-29 15:06:18.283989','104','Post object',3,'',12,4),(131,'2019-03-29 15:06:18.286016','103','Post object',3,'',12,4),(132,'2019-03-29 15:06:18.292106','102','Post object',3,'',12,4),(133,'2019-03-29 15:06:18.294151','101','Post object',3,'',12,4),(134,'2019-03-29 15:06:18.296868','100','Post object',3,'',12,4),(135,'2019-03-29 15:06:18.302677','99','Post object',3,'',12,4),(136,'2019-03-29 16:30:11.546745','132','Post object',3,'',12,4),(137,'2019-03-29 16:30:11.553252','130','Post object',3,'',12,4),(138,'2019-03-29 16:30:11.556484','129','Post object',3,'',12,4),(139,'2019-03-29 16:30:11.559940','128','Post object',3,'',12,4),(140,'2019-03-29 16:30:11.567119','127','Post object',3,'',12,4),(141,'2019-03-29 16:30:11.573329','124','Post object',3,'',12,4),(142,'2019-03-29 16:30:11.577873','123','Post object',3,'',12,4),(143,'2019-03-29 16:30:11.582097','122','Post object',3,'',12,4),(144,'2019-03-29 16:30:11.585639','121','Post object',3,'',12,4),(145,'2019-03-29 16:30:11.588943','120','Post object',3,'',12,4),(146,'2019-03-29 16:30:11.592358','119','Post object',3,'',12,4),(147,'2019-03-29 16:30:11.594371','118','Post object',3,'',12,4),(148,'2019-03-29 16:30:11.600214','117','Post object',3,'',12,4),(149,'2019-03-30 13:12:39.186529','30','Tag object',3,'',14,4),(150,'2019-03-30 13:12:39.193832','29','Tag object',3,'',14,4),(151,'2019-03-30 13:12:39.197716','28','Tag object',3,'',14,4),(152,'2019-03-30 13:12:39.201909','27','Tag object',3,'',14,4),(153,'2019-03-30 13:12:39.204656','26','Tag object',3,'',14,4),(154,'2019-03-30 13:12:39.206654','24','Tag object',3,'',14,4),(155,'2019-03-30 13:12:39.210038','22','Tag object',3,'',14,4),(156,'2019-03-30 13:12:39.214444','21','Tag object',3,'',14,4),(157,'2019-03-30 13:12:39.216957','20','Tag object',3,'',14,4),(158,'2019-03-30 13:12:39.219913','19','Tag object',3,'',14,4),(159,'2019-03-31 12:29:12.573356','7','MusicianProfile object',2,'[{\"changed\": {\"fields\": [\"gender\"]}}]',7,4),(160,'2019-04-05 14:10:34.429596','22','thebigMamba:Post object:2',3,'',15,4),(161,'2019-04-05 14:10:34.436720','21','Rocker_n_roller:Post object:1',3,'',15,4),(162,'2019-04-05 14:10:34.439957','8','Rocker_n_roller:Post object:1',3,'',15,4),(163,'2019-04-05 20:26:07.608438','29','Comment object',3,'',13,4),(164,'2019-04-05 20:26:07.623762','28','Comment object',3,'',13,4),(165,'2019-04-05 20:26:07.631854','26','Comment object',3,'',13,4),(166,'2019-04-05 20:26:07.633612','25','Comment object',3,'',13,4),(167,'2019-04-05 20:26:07.636496','24','Comment object',3,'',13,4),(168,'2019-04-05 21:33:03.452419','41','Comment object',3,'',13,4),(169,'2019-04-05 21:33:03.457983','40','Comment object',3,'',13,4),(170,'2019-04-05 21:33:03.460468','39','Comment object',3,'',13,4),(171,'2019-04-05 21:33:03.462213','38','Comment object',3,'',13,4),(172,'2019-04-05 21:33:03.464715','37','Comment object',3,'',13,4),(173,'2019-04-05 21:33:03.467318','36','Comment object',3,'',13,4),(174,'2019-04-05 21:33:03.469123','35','Comment object',3,'',13,4),(175,'2019-04-05 21:33:03.471619','34','Comment object',3,'',13,4),(176,'2019-04-05 21:33:03.473538','33','Comment object',3,'',13,4),(177,'2019-04-05 21:33:03.476078','31','Comment object',3,'',13,4),(178,'2019-04-05 21:33:03.478175','30','Comment object',3,'',13,4),(179,'2019-04-05 21:33:03.480788','23','Comment object',3,'',13,4),(180,'2019-04-05 21:33:03.483189','21','Comment object',3,'',13,4),(181,'2019-04-05 21:33:03.485042','20','Comment object',3,'',13,4),(182,'2019-04-05 21:33:03.487137','19','Comment object',3,'',13,4),(183,'2019-04-05 21:33:03.491097','17','Comment object',3,'',13,4),(184,'2019-04-10 10:16:34.296845','220','Post object',2,'[{\"changed\": {\"fields\": [\"post_text\", \"post_image\"]}}]',12,4),(185,'2019-04-10 10:16:47.486995','222','Post object',2,'[{\"changed\": {\"fields\": [\"post_text\", \"post_image\"]}}]',12,4),(186,'2019-04-10 10:16:54.504297','219','Post object',2,'[{\"changed\": {\"fields\": [\"post_text\", \"post_image\"]}}]',12,4),(187,'2019-04-10 10:16:58.588327','207','Post object',2,'[{\"changed\": {\"fields\": [\"post_text\", \"post_image\"]}}]',12,4),(188,'2019-04-10 10:17:04.603947','206','Post object',2,'[{\"changed\": {\"fields\": [\"post_text\", \"post_image\"]}}]',12,4),(189,'2019-04-10 10:17:20.243185','164','Post object',2,'[{\"changed\": {\"fields\": [\"post_text\", \"post_image\"]}}]',12,4),(190,'2019-04-10 10:17:31.930287','158','Post object',2,'[{\"changed\": {\"fields\": [\"post_text\", \"post_image\"]}}]',12,4),(191,'2019-04-10 10:17:36.386422','22','Post object',2,'[{\"changed\": {\"fields\": [\"post_text\", \"post_image\"]}}]',12,4),(192,'2019-04-10 10:17:41.140410','1','Post object',2,'[{\"changed\": {\"fields\": [\"post_image\"]}}]',12,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(4,'auth','group'),(2,'auth','permission'),(3,'auth','user'),(5,'contenttypes','contenttype'),(13,'musician','comment'),(10,'musician','friend'),(9,'musician','hasskill'),(8,'musician','message'),(7,'musician','musicianprofile'),(12,'musician','post'),(15,'musician','preference'),(11,'musician','skill'),(14,'musician','tag'),(6,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-03-08 09:04:26.481849'),(2,'auth','0001_initial','2019-03-08 09:04:27.345517'),(3,'admin','0001_initial','2019-03-08 09:04:27.626523'),(4,'admin','0002_logentry_remove_auto_add','2019-03-08 09:04:27.701113'),(5,'contenttypes','0002_remove_content_type_name','2019-03-08 09:04:27.840081'),(6,'auth','0002_alter_permission_name_max_length','2019-03-08 09:04:27.855898'),(7,'auth','0003_alter_user_email_max_length','2019-03-08 09:04:27.915307'),(8,'auth','0004_alter_user_username_opts','2019-03-08 09:04:27.961707'),(9,'auth','0005_alter_user_last_login_null','2019-03-08 09:04:28.049998'),(10,'auth','0006_require_contenttypes_0002','2019-03-08 09:04:28.060102'),(11,'auth','0007_alter_validators_add_error_messages','2019-03-08 09:04:28.078003'),(12,'auth','0008_alter_user_username_max_length','2019-03-08 09:04:28.109143'),(13,'musician','0001_initial','2019-03-08 09:04:28.578801'),(14,'musician','0002_auto_20190308_0903','2019-03-08 09:04:30.163750'),(15,'sessions','0001_initial','2019-03-08 09:04:30.223531'),(16,'musician','0003_tag','2019-03-21 15:07:33.927833'),(17,'musician','0004_auto_20190321_1834','2019-03-21 18:34:48.998462'),(18,'musician','0005_musicianprofile_suggested_friend','2019-03-31 09:12:17.254359'),(19,'musician','0006_preference','2019-04-01 12:34:59.719375'),(20,'musician','0005_preference','2019-04-03 20:54:53.734279'),(21,'musician','0006_auto_20190402_1826','2019-04-03 20:54:53.744687'),(22,'musician','0007_auto_20190402_1909','2019-04-03 20:54:53.754549'),(23,'musician','0008_auto_20190402_2012','2019-04-03 20:54:53.760717'),(24,'musician','0009_auto_20190402_2012','2019-04-03 20:54:53.766204'),(25,'musician','0010_auto_20190402_2013','2019-04-03 20:54:53.771550'),(26,'musician','0011_musicianprofile_suggested_friend','2019-04-03 20:54:53.775823'),(27,'musician','0012_preference_seen','2019-04-04 02:20:54.911835'),(28,'musician','0002_post_post_image','2019-04-10 06:51:24.209892');
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
INSERT INTO `django_session` VALUES ('5egao2zgpq979cm1sivdevww2wz3gpqj','NWU2NDdhOGI2MjMyMzJlNjJlMDkyZGY1NzZmYjdlMGFhNTE5YjA1MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmYjY5OWQ3YzM5NGUxYWY0OWE3OGU1MWJmZDNhNjg1OTU5MTgxMjVhIn0=','2019-04-08 00:59:13.488840'),('5kt546jvpkybkole8ipexdu6i8fpx0v1','Yzg0YzQxOTk5NDBjNGExNzQyZjVkMDFiMDQ2Nzc3ODRjNzhiY2MzZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjQiLCJfYXV0aF91c2VyX2hhc2giOiJlYjEzZDliZTI4N2YzZDQxZjUxMTgwNTNlMDY4ZjM1NTQ5OGM5MGY2In0=','2019-04-13 13:10:45.374833'),('ay1jo0mdvzshs58ervvr40vkh3wfq3ft','ZjZmMzEwNThhNWI4MTI3NDVmOWYwYzQwMDk4MDk0NWE5MWU1NWZjMTp7Il9hdXRoX3VzZXJfaGFzaCI6ImNjYjRhYzNiZmQzYmUzNzFiMjljNjhlN2JhZjBmODA0OGM1Mjc1YjMiLCJfYXV0aF91c2VyX2lkIjoiOCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2019-04-14 11:40:14.988953'),('bcyyqyzb9f17rzj6kyudie8285tomr6h','NmIxOGNmNWY4NjRkMzVjMTY2ZWVkYTA5ZTRhNzE5MGVlYTQzMmM5Mzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlYjEzZDliZTI4N2YzZDQxZjUxMTgwNTNlMDY4ZjM1NTQ5OGM5MGY2In0=','2019-04-12 17:02:06.239035'),('clsav7huwfexx1s1whfimm23hku46p0x','YTFmMDMzNmNhZTU1NDA2ZDQ5MDcyYzBlYWY4MTg4YzJiYmQ5ODdiZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImViMTNkOWJlMjg3ZjNkNDFmNTExODA1M2UwNjhmMzU1NDk4YzkwZjYiLCJfYXV0aF91c2VyX2lkIjoiNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2019-04-13 09:28:14.170313'),('eexq643j9rfuzil0x3indypnh9xnwfch','MzFkZmZiNGM1Y2IzMDYyODMwNjBmNjNjNDczNjZjY2Q3ODhjOTNiODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9oYXNoIjoiZmI2OTlkN2MzOTRlMWFmNDlhNzhlNTFiZmQzYTY4NTk1OTE4MTI1YSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2019-04-17 20:55:08.660900'),('eoxojcvnhmk7z9ulphz0qha0ujqqkhp5','NjI0ZDgxMzIxMTI5NWI5NTViZGZmMzk5NDg4MGNhNjBiN2YyZjE0Nzp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4ZTA4NjkxNjBiNjMyZGEyY2RmNGRkMmYwMWY3NDYyNjRhNzUwMTk2In0=','2019-04-10 17:05:26.971348'),('gpx40sbgxyvq8bpdapmn573npco5k5vn','NTE5YzY0ZWE0YjNlY2M4NDYyY2I4YjE5ZDY0NDliNGFkNWQ0NWMxZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImZiNjk5ZDdjMzk0ZTFhZjQ5YTc4ZTUxYmZkM2E2ODU5NTkxODEyNWEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2019-04-01 16:09:31.160977'),('mokw8utbbzpjqlrh6zn4mauxb0o9bfh7','MTE0ZDA0YzY3Y2EyYjYyMWUxOWI0Y2FlMWJhNDc2ODIxZWMxYjliYjp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGUwODY5MTYwYjYzMmRhMmNkZjRkZDJmMDFmNzQ2MjY0YTc1MDE5NiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2019-04-18 02:47:49.408973'),('mq37t4wxqozdaupf2gwv9h2b4sowr4f1','MTE0ZDA0YzY3Y2EyYjYyMWUxOWI0Y2FlMWJhNDc2ODIxZWMxYjliYjp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGUwODY5MTYwYjYzMmRhMmNkZjRkZDJmMDFmNzQ2MjY0YTc1MDE5NiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2019-04-10 16:40:48.647661'),('ofxi11lrq14o4nmmy99w6tleo2ano74k','NjI0ZDgxMzIxMTI5NWI5NTViZGZmMzk5NDg4MGNhNjBiN2YyZjE0Nzp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4ZTA4NjkxNjBiNjMyZGEyY2RmNGRkMmYwMWY3NDYyNjRhNzUwMTk2In0=','2019-04-10 16:49:54.900364'),('q4c4jwj7iffs1f8nofwmnrggfx80ih4y','MTE0ZDA0YzY3Y2EyYjYyMWUxOWI0Y2FlMWJhNDc2ODIxZWMxYjliYjp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGUwODY5MTYwYjYzMmRhMmNkZjRkZDJmMDFmNzQ2MjY0YTc1MDE5NiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2019-04-10 13:17:56.449034'),('rg2knqo2bo2kjmxlfrofhgbnsx2ot7r1','ZjExYzE1NTc4MTFkZjA0YjVlYzgxZmQ3YjVkNzI0MjUyMmFkNjY2NDp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfaGFzaCI6Ijg4ZjFmZTAyYmM0ZGYyY2I4OGQzODcyYTMxNGQ0ODU3MDBlMGY5YzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9','2019-04-24 06:47:41.648104'),('s6okpmsftruo8chdtn9petukxaat270o','OGVjMWUxZTQ0NTgzZGU1Zjk3NWI5ZGNlMTYwMmU1ZDJlNTYxMTQ4Yjp7Il9hdXRoX3VzZXJfaGFzaCI6ImViMTNkOWJlMjg3ZjNkNDFmNTExODA1M2UwNjhmMzU1NDk4YzkwZjYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI0In0=','2019-04-19 21:32:19.786536'),('sjhg3dz4got2jwaxpln6f43cnj19lvq3','NTE5YzY0ZWE0YjNlY2M4NDYyY2I4YjE5ZDY0NDliNGFkNWQ0NWMxZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImZiNjk5ZDdjMzk0ZTFhZjQ5YTc4ZTUxYmZkM2E2ODU5NTkxODEyNWEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2019-04-24 10:46:35.002492'),('smf7irymmhtfx6slzv6sv9zr26ywbbhe','Yzg0YzQxOTk5NDBjNGExNzQyZjVkMDFiMDQ2Nzc3ODRjNzhiY2MzZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjQiLCJfYXV0aF91c2VyX2hhc2giOiJlYjEzZDliZTI4N2YzZDQxZjUxMTgwNTNlMDY4ZjM1NTQ5OGM5MGY2In0=','2019-04-15 09:42:10.958703'),('ttoobiho9adbs1pw1uzy551l1f8u2aqr','Y2FjODQwOGExZjBjMTYyNWNlZTAxMmNmNGZlYjQyNjhmNGRiODg5Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGUwODY5MTYwYjYzMmRhMmNkZjRkZDJmMDFmNzQ2MjY0YTc1MDE5NiIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2019-04-19 14:11:59.633275'),('uymzl7fm4rh3ip2go7d9zmsp6e2cyqu4','NjI0ZDgxMzIxMTI5NWI5NTViZGZmMzk5NDg4MGNhNjBiN2YyZjE0Nzp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4ZTA4NjkxNjBiNjMyZGEyY2RmNGRkMmYwMWY3NDYyNjRhNzUwMTk2In0=','2019-04-09 08:20:06.977574'),('v1ebifsy02t0kixpy5ovi53y92z092x8','ODE3OTM0MTM3MzczMTViYzNlYzQ2ZDc4YjYzMmU5YTNjYWRiODAxOTp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiODhmMWZlMDJiYzRkZjJjYjg4ZDM4NzJhMzE0ZDQ4NTcwMGUwZjljMiJ9','2019-04-14 12:33:34.045646'),('v9gf3eyfizxk3g3su3l15nr0prwortos','NmIxOGNmNWY4NjRkMzVjMTY2ZWVkYTA5ZTRhNzE5MGVlYTQzMmM5Mzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlYjEzZDliZTI4N2YzZDQxZjUxMTgwNTNlMDY4ZjM1NTQ5OGM5MGY2In0=','2019-04-11 11:36:59.730242'),('ypob0ksi072bivcjbkb8vymnph40r9pe','OTBhZmZkMjBiMWFiNTQ1YmExZWUzYjQzOWU3NWY1Y2RmODBiNzRmZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjE5IiwiX2F1dGhfdXNlcl9oYXNoIjoiOWUyY2Q0NWI4ZDYwODc2ZTgzZTYxZDRiMDcwMDllMTA5MjI2MGE4OCJ9','2019-04-14 15:37:01.047172');
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_comment`
--

LOCK TABLES `musician_comment` WRITE;
/*!40000 ALTER TABLE `musician_comment` DISABLE KEYS */;
INSERT INTO `musician_comment` VALUES (1,'2019-03-10 14:03:28.728850','And open bar was an awesome idea !',1,2,1),(5,'2019-03-21 18:57:29.594512','weee bellawaioone @happytobeyourfriend',1,1,1),(12,'2019-03-24 12:11:36.237720','nuovo asctaaagg #AWM',1,1,1),(18,'2019-04-04 02:21:51.116405','proviamo la notifica real time #speriamo',1,1,1),(22,'2019-04-05 13:53:33.455482','pazzesco',1,1,1),(27,'2019-04-05 15:23:13.723542','te l\'ho detto',1,1,219),(32,'2019-04-05 20:34:00.286990','wella',1,1,1),(33,'2019-04-10 23:12:43.756684','bella',0,1,287);
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
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_friend`
--

LOCK TABLES `musician_friend` WRITE;
/*!40000 ALTER TABLE `musician_friend` DISABLE KEYS */;
INSERT INTO `musician_friend` VALUES (6,2,1,'2019-03-31',1,8),(9,2,1,'2019-03-31',9,10),(10,2,1,'2019-03-31',1,10),(11,2,1,'2019-03-31',2,10),(12,2,1,'2019-03-31',6,10),(13,2,1,'2019-03-31',6,12),(14,2,1,'2019-03-31',9,12),(25,2,1,'2019-03-31',9,13),(26,2,1,'2019-03-31',1,13),(27,2,1,'2019-03-31',8,13),(28,2,1,'2019-03-31',10,14),(29,2,1,'2019-03-31',2,14),(30,2,1,'2019-03-31',2,15),(31,2,1,'2019-03-31',14,15),(32,2,1,'2019-03-31',6,15),(33,2,1,'2019-03-31',12,16),(34,2,1,'2019-03-31',8,18),(35,2,1,'2019-03-31',16,19),(36,2,1,'2019-03-31',6,19),(37,2,1,'2019-03-31',17,20),(38,2,1,'2019-03-31',17,21),(39,2,1,'2019-03-31',20,22),(40,2,1,'2019-03-31',21,22),(41,2,1,'2019-03-31',8,10),(102,2,1,'2019-04-01',19,10),(103,2,1,'2019-04-03',2,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_hasskill`
--

LOCK TABLES `musician_hasskill` WRITE;
/*!40000 ALTER TABLE `musician_hasskill` DISABLE KEYS */;
INSERT INTO `musician_hasskill` VALUES (1,1,1),(3,1,2),(2,1,6),(4,1,10),(5,2,2),(6,2,4),(8,2,8),(7,2,10),(9,4,1),(11,4,2),(10,4,5),(12,5,3),(13,5,7),(16,5,8),(14,5,9),(15,5,11),(17,6,1),(20,6,2),(18,6,3),(19,6,6),(21,6,8),(22,7,1),(25,7,2),(23,7,3),(27,7,8),(26,7,9),(28,8,3),(30,9,2),(29,9,3),(32,9,8),(31,9,9),(34,10,2),(33,10,3),(35,10,9),(36,11,10),(38,12,2),(37,12,3),(41,12,8),(39,12,9),(40,12,10),(42,13,3),(43,13,8),(44,14,1),(45,14,4),(47,14,8),(46,14,9),(48,15,1),(49,15,2),(50,15,8),(51,16,8),(54,17,2),(52,17,3),(53,17,6),(56,17,8),(55,17,9),(57,18,1),(58,18,2),(59,18,8),(60,19,8);
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
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_message`
--

LOCK TABLES `musician_message` WRITE;
/*!40000 ALTER TABLE `musician_message` DISABLE KEYS */;
INSERT INTO `musician_message` VALUES (1,1,'2019-03-10 13:38:43.971921','good morning, what a pleasure!',2,1),(2,1,'2019-03-11 08:32:55.081261','How are you?',2,1),(3,1,'2019-03-11 08:33:10.436277','what\'s up?!',2,1),(4,1,'2019-03-12 11:08:11.215128','FIne bro',1,2),(5,1,'2019-03-16 11:24:01.697191','we',2,1),(6,1,'2019-03-16 11:28:39.551629','bene bene',1,2),(7,1,'2019-03-16 11:59:02.452177','ops',2,1),(8,1,'2019-03-16 12:26:11.427410','figurati',2,1),(9,1,'2019-03-16 12:56:11.288212','isisisisis',1,2),(10,1,'2019-03-16 13:05:29.365773','come stai?',2,1),(11,1,'2019-03-18 15:44:53.486479','bene',2,1),(12,1,'2019-03-18 16:02:06.941208','benone',1,2),(13,1,'2019-03-18 16:09:15.906631','bastaaa',1,2),(14,1,'2019-03-26 08:20:34.779522','bella zi',2,1),(15,1,'2019-03-26 08:20:55.289717','frate come stai',1,2),(16,1,'2019-03-26 08:21:47.012847','bene, te?',2,1),(17,1,'2019-03-26 08:22:06.794557','er traffic è stato retato',1,2),(18,1,'2019-03-26 08:22:12.526458','come famo?',1,2),(19,1,'2019-03-26 08:22:22.791903','ao, ce ne vamo',2,1),(20,1,'2019-03-26 08:24:16.772025','fra',2,1),(21,1,'2019-03-26 08:31:14.660848','ao, dimme',2,1),(22,1,'2019-03-26 08:31:28.620207','nulla',1,2),(23,1,'2019-03-26 08:31:33.967932','statte zitto',2,1),(24,1,'2019-03-26 10:46:07.153440','wella peppa',2,1),(25,1,'2019-03-26 10:46:22.120306','ciccio',1,2),(26,1,'2019-03-26 10:46:28.625240','jfs',2,1),(27,1,'2019-03-27 13:20:25.290397','ti saluto',2,1),(28,1,'2019-03-27 13:20:44.081523','oh',2,1),(29,1,'2019-03-27 13:20:48.975153','va semore',2,1),(30,1,'2019-03-27 13:21:01.850935','o',2,1),(31,1,'2019-03-27 16:40:57.300440','wee',2,1),(32,1,'2019-03-27 16:41:26.541216','deficiente',2,1),(33,1,'2019-03-27 16:48:07.092817','ooo',2,1),(34,1,'2019-03-27 16:50:03.414995','bastard',1,2),(35,1,'2019-03-27 16:56:18.846757','o',2,1),(36,1,'2019-03-27 16:58:41.167057','shish',2,1),(37,1,'2019-03-27 17:00:59.590489','o ma come ti permetti',1,2),(38,1,'2019-03-27 17:05:36.160637','stai shallo',1,2),(39,1,'2019-03-27 17:13:52.852569','gigi',2,1),(40,1,'2019-03-30 12:47:09.971409','bella wuaiooone',1,2),(41,1,'2019-03-30 12:47:20.692179','come stai?',1,2),(42,1,'2019-03-30 12:47:42.430813','direi bene',2,1),(43,1,'2019-03-30 12:48:21.144535','Vorrei darti una botta',2,1),(44,1,'2019-03-30 12:48:36.591074','n\' che senso',1,2),(45,1,'2019-03-30 12:49:42.742462','eh bhe',1,2),(46,1,'2019-03-30 12:50:08.702294','dai ch\'ac capìt',2,1),(47,1,'2019-03-30 13:09:53.188511','no, vattè a coricà',1,2),(48,1,'2019-03-30 13:10:01.468420','strùnz',1,2),(49,1,'2019-03-31 09:46:01.502442','Ciao',9,10),(50,1,'2019-03-31 09:46:36.259991','ciao',10,9),(51,1,'2019-03-31 11:22:40.420515','ciao',6,19),(52,1,'2019-03-31 11:22:57.031420','hey!!',19,6),(53,1,'2019-04-01 10:10:55.745854','ciao',10,19),(54,1,'2019-04-01 10:11:20.454442','weii',19,10),(55,1,'2019-04-05 14:22:53.075772','facciamo pace?',2,1),(56,1,'2019-04-05 14:23:06.876780','dai famo sta pace',2,1),(57,1,'2019-04-05 14:23:24.164633','mo va bene',1,2),(58,1,'2019-04-05 14:23:36.776564','però te devi sta zitto',1,2);
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
  `suggested_friend` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `musician_musicianprofile_user_id_d40e48e3_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_musicianprofile`
--

LOCK TABLES `musician_musicianprofile` WRITE;
/*!40000 ALTER TABLE `musician_musicianprofile` DISABLE KEYS */;
INSERT INTO `musician_musicianprofile` VALUES (1,'Esperto decennale nella batteria, ho affrontato concerti e tour anche come chitarrista e strumenti a fiato.','profile/lucabatterista.jpg','1994-09-08','M','3663513224','Modena','IT',1,'9,14,19,6,15,18'),(2,'Grande conoscenza dei suoni Subsahariani, amante del Blues e sassofonista dall\'età di 14 anni.','profile/sassofonista.jpg','1966-05-20','M','3122998776','Kindu','CD',2,'6,8,19,13,9'),(3,'Administrators','profile/administrator_photo.jpeg','1994-03-16','M','3663513223','Modena','IT',4,NULL),(4,'Let\'s do it','profile/GigiDag.png','1967-12-17','M','9998767898','Torino','IT',6,'2,9,14,16,1,8'),(5,'Przy kazdej kolizji harfy natura eksploduje','profile/polacco_5rExgZ1.jpeg','1974-01-14','M','8332673112','Cracovia','PL',8,'2,9,19,14,6'),(6,'David Eric Grohl is an American singer, songwriter, musician and director. He is the founder, lead vocalist, rhythm guitarist and primary songwriter of the rock band Foo Fighters since 1994, and was the best known and longest-serving drummer for Nirvana from 1990 to 1994, when they disbanded following the death of Kurt Cobain.','profile/dave_grohl.jpg','1969-01-14','M','3333333333','Warren','US',9,'1,6,8,19,2,14,16'),(7,'Suono la chitarra da 10 anni e ho fatto parte di diversi gruppi e partecipato a diversi eventi musicali come Rockin1000 a Firenze, attualmente suono in un gruppo chiamato Out For Summer','profile/bruno_ghion.jpg','1994-03-16','M','3333333333','Vignola','IT',10,'13,15,12,16,18'),(8,'was an American jazz bassist who was a member of Weather Report from 1976 to 1981. He worked with Pat Metheny, Joni Mitchell, and recorded albums as a solo artist and band leader. His bass playing employed funk, lyrical solos, bass chords, and innovative harmonics. As of 2017, he is the only electric bassist of seven bassists inducted into the DownBeat Jazz Hall of Fame, and has been lauded as one of the best electric bassists of all time.','profile/jacopastorius.jpg','1951-12-01','M','3333333333','Norrison','US',11,NULL),(9,'Was Flea, is an Australian-American musician, singer and actor. He is best known as the bassist and a founding member of the rock band Red Hot Chili Peppers. Flea is widely considered among the best bassists of all time. Flea briefly appeared as the bassist for such bands as What Is This?, Fear, and Jane\'s Addiction. He has performed with rock supergroups Atoms for Peace, Antemasque, Pigface, and Rocket Juice & the Moon, and collaborated with The Mars Volta, Johnny Cash, Tom Waits, Alanis Morissette, and Young MC. Flea also performed live with Nirvana in 1993 playing the trumpet.\r\n\r\nFlea incorporates elements of funk (including slap bass), psychedelic, punk, and hard rock. In 2009, Rolling Stone readers ranked Flea the second best bassist of all time, behind only John Entwistle. In 2012, he and the other members of Red Hot Chili Peppers were inducted into the Rock and Roll Hall of Fame.\r\n\r\nSince 1984, Flea has acted in over 20 films and television series such as Suburbia, Back to the Future Part II and Part III, My Own Private Idaho, The Chase, Fear and Loathing in Las Vegas, Dudes, Son in Law, The Big Lebowski, Low Down, Baby Driver and Boy Erased, in addition to voicing the character Donnie Thornberry in The Wild Thornberrys animated television series and films.\r\n\r\nFlea is also the co-founder of Silverlake Conservatory of Music, a non-profit music education organization founded in 2001 for underprivileged children. In 2019 Flea will release his memoir Acid for the Children which will detail his life prior to the formation of Red Hot Chili Peppers.','profile/flea.jpg','1962-10-16','M','3333333333','Melbourne','AU',12,NULL),(10,'Better known by his stage name Slash, is a British–American musician and songwriter. He is the lead guitarist of the American hard rock band Guns N\' Roses, with whom he achieved worldwide success in the late 1980s and early 1990s. Slash has received critical acclaim and is considered one of the greatest guitarists in rock history.\r\n\r\nIn 1993, Slash formed the side project Slash\'s Snakepit; three years later he left Guns N\' Roses in 1996 and co-founded the supergroup Velvet Revolver, which re-established him as a mainstream performer in the mid to late 2000s. Slash has released four solo albums: Slash (2010), featuring an array of guest musicians, and Apocalyptic Love (2012), World on Fire (2014) and Living the Dream (2018) recorded with his band, Myles Kennedy and the Conspirators. He returned to Guns N\' Roses in 2016.\r\n\r\nTime magazine named him runner-up on their list of \"The 10 Best Electric Guitar Players\" in 2009, while Rolling Stone placed him at number 65 on their list of \"The 100 Greatest Guitarists of All Time\" in 2011. Guitar World ranked his guitar solo in \"November Rain\" number 6 on their list of \"The 100 Greatest Guitar Solos\" in 2008, and Total Guitar placed his riff in \"Sweet Child o\' Mine\" at number 1 on their list of \"The 100 Greatest Riffs\" in 2004. In 2010, Gibson Guitar Corporation ranked Slash as number 34 on their \"Top 50 Guitarists of All Time\", while their readers landed him number 9 on Gibson\'s \"Top 25 Guitarists of All Time\". In 2012, he was inducted into the Rock and Roll Hall of Fame as a member of Guns N\' Roses\' classic lineup.','profile/slash.jpg','1965-07-23','M','3333333333','Los Angeles','US',13,'10,12,2,18'),(11,'Musicista, compositore e arrangiatore jazz statunitense. Il suo strumento principale è il sassofono tenore.','profile/BennyGolson.jpg','1960-03-17','M','3333333333','Filadelfia','US',14,'1,6,19,8,9'),(12,'Sting, pseudonimo di Gordon Matthew Thomas Sumner (Wallsend, 2 ottobre 1951), è un cantautore, polistrumentista e attore britannico, che ha esordito come membro dei Police per poi intraprendere una carriera solista di successo. Le sue influenze musicali includono rock, jazz, reggae, musica classica, new-age e worldbeat. Come cantante solista e membro dei Police, nella sua carriera Sting ha ricevuto 16 Grammy Awards, 3 BRIT Awards e un Golden Globe. È stato inoltre candidato 4 volte per l\'Oscar alla migliore canzone nel 2001, 2002, 2004 e 2017 per i film Le follie dell\'imperatore, Kate & Leopold , Ritorno a Cold Mountain e Jim: The James Foley Story. Sting ha venduto in totale oltre 100 milioni di dischi nel mondo tra Police e carriera solista','profile/sting.jpg','1951-10-02','M','3333333333','Wallsend','GB',15,'10,19,1,12'),(13,'Roberto Agustín Miguel Santiago Samuel Trujillo Veracruz, semplicemente conosciuto come Robert Trujillo (Venice, 23 ottobre 1964), è un bassista statunitense, noto per essere il bassista dei Metallica dal 2003. In precedenza ha suonato il basso per i gruppi Suicidal Tendencies, Infectious Grooves, Cyco Miko, Black Label Society e per Ozzy Osbourne.','profile/robert_trujillo.jpg','1964-10-23','M','3333333333','Venice','US',16,'6,9,10'),(14,'cantautore e polistrumentista statunitense.\r\n\r\nÈ noto soprattutto come frontman dei Guns N\' Roses, di cui è stato l\'unico membro fisso. Ha ottenuto il successo principalmente tra la fine degli anni ottanta e l\'inizio dei novanta per poi scomparire dalle scene fino al 2001 quando, con una nuova formazione dei Guns N\' Roses, ha iniziato ad esibirsi in una nuova serie di concerti a partire dal Rock in Rio 3.\r\n\r\nHa un\'estensione vocale di cinque ottave (solo dal vivo di ben tre ottave e mezzo) e una sua caratteristica è riuscire agevolmente ad alternare voce pulita, voce profonda e falsettone graffiato.\r\n\r\nIl 17 aprile 2016 è entrato a far parte degli AC/DC per terminare il tour 2016 al posto di Brian Johnson, affetto da gravi problemi di udito.','profile/axl_rose.jpg','1962-02-06','M','3333333333','Lafayette','US',17,NULL),(15,'English musician, singer, songwriter, and astrophysicist. He is best known as the lead guitarist of the rock band Queen. He uses a home-built electric guitar called the Red Special. His compositions for the band include \"We Will Rock You\", \"Tie Your Mother Down\", \"I Want It All\", \"Fat Bottomed Girls\", \"Flash\", \"Hammer to Fall\", \"Save Me\", \"Who Wants to Live Forever\", and \"The Show Must Go On\".','profile/brian_may.jpg','1958-07-19','M','3333333333','Twickenham','GB',18,NULL),(16,'Italian rapper. Born in Molfetta, in the southern region of Apulia, Caparezza debuted in 1997 at the Sanremo Festival under the name Mikimix.','profile/caparezza.jpg','1973-10-09','M','3333333333','Molfetta','IT',19,'12,1,2,8,9,14,15'),(17,'American singer, songwriter, musician, record producer, and actor. Armstrong serves as the lead vocalist, primary songwriter, and lead guitarist of the punk rock band Green Day, co-founded with Mike Dirnt. He is also a guitarist and vocalist for the punk rock band Pinhead Gunpowder, and provides lead vocals for Green Day\'s side projects Foxboro Hot Tubs, The Network and The Longshot.\r\n\r\nRaised in Rodeo, California, Armstrong developed an interest in music at a young age, and recorded his first song at the age of five. He met Mike Dirnt while attending elementary school, and the two instantly bonded over their mutual interest in music, forming the band Sweet Children when the two were 15 years old. The band changed its name to Green Day, and would later achieve commercial success. Armstrong has also pursued musical projects outside of Green Day\'s work, including numerous collaborations with other musicians.\r\n\r\nIn 1997, to coincide with the release of Nimrod, Armstrong founded Adeline Records in Oakland to help support other bands releasing music, and signed bands such as The Frustrators, AFI and Dillinger Four. The record company later came under the management of Pat Magnarella and finally shut down in August 2017.','profile/Billie_Joe_Armstrong.jpg','1972-02-17','M','3333333333','Oakland','US',20,NULL),(18,'American musician, singer, songwriter, and record producer, best known as the lead guitarist of the rock bands Creed and Alter Bridge. He is a founding member of both bands, and has also collaborated with many other artists over the years. He formed his own band, Tremonti, in 2011, releasing the album All I Was in July 2012, followed by Cauterize in June 2015, Dust in April 2016 and A Dying Machine in June 2018. The metal rock opera A Dying Machine has been adapted by Tremonti and science-fiction novelist John Shirley.','profile/Mark_Tremonti.jpg','1974-04-18','M','3333333333','Detroit','US',21,NULL),(19,'English vocalist, songwriter, actor and reality television star who rose to prominence during the 1970s as the lead vocalist of the heavy metal band Black Sabbath. He was fired from the band in 1979 due to alcohol and drug problems, but went on to have a successful solo career, releasing eleven studio albums, the first seven of which were all awarded multi-platinum certifications in the United States. Osbourne has since reunited with Black Sabbath on several occasions. He rejoined the band in 1997 and recorded the group’s final studio album 13 (2013) before they embarked on a farewell tour which culminated in a final performance in their home city Birmingham, England in February 2017. His longevity and success have earned him the informal title of \"Godfather of Heavy Metal\".','profile/ozzy_osbourne.jpg','1950-12-03','M','3333333333','Aston','GB',22,NULL);
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
  `n_like` int(11) NOT NULL,
  `n_dislike` int(11) NOT NULL,
  `post_image` varchar(100),
  PRIMARY KEY (`id`),
  KEY `musician_post_musician_profile_id_6479917a_fk_musician_` (`musician_profile_id`),
  CONSTRAINT `musician_post_musician_profile_id_6479917a_fk_musician_` FOREIGN KEY (`musician_profile_id`) REFERENCES `musician_musicianprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=292 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_post`
--

LOCK TABLES `musician_post` WRITE;
/*!40000 ALTER TABLE `musician_post` DISABLE KEYS */;
INSERT INTO `musician_post` VALUES (1,'I\'m surprised about what happened last night in \"Coconut & milk\" club, wonderful technical music team organization and Sublime\'s frontman prove his musician knowledge!','2019-03-10 13:52:42.000000',2,1,1,''),(22,'Oggi è un giorno speciale #maimollare #AWM','2019-03-25 00:41:17.000000',1,1,1,''),(158,'ciao a tutt, #belli e #brutti ! #OK','2019-03-29 17:02:40.000000',1,0,1,''),(164,'sos','2019-03-30 09:19:38.000000',4,0,0,''),(181,' #bella frate #rivoluzione','2019-03-30 10:06:30.304265',1,0,2,'/static/musician/images/vm.jpg'),(206,'Bello sto social #soddisfatto','2019-03-31 12:58:59.000000',7,2,0,''),(207,'nuovo post #hola #chica','2019-04-03 21:08:56.000000',1,2,0,''),(219,'kjh','2019-04-04 04:38:06.000000',2,3,1,''),(220,'bella','2019-04-10 07:02:51.000000',7,0,0,''),(224,' bella pic','2019-04-10 10:20:59.521174',7,1,1,'post/1528292940.png'),(271,' che palle','2019-04-10 11:45:44.655233',7,1,1,'post/74875E-pallone-basket-spalding-NBA-replica-game-ball-7-800x800.jpeg'),(287,'','2019-04-10 12:02:04.020204',7,2,0,'post/Fender_AmericanStdStrat-SB_body.jpg'),(290,' swag','2019-04-10 23:27:29.766005',7,0,0,'post/squiddy_dub.gif'),(291,' #wow','2019-04-13 08:39:10.146150',7,0,0,'post/5141.png');
/*!40000 ALTER TABLE `musician_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musician_preference`
--

DROP TABLE IF EXISTS `musician_preference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `musician_preference` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vote` int(11) NOT NULL,
  `pub_date` datetime(6) NOT NULL,
  `musician_profile_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `seen` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `musician_preference_musician_profile_id_f681efa8_fk_musician_` (`musician_profile_id`),
  KEY `musician_preference_post_id_b90f6c0c_fk_musician_post_id` (`post_id`),
  CONSTRAINT `musician_preference_musician_profile_id_f681efa8_fk_musician_` FOREIGN KEY (`musician_profile_id`) REFERENCES `musician_musicianprofile` (`id`),
  CONSTRAINT `musician_preference_post_id_b90f6c0c_fk_musician_post_id` FOREIGN KEY (`post_id`) REFERENCES `musician_post` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_preference`
--

LOCK TABLES `musician_preference` WRITE;
/*!40000 ALTER TABLE `musician_preference` DISABLE KEYS */;
INSERT INTO `musician_preference` VALUES (1,1,'2019-04-01 12:35:33.958693',7,206,0),(2,2,'2019-04-01 12:36:41.424385',7,181,1),(3,1,'2019-04-01 12:37:18.462642',16,206,0),(4,1,'2019-04-03 20:55:27.600723',1,206,0),(5,2,'2019-04-03 20:55:31.253362',1,181,1),(6,1,'2019-04-03 21:08:57.757838',1,207,1),(7,1,'2019-04-03 21:09:14.536677',2,207,1),(9,2,'2019-04-04 02:34:07.581743',2,158,1),(10,2,'2019-04-04 02:34:08.776646',2,181,1),(11,2,'2019-04-04 02:36:44.606353',2,22,1),(12,1,'2019-04-04 03:06:28.752373',2,206,0),(19,1,'2019-04-04 04:24:10.627856',1,22,1),(23,1,'2019-04-05 14:12:09.193599',1,219,1),(24,1,'2019-04-05 14:12:22.812807',2,219,1),(25,2,'2019-04-05 14:12:41.840853',1,1,1),(26,1,'2019-04-10 10:29:08.081073',7,224,1),(28,1,'2019-04-10 12:02:10.562585',7,287,1),(29,1,'2019-04-10 23:12:55.246691',1,287,0),(30,1,'2019-04-10 23:18:50.388046',7,271,1),(31,2,'2019-04-10 23:22:55.300326',1,271,0),(32,2,'2019-04-10 23:23:02.886723',1,224,0);
/*!40000 ALTER TABLE `musician_preference` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_tag`
--

LOCK TABLES `musician_tag` WRITE;
/*!40000 ALTER TABLE `musician_tag` DISABLE KEYS */;
INSERT INTO `musician_tag` VALUES (10,'AWM','2019-03-23 11:24:31.143379'),(15,'maimollare','2019-03-25 00:41:17.018306'),(16,'belli','2019-03-29 17:02:40.329787'),(17,'brutti','2019-03-29 17:02:40.349634'),(18,'OK','2019-03-29 17:02:40.369170'),(23,'rivoluzione','2019-03-30 09:36:15.965878'),(25,'bella','2019-03-30 10:06:30.321077'),(31,'soddisfatto','2019-03-31 12:58:59.119436'),(32,'hola','2019-04-03 21:08:56.232907'),(33,'chica','2019-04-03 21:08:56.251445'),(34,'speriamo','2019-04-04 02:21:51.143786'),(35,'wow','2019-04-13 08:39:10.172237');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_tag_comment`
--

LOCK TABLES `musician_tag_comment` WRITE;
/*!40000 ALTER TABLE `musician_tag_comment` DISABLE KEYS */;
INSERT INTO `musician_tag_comment` VALUES (7,10,12),(8,34,18);
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician_tag_post`
--

LOCK TABLES `musician_tag_post` WRITE;
/*!40000 ALTER TABLE `musician_tag_post` DISABLE KEYS */;
INSERT INTO `musician_tag_post` VALUES (14,10,22),(13,15,22),(15,16,158),(16,17,158),(17,18,158),(29,23,181),(28,25,181),(47,31,206),(48,32,207),(49,33,207),(50,35,291);
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

-- Dump completed on 2019-04-13 10:42:43
