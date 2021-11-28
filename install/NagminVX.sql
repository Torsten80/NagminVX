-- MariaDB dump 10.19  Distrib 10.6.5-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: NagminVX
-- ------------------------------------------------------
-- Server version	10.6.5-MariaDB

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
-- Table structure for table `Actions`
--

DROP TABLE IF EXISTS `Actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` tinytext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Actions`
--

LOCK TABLES `Actions` WRITE;
/*!40000 ALTER TABLE `Actions` DISABLE KEYS */;
INSERT INTO `Actions` VALUES (1,'verify','sudo podman exec -it shinken1 bash -c \"/usr/bin/shinken-arbiter -v -c /etc/shinken/shinken.cfg\"','Verify via Container'),(2,'activate_soft','sudo podman exec -it shinken1 bash -c \"/usr/bin/shinken-arbiter -d -c /etc/shinken/shinken.cfg\"','via Container'),(3,'activate','sudo podman exec -it shinken1 bash -c \"/etc/rc.d/init.d/shinken restart\"','restart via Container'),(4,'status','sudo podman exec -it shinken1 bash -c \"/etc/rc.d/init.d/shinken status\"','via Container'),(5,'stop','sudo podman exec -it shinken1 bash -c \"/etc/rc.d/init.d/shinken stop\"','via Container'),(6,'reload','sudo podman exec -it shinken1 bash -c \"/etc/rc.d/init.d/shinken reload \"','via Container sudo /etc/init.d/shinken reload'),(7,'restart','sudo podman exec -it shinken1 bash -c \"/etc/rc.d/init.d/shinken restart\"','restart via Container'),(8,'Audit_today','grep -i \"audit:\" ../writable/logs/log-$(date +%F).log | sort -r','Tools Action '),(9,'Audit_last_7days','find ../writable/logs/ -type f -mtime -7  -print0  | xargs -0 grep -i \"audit:\" | sort -r','Tools Action ');
/*!40000 ALTER TABLE `Actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Config`
--

DROP TABLE IF EXISTS `Config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Config`
--

LOCK TABLES `Config` WRITE;
/*!40000 ALTER TABLE `Config` DISABLE KEYS */;
INSERT INTO `Config` VALUES (1,'Nagios.cfg','ganze Tabell wird z.Z. nicht benötigt',NULL),(2,'ressource.cfg',NULL,NULL),(3,'Contact.cfg',NULL,NULL),(4,'verify_directory','directory for temp config files in WRITEPATH. must exist!','verify');
/*!40000 ALTER TABLE `Config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Config_Tables`
--

DROP TABLE IF EXISTS `Config_Tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Config_Tables` (
  `id` int(11) NOT NULL,
  `Name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Config_Tables`
--

LOCK TABLES `Config_Tables` WRITE;
/*!40000 ALTER TABLE `Config_Tables` DISABLE KEYS */;
INSERT INTO `Config_Tables` VALUES (1,'Command'),(2,'Contact'),(3,'ContactGroup'),(4,'ContactTemplate'),(6,'Host'),(7,'HostDependency'),(8,'HostEscalation'),(9,'HostExtInfo'),(10,'HostGroup'),(11,'HostGroupEscalation'),(12,'HostTemplate'),(13,'Service'),(14,'ServiceDependency'),(15,'ServiceEscalation'),(16,'ServiceExtInfo'),(17,'ServiceTemplate'),(18,'TimePeriod');
/*!40000 ALTER TABLE `Config_Tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Control`
--

DROP TABLE IF EXISTS `Control`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Control` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Control`
--

LOCK TABLES `Control` WRITE;
/*!40000 ALTER TABLE `Control` DISABLE KEYS */;
INSERT INTO `Control` VALUES (1,'Contact.cfg',NULL,NULL),(2,'Contactx.cfg',NULL,NULL),(3,'Hallo1','2','3'),(4,'config','default values (from old Nagmin)','verify');
/*!40000 ALTER TABLE `Control` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Documentation`
--

DROP TABLE IF EXISTS `Documentation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Documentation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` tinytext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Documentation`
--

LOCK TABLES `Documentation` WRITE;
/*!40000 ALTER TABLE `Documentation` DISABLE KEYS */;
INSERT INTO `Documentation` VALUES (1,'Nagios Website','https://www.nagios.org',NULL),(2,'Shinken Website','http://www.shinken-monitoring.org/',NULL),(3,'Changelog','http://nagminv.blogspot.com/p/changelog-main-changescompared-with.html',NULL),(4,'NagminVX on GitHub','https://github.com/Torsten80/NagminVX',NULL);
/*!40000 ALTER TABLE `Documentation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Help1`
--

DROP TABLE IF EXISTS `Help1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Help1` (
  `column_name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nsource` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`column_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Help1`
--

LOCK TABLES `Help1` WRITE;
/*!40000 ALTER TABLE `Help1` DISABLE KEYS */;
INSERT INTO `Help1` VALUES ('check_command','Command'),('contact_groups','ContactGroup'),('hostgroup_name','HostGroup'),('notification_period','TimePeriod'),('poller_tag','PollerTags'),('service_group','ServiceGroup');
/*!40000 ALTER TABLE `Help1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LOGOS`
--

DROP TABLE IF EXISTS `LOGOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LOGOS` (
  `name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LOGOS`
--

LOCK TABLES `LOGOS` WRITE;
/*!40000 ALTER TABLE `LOGOS` DISABLE KEYS */;
INSERT INTO `LOGOS` VALUES ('activate_1.png'),('aquadot.jpg'),('assign.png'),('australia2.gif'),('background.jpg'),('basicline.png'),('basiclogaxis.png'),('basiclogoptions.png'),('basicoptions.png'),('clear.png'),('clear_1.png'),('cm_fill.gif'),('copy.png'),('copy_1.png'),('cut.png'),('dualaxis.png'),('elvitalfrueher.png'),('essence.jpg'),('navdocs.png'),('navdocsover.png'),('navdownload.png'),('navdownloadover.png'),('navexamples.png'),('navexamplesover.png'),('navhome.gif'),('navhome.png'),('navhomeover.png'),('new.png'),('sample3.png'),('samplesm.png'),('shoulder.jpg'),('toolbar_contents.gif'),('toolbar_help.gif'),('toolbar_home.gif'),('toolbar_logout.gif');
/*!40000 ALTER TABLE `LOGOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Relations`
--

DROP TABLE IF EXISTS `Relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Relations` (
  `table_name` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_name` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nsource` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ntype` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`table_name`,`column_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Relations`
--

