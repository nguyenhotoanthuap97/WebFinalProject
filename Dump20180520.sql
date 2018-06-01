-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.7.22-log

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `username` varchar(50) NOT NULL,
  `password` varchar(32) NOT NULL,
  `type` varchar(5) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
REPLACE INTO `account` (`username`, `password`, `type`) VALUES ('admin','admin','1'),('user1','user1','0');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bill` (
  `idBill` int(11) NOT NULL AUTO_INCREMENT,
  `customer` varchar(50) NOT NULL,
  `time` varchar(45) NOT NULL,
  `state` varchar(10) NOT NULL DEFAULT 'Chưa giao',
  `address` varchar(100) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `shipMethod` varchar(50) NOT NULL DEFAULT 'Miễn Phí',
  `payMethod` varchar(45) NOT NULL DEFAULT 'Tiền mặt',
  PRIMARY KEY (`idBill`),
  KEY `Bill_Accout_PK_idx` (`customer`),
  CONSTRAINT `Bill_Accout_PK` FOREIGN KEY (`customer`) REFERENCES `account` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill_info`
--

DROP TABLE IF EXISTS `bill_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bill_info` (
  `idBill_info` int(11) NOT NULL AUTO_INCREMENT,
  `idBill` int(11) NOT NULL,
  `product` int(11) NOT NULL,
  `count` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idBill_info`),
  KEY `Idbill_Bill_PK_idx` (`idBill`),
  KEY `BillInfo_Product_PK_idx` (`product`),
  CONSTRAINT `BillInfo_Bill_PK` FOREIGN KEY (`idBill`) REFERENCES `bill` (`idBill`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `BillInfo_Product_PK` FOREIGN KEY (`product`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_info`
--

LOCK TABLES `bill_info` WRITE;
/*!40000 ALTER TABLE `bill_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brand` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
REPLACE INTO `brand` (`id`, `name`) VALUES (3,'Acer'),(6,'Apple'),(2,'Asus'),(1,'Dell'),(4,'HP'),(5,'MSI');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `decription` varchar(2048) NOT NULL DEFAULT 'Không có mô tả',
  `ngaydang` date NOT NULL,
  `buyTimes` int(11) NOT NULL,
  `viewTimes` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `brand` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `picture` varchar(45) DEFAULT NULL,
  `config` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ten_UNIQUE` (`name`),
  KEY `Product_Brand_PK_idx` (`brand`),
  KEY `Product_Type_PK_idx` (`type`),
  CONSTRAINT `Product_Brand_PK` FOREIGN KEY (`brand`) REFERENCES `brand` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Product_Type_PK` FOREIGN KEY (`type`) REFERENCES `type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
REPLACE INTO `product` (`id`, `name`, `decription`, `ngaydang`, `buyTimes`, `viewTimes`, `price`, `brand`, `type`, `picture`, `config`) VALUES (1,'Dell Vostro 15 3578-NGMPF11','NULL','2016-05-15',0,10,1000,1,1,'Dell1',''),(2,'Dell Vostro 3468 ','NULL','2015-02-12',0,11,600,1,1,'Dell2',''),(3,'Dell Inspiron 14 3467-M20NR1','NULL','2017-06-24',0,10,500,1,1,'Dell3',''),(4,'Dell Inspiron 3467','NULL','2018-02-11',0,12,660,1,1,'Dell4','NULL'),(5,'Dell Inspiron 3567','NULL','2018-01-01',0,14,500,1,1,'Dell5','NULL'),(6,'Dell Vostro 5568','NULL','2017-06-24',0,25,550,1,1,'Dell6','NULL'),(7,'Dell Inspiron 5570','NULL','2017-06-24',0,61,500,1,1,'Dell7','NULL'),(8,'Dell Precision M6800','NULL','2015-02-12',0,3,3490,1,2,'Dell8','NULL'),(9,'Dell Precision M3800','NULL','2015-02-12',0,24,2236,1,2,'Dell9','NULL'),(10,'Dell Precision M5520','NULL','2017-06-24',0,21,2035,1,2,'Dell10','NULL'),(11,'Asus X441NA N4200 (GA070T)','NULL','2018-02-11',0,45,250,2,1,'Asus1','NULL'),(12,'Asus X441UA(WX027T)','NULL','2015-02-12',0,24,450,2,1,'Asus5','NULL'),(13,'Asus X541UA','NULL','2015-02-12',0,56,550,2,1,'Asus3','NULL'),(14,'Asus UX430UA','NULL','2015-02-12',0,61,1023,2,1,'Asus4','NULL'),(15,'Asus Gaming GL552VX DM070D (Black)','NULL','2015-02-12',0,62,1100,2,3,'Asus2','NULL'),(16,'Asus GL552JX-DM144D','NULL','2017-06-24',0,124,1200,2,3,'Asus6','NULL'),(17,'Asus A540UP','NULL','2018-02-11',0,12,600,2,1,'Asus7','NULL'),(18,'Asus X542UQ','NULL','2018-01-01',0,41,700,2,1,'Asus8','NULL'),(19,'Asus S510UQ','NULL','2015-02-12',0,5,860,2,1,'Asus9','NULL'),(20,'Asus X405UA','NULL','2015-02-12',0,62,500,2,1,'Asus10','NULL'),(21,'Acer Spin 3 SP314','NULL','2017-06-24',0,62,600,3,1,'Acer1','NULL'),(22,'Acer ES1 533','NULL','2017-06-24',0,3,300,3,1,'Acer2','NULL'),(23,'Acer Swift SF314-51-58CC NX.GKKSV.004','NULL','2017-06-24',0,4,750,3,1,'Acer3','NULL'),(24,'Acer Gaming VX5-591G-52YZ NH.GM2SV.002','NULL','2017-06-24',0,5,1100,3,3,'Acer4','NULL'),(25,'Acer G3-572-70J1 (NH.Q2CSV.003)','NULL','2015-02-12',0,6,1300,3,3,'Acer5','NULL'),(26,'Acer G3-572-50XL (NH.Q2CSV.001)','NULL','2015-02-12',0,2,1400,3,3,'Acer9','NULL'),(27,'Acer Aspire ES1 432','NULL','2017-06-24',0,16,300,3,1,'Acer6','NULL'),(28,'Acer Aspire E5 575G','NULL','2017-06-24',0,6,800,3,1,'Acer7','NULL'),(29,'Acer Swift SF314 32EX','NULL','2017-06-24',0,25,790,3,4,'Acer8','NULL'),(30,'Acer Aspire E5 570G','NULL','2017-06-24',0,56,750,3,1,'Acer10','NULL'),(31,'HP 15 bs641TU','NULL','2015-02-12',0,1,300,4,1,'Hp1','NULL'),(32,'HP Pavilion X360 ad032TU','NULL','2015-02-12',0,36,650,4,1,'Hp2','NULL'),(33,'HP Pavilion 14 bf019TU','NULL','2017-06-24',0,61,590,4,1,'Hp3','NULL'),(34,'HP 15 bs572TU','NULL','2017-06-24',0,12,490,4,1,'Hp4','NULL'),(35,'HP 15 bs571TU','NULL','2017-02-06',0,2,450,4,1,'Hp5','NULL'),(36,'HP Pavilion X360 ad026TU','NULL','2018-01-01',0,4,700,4,1,'Hp6','NULL'),(37,'HP Envy 13 ad158TU','NULL','2015-02-12',0,5,1000,4,1,'Hp7','NULL'),(38,'HP 15 bs575TU','NULL','2015-02-12',0,31,500,4,1,'Hp8','NULL'),(39,'HP 15 bs768TX','NULL','2017-06-24',0,6,850,4,1,'Hp9','NULL'),(40,'HP Envy 13 ad160TU','NULL','2015-02-12',0,2,1205,4,1,'Hp10','NULL'),(41,'MSI GP62MVR 7RFX-892XVN','NULL','2015-02-12',0,42,1620,5,3,'MSI1','NULL'),(42,'MSI GV72 7RE-1424XVN','NULL','2015-02-12',0,51,1100,5,3,'MSI2','NULL'),(43,'MSI GP72M 7REX-1216XVN','NULL','2015-02-12',0,2,1300,5,3,'MSI3','NULL'),(44,'MSI GS63 7RD- 093XVN','NULL','2015-02-12',0,5,1300,5,3,'MSI4','NULL'),(45,'MSI GV62 7RD-2823VN','NULL','2015-02-12',0,3,1290,5,3,'MSI5','NULL'),(46,'MSI GL63 8RD-099VN','NULL','2018-02-11',0,23,1400,5,3,'MSI6','NULL'),(47,'MSI GV72 7RD-874XVN','NULL','2017-02-06',0,3,1150,5,3,'MSI7','NULL'),(48,'MSI GV62 7RD-1883XVN','NULL','2016-05-15',0,62,1100,5,3,'MSI8','NULL'),(49,'MSI GP62M 7REX-1497XVN','NULL','2015-02-12',0,12,1500,5,3,'MSI9','NULL'),(50,'MSI GV62 7RD-1882XVN','NULL','2017-11-11',0,6,1200,5,3,'MSI10','NULL'),(51,'Apple Macbook Air MQD32SA/A','NULL','2018-01-01',0,85,1000,6,1,'Mac1','NULL'),(52,'MacBook Air MQD42ZP/A','NULL','2016-05-15',0,57,1400,6,1,'Mac2','NULL'),(53,'MacBook 13.3 MPXW2LL/A\"','NULL','2018-01-01',0,56,2500,6,1,'Mac3','NULL'),(54,'MacBook 13.3 MPXV2LL/A (Xám)\"','NULL','2016-05-15',0,23,2200,6,1,'Mac4','NULL'),(55,'MacBook 15 MPTR2SA/A\"','NULL','2018-01-01',0,36,3000,6,1,'Mac5','NULL'),(56,'MacBook 12 MNYM2ZP/A\"','NULL','2017-06-24',0,37,1600,6,1,'Mac6','NULL');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_bill`
--

DROP TABLE IF EXISTS `report_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idBill` int(11) NOT NULL,
  `content` varchar(200) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Report_Bill_PK_idx` (`idBill`),
  CONSTRAINT `Report_Bill_PK` FOREIGN KEY (`idBill`) REFERENCES `bill` (`idBill`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_bill`
--

LOCK TABLES `report_bill` WRITE;
/*!40000 ALTER TABLE `report_bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
REPLACE INTO `type` (`id`, `name`) VALUES (1,'Business'),(3,'Gaming'),(4,'Ultrabook'),(2,'Workstation');
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_info` (
  `username` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `birthday` date DEFAULT NULL,
  `sex` varchar(5) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `phone` varchar(10) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `Userinfo_Account_PK` FOREIGN KEY (`username`) REFERENCES `account` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
REPLACE INTO `user_info` (`username`, `name`, `birthday`, `sex`, `address`, `phone`, `email`) VALUES ('user1','Nguyễn Đình Tiến','1997-08-20','Nam','181/3, Tân Phước,p6,q10,TPHCM','012345567','tienandehit@gmail.com');
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'mydb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-20 11:07:38