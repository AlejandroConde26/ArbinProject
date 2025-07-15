-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_bookingsystem
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
-- Table structure for table `activity_log`
--

DROP TABLE IF EXISTS `activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_log` (
  `ACTIVITY_LOG_ID` int NOT NULL AUTO_INCREMENT,
  `ACTION` varchar(255) DEFAULT NULL,
  `IP_ADRESS` varchar(255) DEFAULT NULL,
  `TIMESTAMP` datetime DEFAULT NULL,
  `USER_AGENT` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`ACTIVITY_LOG_ID`),
  KEY `FK_ACTIVITY_LOG_user_id` (`user_id`),
  CONSTRAINT `FK_ACTIVITY_LOG_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID_USERS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_log`
--

LOCK TABLES `activity_log` WRITE;
/*!40000 ALTER TABLE `activity_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `ID_ADDRESS` int NOT NULL AUTO_INCREMENT,
  `ADDRESS_POSTAL` varchar(255) DEFAULT NULL,
  `APARTMENT_N` varchar(255) DEFAULT NULL,
  `CIUDAD` varchar(255) DEFAULT NULL,
  `CODE_POSTAL` varchar(255) DEFAULT NULL,
  `COUNTRY` varchar(255) DEFAULT NULL,
  `DEPARTAMENT` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID_ADDRESS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon`
--

DROP TABLE IF EXISTS `coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) DEFAULT '0',
  `code` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `discount_type` varchar(20) DEFAULT NULL,
  `discount_value` decimal(10,2) DEFAULT NULL,
  `min_stay_nights` int DEFAULT NULL,
  `usage_limit_per_coupon` int DEFAULT NULL,
  `usage_limit_per_user` int DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon`
--

LOCK TABLES `coupon` WRITE;
/*!40000 ALTER TABLE `coupon` DISABLE KEYS */;
INSERT INTO `coupon` VALUES (4,1,'NUEVO11','Descuento actualizado del 10%','Porcentaje',10.00,2,100,5,'2025-06-11','2025-07-17'),(5,1,'sd','ds','Porcentaje',2.00,12,1,1,'2025-06-06','2025-07-02'),(7,1,'NUEV','2','Porcentaje',22.00,2,4,4,'2025-06-13','2025-06-14');
/*!40000 ALTER TABLE `coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_type`
--

DROP TABLE IF EXISTS `document_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_type` (
  `DOCUMENT_TYPE` int NOT NULL AUTO_INCREMENT,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DOCUMENT_TYPE`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_type`
--

LOCK TABLES `document_type` WRITE;
/*!40000 ALTER TABLE `document_type` DISABLE KEYS */;
INSERT INTO `document_type` VALUES (1,'Documento Nacional de Identidad','DNI'),(2,'Carné de Extranjería','CE'),(3,'Pasaporte','PAS');
/*!40000 ALTER TABLE `document_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `furniture`
--

DROP TABLE IF EXISTS `furniture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `furniture` (
  `id_furniture` int NOT NULL AUTO_INCREMENT,
  `CREATEDDATE` date NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `furniture_type` varchar(255) NOT NULL,
  `quantity` int NOT NULL,
  `UPDATEDDATE` date DEFAULT NULL,
  `id_housing` int NOT NULL,
  PRIMARY KEY (`id_furniture`),
  KEY `FK_furniture_id_housing` (`id_housing`),
  CONSTRAINT `FK_furniture_id_housing` FOREIGN KEY (`id_housing`) REFERENCES `housing` (`HOUSINGID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `furniture`
--

LOCK TABLES `furniture` WRITE;
/*!40000 ALTER TABLE `furniture` DISABLE KEYS */;
/*!40000 ALTER TABLE `furniture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host`
--

DROP TABLE IF EXISTS `host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `host` (
  `ID_HOST` int NOT NULL AUTO_INCREMENT,
  `CREATEDDATE` date NOT NULL,
  `UPDATEDDATE` date DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`ID_HOST`),
  KEY `FK_HOST_user_id` (`user_id`),
  CONSTRAINT `FK_HOST_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID_USERS`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host`
--

LOCK TABLES `host` WRITE;
/*!40000 ALTER TABLE `host` DISABLE KEYS */;
INSERT INTO `host` VALUES (1,'2024-01-01','2025-01-01',2),(2,'2024-03-10','2025-03-10',3),(3,'2024-05-01','2025-05-01',4),(4,'2024-06-01','2025-06-01',5),(5,'2024-07-20','2025-07-20',6),(6,'2024-09-05','2025-09-05',7),(7,'2024-11-10','2025-11-10',8);
/*!40000 ALTER TABLE `host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `housing`
--

DROP TABLE IF EXISTS `housing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `housing` (
  `HOUSINGID` int NOT NULL AUTO_INCREMENT,
  `ADDRESS` varchar(255) NOT NULL,
  `CHARACTERISTICS` varchar(255) DEFAULT NULL,
  `CITY` varchar(255) NOT NULL,
  `COMMERCIALNAME` varchar(255) NOT NULL,
  `COUNTRY` varchar(255) DEFAULT NULL,
  `CREATEDDATE` date NOT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `LATITUDE` varchar(255) DEFAULT NULL,
  `LONGITUDE` varchar(255) DEFAULT NULL,
  `NUMHABITACIONES` int DEFAULT NULL,
  `NUM_ROOM` int DEFAULT NULL,
  `PRICENIGHT` float DEFAULT NULL,
  `STARS` int DEFAULT NULL,
  `STATUS` varchar(255) DEFAULT NULL,
  `UPDATEDDATE` date DEFAULT NULL,
  `host_id` int NOT NULL,
  `id_housingcategory` int NOT NULL,
  PRIMARY KEY (`HOUSINGID`),
  KEY `FK_HOUSING_id_housingcategory` (`id_housingcategory`),
  KEY `FK_HOUSING_host_id` (`host_id`),
  CONSTRAINT `FK_HOUSING_host_id` FOREIGN KEY (`host_id`) REFERENCES `host` (`ID_HOST`),
  CONSTRAINT `FK_HOUSING_id_housingcategory` FOREIGN KEY (`id_housingcategory`) REFERENCES `housingcategory` (`CATEGORYID`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `housing`
--

LOCK TABLES `housing` WRITE;
/*!40000 ALTER TABLE `housing` DISABLE KEYS */;
INSERT INTO `housing` VALUES (1,'123 Ocean Drive','Sea view, Pool','Miami','Ocean Breeze Villa','USA','2023-06-15','Luxury villa by the beach','25.7617','-80.1918',3,2,320,5,'Available','2025-06-19',1,3),(2,'45 Rue de Rivoli','Balcony, WiFi','Paris','Eiffel Nest','France','2023-05-11','Cozy apartment near the Eiffel Tower','48.8566','2.3522',2,1,150,4,'Available','2024-03-12',2,2),(3,'87 Queen St','Central location, Heating','London','Royal Stay','UK','2023-07-10','Modern flat in city center','51.5074','-0.1278',1,1,180,4,'Available','2024-01-15',3,2),(4,'500 Yonge St','High-rise, Gym access','Toronto','Maple Heights','Canada','2023-08-05','Skyline views from 25th floor','43.6532','-79.3832',2,2,220,5,'Available','2024-01-30',4,1),(5,'2 Chiyoda','Traditional, Zen garden','Tokyo','Sakura Inn','Japan','2023-04-20','Peaceful retreat near the Imperial Palace','35.6895','139.6917',2,1,160,5,'Available','2024-03-28',5,3),(6,'Calle 60, Centro','Colonial, A/C','Mérida','Casa Colonial','Mexico','2023-09-01','Historical colonial house','20.9674','-89.5926',3,2,130,4,'Available','2024-02-22',6,1),(7,'Alexanderplatz 5','Modern, Elevator','Berlin','CityLight Apartments','Germany','2023-03-10','Comfortable stay near Alexanderplatz','52.5200','13.4050',2,1,140,3,'Available','2024-04-12',7,2),(8,'Via del Corso 12','Historic, Rooftop access','Rome','Roma Bella','Italy','2023-06-22','Penthouse with historic views','41.9028','12.4964',2,1,200,5,'Available','2024-03-18',1,3),(9,'100 Collins St','Luxury, Concierge','Melbourne','City Luxe','Australia','2023-05-30','Business & luxury combined','-37.8136','144.9631',2,1,250,5,'Available','2024-01-27',2,1),(10,'Rua Augusta 1200','Lively area, WiFi','Lisbon','Lisboa Central','Portugal','2023-07-04','Heart of nightlife and culture','38.7223','-9.1393',1,1,100,3,'Available','2024-04-10',3,2),(11,'Av. Paulista 1000','Urban, AC, WiFi','São Paulo','Paulista Loft','Brazil','2023-05-02','Trendy loft with modern amenities','-23.5505','-46.6333',1,1,110,4,'Available','2024-01-01',4,2),(12,'Nevsky Prospekt 42','Central, Heating','St. Petersburg','Tsar Stay','Russia','2023-10-01','Elegant apartment in historical zone','59.9343','30.3351',2,1,140,5,'Available','2024-02-10',5,3),(13,'Zhongshan Rd 88','River view, AC','Shanghai','Bund View Flat','China','2023-04-05','Apartment facing the Bund','31.2304','121.4737',2,2,180,4,'Available','2024-01-22',6,1),(14,'5th Avenue 742','Luxury, Central Park view','New York','Empire View','USA','2023-06-10','Luxury condo near Central Park','40.7128','-74.0060',3,2,450,5,'Available','2024-03-10',7,1),(15,'Gran Vía 45','City center, Balcony','Madrid','Sol Suites','Spain','2023-09-12','Steps from Puerta del Sol','40.4168','-3.7038',1,1,130,4,'Available','2024-04-03',1,2),(16,'Bandra West 21','Coastal, WiFi','Mumbai','Arabian Breeze','India','2023-07-16','View of Arabian Sea','19.0760','72.8777',2,2,170,4,'Available','2024-02-18',2,3),(17,'Dorsoduro 310','Canal view, Historic','Venice','Venetian Pearl','Italy','2023-08-20','Peaceful home on the canal','45.4408','12.3155',2,1,210,5,'Available','2024-01-10',3,3),(18,'George St 55','Harbor view, WiFi','Sydney','Harbor Bliss','Australia','2023-05-25','Apartment near Opera House','-33.8688','151.2093',2,2,230,4,'Available','2024-03-01',4,1),(19,'Váci utca 33','Historic center, Heating','Budapest','Danube Dream','Hungary','2023-06-02','Close to Danube River','47.4979','19.0402',1,1,120,3,'Available','2024-03-11',5,2),(20,'Norr Mälarstrand 100','Lake view, Sauna','Stockholm','Nordic Retreat','Sweden','2023-07-25','Scandinavian minimalist comfort','59.3293','18.0686',2,1,190,5,'Available','2024-04-05',6,3),(21,'Calle Alcazaba 10','Terrace, WiFi','Granada','Alhambra View','Spain','2023-04-20','View of the Alhambra fortress','37.1773','-3.5986',2,1,140,4,'Available','2024-02-25',7,2),(22,'Syntagma Sq 7','Central, Historical','Athens','Acropolis Home','Greece','2023-05-10','Near Acropolis Museum','37.9838','23.7275',1,1,110,4,'Available','2024-03-17',1,2),(23,'Sultanahmet Cd. 23','Mosque view, Tea station','Istanbul','Ottoman Corner','Turkey','2023-06-18','Steps from Blue Mosque','41.0082','28.9784',2,1,150,4,'Available','2024-02-10',2,3),(24,'Corniche 99','Sea view, Balcony','Doha','Pearl Residence','Qatar','2023-08-05','Luxury facing the Persian Gulf','25.276987','51.520008',3,2,300,5,'Available','2024-03-03',3,1),(25,'Times City 88','Modern, Pool','Hanoi','Lotus Stay','Vietnam','2023-09-12','Next to Vincom Mega Mall','21.0278','105.8342',2,2,120,4,'Available','2024-02-14',4,2),(26,'Avenida Escazú 45','Mountain view','San José','Tico Paradise','Costa Rica','2023-10-01','Eco-lodge with view of volcanoes','9.7489','-83.7534',3,2,140,4,'Available','2024-01-11',5,3),(27,'R. Augusta 500','Modern, WiFi','Lisbon','Bairro Alto Studio','Portugal','2023-08-14','Trendy apartment in nightlife district','38.7169','-9.1399',1,1,110,3,'Available','2024-01-17',6,2),(28,'Jalan Uluwatu 88','Beach access, Pool','Bali','Uluwatu Escape','Indonesia','2023-07-02','Private villa near beach','-8.4095','115.1889',2,2,200,5,'Available','2024-02-28',7,1),(29,'Calle Perú 123','Vintage, Central','Buenos Aires','Recoleta Flat','Argentina','2023-06-19','Charming apartment in historic zone','-34.6037','-58.3816',2,1,130,4,'Available','2024-03-09',1,3),(30,'Khaosan Rd 12','Backpacker friendly','Bangkok','Khaosan Capsule','Thailand','2023-05-27','Budget-friendly capsule stay','13.7563','100.5018',1,1,60,2,'Available','2024-01-20',2,2),(31,'Via Roma 100','Old town, Balcony','Palermo','Sicilian Dream','Italy','2023-06-15','Heart of Palermo','38.1157','13.3615',2,1,140,4,'Available','2024-01-05',3,3),(32,'King St 77','City view','Auckland','Kiwi Nest','New Zealand','2023-08-20','Penthouse in downtown','-36.8485','174.7633',2,2,190,5,'Available','2024-03-01',4,1),(33,'Rua da Praia 11','Beachfront','Rio de Janeiro','Copacabana Bliss','Brazil','2023-07-30','Just steps from the beach','-22.9068','-43.1729',2,2,210,5,'Available','2024-04-05',5,1),(34,'Paseo de la Reforma 100','Luxury tower','Mexico City','CDMX Tower Stay','Mexico','2023-05-01','Suite with skyline views','19.4326','-99.1332',2,2,170,5,'Available','2024-02-22',6,1),(35,'Karl Johans gate 50','Scenic, WiFi','Oslo','Nordic Lights','Norway','2023-06-06','Elegant Nordic-style home','59.9139','10.7522',2,1,180,4,'Available','2024-03-14',7,2),(37,'Myeongdong 88','City center','Seoul','Seoul Central Loft','South Korea','2023-04-14','Walking distance to shopping','37.5665','126.9780',1,1,150,4,'Available','2024-01-08',2,2),(38,'Kuwait Towers St','Sea view','Kuwait City','Gulf Pearl','Kuwait','2023-10-12','Facing Kuwait Towers','29.3759','47.9774',2,1,170,4,'Available','2024-03-25',3,1),(39,'Main Bazar 77','Cultural hub','New Delhi','Dilli Darshan','India','2023-06-01','Colorful and local experience','28.6139','77.2090',2,1,90,3,'Available','2024-02-02',4,2),(40,'Place Jemaa el-Fna 20','Riad style','Marrakech','Riad Rose','Morocco','2023-07-07','Authentic Moroccan riad','31.6295','-7.9811',2,1,120,4,'Available','2024-01-12',5,3);
/*!40000 ALTER TABLE `housing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `housing_services`
--

DROP TABLE IF EXISTS `housing_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `housing_services` (
  `housing_id` int NOT NULL,
  `service_id` int NOT NULL,
  PRIMARY KEY (`housing_id`,`service_id`),
  KEY `FK_housing_services_service_id` (`service_id`),
  CONSTRAINT `FK_housing_services_housing_id` FOREIGN KEY (`housing_id`) REFERENCES `housing` (`HOUSINGID`),
  CONSTRAINT `FK_housing_services_service_id` FOREIGN KEY (`service_id`) REFERENCES `services` (`ID_SERVICE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `housing_services`
--

LOCK TABLES `housing_services` WRITE;
/*!40000 ALTER TABLE `housing_services` DISABLE KEYS */;
INSERT INTO `housing_services` VALUES (1,18),(8,18),(1,20),(8,20),(8,21),(1,22),(1,24),(1,25),(1,26),(1,28),(8,28),(1,29),(2,29),(8,29),(1,30),(8,30);
/*!40000 ALTER TABLE `housing_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `housingcategory`
--

DROP TABLE IF EXISTS `housingcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `housingcategory` (
  `CATEGORYID` int NOT NULL AUTO_INCREMENT,
  `CATEGORYDESCRIPTION` varchar(255) DEFAULT NULL,
  `CATEGORYNAME` varchar(255) NOT NULL,
  PRIMARY KEY (`CATEGORYID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `housingcategory`
--

LOCK TABLES `housingcategory` WRITE;
/*!40000 ALTER TABLE `housingcategory` DISABLE KEYS */;
INSERT INTO `housingcategory` VALUES (1,'Alojamientos ubicados en zonas urbanas o residenciales.','Apartamentos'),(2,'Habitaciones en establecimientos turísticos.','Hoteles'),(3,'Viviendas cercanas al mar, ideales para vacaciones.','Casas de playas'),(4,'Alojamientos amplios para grupos o familias.','Casas Familiares'),(5,'Espacios rurales rodeados de naturaleza.','Casas de Campo'),(6,'Refugios ubicados en zonas elevadas o montañosas.','Casas en la montaña'),(7,'Restaurantes.','Lugares donde se ofrecen comidas, no necesariamente hospedaje.'),(12,'as','as');
/*!40000 ALTER TABLE `housingcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `housingimage`
--

DROP TABLE IF EXISTS `housingimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `housingimage` (
  `HOUSINGIMAGEID` int NOT NULL AUTO_INCREMENT,
  `CAPTION` varchar(255) DEFAULT NULL,
  `IMAGEURL` varchar(255) NOT NULL,
  `housing_id` int NOT NULL,
  PRIMARY KEY (`HOUSINGIMAGEID`),
  KEY `FK_HOUSINGIMAGE_housing_id` (`housing_id`),
  CONSTRAINT `FK_HOUSINGIMAGE_housing_id` FOREIGN KEY (`housing_id`) REFERENCES `housing` (`HOUSINGID`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `housingimage`
--

LOCK TABLES `housingimage` WRITE;
/*!40000 ALTER TABLE `housingimage` DISABLE KEYS */;
INSERT INTO `housingimage` VALUES (1,'Vista principal','images\\img-houses\\img-7.avif',1),(2,'Vista principal','images\\img-houses\\img-7.avif',2),(3,'Vista principal','images\\img-houses\\img-7.avif',3),(4,'Vista principal','images\\img-houses\\img-7.avif',4),(5,'Vista principal','images\\img-houses\\img-7.avif',5),(6,'Vista principal','images\\img-houses\\img-7.avif',6),(7,'Vista principal','images\\img-houses\\img-7.avif',7),(8,'Vista principal','images\\img-houses\\img-7.avif',8),(9,'Vista principal','images\\img-houses\\img-7.avif',9),(10,'Vista principal','images\\img-houses\\img-7.avif',10),(11,'Vista principal','images\\img-houses\\img-7.avif',11),(12,'Vista principal','images\\img-houses\\img-7.avif',12),(13,'Vista principal','images\\img-houses\\img-7.avif',13),(14,'Vista principal','images\\img-houses\\img-7.avif',14),(15,'Vista principal','images\\img-houses\\img-7.avif',15),(16,'Vista principal','images\\img-houses\\img-7.avif',16),(17,'Vista principal','images\\img-houses\\img-7.avif',17),(18,'Vista principal','images\\img-houses\\img-7.avif',18),(19,'Vista principal','images\\img-houses\\img-7.avif',19),(20,'Vista principal','images\\img-houses\\img-7.avif',20),(21,'Vista principal','images\\img-houses\\img-7.avif',21),(22,'Vista principal','images\\img-houses\\img-7.avif',22),(23,'Vista principal','images\\img-houses\\img-7.avif',23),(24,'Vista principal','images\\img-houses\\img-7.avif',24),(25,'Vista principal','images\\img-houses\\img-7.avif',25),(26,'Vista principal','images\\img-houses\\img-7.avif',26),(27,'Vista principal','images\\img-houses\\img-7.avif',27),(28,'Vista principal','images\\img-houses\\img-7.avif',28),(29,'Vista principal','images\\img-houses\\img-7.avif',29),(30,'Vista principal','images\\img-houses\\img-7.avif',30),(31,'Vista principal','images\\img-houses\\img-8.avif',31),(32,'Vista principal','images\\img-houses\\img-8.avif',32),(33,'Vista principal','images\\img-houses\\img-8.avif',33),(34,'Vista principal','images\\img-houses\\img-8.avif',34),(35,'Vista principal','images\\img-houses\\img-8.avif',35),(37,'Vista principal','images\\img-houses\\img-8.avif',37),(38,'Vista principal','images\\img-houses\\img-8.avif',38),(39,'Vista principal','images\\img-houses\\img-8.avif',39),(40,'Vista principal','images\\img-houses\\img-8.avif',40),(41,NULL,'images/img-houses/0c56c338-3661-47ee-8e6b-49a5ecc4d72c_noo.jpg',2);
/*!40000 ALTER TABLE `housingimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `ID_MESSAGE` int NOT NULL AUTO_INCREMENT,
  `CONTENT` varchar(255) NOT NULL,
  `SENTDATE` datetime(3) NOT NULL,
  `STATUS` varchar(255) NOT NULL,
  `receiver_id` int NOT NULL,
  `sender_id` int NOT NULL,
  PRIMARY KEY (`ID_MESSAGE`),
  KEY `FK_MESSAGE_receiver_id` (`receiver_id`),
  KEY `FK_MESSAGE_sender_id` (`sender_id`),
  CONSTRAINT `FK_MESSAGE_receiver_id` FOREIGN KEY (`receiver_id`) REFERENCES `user` (`ID_USERS`),
  CONSTRAINT `FK_MESSAGE_sender_id` FOREIGN KEY (`sender_id`) REFERENCES `user` (`ID_USERS`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,'uy','2025-07-04 03:48:15.274','READ',3,2),(2,'yape','2025-07-04 03:50:57.249','READ',2,3),(3,'hola','2025-07-04 03:51:30.947','READ',3,3),(4,'que','2025-07-04 03:51:39.940','READ',3,3),(5,'uffffffffffffffff','2025-07-04 04:05:34.962','READ',3,2),(6,'uffffffffffffffff','2025-07-04 07:26:55.779','READ',3,2),(7,'H0oola','2025-07-04 07:27:39.263','READ',8,3);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `PAYMENTID` int NOT NULL AUTO_INCREMENT,
  `AMOUNT` float NOT NULL,
  `CREATEDDATE` date NOT NULL,
  `ENDDATE` date DEFAULT NULL,
  `PAYMENTDATE` date DEFAULT NULL,
  `PAYMENTSTATUS` varchar(50) DEFAULT NULL,
  `UPDATEDDATE` date DEFAULT NULL,
  `payment_method_id` int DEFAULT NULL,
  `reservationId` int NOT NULL,
  PRIMARY KEY (`PAYMENTID`),
  KEY `FK_PAYMENT_payment_method_id` (`payment_method_id`),
  KEY `FK_PAYMENT_reservationId` (`reservationId`),
  CONSTRAINT `FK_PAYMENT_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `paymentmethod` (`PAYMENTMETHODID`),
  CONSTRAINT `FK_PAYMENT_reservationId` FOREIGN KEY (`reservationId`) REFERENCES `reservation` (`RESERVATIONID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,9900,'2025-07-03','2025-06-23','2025-07-03','Pendiente',NULL,1,2),(2,60,'2024-06-03','2024-07-04','2024-06-03','Pagado','2024-06-03',1,2),(5,75,'2024-06-06','2024-07-07','2024-06-06','Pagado','2024-06-06',1,5),(6,80,'2024-06-07','2024-07-08','2024-06-07','Pagado','2024-06-07',1,6),(7,85,'2024-06-08','2024-07-09','2024-06-08','Pagado','2024-06-08',1,7),(8,90,'2024-06-09','2024-07-10','2024-06-09','Pagado','2024-06-09',1,8),(9,95,'2024-06-10','2024-07-11','2024-06-10','Pagado','2024-06-10',1,9),(10,100,'2024-06-11','2024-07-12','2024-06-11','Pagado','2024-06-11',1,10),(11,105,'2024-06-12','2024-07-13','2024-06-12','Pagado','2024-06-12',1,11),(12,110,'2024-06-13','2024-07-14','2024-06-13','Pagado','2024-06-13',1,12),(13,115,'2024-06-14','2024-07-15','2024-06-14','Pagado','2024-06-14',1,13),(14,120,'2024-06-15','2024-07-16','2024-06-15','Pagado','2024-06-15',1,14),(15,125,'2024-06-16','2024-07-17','2024-06-16','Pagado','2024-06-16',1,15),(16,130,'2024-06-17','2024-07-18','2024-06-17','Pagado','2024-06-17',1,16),(17,135,'2024-06-18','2024-07-19','2024-06-18','Pagado','2024-06-18',1,17),(18,140,'2024-06-19','2024-07-20','2024-06-19','Pagado','2024-06-19',1,18),(19,145,'2024-06-20','2024-07-21','2024-06-20','Pagado','2024-06-20',1,19),(20,150,'2024-06-21','2024-07-22','2024-06-21','Pagado','2024-06-21',1,20),(21,155,'2024-06-22','2024-07-23','2024-06-22','Pagado','2024-06-22',1,21),(22,160,'2024-06-23','2024-07-24','2024-06-23','Pagado','2024-06-23',1,22),(23,165,'2024-06-24','2024-07-25','2024-06-24','Pagado','2024-06-24',1,23),(24,170,'2024-06-25','2024-07-26','2024-06-25','Pagado','2024-06-25',1,24),(25,175,'2024-06-26','2024-07-27','2024-06-26','Pagado','2024-06-26',1,25),(26,180,'2024-06-27','2024-07-28','2024-06-27','Pagado','2024-06-27',1,26),(27,185,'2024-06-28','2024-07-29','2024-06-28','Pagado','2024-06-28',1,27),(28,190,'2024-06-29','2024-07-30','2024-06-29','Pagado','2024-06-29',1,28),(29,195,'2024-06-30','2024-07-31','2024-06-30','Pagado','2024-06-30',1,29),(30,200,'2024-07-01','2024-08-01','2024-07-01','Pagado','2024-07-01',1,30),(31,205,'2024-07-02','2024-08-02','2024-07-02','Pagado','2024-07-02',1,31),(32,210,'2024-07-03','2024-08-03','2024-07-03','Pagado','2024-07-03',1,32),(33,215,'2024-07-04','2024-08-04','2024-07-04','Pagado','2024-07-04',1,33),(34,220,'2024-07-05','2024-08-05','2024-07-05','Pagado','2024-07-05',1,34),(35,225,'2024-07-06','2024-08-06','2024-07-06','Pagado','2024-07-06',1,35),(36,230,'2024-07-07','2024-08-07','2024-07-07','Pagado','2024-07-07',1,36),(37,235,'2024-07-08','2024-08-08','2024-07-08','Pagado','2024-07-08',1,37),(38,240,'2024-07-09','2024-08-09','2024-07-09','Pagado','2024-07-09',1,38),(39,245,'2024-07-10','2024-08-10','2024-07-10','Pagado','2024-07-10',1,39),(40,250,'2024-07-11','2024-08-11','2024-07-11','Pagado','2024-07-11',1,40),(41,5700,'2025-07-04','2025-06-23','2025-07-04','Pagado','2025-07-04',1,125),(42,7200,'2025-07-04','2025-06-23','2025-07-04','Pagado','2025-07-04',1,126),(43,6300,'2025-07-04','2025-06-23','2025-07-04','Pagado','2025-07-04',1,127),(44,5700,'2025-07-04','2025-06-23','2025-07-04','Pagado','2025-07-04',1,128),(47,444.54,'2025-05-10','2025-05-21','2025-05-22','Pagado','2025-05-22',2,129),(48,531.83,'2025-03-29','2025-04-09','2025-04-09','Pagado','2025-04-09',1,130),(49,608.18,'2025-08-20','2025-09-03','2025-09-04','Pagado','2025-09-04',1,131),(50,983.14,'2025-10-19','2025-11-09','2025-11-14','Pagado','2025-11-14',3,132),(51,294.47,'2025-03-17','2025-03-28','2025-04-02','Pagado','2025-04-02',2,133),(52,993.32,'2025-03-12','2025-03-25','2025-03-27','Pagado','2025-03-27',1,134),(53,145.3,'2025-10-22','2025-11-05','2025-11-08','Pagado','2025-11-08',2,135),(54,925.97,'2025-09-04','2025-09-14','2025-09-19','Pagado','2025-09-19',2,136),(55,258.2,'2025-05-02','2025-05-16','2025-05-20','Pagado','2025-05-20',3,137),(56,437.58,'2025-05-12','2025-05-25','2025-05-25','Pagado','2025-05-25',2,138),(57,467.04,'2025-10-03','2025-10-18','2025-10-23','Pagado','2025-10-23',3,139),(58,285.14,'2025-11-14','2025-12-02','2025-12-04','Pagado','2025-12-04',3,140),(59,843.44,'2025-12-10','2025-12-22','2025-12-24','Pagado','2025-12-24',3,141),(60,917.64,'2025-07-03','2025-07-14','2025-07-15','Pagado','2025-07-15',3,142),(61,178.54,'2025-12-09','2025-12-16','2025-12-16','Pagado','2025-12-16',2,143),(62,349.01,'2025-02-12','2025-03-04','2025-03-09','Pagado','2025-03-09',3,144),(63,405.78,'2025-09-18','2025-09-29','2025-10-03','Pagado','2025-10-03',2,145),(64,641.6,'2025-07-02','2025-07-21','2025-07-23','Pagado','2025-07-23',2,146),(65,865.06,'2025-07-18','2025-08-01','2025-08-02','Pagado','2025-08-02',2,147),(66,436.21,'2025-10-06','2025-10-13','2025-10-15','Pagado','2025-10-15',3,148),(67,893.38,'2025-01-02','2025-01-18','2025-01-19','Pagado','2025-01-19',3,149),(68,988.56,'2025-11-22','2025-12-10','2025-12-11','Pagado','2025-12-11',2,150),(69,758.06,'2025-07-31','2025-08-08','2025-08-09','Pagado','2025-08-09',3,151),(70,602.35,'2025-12-26','2026-01-08','2026-01-12','Pagado','2026-01-12',1,152),(71,737.18,'2025-09-23','2025-09-29','2025-10-04','Pagado','2025-10-04',2,153),(72,111.26,'2025-10-23','2025-11-06','2025-11-06','Pagado','2025-11-06',3,154),(73,422.93,'2025-04-10','2025-04-19','2025-04-24','Pagado','2025-04-24',1,155),(74,515.33,'2025-12-19','2025-12-25','2025-12-26','Pagado','2025-12-26',2,156),(75,838.06,'2025-05-19','2025-06-03','2025-06-03','Pagado','2025-06-03',2,157),(76,520.6,'2025-10-09','2025-10-24','2025-10-26','Pagado','2025-10-26',1,158),(77,734.92,'2025-02-23','2025-03-02','2025-03-04','Pagado','2025-03-04',1,159),(78,294.98,'2025-08-06','2025-08-26','2025-08-28','Pagado','2025-08-28',3,160),(79,985.75,'2025-10-31','2025-11-11','2025-11-14','Pagado','2025-11-14',1,161),(80,500.41,'2025-05-17','2025-06-02','2025-06-05','Pagado','2025-06-05',2,162),(81,317.14,'2025-03-01','2025-03-18','2025-03-19','Pagado','2025-03-19',3,163),(82,669.03,'2025-04-14','2025-04-27','2025-04-29','Pagado','2025-04-29',3,164),(83,450.79,'2025-01-06','2025-01-13','2025-01-17','Pagado','2025-01-17',1,165),(84,479.01,'2025-01-17','2025-02-01','2025-02-06','Pagado','2025-02-06',3,166),(85,967.78,'2025-12-30','2026-01-09','2026-01-09','Pagado','2026-01-09',1,167),(86,117.24,'2025-09-29','2025-10-07','2025-10-11','Pagado','2025-10-11',2,168),(88,656.45,'2025-03-05','2025-03-22','2025-03-23','Pagado','2025-03-23',1,170),(89,153.33,'2025-08-09','2025-08-14','2025-08-18','Pagado','2025-08-18',3,171),(90,903.94,'2025-03-21','2025-03-30','2025-04-04','Pagado','2025-04-04',1,172),(91,333.09,'2025-02-02','2025-02-08','2025-02-13','Pagado','2025-02-13',3,173),(94,272.27,'2025-02-10','2025-02-20','2025-02-23','Pagado','2025-02-23',1,266),(97,967.88,'2025-10-17','2025-10-25','2025-10-30','Pagado','2025-10-30',3,262),(99,416.89,'2025-01-10','2025-01-16','2025-01-21','Pagado','2025-01-21',1,260);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymentmethod`
--

DROP TABLE IF EXISTS `paymentmethod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paymentmethod` (
  `PAYMENTMETHODID` int NOT NULL AUTO_INCREMENT,
  `DESCRIPTION` varchar(500) DEFAULT NULL,
  `METHODNAME` varchar(100) NOT NULL,
  PRIMARY KEY (`PAYMENTMETHODID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymentmethod`
--

LOCK TABLES `paymentmethod` WRITE;
/*!40000 ALTER TABLE `paymentmethod` DISABLE KEYS */;
INSERT INTO `paymentmethod` VALUES (1,'Pago mediante tarjeta de crédito o débito Visa, Mastercard, American Express','Tarjeta de Crédito/Débito'),(2,'Pago mediante transferencia bancaria directa a la cuenta del vendedor','Transferencia Bancaria'),(3,'Pago electrónico a través de la plataforma PayPal, seguro y rápido','PayPal');
/*!40000 ALTER TABLE `paymentmethod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `RESERVATIONID` int NOT NULL AUTO_INCREMENT,
  `CREATEDDATE` date NOT NULL,
  `ENDDATE` date NOT NULL,
  `NUMBEROFADULTS` int NOT NULL,
  `NUMBEROFCHILDREN` int NOT NULL,
  `STARTDATE` date NOT NULL,
  `TAX` float NOT NULL,
  `TOTALPRICE` float NOT NULL,
  `UPDATEDDATE` date DEFAULT NULL,
  `housing_id` int NOT NULL,
  `reservation_status_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`RESERVATIONID`),
  KEY `FK_RESERVATION_housing_id` (`housing_id`),
  KEY `FK_RESERVATION_user_id` (`user_id`),
  KEY `FK_RESERVATION_reservation_status_id` (`reservation_status_id`),
  CONSTRAINT `FK_RESERVATION_housing_id` FOREIGN KEY (`housing_id`) REFERENCES `housing` (`HOUSINGID`),
  CONSTRAINT `FK_RESERVATION_reservation_status_id` FOREIGN KEY (`reservation_status_id`) REFERENCES `reservationstatus` (`RESERVATIONSTATUSID`),
  CONSTRAINT `FK_RESERVATION_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID_USERS`)
) ENGINE=InnoDB AUTO_INCREMENT=270 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (2,'2025-07-03','2025-06-23',1,0,'2025-05-24',0,9900,'2025-07-03',1,1,2),(5,'2025-02-01','2025-02-03',1,0,'2025-02-01',10,90,'2025-02-01',2,2,5),(6,'2025-02-10','2025-02-12',2,2,'2025-02-09',15,105,'2025-02-09',2,2,5),(7,'2025-02-15','2025-02-18',4,0,'2025-02-14',25,160,'2025-02-14',2,2,8),(8,'2025-03-05','2025-03-10',2,1,'2025-03-04',12,95,'2025-03-04',3,2,8),(9,'2025-03-12','2025-03-15',2,0,'2025-03-11',18,115,'2025-03-11',3,2,7),(10,'2025-03-20','2025-03-23',1,1,'2025-03-19',20,120,'2025-03-19',3,2,7),(11,'2025-04-03','2025-04-06',2,0,'2025-04-02',14,100,'2025-04-02',4,2,2),(12,'2025-04-15','2025-04-18',3,2,'2025-04-14',30,180,'2025-04-14',4,2,3),(13,'2025-04-20','2025-04-22',2,0,'2025-04-19',18,110,'2025-04-19',4,2,4),(14,'2025-05-01','2025-05-04',1,1,'2025-05-01',15,100,'2025-05-01',5,2,5),(15,'2025-05-10','2025-05-12',2,2,'2025-05-09',22,140,'2025-05-09',5,2,6),(16,'2025-05-20','2025-05-23',2,0,'2025-05-19',16,105,'2025-05-19',5,2,7),(17,'2025-06-03','2025-06-06',2,1,'2025-06-02',19,115,'2025-06-02',6,2,8),(18,'2025-06-15','2025-06-17',1,0,'2025-06-14',12,90,'2025-06-14',6,2,5),(19,'2025-06-25','2025-06-28',3,2,'2025-06-24',28,170,'2025-06-24',6,2,6),(20,'2025-07-05','2025-07-09',2,1,'2025-07-04',20,130,'2025-07-04',7,2,3),(21,'2025-07-11','2025-07-14',2,2,'2025-07-10',25,150,'2025-07-10',7,2,7),(22,'2025-07-20','2025-07-22',1,1,'2025-07-19',13,95,'2025-07-19',7,2,4),(23,'2025-08-02','2025-08-05',2,0,'2025-08-01',18,110,'2025-08-01',8,2,6),(24,'2025-08-10','2025-08-13',3,2,'2025-08-09',30,180,'2025-08-09',8,2,7),(25,'2025-08-25','2025-08-27',2,0,'2025-08-24',16,100,'2025-08-24',8,2,7),(26,'2025-09-01','2025-09-04',2,2,'2025-09-01',22,135,'2025-09-01',9,2,8),(27,'2025-09-10','2025-09-13',1,0,'2025-09-09',10,85,'2025-09-09',9,2,8),(28,'2025-09-20','2025-09-22',3,1,'2025-09-19',26,160,'2025-09-19',9,2,8),(29,'2025-10-03','2025-10-06',2,1,'2025-10-02',18,115,'2025-10-02',10,2,5),(30,'2025-10-14','2025-10-16',1,1,'2025-10-13',12,95,'2025-10-13',10,2,5),(31,'2025-10-25','2025-10-27',2,0,'2025-10-24',16,105,'2025-10-24',10,2,5),(32,'2025-11-02','2025-11-05',1,2,'2025-11-01',15,100,'2025-11-01',11,2,6),(33,'2025-11-12','2025-11-15',2,0,'2025-11-11',20,125,'2025-11-11',11,2,6),(34,'2025-11-22','2025-11-25',2,2,'2025-11-21',30,180,'2025-11-21',11,2,6),(35,'2025-12-01','2025-12-04',2,1,'2025-12-01',15,105,'2025-12-01',12,2,3),(36,'2025-12-10','2025-12-12',1,0,'2025-12-09',12,90,'2025-12-09',12,2,3),(37,'2025-12-20','2025-12-23',3,1,'2025-12-19',25,150,'2025-12-19',12,2,3),(38,'2025-03-05','2025-03-07',2,0,'2025-03-04',10,90,'2025-03-04',15,2,4),(39,'2025-07-15','2025-07-18',2,1,'2025-07-14',18,120,'2025-07-14',18,2,2),(40,'2025-05-27','2025-05-29',1,1,'2025-05-26',15,95,'2025-05-26',20,2,3),(113,'2025-01-02','2025-01-08',2,1,'2025-01-03',11,112,'2025-01-03',1,2,2),(114,'2025-02-06','2025-02-14',2,1,'2025-02-07',11,124,'2025-02-07',2,2,2),(115,'2025-03-01','2025-03-05',2,1,'2025-03-02',11,124,'2025-03-02',3,2,3),(116,'2025-04-21','2025-04-24',2,1,'2025-04-22',11,124,'2025-04-22',4,2,4),(117,'2025-05-16','2025-05-20',2,1,'2025-05-17',11,124,'2025-05-17',5,2,5),(118,'2025-06-21','2025-06-24',2,1,'2025-06-22',11,124,'2025-06-22',6,2,3),(119,'2025-07-19','2025-07-23',2,1,'2025-07-23',11,124,'2025-07-23',7,2,4),(120,'2025-08-24','2025-08-29',2,1,'2025-08-25',11,124,'2025-08-25',8,2,5),(121,'2025-09-10','2025-09-17',2,1,'2025-09-11',11,124,'2025-09-11',9,2,7),(122,'2025-10-21','2025-10-25',2,2,'2025-10-22',12,135,'2025-10-22',10,2,7),(123,'2025-11-10','2025-11-12',2,2,'2025-11-11',12,135,'2025-11-11',11,2,5),(124,'2025-12-03','2025-12-09',2,2,'2025-12-04',12,135,'2025-12-04',12,2,5),(125,'2025-07-04','2025-06-23',1,0,'2025-05-24',0,5700,'2025-07-04',3,1,2),(126,'2025-07-04','2025-06-23',1,0,'2025-05-24',0,7200,'2025-07-04',18,1,3),(127,'2025-07-04','2025-06-23',1,0,'2025-05-24',0,6300,'2025-07-04',28,1,3),(128,'2025-07-04','2025-06-23',1,0,'2025-05-24',0,5700,'2025-07-04',3,1,5),(129,'2025-05-10','2025-05-21',1,3,'2025-05-19',11.6,444.54,'2025-05-22',6,2,4),(130,'2025-03-29','2025-04-09',1,1,'2025-04-05',11.71,531.83,'2025-04-09',1,3,6),(131,'2025-08-20','2025-09-03',3,2,'2025-08-31',12.8,608.18,'2025-09-04',6,2,8),(132,'2025-10-19','2025-11-09',3,0,'2025-11-02',7,983.14,'2025-11-14',6,1,1),(133,'2025-03-17','2025-03-28',3,3,'2025-03-22',12.66,294.47,'2025-04-02',1,1,3),(134,'2025-03-12','2025-03-25',3,3,'2025-03-21',11.48,993.32,'2025-03-27',5,2,2),(135,'2025-10-22','2025-11-05',2,2,'2025-11-04',10.74,145.3,'2025-11-08',5,3,9),(136,'2025-09-04','2025-09-14',4,0,'2025-09-07',11.36,925.97,'2025-09-19',1,1,7),(137,'2025-05-02','2025-05-16',1,3,'2025-05-13',11.13,258.2,'2025-05-20',3,2,2),(138,'2025-05-12','2025-05-25',4,3,'2025-05-19',14.38,437.58,'2025-05-25',8,2,2),(139,'2025-10-03','2025-10-18',3,3,'2025-10-13',5.51,467.04,'2025-10-23',4,2,3),(140,'2025-11-14','2025-12-02',1,1,'2025-11-27',12.94,285.14,'2025-12-04',6,3,3),(141,'2025-12-10','2025-12-22',2,0,'2025-12-21',12.18,843.44,'2025-12-24',2,1,9),(142,'2025-07-03','2025-07-14',4,2,'2025-07-07',10.89,917.64,'2025-07-15',5,2,2),(143,'2025-12-09','2025-12-16',2,2,'2025-12-15',14.61,178.54,'2025-12-16',10,2,1),(144,'2025-02-12','2025-03-04',1,3,'2025-02-26',11.81,349.01,'2025-03-09',7,3,2),(145,'2025-09-18','2025-09-29',1,0,'2025-09-26',14.93,405.78,'2025-10-03',2,1,3),(146,'2025-07-02','2025-07-21',2,3,'2025-07-14',7.73,641.6,'2025-07-23',7,3,3),(147,'2025-07-18','2025-08-01',1,0,'2025-07-28',14.96,865.06,'2025-08-02',4,2,3),(148,'2025-10-06','2025-10-13',2,0,'2025-10-09',13.15,436.21,'2025-10-15',1,1,9),(149,'2025-01-02','2025-01-18',4,0,'2025-01-15',13.81,893.38,'2025-01-19',5,3,8),(150,'2025-11-22','2025-12-10',1,1,'2025-12-04',8.81,988.56,'2025-12-11',7,2,4),(151,'2025-07-31','2025-08-08',2,2,'2025-08-02',10.74,758.06,'2025-08-09',8,2,9),(152,'2025-12-26','2026-01-08',2,1,'2026-01-01',10.31,602.35,'2026-01-12',2,2,2),(153,'2025-09-23','2025-09-29',1,2,'2025-09-28',8.84,737.18,'2025-10-04',4,2,8),(154,'2025-10-23','2025-11-06',1,2,'2025-10-31',11.67,111.26,'2025-11-06',7,3,5),(155,'2025-04-10','2025-04-19',3,2,'2025-04-18',7.89,422.93,'2025-04-24',9,1,3),(156,'2025-12-19','2025-12-25',2,3,'2025-12-21',9.83,515.33,'2025-12-26',8,3,3),(157,'2025-05-19','2025-06-03',1,3,'2025-06-02',12.38,838.06,'2025-06-03',7,3,8),(158,'2025-10-09','2025-10-24',1,0,'2025-10-17',13.18,520.6,'2025-10-26',2,1,1),(159,'2025-02-23','2025-03-02',4,3,'2025-03-01',11.09,734.92,'2025-03-04',4,1,4),(160,'2025-08-06','2025-08-26',2,3,'2025-08-20',8.32,294.98,'2025-08-28',5,1,8),(161,'2025-10-31','2025-11-11',4,0,'2025-11-06',8.2,985.75,'2025-11-14',4,2,6),(162,'2025-05-17','2025-06-02',4,1,'2025-05-28',6.45,500.41,'2025-06-05',3,2,3),(163,'2025-03-01','2025-03-18',4,0,'2025-03-14',10.65,317.14,'2025-03-19',3,2,6),(164,'2025-04-14','2025-04-27',4,2,'2025-04-21',5.89,669.03,'2025-04-29',10,2,8),(165,'2025-01-06','2025-01-13',4,3,'2025-01-10',5.73,450.79,'2025-01-17',8,1,8),(166,'2025-01-17','2025-02-01',4,3,'2025-01-31',5.12,479.01,'2025-02-06',5,2,3),(167,'2025-12-30','2026-01-09',2,0,'2026-01-05',7.4,967.78,'2026-01-09',10,3,4),(168,'2025-09-29','2025-10-07',2,0,'2025-10-05',12.28,117.24,'2025-10-11',2,1,5),(170,'2025-03-07','2025-03-26',3,2,'2025-03-21',14.7,240,'2025-03-27',9,1,2),(171,'2025-03-05','2025-03-22',1,2,'2025-03-18',10.63,656.45,'2025-03-23',10,1,7),(172,'2025-08-09','2025-08-14',1,3,'2025-08-10',12.34,153.33,'2025-08-18',4,3,6),(173,'2025-03-21','2025-03-30',2,2,'2025-03-24',9.63,903.94,'2025-04-04',3,3,2),(174,'2025-02-02','2025-02-08',3,3,'2025-02-06',14.31,333.09,'2025-02-13',5,2,8),(175,'2025-10-05','2025-10-12',4,0,'2025-10-06',7.11,331.36,'2025-10-12',8,1,4),(176,'2025-09-02','2025-09-09',2,1,'2025-09-04',14.84,123.57,'2025-09-14',7,2,4),(177,'2025-05-21','2025-06-09',2,3,'2025-06-05',14.34,595.36,'2025-06-09',3,2,2),(178,'2025-12-05','2025-12-22',3,1,'2025-12-19',9.19,780.31,'2025-12-27',4,3,8),(179,'2025-09-10','2025-09-30',2,0,'2025-09-23',14.92,372.3,'2025-10-04',1,1,8),(180,'2025-04-12','2025-04-21',2,2,'2025-04-15',8,243.59,'2025-04-25',1,2,8),(181,'2025-08-07','2025-08-18',3,1,'2025-08-11',12.49,790.47,'2025-08-23',3,1,6),(182,'2025-10-14','2025-11-02',3,2,'2025-10-27',9.34,252.58,'2025-11-05',1,4,8),(183,'2025-01-19','2025-01-29',3,1,'2025-01-26',9.46,524.02,'2025-02-02',7,3,4),(184,'2025-03-27','2025-04-12',1,0,'2025-04-07',14.36,616.48,'2025-04-16',7,2,7),(185,'2025-04-17','2025-04-26',3,0,'2025-04-24',7.45,672.12,'2025-04-28',8,1,8),(186,'2025-03-21','2025-04-01',4,0,'2025-03-31',6.61,730,'2025-04-03',8,4,7),(187,'2025-05-07','2025-05-22',1,3,'2025-05-18',10.97,152.71,'2025-05-24',8,2,6),(188,'2025-12-29','2026-01-12',2,1,'2026-01-09',13.72,509.82,'2026-01-14',8,1,6),(189,'2025-08-08','2025-08-26',3,1,'2025-08-21',6.8,674.69,'2025-08-31',5,3,8),(190,'2025-02-02','2025-02-18',3,3,'2025-02-16',6.99,159.78,'2025-02-22',7,1,8),(191,'2025-02-06','2025-02-15',2,0,'2025-02-14',9.5,277.56,'2025-02-15',10,2,5),(192,'2025-08-12','2025-08-26',4,0,'2025-08-22',5.3,407.88,'2025-08-30',8,3,7),(193,'2025-04-12','2025-04-30',2,3,'2025-04-26',11.57,901.75,'2025-05-01',2,2,3),(194,'2025-12-27','2025-12-30',1,3,'2025-12-28',12.82,510.06,'2026-01-03',7,4,5),(195,'2025-11-19','2025-11-30',3,1,'2025-11-29',12.58,825.53,'2025-12-03',10,1,7),(196,'2025-12-04','2025-12-19',2,0,'2025-12-12',11.8,373.93,'2025-12-22',7,3,3),(197,'2025-12-15','2025-12-30',4,2,'2025-12-28',11.39,753.88,'2025-12-31',3,2,6),(198,'2025-07-06','2025-07-25',1,3,'2025-07-18',7.03,628.3,'2025-07-28',10,1,3),(199,'2025-08-16','2025-08-28',4,3,'2025-08-23',13.43,493.94,'2025-08-28',6,1,7),(200,'2025-02-06','2025-02-11',4,2,'2025-02-07',8.65,411.86,'2025-02-12',4,1,6),(201,'2025-12-13','2025-12-27',3,3,'2025-12-26',14.63,412.18,'2026-01-01',1,4,7),(202,'2025-08-04','2025-08-18',3,0,'2025-08-12',13.64,210.06,'2025-08-19',8,1,2),(203,'2025-03-05','2025-03-09',3,2,'2025-03-08',10.6,246.01,'2025-03-11',2,4,3),(204,'2025-11-29','2025-12-18',1,2,'2025-12-11',13.94,630.18,'2025-12-21',6,1,8),(205,'2025-07-31','2025-08-12',4,3,'2025-08-08',10.41,532.37,'2025-08-17',7,3,4),(206,'2025-03-08','2025-03-16',3,3,'2025-03-12',6.14,600.49,'2025-03-18',5,1,4),(207,'2025-10-16','2025-10-30',2,3,'2025-10-27',10.06,559.47,'2025-11-02',7,4,3),(208,'2025-09-30','2025-10-12',1,0,'2025-10-10',9.31,300.87,'2025-10-12',1,3,3),(209,'2025-12-31','2026-01-15',2,2,'2026-01-13',8.85,462.82,'2026-01-15',4,1,3),(210,'2025-04-23','2025-05-04',2,1,'2025-05-01',6.02,311.38,'2025-05-09',8,2,3),(211,'2025-11-18','2025-12-04',2,1,'2025-12-03',13.86,176.03,'2025-12-06',8,3,6),(212,'2025-05-20','2025-05-31',3,3,'2025-05-25',8.58,363.13,'2025-06-02',2,2,5),(213,'2025-06-19','2025-07-05',1,0,'2025-07-04',12.69,630.89,'2025-07-05',8,3,4),(214,'2025-06-15','2025-06-29',3,3,'2025-06-24',11.6,311.16,'2025-07-02',4,1,4),(215,'2025-10-04','2025-10-14',4,3,'2025-10-09',13.1,896.52,'2025-10-19',2,4,8),(216,'2025-02-22','2025-03-09',1,2,'2025-03-02',10.28,828.89,'2025-03-14',4,3,2),(217,'2025-10-09','2025-10-20',4,1,'2025-10-17',8.35,322.8,'2025-10-24',10,1,3),(218,'2025-07-25','2025-07-30',1,0,'2025-07-29',14.27,185.61,'2025-07-30',9,3,4),(219,'2025-06-27','2025-07-04',3,1,'2025-07-01',11.3,914.81,'2025-07-04',6,1,5),(220,'2025-01-25','2025-02-14',4,2,'2025-02-08',5.48,273.02,'2025-02-16',7,4,7),(221,'2025-10-23','2025-11-06',1,0,'2025-11-01',14.82,787.33,'2025-11-07',5,1,2),(222,'2025-06-21','2025-07-06',4,3,'2025-07-05',6.12,571.13,'2025-07-10',3,3,2),(223,'2025-02-14','2025-02-27',3,1,'2025-02-23',14.4,993.63,'2025-03-03',6,3,2),(224,'2025-04-23','2025-05-15',4,3,'2025-05-08',9.15,919.72,'2025-05-18',5,4,6),(225,'2025-09-19','2025-09-30',2,3,'2025-09-25',5.36,931.23,'2025-10-02',9,1,6),(226,'2025-07-06','2025-07-17',1,0,'2025-07-14',10.14,805.29,'2025-07-21',5,1,2),(227,'2025-08-11','2025-08-27',4,0,'2025-08-25',13.64,594.68,'2025-08-27',2,4,7),(228,'2025-10-13','2025-10-20',1,2,'2025-10-16',6.88,407.24,'2025-10-25',9,4,4),(229,'2025-10-05','2025-10-16',4,0,'2025-10-12',11.39,336.37,'2025-10-18',5,4,7),(230,'2025-11-12','2025-11-27',4,3,'2025-11-23',12.3,806.16,'2025-11-28',4,1,6),(231,'2025-07-26','2025-08-09',2,1,'2025-08-04',11.65,649.35,'2025-08-14',7,1,2),(232,'2025-01-04','2025-01-19',3,1,'2025-01-15',8.92,142.2,'2025-01-21',5,3,3),(233,'2025-05-31','2025-06-19',4,2,'2025-06-12',7.54,688.27,'2025-06-22',3,2,8),(234,'2025-05-29','2025-06-12',1,3,'2025-06-11',12.59,581.36,'2025-06-15',2,2,6),(235,'2025-03-27','2025-04-06',4,2,'2025-04-04',13.82,960.62,'2025-04-11',4,2,6),(236,'2025-03-06','2025-03-17',4,1,'2025-03-16',14.59,913.86,'2025-03-20',10,4,6),(237,'2025-08-06','2025-08-21',1,3,'2025-08-20',8.05,419.08,'2025-08-25',1,1,3),(238,'2025-12-15','2025-12-19',2,3,'2025-12-16',13.13,596.63,'2025-12-22',8,3,6),(239,'2025-03-03','2025-03-23',2,3,'2025-03-16',7.49,322.32,'2025-03-26',5,1,2),(240,'2025-04-23','2025-05-02',1,1,'2025-04-26',5.79,703.19,'2025-05-04',3,3,3),(241,'2025-08-18','2025-08-31',4,1,'2025-08-30',9.94,365.52,'2025-09-05',9,4,4),(242,'2025-02-23','2025-03-13',3,1,'2025-03-08',13.03,926.63,'2025-03-15',1,1,3),(243,'2025-02-26','2025-03-19',1,0,'2025-03-13',10.12,639.4,'2025-03-20',10,2,6),(244,'2025-08-03','2025-08-17',3,0,'2025-08-10',10.61,291.72,'2025-08-21',9,1,2),(245,'2025-06-20','2025-06-25',4,1,'2025-06-22',10.73,323.47,'2025-06-30',2,4,4),(246,'2025-12-30','2026-01-15',3,1,'2026-01-11',10.86,400.9,'2026-01-15',5,3,8),(247,'2025-06-21','2025-07-06',1,3,'2025-06-30',9.83,994.88,'2025-07-09',7,4,6),(248,'2025-11-12','2025-11-20',1,0,'2025-11-15',14.64,942.96,'2025-11-25',6,1,8),(249,'2025-08-16','2025-08-31',1,2,'2025-08-26',10.68,899.26,'2025-09-05',8,3,8),(250,'2025-01-22','2025-02-10',2,2,'2025-02-06',12.6,133.8,'2025-02-10',5,3,6),(251,'2025-04-02','2025-04-20',3,2,'2025-04-16',12.96,993.83,'2025-04-21',3,3,6),(252,'2025-04-08','2025-04-20',2,1,'2025-04-18',6.17,546.13,'2025-04-23',1,1,6),(253,'2025-04-20','2025-05-11',4,1,'2025-05-05',8.17,196.33,'2025-05-11',5,1,4),(254,'2025-02-23','2025-03-09',3,2,'2025-03-04',5.18,715.1,'2025-03-14',2,1,4),(255,'2025-11-13','2025-11-27',4,2,'2025-11-21',9.22,435.23,'2025-11-27',2,3,8),(256,'2025-06-11','2025-06-26',2,3,'2025-06-23',5.66,826.4,'2025-06-27',4,3,7),(257,'2025-11-08','2025-11-28',3,2,'2025-11-23',8.49,656.44,'2025-12-03',7,1,3),(258,'2025-05-17','2025-05-23',1,3,'2025-05-20',10.3,260.16,'2025-05-26',8,2,4),(259,'2025-12-17','2026-01-02',4,1,'2025-12-31',12.52,672.76,'2026-01-04',8,4,5),(260,'2025-04-24','2025-04-29',3,1,'2025-04-28',10.47,544.4,'2025-05-04',8,3,2),(261,'2025-01-10','2025-01-16',1,1,'2025-01-15',5.16,416.89,'2025-01-21',7,1,6),(262,'2025-05-29','2025-06-11',4,1,'2025-06-05',10.74,379.14,'2025-06-11',9,1,5),(263,'2025-10-17','2025-10-25',2,2,'2025-10-23',12.54,967.88,'2025-10-30',2,4,6),(264,'2025-07-23','2025-08-09',1,3,'2025-08-05',5.13,701.13,'2025-08-12',4,4,7),(265,'2025-10-26','2025-11-10',4,3,'2025-11-08',6.25,229.82,'2025-11-10',3,4,2),(266,'2025-05-12','2025-05-23',2,0,'2025-05-16',11.02,709.11,'2025-05-25',10,3,6),(267,'2025-02-10','2025-02-20',4,3,'2025-02-16',7.81,272.27,'2025-02-23',9,1,4),(268,'2025-07-17','2025-07-31',1,3,'2025-07-28',12.76,969.86,'2025-08-03',4,3,4),(269,'2025-11-26','2025-12-12',3,3,'2025-12-07',7.27,581.06,'2025-12-17',10,1,8);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservationstatus`
--

DROP TABLE IF EXISTS `reservationstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservationstatus` (
  `RESERVATIONSTATUSID` int NOT NULL AUTO_INCREMENT,
  `STATUSNAME` varchar(100) NOT NULL,
  PRIMARY KEY (`RESERVATIONSTATUSID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservationstatus`
--

LOCK TABLES `reservationstatus` WRITE;
/*!40000 ALTER TABLE `reservationstatus` DISABLE KEYS */;
INSERT INTO `reservationstatus` VALUES (1,'Pendiente'),(2,'Confirmada'),(3,'Cancelada'),(4,'Completada');
/*!40000 ALTER TABLE `reservationstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviewhousing`
--

DROP TABLE IF EXISTS `reviewhousing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviewhousing` (
  `ID_REVIEWHOUSING` int NOT NULL AUTO_INCREMENT,
  `CREATEDDATE` date NOT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `SCORE` int DEFAULT NULL,
  `STADIA_DES` varchar(255) DEFAULT NULL,
  `UPDATEDDATE` date DEFAULT NULL,
  `reservation_id` int NOT NULL,
  PRIMARY KEY (`ID_REVIEWHOUSING`),
  UNIQUE KEY `reservation_id` (`reservation_id`),
  CONSTRAINT `FK_REVIEWHOUSING_reservation_id` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`RESERVATIONID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviewhousing`
--

LOCK TABLES `reviewhousing` WRITE;
/*!40000 ALTER TABLE `reviewhousing` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviewhousing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `ROLE_ID` int NOT NULL AUTO_INCREMENT,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Usuario registrado que puede hacer reservas y dejar reseñas.','user-comun'),(2,'Administrador general del sistema con acceso completo.','admin-plataforma');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `ID_SERVICE` int NOT NULL AUTO_INCREMENT,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `NAME_SERVICE` varchar(255) DEFAULT NULL,
  `STATUS` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ID_SERVICE`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (18,'wifi','WIFI',1),(19,'cochera','COCHERA',1),(20,'cocina\r\n','COCINA',1),(21,'tv','TV',1),(22,'horno','HORNO',1),(23,'Detector de humo','Detector de humo',1),(24,'Detector de monóxido de carbono','Detector de monóxido de carbono',1),(25,'Calefacción','Calefacción',1),(26,'Agua caliente','Agua caliente',1),(28,'Sábanas de algodón','Sábanas',1),(29,'Almohadas y mantas adicionales','Almohadas y mantas adicionales',1),(30,'Persianas o cortinas opacas','Persianas o cortinas opacas',1),(31,'Persianas o cortinas opacas y sueaves\r\n','prueba 1',1),(33,'aa','go rusia',1);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `SESSION_ID` int NOT NULL AUTO_INCREMENT,
  `CREATED_AT` datetime DEFAULT NULL,
  `EXPIRES_AT` datetime DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `IS_ACTIVE` tinyint(1) DEFAULT '0',
  `TOKEN` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`SESSION_ID`),
  KEY `FK_SESSIONS_user_id` (`user_id`),
  CONSTRAINT `FK_SESSIONS_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID_USERS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `ID_USERS` int NOT NULL AUTO_INCREMENT,
  `CREATEDDATE` date NOT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `EMERGENCY_CONTACT` varchar(255) DEFAULT NULL,
  `FULL_NAME` varchar(255) DEFAULT NULL,
  `IS_ACTIVE` tinyint(1) DEFAULT '0',
  `LAST_NAME` varchar(255) DEFAULT NULL,
  `NUM_DOCUMENT` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `PHONE` varchar(255) DEFAULT NULL,
  `UPDATEDDATE` date DEFAULT NULL,
  `URL_IMG_PERFILE` varchar(255) DEFAULT NULL,
  `document_type_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  PRIMARY KEY (`ID_USERS`),
  KEY `FK_USER_address_id` (`address_id`),
  KEY `FK_USER_document_type_id` (`document_type_id`),
  KEY `FK_USER_role_id` (`role_id`),
  CONSTRAINT `FK_USER_address_id` FOREIGN KEY (`address_id`) REFERENCES `address` (`ID_ADDRESS`),
  CONSTRAINT `FK_USER_document_type_id` FOREIGN KEY (`document_type_id`) REFERENCES `document_type` (`DOCUMENT_TYPE`),
  CONSTRAINT `FK_USER_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'2025-07-03','alex@upn.pe',NULL,'Alex',1,'Conde',NULL,'12',NULL,NULL,NULL,NULL,NULL,NULL),(2,'2024-05-01','juan.perez@example.com','999111222','Alex',1,'Conde','DNI002','12','987654321','2025-07-04','images/profile/efc95429-136d-4797-a441-c9940444896e-7339f315-4349-4a13-890d-c324c6cd40a5.jpg',1,1,NULL),(3,'2024-05-02','maria.lopez@example.com','988222333','María',1,'López','DNI003','12','987123456','2025-07-04',NULL,1,1,NULL),(4,'2025-06-07','admin@arbin.com','999999999','Admin',1,'Principal','7474612','12','987654321','2025-06-07',NULL,1,2,NULL),(5,'2024-05-03','carlos.sanchez@example.com','977333444','Carlos',1,'Sánchez','DNI004','12','981234567','2025-07-04',NULL,1,1,NULL),(6,'2024-05-04','ana.torres@example.com','966444555','Ana',1,'Torres','DNI005','12','982345678','2024-05-10',NULL,1,1,NULL),(7,'2024-05-05','luis.ramirez@example.com','955555666','Luis',1,'Ramírez','DNI006','12','983456789','2024-05-10',NULL,1,1,NULL),(8,'2024-05-06','patricia.morales@example.com','944666777','Patricia',1,'Morales','DNI007','12','984567890','2024-05-10',NULL,1,1,NULL),(9,'2024-05-07','diego.rojas@example.com','933777888','Diego',1,'Rojas','DNI008','12','985678901','2024-05-10',NULL,1,1,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-10 12:48:40