LOCK TABLES `Relations` WRITE;
/*!40000 ALTER TABLE `Relations` DISABLE KEYS */;
INSERT INTO `Relations` VALUES ('Command','poller_tag','SELECT name, \"poller_tag\" as fn FROM PollerTags union select \"\" as name, \"poller_tag\" as fn ORDER BY name','selectone,0'),('Contact','host_notification_commands','select command_name as name, \"host_notification_commands\" as fn from Command union select \"\" as name, \"host_notification_commands\" as fn order by name','selectone,0'),('Contact','host_notification_options','select noption_name as name, \"host_notification_options\" as fn, noption as value from NagminVX.notification_options','mselect,0'),('Contact','host_notification_period','select timeperiod_name as name, \"host_notification_period\" as fn from TimePeriod union select \"\" as name, \"host_notification_period\" as fn order by name','selectone,0'),('Contact','service_notification_commands','select command_name as name, \"service_notification_commands\" as fn from Command union select \"\" as name, \"service_notification_commands\" as fn order by name','selectone,0'),('Contact','service_notification_options','select noption_name as name, \"service_notification_options\" as fn, noption as value  from NagminVX.notification_options','mselect,0'),('Contact','service_notification_period','select timeperiod_name as name, \"service_notification_period\" as fn from TimePeriod union select \"\" as name, \"service_notification_period\" as fn order by name = \"\" DESC','selectone,0'),('Contact','template','select name, \"template\" as fn from ContactTemplate union select \"\" as name, \"template\" as fn order by name = \"\" DESC','selectone,1'),('ContactGroup','members','select contact_name as name, \"members\" as fn from Contact order by contact_name','mselect,0'),('ContactTemplate','host_notification_commands','select command_name as name, \"host_notification_commands\" as fn from Command union select \"\" as name, \"host_notification_commands\" as fn order by name','selectone,0'),('ContactTemplate','host_notification_options','select noption_name as name, \"host_notification_options\" as fn, noption as value from NagminVX.notification_options','mselect,0'),('ContactTemplate','host_notification_period','select timeperiod_name as name, \"host_notification_period\" as fn from TimePeriod union select \"\" as name, \"host_notification_period\" as fn order by name','selectone,0'),('ContactTemplate','service_notification_commands','select command_name as name, \"service_notification_commands\" as fn from Command union select \"\" as name, \"service_notification_commands\" as fn order by name','selectone,0'),('ContactTemplate','service_notification_options','select noption_name as name, \"service_notification_options\" as fn, noption as value  from NagminVX.notification_options','mselect,0'),('ContactTemplate','service_notification_period','select timeperiod_name as name, \"service_notification_period\" as fn from TimePeriod union select \"\" as name, \"service_notification_period\" as fn order by name = \"\" DESC','selectone,0'),('Host','check_period','select timeperiod_name as name, \"check_period\" as fn from TimePeriod','selectone,0'),('Host','contact_groups','select ContactGroup_name as name, \"contact_groups\" as fn from ContactGroup','mselect,0'),('Host','host_notification_options','select noption_name as name, \"host_notification_options\" as fn, noption as value from NagminVX.notification_options','mselect,0'),('Host','hostextinfo','select name as name, \"hostextinfo\" as fn from HostExtTemplate','mselect,0'),('Host','notification_period','select timeperiod_name as name, \"notification_period\" as fn from TimePeriod union select \"\" as name, \"notification_period\" as fn order by name = \"\" DESC','selectone,0'),('Host','parents','select host_name as name, \"parents\" as fn from Host','mselect,0'),('Host','poller_tag','SELECT name, \"poller_tag\" as fn FROM PollerTags union select \"\" as name, \"poller_tag\" as fn ORDER BY name','mselect,0'),('Host','service_group','select ServiceGroup_name as name, \"service_group\" as fn from ServiceGroup','mselect,0'),('Host','store_config','SELECT \"yes\" AS name, \"store_config\" AS fn FROM DUAL UNION ALL SELECT \"no\" AS name,\"store_config\" AS store_config','selectone,0'),('Host','template','select name, \"template\" as fn from HostTemplate union select \"\" as name, \"template\" as fn order by name = \"\" DESC','selectone,1'),('HostDependency','host_name','select host_name as name,  \"host_name\" as fn from Host ','mselect,0'),('HostDetail','host_name','select host_name as name,  \"host_name\" as fn from Host ','selectone,0'),('HostEscalation','host_name','select host_name as name,  \"host_name\" as fn from Host ','selectone,0'),('HostExtInfo','host_name','select host_name as name,  \"host_name\" as fn from Host ','selectone,0'),('HostExtTemplate','icon_image','select name, \"icon_image\" as fn from NagminVX.LOGOS union select \"\" as name, \"icon_image\" as fn order by name','selectone,0'),('HostGroup','contact_groups','select contactgroup_name as name, \"contact_groups\" as fn from ContactGroup','mselect,0'),('HostGroup','members','select host_name as name, \"members\" as fn from Host','mselect,0'),('HostTemplate','contact_groups','select ContactGroup_name as name, \"contact_groups\" as fn from ContactGroup','mselect,0'),('HostTemplate','host_notification_options','select noption_name as name, \"host_notification_options\" as fn, noption as value  from NagminVX.notification_options','mselect,0'),('HostTemplate','notification_period','select timeperiod_name as name, \"notification_period\" as fn from TimePeriod union select \"\" as name, \"notification_period\" as fn order by name = \"\" DESC','selectone,0'),('Notifications','check_command','select command_name as name, \"check_command\" as fn from Command union select \"\" as name, \"check_command\" as fn order by name','selectone,0'),('Relations','table_name','SELECT table_name as name, \"table_name\" as fn FROM information_schema.tables where table_schema = \"nagios\" order by name','selectone,0'),('Service','check_period','select timeperiod_name as name, \"check_period\" as fn from TimePeriod union select \"\" as name, \"check_period\" as fn order by name = \"\" DESC','selectone,0'),('Service','contact_groups','select ContactGroup_name as name, \"contact_groups\" as fn from ContactGroup','mselect,0'),('Service','host_name','select host_name as name,  \"host_name\" as fn from Host ','mselect,0'),('Service','hostgroup_name','select HostGroup_name as name, \"hostgroup_name\" as fn from HostGroup','mselect,0'),('Service','icon_image','select name, \"icon_image\" as fn from NagminVX.LOGOS union select \"\" as name, \"icon_image\" as fn order by name','selectone,0'),('Service','notification_period','select timeperiod_name as name, \"notification_period\" as fn from TimePeriod union select \"\" as name, \"notification_period\" as fn order by name = \"\" DESC','selectone,0'),('Service','poller_tag','SELECT name, \"poller_tag\" as fn FROM PollerTags union select \"\" as name, \"poller_tag\" as fn ORDER BY name','mselect,0'),('Service','service_notification_options','select noption_name as name, \"service_notification_options\" as fn, noption as value  from NagminVX.notification_options','mselect,0'),('Service','template','select name, \"template\" as fn from ServiceTemplate union select \"\" as name, \"template\" as fn order by name = \"\" DESC','selectone,1'),('ServiceDependency','host_name','select host_name as name,  \"host_name\" as fn from Host ','selectone,0'),('ServiceGroup','service_templates','select name, \"service_templates\" as fn from ServiceTemplate union select \"\" as name, \"service_templates\" as fn order by name','mselect,0'),('ServiceTemplate','check_period','select timeperiod_name as name, \"check_period\" as fn from TimePeriod union select \"\" as name, \"check_period\" as fn order by name = \"\" DESC','selectone,0'),('ServiceTemplate','contact_groups','select ContactGroup_name as name, \"contact_groups\" as fn from ContactGroup','mselect,0'),('ServiceTemplate','host_name','select host_name as name,  \"host_name\" as fn from Host','mselect,0'),('ServiceTemplate','hostgroup_name','select HostGroup_name as name, \"hostgroup_name\" as fn from HostGroup','mselect,0'),('ServiceTemplate','notification_period','select timeperiod_name as name, \"notification_period\" as fn from TimePeriod union select \"\" as name, \"notification_period\" as fn order by name = \"\" DESC','selectone,0'),('ServiceTemplate','service_notification_options','select noption_name as name, \"service_notification_options\" as fn, noption as value  from NagminVX.notification_options','mselect,0'),('SNMP_Walker','authProtocol','SELECT \"MD5\" AS name, \"authProtocol\" AS fn FROM DUAL UNION ALL SELECT \"SHA\" AS name,\"authProtocol\"  UNION ALL SELECT \"SHA-224\" AS name,\"authProtocol\"  UNION ALL SELECT \"SHA-256\" AS name,\"authProtocol\"  UNION ALL SELECT \"SHA-384\" AS name,\"authProtocol\"   UNION ALL SELECT \"SHA-512\" AS name,\"authProtocol\" UNION ALL SELECT \"\" AS name,\"authProtocol\" order by name = \"\" DESC','selectone,0'),('SNMP_Walker','host_name','select host_name as name,  \"host_name\" as fn from Host ','selectone,0'),('SNMP_Walker','privProtocol','SELECT \"DES\" AS name, \"privProtocol\" AS fn FROM DUAL UNION ALL SELECT \"AES\" AS name,\"privProtocol\" UNION ALL SELECT \"\" AS name,\"privProtocol\" order by name = \"\" DESC','selectone,0'),('SNMP_Walker','securityLevel','SELECT \"noAuthNoPriv\" AS name, \"securityLevel\" AS fn FROM DUAL UNION ALL SELECT \"authNoPriv\" AS name,\"securityLevel\"  UNION ALL SELECT \"authPriv\" AS name,\"securityLevel\"  UNION ALL SELECT \"\" AS name,\"securityLevel\"  order by name = \"\" DESC','selectone,0'),('SNMP_Walker','version','SELECT \"1\" AS name, \"version\" AS fn FROM DUAL UNION ALL SELECT \"2c\" AS name,\"version\" AS version UNION ALL SELECT \"3\" AS name,\"version\" ','selectone,0');
/*!40000 ALTER TABLE `Relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reports`
--

DROP TABLE IF EXISTS `Reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reports` (
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reports`
--

LOCK TABLES `Reports` WRITE;
/*!40000 ALTER TABLE `Reports` DISABLE KEYS */;
INSERT INTO `Reports` VALUES ('V_Host1','einfacher View aus Host Tablle','erster Test',3);
/*!40000 ALTER TABLE `Reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SNMP_Walker`
--

DROP TABLE IF EXISTS `SNMP_Walker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SNMP_Walker` (
  `version` varchar(2) DEFAULT NULL,
  `host_name` text DEFAULT NULL,
  `community` varchar(80) DEFAULT NULL,
  `authProtocol` varchar(8) DEFAULT NULL,
  `privProtocol` varchar(8) DEFAULT NULL,
  `authKey` varchar(40) DEFAULT NULL,
  `privKey` varchar(40) DEFAULT NULL,
  `securityLevel` varchar(20) DEFAULT NULL,
  `oid` varchar(64) DEFAULT NULL,
  `port` int(6) DEFAULT NULL,
  `current_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SNMP_Walker`
--

LOCK TABLES `SNMP_Walker` WRITE;
/*!40000 ALTER TABLE `SNMP_Walker` DISABLE KEYS */;
INSERT INTO `SNMP_Walker` VALUES ('1','Heidi1','public','SHA-384','DES',NULL,NULL,'noAuthNoPriv',NULL,222,'2021-07-14 17:40:10',1),('3','TorstenHost','torsten','SHA-256','DES','autkey1sjaLJSALSjaLSJA','privkey1sdjshfksdhfk','authPriv',NULL,161,'2021-07-14 17:40:10',3);
/*!40000 ALTER TABLE `SNMP_Walker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tools`
--

DROP TABLE IF EXISTS `Tools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tools` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tools`
--

LOCK TABLES `Tools` WRITE;
/*!40000 ALTER TABLE `Tools` DISABLE KEYS */;
INSERT INTO `Tools` VALUES (1,'Logo_Manager','der Logo manager','action1'),(4,'SNMP_Walker','SNMP_Walker',''),(5,'Interface_Scanner','Interface_Scanner','Interface_Scanner'),(6,'Reports',NULL,'Reports'),(7,'Backup Configuration DB','Backup Configuration DB','mysqldump'),(8,'Audit_today','SQL Log','is in action table'),(9,'Audit_last_7days','SQL Log','is in action table');
/*!40000 ALTER TABLE `Tools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `V_Host1`
--

DROP TABLE IF EXISTS `V_Host1`;
/*!50001 DROP VIEW IF EXISTS `V_Host1`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `V_Host1` (
  `Hostname` tinyint NOT NULL,
  `Alias` tinyint NOT NULL,
  `IP Adresse` tinyint NOT NULL,
  `Kontakt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `auth_activation_attempts`
--

DROP TABLE IF EXISTS `auth_activation_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_activation_attempts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(255) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_activation_attempts`
--

LOCK TABLES `auth_activation_attempts` WRITE;
/*!40000 ALTER TABLE `auth_activation_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_activation_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_groups`
--

DROP TABLE IF EXISTS `auth_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_groups`
--

LOCK TABLES `auth_groups` WRITE;
/*!40000 ALTER TABLE `auth_groups` DISABLE KEYS */;
INSERT INTO `auth_groups` VALUES (1,'admins','admin'),(2,'user','user');
/*!40000 ALTER TABLE `auth_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_groups_permissions`
--

DROP TABLE IF EXISTS `auth_groups_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_groups_permissions` (
  `group_id` int(11) unsigned NOT NULL DEFAULT 0,
  `permission_id` int(11) unsigned NOT NULL DEFAULT 0,
  KEY `auth_groups_permissions_permission_id_foreign` (`permission_id`),
  KEY `group_id_permission_id` (`group_id`,`permission_id`),
  CONSTRAINT `auth_groups_permissions_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `auth_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `auth_groups_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `auth_permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_groups_permissions`
--

LOCK TABLES `auth_groups_permissions` WRITE;
/*!40000 ALTER TABLE `auth_groups_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_groups_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_groups_users`
--

DROP TABLE IF EXISTS `auth_groups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_groups_users` (
  `group_id` int(11) unsigned NOT NULL DEFAULT 0,
  `user_id` int(11) unsigned NOT NULL DEFAULT 0,
  KEY `auth_groups_users_user_id_foreign` (`user_id`),
  KEY `group_id_user_id` (`group_id`,`user_id`),
  CONSTRAINT `auth_groups_users_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `auth_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `auth_groups_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_groups_users`
--

LOCK TABLES `auth_groups_users` WRITE;
/*!40000 ALTER TABLE `auth_groups_users` DISABLE KEYS */;
INSERT INTO `auth_groups_users` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `auth_groups_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_logins`
--

