-- MariaDB dump 10.19  Distrib 10.6.4-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: nagios
-- ------------------------------------------------------
-- Server version	10.6.4-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Command`
--

DROP TABLE IF EXISTS `Command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Command` (
  `command_name` varchar(80) NOT NULL DEFAULT '',
  `command_line` text DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `poller_tag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`command_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Command`
--

LOCK TABLES `Command` WRITE;
/*!40000 ALTER TABLE `Command` DISABLE KEYS */;
INSERT INTO `Command` VALUES ('notify-by-email','/usr/bin/printf \"%b\" \"***** Nagios 3 *****\\n\\nNotification Type: $NOTIFICATIONTYPE$\\nHost: $HOSTNAME$\\nState: $HOSTSTATE$\\nAddress: $HOSTADDRESS$\\nInfo: $SERVICEOUTPUT$ \\n$SERVICEDESC$ is $SERVICESTATE$\\n \\nDate/Time:  $SHORTDATETIME$\\n\" | /usr/bin/xxmail -s \"Service $SERVICESTATE$ alert for $HOSTNAME$!\" $CONTACTEMAIL$',NULL,NULL),('host-notify-by-email','/usr/bin/printf \"%b\" \"***** Nagios 3  *****\\n\\nNotification Type: $NOTIFICATIONTYPE$\\nHost: $HOSTNAME$ $HOSTALIAS$\\nState: $HOSTSTATE$\\nAddress: $HOSTADDRESS$\\nInfo: $HOSTOUTPUT$\\n\\nDate/Time:  $SHORTDATETIME$\\n\" | /usr/bin/xxmail -s \"Host $HOSTSTATE$ alert for $HOSTNAME$! $SERVICEDESC$\" $CONTACTEMAIL$',NULL,NULL),('check-host-alive','$USER1$/check_icmp -w 200,40% -c 2000,90% $HOSTADDRESS$','xxxxxxxxxxxxxxx',NULL),('check_ping','$USER1$/check_ping -H $HOSTADDRESS$ -w $ARG1$ -c $ARG2$ -p 5',NULL,NULL);
/*!40000 ALTER TABLE `Command` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Contact`
--

DROP TABLE IF EXISTS `Contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Contact` (
  `template` varchar(80) NOT NULL DEFAULT '',
  `contact_name` varchar(80) NOT NULL DEFAULT '',
  `alias` varchar(80) NOT NULL DEFAULT '',
  `email` varchar(80) DEFAULT NULL,
  `pager` varchar(80) DEFAULT NULL,
  `service_notification_period` varchar(80) DEFAULT NULL,
  `host_notification_period` varchar(80) DEFAULT NULL,
  `service_notification_options` varchar(20) DEFAULT NULL,
  `host_notification_options` varchar(20) DEFAULT NULL,
  `service_notification_commands` varchar(80) DEFAULT NULL,
  `host_notification_commands` varchar(80) DEFAULT NULL,
  `level` int(1) DEFAULT 0,
  `password` char(20) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`contact_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Contact`
--

LOCK TABLES `Contact` WRITE;
/*!40000 ALTER TABLE `Contact` DISABLE KEYS */;
INSERT INTO `Contact` VALUES ('mail','admin','nagios administrator','admin@test.com','','','','','','','',0,'admin','Torsten'),('sms1','Torsten1','Torsten_SMS',NULL,'9182918209',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),('mail','Holger1','Holger SMS','blabla@xyz.com',NULL,NULL,NULL,NULL,NULL,'notify-by-email','host-notify-by-email',0,NULL,NULL);
/*!40000 ALTER TABLE `Contact` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`torsten`@`localhost`*/ /*!50003 TRIGGER `update_ContactGroup_after_UpdateContact` AFTER UPDATE ON `Contact` FOR EACH ROW update ContactGroup set members=TRIM(BOTH ',' FROM REPLACE( CONCAT(',',members,','), CONCAT(',',OLD.contact_name,','), CONCAT(',',NEW.contact_name,',')) )  where FIND_IN_SET(OLD.contact_name, members) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`torsten`@`localhost`*/ /*!50003 TRIGGER `update_ContactGroup_after_DeleteContact` AFTER DELETE ON `Contact` FOR EACH ROW update ContactGroup set members=TRIM(BOTH ',' FROM REPLACE( CONCAT(',',members,','), CONCAT(',',OLD.contact_name,','),  ',') )  where FIND_IN_SET(OLD.contact_name, members) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ContactGroup`
--

DROP TABLE IF EXISTS `ContactGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ContactGroup` (
  `contactgroup_name` varchar(80) NOT NULL DEFAULT '',
  `alias` varchar(80) DEFAULT NULL,
  `members` text DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`contactgroup_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ContactGroup`
--

LOCK TABLES `ContactGroup` WRITE;
/*!40000 ALTER TABLE `ContactGroup` DISABLE KEYS */;
INSERT INTO `ContactGroup` VALUES ('admins','administrators','admin','test group'),('alle','alle Kontakte','admin,Holger1,Torsten1','nur ein Test'),('aaa','aaa','admin,Holger1',NULL);
/*!40000 ALTER TABLE `ContactGroup` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`torsten`@`localhost`*/ /*!50003 TRIGGER `update_Service_after_UpdateContactGroup` AFTER UPDATE ON `ContactGroup` FOR EACH ROW update Service set contact_groups=TRIM(BOTH ',' FROM REPLACE( CONCAT(',',contact_groups,','), CONCAT(',',OLD.contactgroup_name,','), CONCAT(',',NEW.contactgroup_name,',')) )  where FIND_IN_SET(OLD.contactgroup_name, contact_groups) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`torsten`@`localhost`*/ /*!50003 TRIGGER `update_Service_after_DeleteContactGroup` AFTER DELETE ON `ContactGroup` FOR EACH ROW update Service set contact_groups=TRIM(BOTH ',' FROM REPLACE( CONCAT(',',contact_groups,','), CONCAT(',',OLD.contactgroup_name,','), ',') )  where FIND_IN_SET(OLD.contactgroup_name, contact_groups) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ContactTemplate`
--

DROP TABLE IF EXISTS `ContactTemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ContactTemplate` (
  `name` varchar(80) NOT NULL DEFAULT '',
  `service_notification_period` varchar(80) DEFAULT NULL,
  `host_notification_period` varchar(80) DEFAULT NULL,
  `service_notification_options` varchar(80) DEFAULT NULL,
  `host_notification_options` varchar(80) DEFAULT NULL,
  `service_notification_commands` varchar(80) DEFAULT NULL,
  `host_notification_commands` varchar(80) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `register` char(1) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ContactTemplate`
--

LOCK TABLES `ContactTemplate` WRITE;
/*!40000 ALTER TABLE `ContactTemplate` DISABLE KEYS */;
INSERT INTO `ContactTemplate` VALUES ('sms1',NULL,NULL,'c,r',NULL,NULL,NULL,NULL,NULL),('mail',NULL,NULL,'c,r',NULL,'notify-by-email','host-notify-by-email',NULL,NULL),('view_only',NULL,NULL,'n','n','host-notify-by-email','host-notify-by-email',NULL,NULL);
/*!40000 ALTER TABLE `ContactTemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Host`
--

DROP TABLE IF EXISTS `Host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Host` (
  `template` varchar(80) DEFAULT NULL,
  `host_name` varchar(80) NOT NULL DEFAULT '',
  `alias` varchar(80) NOT NULL DEFAULT '',
  `address` varchar(80) NOT NULL DEFAULT '',
  `parents` text DEFAULT NULL,
  `hostextinfo` varchar(80) DEFAULT NULL,
  `contact_groups` text DEFAULT NULL,
  `service_group` text DEFAULT NULL,
  `poller_tag` varchar(255) DEFAULT NULL,
  `port_scan` int(1) DEFAULT NULL,
  `store_config` varchar(80) DEFAULT NULL,
  `check_command` text DEFAULT NULL,
  `max_check_attempts` int(3) DEFAULT NULL,
  `notification_interval` int(3) DEFAULT NULL,
  `notification_period` varchar(80) DEFAULT NULL,
  `host_notification_options` varchar(20) DEFAULT NULL,
  `community` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`host_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Host`
--

LOCK TABLES `Host` WRITE;
/*!40000 ALTER TABLE `Host` DISABLE KEYS */;
INSERT INTO `Host` VALUES ('generic-host','localhostnew19','Tortisoft','127.0.0.2',NULL,NULL,'admins',NULL,'poller11',0,NULL,NULL,0,5,NULL,NULL,NULL,NULL),('generic-host','TorstenHost','TorstenHost','192.168.221.10',NULL,NULL,'admins',NULL,NULL,0,NULL,NULL,NULL,NULL,'24x7',NULL,NULL,NULL),('generic-host','TorstenHost11','','192.168.221.11',NULL,NULL,'admins',NULL,'poller111',NULL,NULL,NULL,NULL,NULL,'24x7',NULL,NULL,'TEST1'),('generic-host','localhost','Tortisoft','127.0.0.1',NULL,NULL,'admins',NULL,'Poller1',0,NULL,NULL,0,5,NULL,NULL,NULL,NULL),('generic-host','localhosty3','Tortisoft','127.0.0.1',NULL,NULL,'admins',NULL,'Poller1',0,NULL,NULL,0,5,NULL,NULL,NULL,NULL),('generic-host','localhosty55','Tortisoft','127.0.0.1',NULL,NULL,'admins',NULL,'poller27',0,NULL,NULL,0,5,NULL,NULL,NULL,NULL),('generic-host','localhosty6','Tortisoft','127.0.0.1',NULL,NULL,'admins',NULL,'Poller1',0,NULL,NULL,0,5,NULL,NULL,NULL,NULL),('generic-host','localhostnew18','Tortisoft','127.0.0.2',NULL,NULL,'admins',NULL,'poller11',0,NULL,NULL,0,5,NULL,NULL,NULL,NULL),('generic-host1','Heute1','Heute1','172.28282',NULL,NULL,NULL,NULL,NULL,0,'yes',NULL,4,18,'24x7',NULL,NULL,NULL),('generic-host1','Heidi1o1','Hallo Balo','172.27.1.1',NULL,NULL,NULL,NULL,'Pollerxyyyyy',0,NULL,NULL,4,18,'24x7','u,r',NULL,NULL),('template1','Heidi1','TorstenHost11','192.168.221.11',NULL,NULL,NULL,NULL,'poller111',0,NULL,NULL,0,0,NULL,NULL,NULL,'213333');
/*!40000 ALTER TABLE `Host` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`torsten`@`localhost`*/ /*!50003 TRIGGER `update HostGroup_after_UpdateHost` AFTER UPDATE ON `Host` FOR EACH ROW update HostGroup set members=TRIM(BOTH ',' FROM REPLACE( CONCAT(',',members,','), CONCAT(',',OLD.host_name,','), CONCAT(',',NEW.host_name,',')) )  where FIND_IN_SET(OLD.host_name, members) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`torsten`@`localhost`*/ /*!50003 TRIGGER `update_Service_after_UpdateHost` AFTER UPDATE ON `Host` FOR EACH ROW update Service set host_name=TRIM(BOTH ',' FROM REPLACE( CONCAT(',',host_name,','), CONCAT(',',OLD.host_name,','), CONCAT(',',NEW.host_name,',')) )  where FIND_IN_SET(OLD.host_name, host_name) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`torsten`@`localhost`*/ /*!50003 TRIGGER `update_Service_after_UpdateHostEQ` AFTER UPDATE ON `Host` FOR EACH ROW update Service set host_name=NEW.host_name where host_name=OLD.host_name */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`torsten`@`localhost`*/ /*!50003 TRIGGER `update_HostGroup_after_DeleteHost` AFTER DELETE ON `Host` FOR EACH ROW update HostGroup set members=TRIM(BOTH ',' FROM REPLACE( CONCAT(',',members,','), CONCAT(',',OLD.host_name,','), ',') )  where FIND_IN_SET(OLD.host_name, members) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`torsten`@`localhost`*/ /*!50003 TRIGGER `update_Service_after_DeleteHost` AFTER DELETE ON `Host` FOR EACH ROW BEGIN
	delete from Service where host_name=OLD.host_name;
	update Service set host_name=TRIM(BOTH ',' FROM REPLACE( CONCAT(',',host_name,','), CONCAT(',',OLD.host_name,','), ',') )  where FIND_IN_SET(OLD.host_name, host_name);
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `HostAlerts`
--

DROP TABLE IF EXISTS `HostAlerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HostAlerts` (
  `host_name` varchar(80) DEFAULT NULL,
  `host_state` varchar(12) DEFAULT NULL,
  `output` varchar(255) DEFAULT NULL,
  `execution_time` int(4) DEFAULT NULL,
  `timet` int(12) DEFAULT NULL,
  `last_check` int(12) DEFAULT NULL,
  `last_state_change` int(12) DEFAULT NULL,
  `state_type` varchar(4) DEFAULT NULL,
  `host_attempt` int(4) DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HostAlerts`
--

LOCK TABLES `HostAlerts` WRITE;
/*!40000 ALTER TABLE `HostAlerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `HostAlerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HostDependency`
--

DROP TABLE IF EXISTS `HostDependency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HostDependency` (
  `dependent_host_name` varchar(80) NOT NULL DEFAULT '',
  `host_name` varchar(80) NOT NULL DEFAULT '',
  `notification_failure_criteria` varchar(20) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`dependent_host_name`,`host_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HostDependency`
--

LOCK TABLES `HostDependency` WRITE;
/*!40000 ALTER TABLE `HostDependency` DISABLE KEYS */;
/*!40000 ALTER TABLE `HostDependency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HostDetail`
--

DROP TABLE IF EXISTS `HostDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HostDetail` (
  `host_name` varchar(255) NOT NULL DEFAULT '',
  `device_type` varchar(80) DEFAULT NULL,
  `connection_type` varchar(80) DEFAULT NULL,
  `time_zone` varchar(3) DEFAULT NULL,
  `sort1` varchar(255) DEFAULT NULL,
  `sort2` varchar(255) DEFAULT NULL,
  `sort3` varchar(255) DEFAULT NULL,
  `sysDescr` varchar(255) DEFAULT NULL,
  `sysName` varchar(255) DEFAULT NULL,
  `sysLocation` varchar(255) DEFAULT NULL,
  `sysContact` varchar(255) DEFAULT NULL,
  `ploss_day` varchar(10) DEFAULT NULL,
  `ploss_week` varchar(10) DEFAULT NULL,
  `ploss_month` varchar(10) DEFAULT NULL,
  `ploss_year` varchar(10) DEFAULT NULL,
  `rtt_day` varchar(10) DEFAULT NULL,
  `rtt_week` varchar(10) DEFAULT NULL,
  `rtt_month` varchar(10) DEFAULT NULL,
  `rtt_year` varchar(10) DEFAULT NULL,
  `sla_day` varchar(10) DEFAULT NULL,
  `sla_week` varchar(10) DEFAULT NULL,
  `sla_month` varchar(10) DEFAULT NULL,
  `sla_year` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`host_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HostDetail`
--

LOCK TABLES `HostDetail` WRITE;
/*!40000 ALTER TABLE `HostDetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `HostDetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HostEscalation`
--

DROP TABLE IF EXISTS `HostEscalation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HostEscalation` (
  `host_name` text DEFAULT NULL,
  `hostgroup_name` text DEFAULT NULL,
  `first_notification` int(3) NOT NULL DEFAULT 0,
  `last_notification` int(3) DEFAULT NULL,
  `notification_interval` int(3) DEFAULT NULL,
  `contact_groups` text DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HostEscalation`
--

LOCK TABLES `HostEscalation` WRITE;
/*!40000 ALTER TABLE `HostEscalation` DISABLE KEYS */;
/*!40000 ALTER TABLE `HostEscalation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HostExtInfo`
--

DROP TABLE IF EXISTS `HostExtInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HostExtInfo` (
  `template` varchar(255) DEFAULT NULL,
  `host_name` varchar(255) NOT NULL DEFAULT '',
  `notes` varchar(80) DEFAULT NULL,
  `notes_url` varchar(255) DEFAULT NULL,
  `action_url` varchar(255) NOT NULL,
  `icon_image` varchar(80) DEFAULT NULL,
  `icon_image_alt` varchar(80) DEFAULT NULL,
  `vrml_image` varchar(80) DEFAULT NULL,
  `statusmap_image` varchar(80) DEFAULT NULL,
  `2d_coords` varchar(255) DEFAULT NULL,
  `3d_coords` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`host_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HostExtInfo`
--

LOCK TABLES `HostExtInfo` WRITE;
/*!40000 ALTER TABLE `HostExtInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `HostExtInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HostExtTemplate`
--

DROP TABLE IF EXISTS `HostExtTemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HostExtTemplate` (
  `name` varchar(255) NOT NULL DEFAULT '',
  `notes` varchar(80) DEFAULT NULL,
  `notes_url` varchar(255) DEFAULT NULL,
  `action_url` varchar(255) NOT NULL,
  `icon_image` varchar(255) DEFAULT NULL,
  `icon_image_alt` varchar(255) DEFAULT NULL,
  `vrml_image` varchar(255) DEFAULT NULL,
  `statusmap_image` varchar(255) DEFAULT NULL,
  `2d_coords` varchar(255) DEFAULT NULL,
  `3d_coords` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `register` char(1) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HostExtTemplate`
--

LOCK TABLES `HostExtTemplate` WRITE;
/*!40000 ALTER TABLE `HostExtTemplate` DISABLE KEYS */;
INSERT INTO `HostExtTemplate` VALUES ('normal',NULL,NULL,'','australia2.gif',NULL,'Frame.jpg','Gem_Blue.gif',NULL,NULL,'hall ballo',NULL);
/*!40000 ALTER TABLE `HostExtTemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HostGroup`
--

DROP TABLE IF EXISTS `HostGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HostGroup` (
  `hostgroup_name` varchar(80) NOT NULL DEFAULT '',
  `alias` varchar(80) NOT NULL DEFAULT '',
  `contact_groups` text DEFAULT NULL,
  `members` text DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `current_contact_groups` text DEFAULT NULL,
  `poller_tags` varchar(255) DEFAULT NULL,
  `rtt_day` varchar(10) DEFAULT NULL,
  `rtt_week` varchar(10) DEFAULT NULL,
  `rtt_month` varchar(10) DEFAULT NULL,
  `rtt_year` varchar(10) DEFAULT NULL,
  `sla_day` varchar(10) DEFAULT NULL,
  `sla_week` varchar(10) DEFAULT NULL,
  `sla_month` varchar(10) DEFAULT NULL,
  `sla_year` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`hostgroup_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HostGroup`
--

LOCK TABLES `HostGroup` WRITE;
/*!40000 ALTER TABLE `HostGroup` DISABLE KEYS */;
INSERT INTO `HostGroup` VALUES ('Group1','Test Group1',NULL,'Heidi1,localhostnew18,TorstenHost',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `HostGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HostGroupEscalation`
--

DROP TABLE IF EXISTS `HostGroupEscalation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HostGroupEscalation` (
  `hostgroup_name` varchar(255) NOT NULL DEFAULT '',
  `first_notification` int(3) NOT NULL DEFAULT 0,
  `last_notification` int(3) DEFAULT NULL,
  `notification_interval` int(3) DEFAULT NULL,
  `contact_groups` text DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HostGroupEscalation`
--

LOCK TABLES `HostGroupEscalation` WRITE;
/*!40000 ALTER TABLE `HostGroupEscalation` DISABLE KEYS */;
/*!40000 ALTER TABLE `HostGroupEscalation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HostTemplate`
--

DROP TABLE IF EXISTS `HostTemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HostTemplate` (
  `name` varchar(80) NOT NULL DEFAULT '',
  `max_check_attempts` int(3) DEFAULT NULL,
  `notification_interval` int(3) DEFAULT NULL,
  `host_notification_options` varchar(20) DEFAULT NULL,
  `notification_period` varchar(40) DEFAULT NULL,
  `notifications_enabled` int(1) DEFAULT NULL,
  `port_scan` int(1) DEFAULT NULL,
  `check_command` text DEFAULT NULL,
  `contact_groups` text DEFAULT NULL,
  `action_url` varchar(255) DEFAULT NULL,
  `checks_enabled` int(1) DEFAULT NULL,
  `flap_detection_enabled` int(1) DEFAULT NULL,
  `process_perf_data` int(1) DEFAULT NULL,
  `retain_status_information` int(1) DEFAULT NULL,
  `retain_nonstatus_information` int(1) DEFAULT NULL,
  `event_handler` varchar(80) DEFAULT NULL,
  `event_handler_enabled` int(1) DEFAULT NULL,
  `low_flap_threshold` int(3) DEFAULT NULL,
  `high_flap_threshold` int(3) DEFAULT NULL,
  `stalking_options` varchar(5) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `register` int(1) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HostTemplate`
--

LOCK TABLES `HostTemplate` WRITE;
/*!40000 ALTER TABLE `HostTemplate` DISABLE KEYS */;
INSERT INTO `HostTemplate` VALUES ('generic-host',NULL,NULL,'','24x7',NULL,NULL,'','admins',NULL,1,0,1,1,1,'',1,0,0,'','',0),('generic-host-graph',0,18,'d,u,r','24x7',1,0,'','','http://$HOSTNAME$',1,0,1,1,1,'',1,0,0,'','',0),('generic-host-no',4,18,'d,u,r','24x7',1,0,'','','http://$HOSTNAME$',1,0,1,1,1,'',1,0,0,'','',0),('generic-host1',4,18,'d,u,r','24x7',1,0,'','','http://$HOSTNAME$',1,0,1,1,1,'',1,0,0,'','',0),('template1',6,9,'','',1,0,'','','',0,0,0,0,0,'',0,0,0,'','',0);
/*!40000 ALTER TABLE `HostTemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Interfaces`
--

DROP TABLE IF EXISTS `Interfaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Interfaces` (
  `host_name` varchar(80) DEFAULT NULL,
  `interface_description` varchar(255) DEFAULT NULL,
  `interface_address` varchar(80) DEFAULT NULL,
  `interface_type` varchar(40) DEFAULT NULL,
  `interface_number` int(3) DEFAULT NULL,
  `interface_status` varchar(8) DEFAULT NULL,
  `admin_status` varchar(8) DEFAULT NULL,
  `oper_status` varchar(8) DEFAULT NULL,
  `config_status` varchar(8) DEFAULT NULL,
  `ping` int(1) DEFAULT NULL,
  `interface_speed` int(12) DEFAULT NULL,
  `warning_threshold` int(2) DEFAULT NULL,
  `critical_threshold` int(2) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Interfaces`
--

LOCK TABLES `Interfaces` WRITE;
/*!40000 ALTER TABLE `Interfaces` DISABLE KEYS */;
/*!40000 ALTER TABLE `Interfaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Notifications`
--

DROP TABLE IF EXISTS `Notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Notifications` (
  `notification_table` varchar(10) DEFAULT NULL,
  `notification_method` varchar(5) DEFAULT NULL,
  `contact_name` varchar(80) DEFAULT NULL,
  `host_name` varchar(80) DEFAULT NULL,
  `host_state` varchar(12) DEFAULT NULL,
  `output` varchar(255) DEFAULT NULL,
  `notification_type` varchar(15) DEFAULT NULL,
  `notification_number` int(12) DEFAULT NULL,
  `timet` int(12) DEFAULT NULL,
  `service_description` varchar(255) DEFAULT NULL,
  `service_state` varchar(8) DEFAULT NULL,
  `sent` int(1) DEFAULT 0,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Notifications`
--

LOCK TABLES `Notifications` WRITE;
/*!40000 ALTER TABLE `Notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `Notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PollerTags`
--

DROP TABLE IF EXISTS `PollerTags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PollerTags` (
  `name` varchar(80) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PollerTags`
--

LOCK TABLES `PollerTags` WRITE;
/*!40000 ALTER TABLE `PollerTags` DISABLE KEYS */;
INSERT INTO `PollerTags` VALUES ('p21','p2'),('Poller1','Holger 123XXXXXXXXXXXXXX11333'),('poller11','Extern1'),('poller111','Extern1'),('poller112','Extern1'),('poller113','Extern1'),('poller21','noch einTest'),('poller27',''),('Pollerxyyyyy','noch ein Test'),('Torsten','Tortisoft');
/*!40000 ALTER TABLE `PollerTags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PortScan`
--

DROP TABLE IF EXISTS `PortScan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PortScan` (
  `host_name` varchar(80) NOT NULL DEFAULT '',
  `address` varchar(80) DEFAULT NULL,
  `port` int(6) NOT NULL DEFAULT 0,
  `protocol` varchar(6) NOT NULL DEFAULT '',
  `service` varchar(80) DEFAULT NULL,
  `active` char(1) DEFAULT NULL,
  `lockport` char(1) DEFAULT NULL,
  PRIMARY KEY (`host_name`,`port`,`protocol`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PortScan`
--

LOCK TABLES `PortScan` WRITE;
/*!40000 ALTER TABLE `PortScan` DISABLE KEYS */;
INSERT INTO `PortScan` VALUES ('Host1',NULL,0,'TCP',NULL,NULL,NULL),('Host2',NULL,0,'TCP',NULL,NULL,NULL);
/*!40000 ALTER TABLE `PortScan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Service`
--

DROP TABLE IF EXISTS `Service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Service` (
  `template` varchar(80) DEFAULT NULL,
  `host_name` text DEFAULT NULL,
  `hostgroup_name` text DEFAULT NULL,
  `service_description` varchar(80) DEFAULT NULL,
  `contact_groups` text DEFAULT NULL,
  `check_period` varchar(40) DEFAULT NULL,
  `notification_interval` int(3) DEFAULT NULL,
  `service_notification_options` varchar(20) DEFAULT NULL,
  `notification_period` varchar(40) DEFAULT NULL,
  `check_command` text DEFAULT NULL,
  `max_check_attempts` int(3) DEFAULT NULL,
  `normal_check_interval` int(3) DEFAULT NULL,
  `retry_check_interval` int(3) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `poller_tag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1267 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Service`
--

LOCK TABLES `Service` WRITE;
/*!40000 ALTER TABLE `Service` DISABLE KEYS */;
INSERT INTO `Service` VALUES ('generic-service','TFTEST','','ping','admins','24x7',3,'','24x7','check-host-alive',3,3,1,'',1,''),('generic-service','localhost',NULL,'tsstst','admins',NULL,0,'u,c,r',NULL,'rtzr',4,5,2,'',1262,NULL),('generic-service','localhost',NULL,'tsstst','admins',NULL,0,'u,c,r',NULL,'rtzr',4,5,2,'',1264,NULL),('generic-service',NULL,NULL,NULL,'admins',NULL,0,'u,r,w',NULL,NULL,4,5,2,NULL,1266,NULL);
/*!40000 ALTER TABLE `Service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServiceAlerts`
--

DROP TABLE IF EXISTS `ServiceAlerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ServiceAlerts` (
  `host_name` varchar(80) DEFAULT NULL,
  `host_state` varchar(12) DEFAULT NULL,
  `service_description` varchar(255) DEFAULT NULL,
  `service_state` varchar(12) DEFAULT NULL,
  `output` varchar(255) DEFAULT NULL,
  `execution_time` int(4) DEFAULT NULL,
  `latency` int(4) DEFAULT NULL,
  `timet` int(12) DEFAULT NULL,
  `last_check` int(12) DEFAULT NULL,
  `last_state_change` int(12) DEFAULT NULL,
  `state_type` varchar(4) DEFAULT NULL,
  `service_attempt` int(4) DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServiceAlerts`
--

LOCK TABLES `ServiceAlerts` WRITE;
/*!40000 ALTER TABLE `ServiceAlerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ServiceAlerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServiceDependency`
--

DROP TABLE IF EXISTS `ServiceDependency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ServiceDependency` (
  `host_name` varchar(80) NOT NULL DEFAULT '',
  `service_description` varchar(80) DEFAULT NULL,
  `dependent_host_name` varchar(80) NOT NULL DEFAULT '',
  `dependent_service_description` varchar(80) NOT NULL DEFAULT '',
  `execution_failure_criteria` varchar(20) DEFAULT NULL,
  `notification_failure_criteria` varchar(20) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`host_name`,`dependent_host_name`,`dependent_service_description`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServiceDependency`
--

LOCK TABLES `ServiceDependency` WRITE;
/*!40000 ALTER TABLE `ServiceDependency` DISABLE KEYS */;
/*!40000 ALTER TABLE `ServiceDependency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServiceEscalation`
--

DROP TABLE IF EXISTS `ServiceEscalation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ServiceEscalation` (
  `host_name` text DEFAULT NULL,
  `hostgroup_name` text DEFAULT NULL,
  `service_description` varchar(80) NOT NULL DEFAULT '',
  `first_notification` int(3) NOT NULL DEFAULT 0,
  `last_notification` int(3) DEFAULT NULL,
  `notification_interval` int(3) DEFAULT NULL,
  `contact_groups` text DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServiceEscalation`
--

LOCK TABLES `ServiceEscalation` WRITE;
/*!40000 ALTER TABLE `ServiceEscalation` DISABLE KEYS */;
/*!40000 ALTER TABLE `ServiceEscalation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServiceExtInfo`
--

DROP TABLE IF EXISTS `ServiceExtInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ServiceExtInfo` (
  `template` varchar(80) DEFAULT NULL,
  `host_name` text DEFAULT NULL,
  `hostgroup_name` text DEFAULT NULL,
  `service_description` varchar(80) DEFAULT NULL,
  `notes` varchar(80) DEFAULT NULL,
  `notes_url` varchar(255) DEFAULT NULL,
  `action_url` varchar(255) NOT NULL,
  `icon_image` varchar(80) DEFAULT NULL,
  `icon_image_alt` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServiceExtInfo`
--

LOCK TABLES `ServiceExtInfo` WRITE;
/*!40000 ALTER TABLE `ServiceExtInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `ServiceExtInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServiceExtTemplate`
--

DROP TABLE IF EXISTS `ServiceExtTemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ServiceExtTemplate` (
  `name` varchar(255) DEFAULT NULL,
  `notes` varchar(80) DEFAULT NULL,
  `host_name` text DEFAULT NULL,
  `hostgroup_name` text DEFAULT NULL,
  `service_description` varchar(255) DEFAULT NULL,
  `notes_url` varchar(255) DEFAULT NULL,
  `action_url` varchar(255) NOT NULL,
  `icon_image` varchar(255) DEFAULT NULL,
  `icon_image_alt` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServiceExtTemplate`
--

LOCK TABLES `ServiceExtTemplate` WRITE;
/*!40000 ALTER TABLE `ServiceExtTemplate` DISABLE KEYS */;
/*!40000 ALTER TABLE `ServiceExtTemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServiceGroup`
--

DROP TABLE IF EXISTS `ServiceGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ServiceGroup` (
  `servicegroup_name` varchar(80) NOT NULL DEFAULT '',
  `alias` varchar(80) NOT NULL DEFAULT '',
  `service_templates` text DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`servicegroup_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServiceGroup`
--

LOCK TABLES `ServiceGroup` WRITE;
/*!40000 ALTER TABLE `ServiceGroup` DISABLE KEYS */;
INSERT INTO `ServiceGroup` VALUES ('Linux1','Standard service Group','generic-service','nur Test');
/*!40000 ALTER TABLE `ServiceGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServiceTemplate`
--

DROP TABLE IF EXISTS `ServiceTemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ServiceTemplate` (
  `name` varchar(80) NOT NULL DEFAULT '',
  `service_description` varchar(80) DEFAULT NULL,
  `port` int(6) DEFAULT NULL,
  `protocol` varchar(10) DEFAULT NULL,
  `check_command` text DEFAULT NULL,
  `contact_groups` text NOT NULL,
  `check_period` varchar(40) DEFAULT NULL,
  `notification_period` varchar(40) DEFAULT NULL,
  `action_url` varchar(255) DEFAULT NULL,
  `is_volatile` int(1) DEFAULT NULL,
  `max_check_attempts` int(1) DEFAULT NULL,
  `normal_check_interval` int(1) DEFAULT NULL,
  `retry_check_interval` int(1) DEFAULT NULL,
  `notification_interval` int(3) DEFAULT NULL,
  `service_notification_options` varchar(20) DEFAULT NULL,
  `active_checks_enabled` int(1) DEFAULT NULL,
  `passive_checks_enabled` int(1) DEFAULT NULL,
  `parallelize_check` int(1) DEFAULT NULL,
  `obsess_over_service` int(1) DEFAULT NULL,
  `check_freshness` int(1) DEFAULT NULL,
  `notifications_enabled` int(1) DEFAULT NULL,
  `event_handler_enabled` int(1) DEFAULT NULL,
  `flap_detection_enabled` int(1) DEFAULT NULL,
  `process_perf_data` int(1) DEFAULT NULL,
  `retain_status_information` int(1) DEFAULT NULL,
  `freshness_threshold` int(3) DEFAULT NULL,
  `event_handler` varchar(80) DEFAULT NULL,
  `low_flap_threshold` int(3) DEFAULT NULL,
  `high_flap_threshold` int(3) DEFAULT NULL,
  `retain_nonstatus_information` int(1) DEFAULT NULL,
  `stalking_options` varchar(7) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `register` int(1) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServiceTemplate`
--

LOCK TABLES `ServiceTemplate` WRITE;
/*!40000 ALTER TABLE `ServiceTemplate` DISABLE KEYS */;
INSERT INTO `ServiceTemplate` VALUES ('generic-service',NULL,NULL,NULL,NULL,'admins',NULL,NULL,'http://localhost',0,4,5,2,NULL,'u,c,r',1,1,1,0,0,1,1,0,1,1,NULL,NULL,NULL,NULL,1,NULL,NULL,0);
/*!40000 ALTER TABLE `ServiceTemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `System`
--

DROP TABLE IF EXISTS `System`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `System` (
  `host_name` varchar(80) NOT NULL DEFAULT '',
  `local_host` int(1) NOT NULL DEFAULT 1,
  `address` varchar(80) DEFAULT NULL,
  `alias` varchar(80) DEFAULT NULL,
  `nagiosrc` varchar(80) DEFAULT NULL,
  `nagiosbin` varchar(80) DEFAULT NULL,
  `nagiosetc` varchar(80) DEFAULT NULL,
  `nagioslibexec` varchar(80) DEFAULT NULL,
  `nagiosshare` varchar(80) DEFAULT NULL,
  `nagminroot` varchar(80) DEFAULT NULL,
  `snmpbin` varchar(80) DEFAULT NULL,
  `rrdbin` varchar(80) DEFAULT NULL,
  `rrddir` varchar(80) DEFAULT NULL,
  `rrdgraphs` varchar(80) DEFAULT NULL,
  `notesurl` varchar(80) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`host_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `System`
--

LOCK TABLES `System` WRITE;
/*!40000 ALTER TABLE `System` DISABLE KEYS */;
/*!40000 ALTER TABLE `System` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TimePeriod`
--

DROP TABLE IF EXISTS `TimePeriod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TimePeriod` (
  `timeperiod_name` varchar(80) NOT NULL DEFAULT '',
  `alias` varchar(80) DEFAULT NULL,
  `monday` varchar(40) DEFAULT NULL,
  `tuesday` varchar(40) DEFAULT NULL,
  `wednesday` varchar(40) DEFAULT NULL,
  `thursday` varchar(40) DEFAULT NULL,
  `friday` varchar(40) DEFAULT NULL,
  `saturday` varchar(40) DEFAULT NULL,
  `sunday` varchar(40) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`timeperiod_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TimePeriod`
--

LOCK TABLES `TimePeriod` WRITE;
/*!40000 ALTER TABLE `TimePeriod` DISABLE KEYS */;
INSERT INTO `TimePeriod` VALUES ('workhours','\"Normal\" Working Hours','09:00-17:00','09:00-17:00','09:00-17:00','09:00-17:00','09:00-17:00',NULL,NULL,NULL),('24x7','24 Hours A Day, 7 Days A Week','00:00-24:00','00:00-24:00','00:00-24:00','00:00-24:00','00:00-24:00','00:00-24:00','00:00-24:00',NULL);
/*!40000 ALTER TABLE `TimePeriod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostcomments`
--

DROP TABLE IF EXISTS `hostcomments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostcomments` (
  `hostcomment_id` int(11) NOT NULL AUTO_INCREMENT,
  `host_name` varchar(75) NOT NULL,
  `entry_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `persistent` tinyint(4) NOT NULL DEFAULT 0,
  `author_name` varchar(75) NOT NULL,
  `comment_data` text NOT NULL,
  PRIMARY KEY (`hostcomment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostcomments`
--

LOCK TABLES `hostcomments` WRITE;
/*!40000 ALTER TABLE `hostcomments` DISABLE KEYS */;
/*!40000 ALTER TABLE `hostcomments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostdowntime`
--

DROP TABLE IF EXISTS `hostdowntime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostdowntime` (
  `hostdowntime_id` int(11) NOT NULL AUTO_INCREMENT,
  `host_name` varchar(75) NOT NULL,
  `entry_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fixed` tinyint(4) NOT NULL DEFAULT 0,
  `duration` bigint(20) NOT NULL DEFAULT 0,
  `author_name` varchar(75) NOT NULL,
  `comment_data` text NOT NULL,
  PRIMARY KEY (`hostdowntime_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostdowntime`
--

LOCK TABLES `hostdowntime` WRITE;
/*!40000 ALTER TABLE `hostdowntime` DISABLE KEYS */;
/*!40000 ALTER TABLE `hostdowntime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostextinfo`
--

DROP TABLE IF EXISTS `hostextinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostextinfo` (
  `host_name` varchar(75) NOT NULL,
  `notes_url` varchar(128) NOT NULL,
  `icon_image` varchar(32) NOT NULL,
  `vrml_image` varchar(32) NOT NULL,
  `gd2_icon_image` varchar(32) NOT NULL,
  `icon_image_alt` varchar(128) NOT NULL,
  `x_2d` int(11) NOT NULL DEFAULT -1,
  `y_2d` int(11) NOT NULL DEFAULT -1,
  `x_3d` double(16,4) NOT NULL DEFAULT -1.0000,
  `y_3d` double(16,4) NOT NULL DEFAULT -1.0000,
  `z_3d` double(16,4) NOT NULL DEFAULT -1.0000,
  `have_2d_coords` tinyint(4) NOT NULL DEFAULT 0,
  `have_3d_coords` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostextinfo`
--

LOCK TABLES `hostextinfo` WRITE;
/*!40000 ALTER TABLE `hostextinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `hostextinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostretention`
--

DROP TABLE IF EXISTS `hostretention`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostretention` (
  `host_name` varchar(75) NOT NULL,
  `host_state` tinyint(4) NOT NULL DEFAULT 0,
  `last_check` int(11) NOT NULL DEFAULT 0,
  `checks_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `time_up` int(11) NOT NULL DEFAULT 0,
  `time_down` int(11) NOT NULL DEFAULT 0,
  `time_unreachable` int(11) NOT NULL DEFAULT 0,
  `last_notification` int(11) NOT NULL DEFAULT 0,
  `current_notification` int(11) NOT NULL DEFAULT 0,
  `notifications_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `event_handler_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `problem_has_been_acknowledged` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_output` text NOT NULL,
  `flap_detection_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `failure_prediction_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `process_performance_data` tinyint(4) NOT NULL DEFAULT 0,
  `last_state_change` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostretention`
--

LOCK TABLES `hostretention` WRITE;
/*!40000 ALTER TABLE `hostretention` DISABLE KEYS */;
/*!40000 ALTER TABLE `hostretention` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hoststatus`
--

DROP TABLE IF EXISTS `hoststatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hoststatus` (
  `host_name` varchar(75) NOT NULL,
  `host_status` varchar(16) NOT NULL,
  `last_update` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_check` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_state_change` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `problem_acknowledged` tinyint(4) NOT NULL DEFAULT 0,
  `time_up` int(11) NOT NULL DEFAULT 0,
  `time_down` int(11) NOT NULL DEFAULT 0,
  `time_unreachable` int(11) NOT NULL DEFAULT 0,
  `last_notification` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `current_notification` int(11) NOT NULL DEFAULT 0,
  `notifications_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `event_handler_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `checks_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_output` text DEFAULT NULL,
  `flap_detection_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `is_flapping` tinyint(4) NOT NULL DEFAULT 0,
  `percent_state_change` float(10,2) NOT NULL DEFAULT 0.00,
  `scheduled_downtime_depth` int(11) NOT NULL DEFAULT 0,
  `failure_prediction_enabled` tinyint(4) NOT NULL DEFAULT 0,
  `process_performance_data` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hoststatus`
--

LOCK TABLES `hoststatus` WRITE;
/*!40000 ALTER TABLE `hoststatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `hoststatus` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-01 14:35:09
