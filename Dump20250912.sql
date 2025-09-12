CREATE DATABASE  IF NOT EXISTS `network_monitoring` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `network_monitoring`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: network_monitoring
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `outage_id` bigint unsigned DEFAULT NULL,
  `alert_time` datetime(6) NOT NULL,
  `channel` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `severity` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acknowledged_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ack_time` datetime(6) DEFAULT NULL,
  `status` enum('sent','ack','resolved') COLLATE utf8mb4_unicode_ci DEFAULT 'sent',
  PRIMARY KEY (`id`),
  KEY `outage_id` (`outage_id`),
  CONSTRAINT `alerts_ibfk_1` FOREIGN KEY (`outage_id`) REFERENCES `outages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
INSERT INTO `alerts` VALUES (1,1,'2025-09-12 12:00:25.000000','email','major','Admin1','2025-09-12 12:01:25.000000','ack'),(2,2,'2025-09-12 12:15:25.000000','slack','critical',NULL,NULL,'sent'),(3,3,'2025-09-12 11:30:25.000000','email','minor','Admin2','2025-09-12 11:31:25.000000','resolved');
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devices` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int unsigned NOT NULL,
  `device_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `device_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vendor` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  CONSTRAINT `devices_ibfk_1` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
INSERT INTO `devices` VALUES (1,1,'core-router-1','10.0.0.1','Router','Cisco','ISR4451',1,'2025-09-12 12:17:53'),(2,1,'edge-switch-1','10.0.0.2','Switch','Cisco','Catalyst 9300',1,'2025-09-12 12:17:53'),(3,2,'core-router-2','10.0.1.1','Router','Juniper','MX480',1,'2025-09-12 12:17:53'),(4,2,'edge-switch-2','10.0.1.2','Switch','Juniper','EX4300',1,'2025-09-12 12:17:53');
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interfaces`
--

DROP TABLE IF EXISTS `interfaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interfaces` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int unsigned NOT NULL,
  `if_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `if_index` int DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_status` enum('up','down') COLLATE utf8mb4_unicode_ci DEFAULT 'up',
  `oper_status` enum('up','down') COLLATE utf8mb4_unicode_ci DEFAULT 'up',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `interfaces_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interfaces`
--

LOCK TABLES `interfaces` WRITE;
/*!40000 ALTER TABLE `interfaces` DISABLE KEYS */;
INSERT INTO `interfaces` VALUES (1,1,'Gig0/0',1,'10.0.0.1','up','up','2025-09-12 12:20:17'),(2,1,'Gig0/1',2,'10.0.0.3','up','up','2025-09-12 12:20:17'),(3,2,'Gig1/0',1,'10.0.0.2','up','up','2025-09-12 12:20:17'),(4,3,'ge-0/0/0',1,'10.0.1.1','up','up','2025-09-12 12:20:17'),(5,4,'ge-0/0/1',1,'10.0.1.2','up','up','2025-09-12 12:20:17');
/*!40000 ALTER TABLE `interfaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_windows`
--

DROP TABLE IF EXISTS `maintenance_windows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance_windows` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int unsigned DEFAULT NULL,
  `device_id` int unsigned DEFAULT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `maintenance_windows_ibfk_1` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`) ON DELETE CASCADE,
  CONSTRAINT `maintenance_windows_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_windows`
--

LOCK TABLES `maintenance_windows` WRITE;
/*!40000 ALTER TABLE `maintenance_windows` DISABLE KEYS */;
INSERT INTO `maintenance_windows` VALUES (1,1,NULL,'2025-09-12 10:27:19.000000','2025-09-12 11:27:19.000000','Network upgrade','Admin1','2025-09-12 12:27:19'),(2,NULL,2,'2025-09-12 09:27:19.000000','2025-09-12 10:27:19.000000','Switch firmware update','Admin2','2025-09-12 12:27:19');
/*!40000 ALTER TABLE `maintenance_windows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics`
--

DROP TABLE IF EXISTS `metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metrics` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int unsigned NOT NULL,
  `interface_id` int unsigned DEFAULT NULL,
  `metric_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `metric_value` double DEFAULT NULL,
  `tags` json DEFAULT NULL,
  `check_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`,`check_time`),
  KEY `idx_device_time` (`device_id`,`check_time`),
  KEY `idx_metric_time` (`metric_name`,`check_time`),
  CONSTRAINT `metrics_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics`
--

LOCK TABLES `metrics` WRITE;
/*!40000 ALTER TABLE `metrics` DISABLE KEYS */;
INSERT INTO `metrics` VALUES (1,1,1,'ping_rtt_ms',2.5,NULL,'2025-09-12 12:22:03.000000'),(2,1,2,'ping_rtt_ms',3.1,NULL,'2025-09-12 12:22:03.000000'),(3,2,3,'ping_rtt_ms',1.8,NULL,'2025-09-12 12:22:03.000000'),(4,3,4,'ping_rtt_ms',2.2,NULL,'2025-09-12 12:22:03.000000'),(5,4,5,'ping_rtt_ms',2.9,NULL,'2025-09-12 12:22:03.000000'),(6,1,1,'packet_loss',0,NULL,'2025-09-12 12:22:03.000000'),(7,2,3,'packet_loss',0.2,NULL,'2025-09-12 12:22:03.000000');
/*!40000 ALTER TABLE `metrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outages`
--

DROP TABLE IF EXISTS `outages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `outages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int unsigned NOT NULL,
  `interface_id` int unsigned DEFAULT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  `severity` enum('critical','major','minor','info') COLLATE utf8mb4_unicode_ci DEFAULT 'major',
  `status` enum('open','acknowledged','closed') COLLATE utf8mb4_unicode_ci DEFAULT 'open',
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ticket_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_device_start` (`device_id`,`start_time`),
  KEY `idx_status` (`status`),
  CONSTRAINT `outages_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outages`
--

LOCK TABLES `outages` WRITE;
/*!40000 ALTER TABLE `outages` DISABLE KEYS */;
INSERT INTO `outages` VALUES (1,1,1,'2025-09-12 11:53:49.000000','2025-09-12 12:03:49.000000','major','closed','Link flapped due to maintenance','TCKT001','2025-09-12 12:23:49','2025-09-12 12:23:49'),(2,2,3,'2025-09-12 12:08:49.000000',NULL,'critical','open','Router unreachable','TCKT002','2025-09-12 12:23:49','2025-09-12 12:23:49'),(3,4,5,'2025-09-12 11:23:49.000000','2025-09-12 11:33:49.000000','minor','closed','Temporary packet loss','TCKT003','2025-09-12 12:23:49','2025-09-12 12:23:49');
/*!40000 ALTER TABLE `outages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sites` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `region` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
INSERT INTO `sites` VALUES (1,'DC Chennai','South-India','Main data center in Chennai','2025-09-12 12:16:08'),(2,'DC Hyderabad','South-India','Backup data center in Hyderabad','2025-09-12 12:16:08');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-12 18:44:31