DROP TABLE IF EXISTS `auth_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_logins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `date` datetime NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=290 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_logins`
--

LOCK TABLES `auth_logins` WRITE;
/*!40000 ALTER TABLE `auth_logins` DISABLE KEYS */;
INSERT INTO `auth_logins` VALUES (1,'127.0.0.1','admin',NULL,'2021-03-06 04:18:16',0),(2,'127.0.0.1','torsten',NULL,'2021-03-06 04:30:47',0),(3,'127.0.0.1','admin',NULL,'2021-03-06 05:00:25',0),(4,'127.0.0.1','admin',1,'2021-03-06 05:07:05',0),(5,'127.0.0.1','tfaehr@freenet.de',2,'2021-03-06 05:07:20',1),(6,'127.0.0.1','tfaehr@gmx.de',1,'2021-03-06 05:15:44',1),(7,'127.0.0.1','tfaehr@freenet.de',2,'2021-03-06 05:18:32',1),(8,'127.0.0.1','tfaehr@gmx.de',1,'2021-03-06 05:19:18',1),(9,'127.0.0.1','tfaehr@gmx.de',1,'2021-03-06 09:55:18',1),(10,'127.0.0.1','tfaehr@gmx.de',1,'2021-03-07 03:55:25',1),(11,'127.0.0.1','tfaehr@freenet.de',2,'2021-03-07 03:58:05',1),(12,'127.0.0.1','tfaehr@gmx.de',1,'2021-03-07 04:44:21',1),(13,'127.0.0.1','tfaehr@freenet.de',2,'2021-03-07 04:51:57',1),(14,'127.0.0.1','tfaehr@gmx.de',1,'2021-03-07 05:02:13',1),(15,'127.0.0.1','tfaehr@gmx.de',1,'2021-03-07 05:16:49',1),(16,'127.0.0.1','tfaehr@freenet.de',2,'2021-03-07 10:46:41',1),(17,'127.0.0.1','torsten',NULL,'2021-03-07 10:49:52',0),(18,'127.0.0.1','tfaehr@freenet.de',2,'2021-03-07 10:50:04',1),(19,'127.0.0.1','tfaehr@gmx.de',1,'2021-03-07 10:50:38',1),(20,'127.0.0.1','tfaehr@freenet.de',2,'2021-03-07 10:54:26',1),(21,'127.0.0.1','tfaehr@gmx.de',1,'2021-03-07 11:25:56',1),(22,'127.0.0.1','tfaehr@gmx.de',1,'2021-03-09 12:41:17',1),(23,'127.0.0.1','torsten',NULL,'2021-03-14 11:12:27',0),(24,'127.0.0.1','tfaehr@freenet.de',2,'2021-03-14 11:12:34',1),(25,'127.0.0.1','tfaehr@freenet.de',2,'2021-03-15 13:26:25',1),(26,'127.0.0.1','tfaehr@freenet.de',2,'2021-03-16 13:27:07',1),(27,'127.0.0.1','tfaehr@freenet.de',2,'2021-03-20 06:16:40',1),(28,'127.0.0.1','tfaehr@freenet.de',2,'2021-03-25 13:43:17',1),(29,'127.0.0.1','tfaehr@freenet.de',2,'2021-03-30 20:26:58',1),(30,'127.0.0.1','tfaehr@freenet.de',2,'2021-03-31 11:24:40',1),(31,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-02 11:06:16',1),(32,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-02 19:17:17',1),(33,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-03 12:09:50',1),(34,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-03 17:43:50',1),(35,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-04 10:26:38',1),(36,'127.0.0.1','tfaehr@gmx.de',1,'2021-04-05 09:36:22',1),(37,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-05 15:12:33',1),(38,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-06 19:31:49',1),(39,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-07 16:47:03',1),(40,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-08 19:42:23',1),(41,'127.0.0.1','tfaehr@gmx.de',1,'2021-04-08 22:18:38',1),(42,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-09 16:02:46',1),(43,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-10 20:33:22',1),(44,'127.0.0.1','tfaehr@gmx.de',1,'2021-04-10 21:05:16',1),(45,'127.0.0.1','tfaehr@gmx.de',1,'2021-04-10 22:28:31',1),(46,'127.0.0.1','tfaehr@gmx.de',1,'2021-04-10 23:03:30',1),(47,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-11 09:37:40',1),(48,'127.0.0.1','tfaehr@gmx.de',1,'2021-04-11 12:29:15',1),(49,'127.0.0.1','tfaehr@gmx.de',1,'2021-04-11 12:40:23',1),(50,'127.0.0.1','torsten',NULL,'2021-04-11 12:53:46',0),(51,'127.0.0.1','tfaehr@gmx.de',1,'2021-04-11 12:53:58',1),(52,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-11 12:55:31',1),(53,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-11 16:18:20',1),(54,'127.0.0.1','tfaehr@gmx.de',1,'2021-04-11 16:41:57',1),(55,'127.0.0.1','tfaehr@gmx.de',1,'2021-04-11 16:48:17',1),(56,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-11 16:55:03',1),(57,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-12 08:27:53',1),(58,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-13 19:21:50',1),(59,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-15 17:28:30',1),(60,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-15 19:12:03',1),(61,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-16 17:02:06',1),(62,'127.0.0.1','tfaehr@gmx.de',1,'2021-04-16 17:11:50',1),(63,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-17 12:37:40',1),(64,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-17 17:35:38',1),(65,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-18 10:15:47',1),(66,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-18 17:28:22',1),(67,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-19 17:44:29',1),(68,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-22 19:17:10',1),(69,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-25 13:19:47',1),(70,'127.0.0.1','torsten',NULL,'2021-04-25 19:35:39',0),(71,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-25 19:35:47',1),(72,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-26 20:29:16',1),(73,'127.0.0.1','tfaehr@gmx.de',1,'2021-04-26 20:43:03',1),(74,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-27 18:16:55',1),(75,'127.0.0.1','tfaehr@freenet.de',2,'2021-04-28 21:13:04',1),(76,'127.0.0.1','torsten',NULL,'2021-05-01 12:16:39',0),(77,'127.0.0.1','torsten',NULL,'2021-05-01 12:16:47',0),(78,'127.0.0.1','tfaehr@gmx.de',1,'2021-05-01 12:16:57',1),(79,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-01 17:05:01',1),(80,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-02 10:33:17',1),(81,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-02 17:39:58',1),(82,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-03 19:17:28',1),(83,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-04 11:06:39',1),(84,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-04 17:33:28',1),(85,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-04 19:18:51',1),(86,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-08 12:56:10',1),(87,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-08 16:15:20',1),(88,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-09 10:21:09',1),(89,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-11 20:46:58',1),(90,'127.0.0.1','torsten',NULL,'2021-05-12 17:39:29',0),(91,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-12 17:39:37',1),(92,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-12 20:19:52',1),(93,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-13 11:47:44',1),(94,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-13 17:31:56',1),(95,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-14 16:25:44',1),(96,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-15 15:22:51',1),(97,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-17 08:02:12',1),(98,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-17 17:56:08',1),(99,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-20 19:24:53',1),(100,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-22 15:40:41',1),(101,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-22 19:05:09',1),(102,'127.0.0.1','tfaehr@gmx.de',1,'2021-05-22 19:07:08',1),(103,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-22 19:16:35',1),(104,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-22 19:43:30',1),(105,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-23 10:38:02',1),(106,'127.0.0.1','tfaehr@gmx.de',1,'2021-05-23 12:16:58',1),(107,'127.0.0.1','torsten',NULL,'2021-05-23 12:24:01',0),(108,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-23 12:24:17',1),(109,'127.0.0.1','tfaehr@gmx.de',1,'2021-05-23 12:31:29',1),(110,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-23 12:33:05',1),(111,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-23 12:35:14',1),(112,'127.0.0.1','tfaehr@gmx.de',1,'2021-05-23 12:38:26',1),(113,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-23 12:39:00',1),(114,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-23 19:20:08',1),(115,'127.0.0.1','tfaehr@gmx.de',1,'2021-05-23 19:23:26',1),(116,'127.0.0.1','torsten',NULL,'2021-05-23 19:23:46',0),(117,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-23 19:23:54',1),(118,'127.0.0.1','tfaehr@gmx.de',1,'2021-05-23 19:24:58',1),(119,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-23 19:25:48',1),(120,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-23 19:46:26',1),(121,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-26 19:53:07',1),(122,'127.0.0.1','tfaehr@gmx.de',1,'2021-05-26 19:53:24',1),(123,'127.0.0.1','tfaehr@gmx.de',1,'2021-05-28 09:38:42',1),(124,'127.0.0.1','tfaehr@gmx.de',1,'2021-05-29 12:08:36',1),(125,'127.0.0.1','torsten',NULL,'2021-05-29 12:19:36',0),(126,'127.0.0.1','tfaehr@freenet.de',2,'2021-05-29 12:19:46',1),(127,'127.0.0.1','tfaehr@gmx.de',1,'2021-05-29 14:39:24',1),(128,'127.0.0.1','tfaehr@gmx.de',1,'2021-05-30 11:56:45',1),(129,'127.0.0.1','tfaehr@gmx.de',1,'2021-05-30 17:47:56',1),(130,'127.0.0.1','tfaehr@gmx.de',1,'2021-05-31 08:23:50',1),(131,'127.0.0.1','tfaehr@gmx.de',1,'2021-06-03 18:32:31',1),(132,'127.0.0.1','tfaehr@gmx.de',1,'2021-06-04 20:23:50',1),(133,'127.0.0.1','tfaehr@freenet.de',2,'2021-06-04 20:28:05',1),(134,'127.0.0.1','tfaehr@gmx.de',1,'2021-06-05 17:52:48',1),(135,'2003:f0:8729:3800:d6f2:792c:f3a8:3e8','tfaehr@gmx.de',1,'2021-06-06 10:27:08',1),(136,'2003:f0:8729:3800:d6f2:792c:f3a8:3e8','tfaehr@freenet.de',2,'2021-06-06 10:28:54',1),(137,'127.0.0.1','tfaehr@gmx.de',1,'2021-06-06 10:39:05',1),(138,'127.0.0.1','tfaehr@gmx.de',1,'2021-06-06 10:40:00',1),(139,'192.168.221.53','tfaehr@freenet.de',2,'2021-06-06 10:45:58',1),(140,'127.0.0.1','tfaehr@gmx.de',1,'2021-06-20 13:25:55',1),(141,'127.0.0.1','tfaehr@gmx.de',1,'2021-06-21 10:03:30',1),(142,'127.0.0.1','tfaehr@freenet.de',2,'2021-06-21 10:04:42',1),(143,'127.0.0.1','tfaehr@gmx.de',1,'2021-06-21 11:12:03',1),(144,'192.168.221.53','tfaehr@freenet.de',2,'2021-06-21 12:35:50',1),(145,'127.0.0.1','tfaehr@freenet.de',2,'2021-06-23 11:10:49',1),(146,'127.0.0.1','tfaehr@gmx.de',1,'2021-06-23 11:13:43',1),(147,'127.0.0.1','tfaehr@gmx.de',1,'2021-06-23 11:14:47',1),(148,'192.168.221.53','tfaehr@gmx.de',1,'2021-06-23 11:34:11',1),(149,'127.0.0.1','tfaehr@gmx.de',1,'2021-06-23 11:35:26',1),(150,'127.0.0.1','torsten',NULL,'2021-06-23 11:39:00',0),(151,'127.0.0.1','tfaehr@freenet.de',2,'2021-06-23 11:39:10',1),(152,'127.0.0.1','tfaehr@gmx.de',1,'2021-06-23 19:33:40',1),(153,'127.0.0.1','tfaehr@gmx.de',1,'2021-06-24 09:39:59',1),(154,'127.0.0.1','tfaehr@gmx.de',1,'2021-06-24 17:16:35',1),(155,'127.0.0.1','tfaehr@gmx.de',1,'2021-06-25 09:52:21',1),(156,'127.0.0.1','tfaehr@gmx.de',1,'2021-06-27 10:38:19',1),(157,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-03 15:46:23',1),(158,'127.0.0.1','tfaehr@freenet.de',2,'2021-07-03 16:32:25',1),(159,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-04 10:14:44',1),(160,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-05 13:34:28',1),(161,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-08 20:25:57',1),(162,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-09 09:09:52',1),(163,'127.0.0.1','admin',NULL,'2021-07-09 18:07:16',0),(164,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-09 18:07:29',1),(165,'127.0.0.1','torsten',NULL,'2021-07-09 18:29:56',0),(166,'127.0.0.1','tfaehr@freenet.de',2,'2021-07-09 18:30:05',1),(167,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-10 17:28:21',1),(168,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-11 10:02:29',1),(169,'127.0.0.1','torsten',NULL,'2021-07-11 11:53:49',0),(170,'127.0.0.1','tfaehr@freenet.de',2,'2021-07-11 11:53:56',1),(171,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-11 18:15:45',1),(172,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-12 18:18:42',1),(173,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-13 19:26:01',1),(174,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-14 17:51:30',1),(175,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-14 19:26:28',1),(176,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-15 19:37:50',1),(177,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-16 09:23:04',1),(178,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-17 17:15:11',1),(179,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-18 10:29:59',1),(180,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-20 19:32:27',1),(181,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-21 19:42:03',1),(182,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-22 18:13:47',1),(183,'127.0.0.1','torsten',NULL,'2021-07-23 14:10:56',0),(184,'127.0.0.1','tfaehr@freenet.de',2,'2021-07-23 14:11:05',1),(185,'127.0.0.1','tfaehr@freenet.de',2,'2021-07-23 20:30:31',1),(186,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-24 18:25:32',1),(187,'127.0.0.1','tfaehr@gmx.de',1,'2021-07-25 10:06:13',1),(188,'127.0.0.1','torsten',NULL,'2021-07-30 08:55:30',0),(189,'127.0.0.1','tfaehr@freenet.de',2,'2021-07-30 08:55:39',1),(190,'127.0.0.1','tfaehr@freenet.de',2,'2021-08-01 12:44:34',1),(191,'127.0.0.1','tfaehr@gmx.de',1,'2021-08-01 17:42:12',1),(192,'127.0.0.1','tfaehr@gmx.de',1,'2021-08-04 19:39:28',1),(193,'127.0.0.1','tfaehr@freenet.de',2,'2021-08-10 21:07:30',1),(194,'127.0.0.1','tfaehr@gmx.de',1,'2021-08-15 11:36:11',1),(195,'127.0.0.1','tfaehr@gmx.de',1,'2021-08-18 18:03:27',1),(196,'127.0.0.1','torsten',NULL,'2021-08-18 18:16:02',0),(197,'127.0.0.1','tfaehr@freenet.de',2,'2021-08-18 18:16:10',1),(198,'127.0.0.1','tfaehr@gmx.de',1,'2021-08-21 17:06:40',1),(199,'127.0.0.1','tfaehr@gmx.de',1,'2021-08-21 20:26:34',1),(200,'127.0.0.1','tfaehr@gmx.de',1,'2021-08-22 10:39:40',1),(201,'127.0.0.1','tfaehr@gmx.de',1,'2021-08-25 19:27:40',1),(202,'127.0.0.1','admin',NULL,'2021-08-28 14:40:34',0),(203,'127.0.0.1','tfaehr@gmx.de',1,'2021-08-28 14:40:43',1),(204,'127.0.0.1','tfaehr@gmx.de',1,'2021-08-28 17:13:55',1),(205,'127.0.0.1','tfaehr@gmx.de',1,'2021-08-29 10:57:35',1),(206,'127.0.0.1','tfaehr@gmx.de',1,'2021-08-29 18:22:32',1),(207,'127.0.0.1','tfaehr@gmx.de',1,'2021-08-30 20:17:35',1),(208,'127.0.0.1','tfaehr@gmx.de',1,'2021-08-30 20:37:17',1),(209,'127.0.0.1','tfaehr@gmx.de',1,'2021-09-01 20:18:02',1),(210,'127.0.0.1','admin',NULL,'2021-09-05 12:52:31',0),(211,'127.0.0.1','tfaehr@gmx.de',1,'2021-09-05 12:52:40',1),(212,'127.0.0.1','tfaehr@gmx.de',1,'2021-09-10 18:01:09',1),(213,'127.0.0.1','Faehrmann',NULL,'2021-09-11 17:19:32',0),(214,'127.0.0.1','tfaehr@gmx.de',1,'2021-09-11 17:19:41',1),(215,'127.0.0.1','tfaehr@freenet.de',2,'2021-09-11 17:31:13',1),(216,'127.0.0.1','tfaehr@gmx.de',1,'2021-09-11 20:43:25',1),(217,'127.0.0.1','tfaehr@freenet.de',2,'2021-09-11 21:42:55',1),(218,'127.0.0.1','tfaehr@gmx.de',1,'2021-09-12 10:39:32',1),(219,'127.0.0.1','tfaehr@freenet.de',2,'2021-09-12 11:59:22',1),(220,'127.0.0.1','tfaehr@gmx.de',1,'2021-09-12 18:17:24',1),(221,'127.0.0.1','tfaehr@freenet.de',2,'2021-09-12 18:18:39',1),(222,'127.0.0.1','tfaehr@freenet.de',2,'2021-09-16 17:57:31',1),(223,'127.0.0.1','tfaehr@freenet.de',2,'2021-09-17 18:27:21',1),(224,'127.0.0.1','tfaehr@gmx.de',1,'2021-09-20 09:58:27',1),(225,'127.0.0.1','tfaehr@freenet.de',2,'2021-09-20 10:18:17',1),(226,'127.0.0.1','tfaehr@freenet.de',2,'2021-09-20 10:21:58',1),(227,'127.0.0.1','tfaehr@freenet.de',2,'2021-09-20 10:42:49',1),(228,'127.0.0.1','tfaehr@gmx.de',1,'2021-09-20 10:52:12',1),(229,'127.0.0.1','tfaehr@freenet.de',2,'2021-09-20 10:52:34',1),(230,'127.0.0.1','tfaehr@freenet.de',2,'2021-09-20 10:54:30',1),(231,'127.0.0.1','tfaehr@freenet.de',2,'2021-09-20 11:28:29',1),(232,'127.0.0.1','tfaehr@gmx.de',1,'2021-09-20 11:29:27',1),(233,'127.0.0.1','tfaehr@gmx.de',1,'2021-09-20 11:34:56',1),(234,'127.0.0.1','tfaehr@gmx.de',1,'2021-09-26 17:39:06',1),(235,'127.0.0.1','tfaehr@gmx.de',1,'2021-09-26 17:40:05',1),(236,'127.0.0.1','tfaehr@freenet.de',2,'2021-09-27 17:28:01',1),(237,'127.0.0.1','tfaehr@gmx.de',1,'2021-09-27 17:45:48',1),(238,'127.0.0.1','tfaehr@gmx.de',1,'2021-10-04 17:23:11',1),(239,'127.0.0.1','tfaehr@gmx.de',1,'2021-10-05 18:01:11',1),(240,'127.0.0.1','tfaehr@gmx.de',1,'2021-10-06 20:20:41',1),(241,'127.0.0.1','tfaehr@gmx.de',1,'2021-10-06 20:42:36',1),(242,'127.0.0.1','tfaehr@gmx.de',1,'2021-10-09 17:37:44',1),(243,'127.0.0.1','tfaehr@gmx.de',1,'2021-10-10 17:41:06',1),(244,'127.0.0.1','tfaehr@freenet.de',2,'2021-10-10 19:35:58',1),(245,'127.0.0.1','tfaehr@gmx.de',1,'2021-10-13 20:24:42',1),(246,'127.0.0.1','admin',NULL,'2021-10-16 18:21:55',0),(247,'127.0.0.1','tfaehr@gmx.de',1,'2021-10-16 18:22:03',1),(248,'127.0.0.1','tfaehr@gmx.de',1,'2021-10-17 11:09:35',1),(249,'127.0.0.1','tfaehr@gmx.de',1,'2021-10-17 11:28:04',1),(250,'127.0.0.1','tfaehr@gmx.de',1,'2021-10-17 19:07:45',1),(251,'127.0.0.1','tfaehr@gmx.de',1,'2021-10-24 12:49:08',1),(252,'127.0.0.1','tfaehr@gmx.de',1,'2021-10-24 18:42:35',1),(253,'127.0.0.1','tfaehr@gmx.de',1,'2021-10-30 17:12:17',1),(254,'127.0.0.1','tfaehr@gmx.de',1,'2021-10-31 10:35:42',1),(255,'127.0.0.1','tfaehr@gmx.de',1,'2021-10-31 17:35:53',1),(256,'127.0.0.1','tfaehr@gmx.de',1,'2021-11-01 09:55:01',1),(257,'127.0.0.1','tfaehr@gmx.de',1,'2021-11-01 18:37:04',1),(258,'127.0.0.1','tfaehr@gmx.de',1,'2021-11-07 17:56:31',1),(259,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-07 18:13:19',1),(260,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-13 17:50:12',1),(261,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-13 18:03:44',1),(262,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-13 18:07:10',1),(263,'127.0.0.1','torsten',NULL,'2021-11-13 18:09:35',0),(264,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-13 18:09:51',1),(265,'127.0.0.1','tfaehr@gmx.de',1,'2021-11-13 18:19:06',1),(266,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-13 19:23:47',1),(267,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-13 19:32:15',1),(268,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-13 19:43:39',1),(269,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-14 11:45:49',1),(270,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-14 12:30:05',1),(271,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-14 12:32:39',1),(272,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-14 12:35:37',1),(273,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-14 12:36:46',1),(274,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-14 12:37:19',1),(275,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-14 12:39:11',1),(276,'127.0.0.1','torsten',NULL,'2021-11-14 12:41:09',0),(277,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-14 12:41:18',1),(278,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-14 12:45:54',1),(279,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-14 13:06:17',1),(280,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-14 17:45:11',1),(281,'127.0.0.1','torsten',NULL,'2021-11-20 17:17:57',0),(282,'127.0.0.1','torsten',NULL,'2021-11-20 17:18:05',0),(283,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-20 17:18:31',1),(284,'127.0.0.1','tfaehr@gmx.de',1,'2021-11-20 17:27:40',1),(285,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-20 17:31:34',1),(286,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-20 17:32:29',1),(287,'127.0.0.1','tfaehr@freenet.de',2,'2021-11-20 17:38:28',1),(288,'127.0.0.1','tfaehr@gmx.de',1,'2021-11-28 12:29:58',1),(289,'127.0.0.1','tfaehr@gmx.de',1,'2021-11-28 12:49:49',1);
/*!40000 ALTER TABLE `auth_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permissions`
--

DROP TABLE IF EXISTS `auth_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permissions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permissions`
--

LOCK TABLES `auth_permissions` WRITE;
/*!40000 ALTER TABLE `auth_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_reset_attempts`
--

DROP TABLE IF EXISTS `auth_reset_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_reset_attempts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `ip_address` varchar(255) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_reset_attempts`
--

LOCK TABLES `auth_reset_attempts` WRITE;
/*!40000 ALTER TABLE `auth_reset_attempts` DISABLE KEYS */;
INSERT INTO `auth_reset_attempts` VALUES (1,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','$2y$10$X51po.zKnqLz.MCMmiCCKOCzl6kFHvsh9DcCBrJ1/6ZxglRfzCeGC','2021-11-07 18:40:10'),(2,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','$2y$10$X51po.zKnqLz.MCMmiCCKOCzl6kFHvsh9DcCBrJ1/6ZxglRfzCeGC','2021-11-07 18:40:53'),(3,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','$2y$10$X51po.zKnqLz.MCMmiCCKOCzl6kFHvsh9DcCBrJ1/6ZxglRfzCeGC','2021-11-07 18:41:21'),(4,'tfaehr@gmx.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','$2y$10$X51po.zKnqLz.MCMmiCCKOCzl6kFHvsh9DcCBrJ1/6ZxglRfzCeGC','2021-11-07 18:42:01'),(5,'tfaehr@gmx.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','08fc2b8e4778dade0777af8455769437','2021-11-07 19:11:16'),(6,'tfaehr@gmx.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','08fc2b8e4778dade0777af8455769437','2021-11-07 19:12:20'),(7,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','08fc2b8e4778dade0777af8455769437','2021-11-07 19:12:58'),(8,'','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','08fc2b8e4778dade0777af8455769437','2021-11-07 19:13:39'),(9,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','b048a2739ae4025b7f3881a2b51300cc','2021-11-13 17:54:26'),(10,'tfaehr@freeet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','5c217e326852d2c0f5fd48497b2cc013','2021-11-13 18:04:36'),(11,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64; rv:94.0) Gecko/20100101 Firefox/94.0','5c217e326852d2c0f5fd48497b2cc013','2021-11-13 18:07:57'),(12,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64; rv:94.0) Gecko/20100101 Firefox/94.0','b048a2739ae4025b7f3881a2b51300cc	','2021-11-13 19:25:50'),(13,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','b048a2739ae4025b7f3881a2b51300cc	','2021-11-13 19:33:40'),(14,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','','2021-11-14 12:40:51'),(15,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','08fc2b8e4778dade0777af8455769437','2021-11-14 12:42:35'),(16,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','QgrgvVOxRNz326zT9to6hP7Nhdlqta9JDLyS56','2021-11-20 17:19:09'),(17,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','QgrgvVOxRNz326zT9to6hP7Nhdlqta9JDLyS56','2021-11-20 17:26:33'),(18,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','lajsdsaldjaklsdj','2021-11-20 17:34:08'),(19,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','lajsdsaldjaklsdj','2021-11-20 17:39:09'),(20,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','lajsdsaldjaklsdj','2021-11-20 17:39:26'),(21,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','lajsdsaldjaklsdj','2021-11-20 17:39:42'),(22,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','lajsdsaldjaklsdj','2021-11-20 17:40:47'),(23,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','lajsdsaldjaklsdj','2021-11-20 17:42:28'),(24,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','lajsdsaldjaklsdj','2021-11-20 17:49:04'),(25,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','lajsdsaldjaklsdj','2021-11-20 17:51:26'),(26,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','lajsdsaldjaklsdj','2021-11-20 17:52:54'),(27,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','lajsdsaldjaklsdj','2021-11-20 17:58:23'),(28,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','$2y$10$Iq6X/aqCT1FyQKPhwdVcTuV2kxNS9C5z8jl2l9S5388j5k1N7qOpG','2021-11-20 17:59:06'),(29,'tfaehr@freenet.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36','$2y$10$QxWaDKrni.nHwqbdz11vue6yITdIsnO8cFbrp9mn9ZwZrXWBnWd6q','2021-11-20 17:59:56'),(30,'tfaehr@gmx.de','127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36','$2y$10$gUvYzau.vND8z/8eybupKeyvfOtPkaov1g9dZwdk9GLYVnvATC8C6','2021-11-28 12:32:48');
/*!40000 ALTER TABLE `auth_reset_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_tokens`
--

DROP TABLE IF EXISTS `auth_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_tokens` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `selector` varchar(255) NOT NULL,
  `hashedValidator` varchar(255) NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `expires` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_tokens_user_id_foreign` (`user_id`),
  KEY `selector` (`selector`),
  CONSTRAINT `auth_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_tokens`
--

LOCK TABLES `auth_tokens` WRITE;
/*!40000 ALTER TABLE `auth_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_users_permissions`
--

DROP TABLE IF EXISTS `auth_users_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_users_permissions` (
  `user_id` int(11) unsigned NOT NULL DEFAULT 0,
  `permission_id` int(11) unsigned NOT NULL DEFAULT 0,
  KEY `auth_users_permissions_permission_id_foreign` (`permission_id`),
  KEY `user_id_permission_id` (`user_id`,`permission_id`),
  CONSTRAINT `auth_users_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `auth_permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `auth_users_permissions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_users_permissions`
--

LOCK TABLES `auth_users_permissions` WRITE;
/*!40000 ALTER TABLE `auth_users_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_users_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `version` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `batch` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2017-11-20-223112','Myth\\Auth\\Database\\Migrations\\CreateAuthTables','default','Myth\\Auth',1613326362,1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_options`
--

DROP TABLE IF EXISTS `notification_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `noption_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `noption` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_options`
--

LOCK TABLES `notification_options` WRITE;
/*!40000 ALTER TABLE `notification_options` DISABLE KEYS */;
INSERT INTO `notification_options` VALUES (1,'Critical','c'),(2,'Unknown','u'),(3,'Recovery','r'),(4,'Warning','w'),(6,'None','n');
/*!40000 ALTER TABLE `notification_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `reset_hash` varchar(255) DEFAULT NULL,
  `reset_at` datetime DEFAULT NULL,
  `reset_expires` datetime DEFAULT NULL,
  `activate_hash` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `status_message` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `force_pass_reset` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'tfaehr@gmx.de','admin','$2y$10$aQOy8jPNYsy4LbuQKUtiqOfFVEcAWrA3Qrz1R1PuJnF8g18.OI5OS',NULL,'2021-11-28 12:32:49',NULL,'08fc2b8e4778dade0777af8455769437',NULL,NULL,1,0,'2021-03-06 05:00:50','2021-11-28 12:32:49',NULL),(2,'tfaehr@freenet.de','Torsten','$2y$10$rKVNfi1NoPD5gwzjyUggnuQwRioAfm9p97MFm1v8Nj6.wwXml4Y4y',NULL,'2021-11-20 17:59:56',NULL,'QgrgvVOxRNz326zT9to6hP7Nhdlqta9JDLyS56',NULL,NULL,1,0,'2021-03-06 05:05:36','2021-11-20 17:59:56',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `V_Host1`
--

/*!50001 DROP TABLE IF EXISTS `V_Host1`*/;
/*!50001 DROP VIEW IF EXISTS `V_Host1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`torsten`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `V_Host1` AS select `nagios`.`Host`.`host_name` AS `Hostname`,`nagios`.`Host`.`alias` AS `Alias`,`nagios`.`Host`.`address` AS `IP Adresse`,`nagios`.`Host`.`contact_groups` AS `Kontakt` from `nagios`.`Host` order by `nagios`.`Host`.`host_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-28 13:14:21
