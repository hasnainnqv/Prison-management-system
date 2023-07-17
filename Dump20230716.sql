-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: priosn_management
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `cell`
--

DROP TABLE IF EXISTS `cell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cell` (
  `CellID` varchar(4) NOT NULL,
  `PrisonID` varchar(20) NOT NULL,
  `Capacity` varchar(3) DEFAULT NULL,
  `Occupancy` varchar(3) DEFAULT NULL ,
  PRIMARY KEY (`CellID`,`PrisonID`),
  KEY `PrisonID` (`PrisonID`),
  CONSTRAINT `cell_ibfk_1` FOREIGN KEY (`PrisonID`) REFERENCES `prison` (`prisonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cell`
--

LOCK TABLES `cell` WRITE;
/*!40000 ALTER TABLE `cell` DISABLE KEYS */;
INSERT INTO `cell` VALUES ('CE01','PR01','25','14'),('CE02','PR01','25','13'),('CE03','PR02','25','21'),('CE04','PR03','25','22');
/*!40000 ALTER TABLE `cell` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `empid` char(6) NOT NULL,
  `prisonID` char(4) DEFAULT NULL,
  `staff_type` char(5) DEFAULT NULL,
  PRIMARY KEY (`empid`),
  KEY `prisonID` (`prisonID`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`prisonID`) REFERENCES `prison` (`prisonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES ('EMP01','PR01','staff'),('EMP02','PR01','staff'),('EMP03','PR02','guard'),('EMP04','PR01','guard'),('EMP05','PR02','guard'),('EMP06','PR03','guard'),('EMP08','PR03','staff'),('EMP09','PR01','GUARD'),('EMP10','PR01','GUARD'),('EMP11','PR01','GUARD'),('EMP12','PR01','STAFF'),('EMP13','PR01','STAFF'),('EMP14','PR01','STAFF'),('EMP15','PR01','STAFF'),('EMP16','PR02','GUARD'),('EMP17','PR02','GUARD'),('EMP18','PR02','GUARD'),('EMP19','PR02','GUARD'),('EMP20','PR02','GUARD'),('EMP21','PR03','GUARD'),('EMP22','PR03','GUARD'),('EMP23','PR03','GUARD'),('EMP24','PR03','GUARD'),('EMP25','PR03','GUARD'),('EMP26','PR02','STAFF'),('EMP27','PR02','STAFF'),('EMP28','PR02','STAFF'),('EMP29','PR02','STAFF'),('EMP30','PR03','STAFF'),('EMP31','PR03','STAFF'),('EMP32','PR03','STAFF'),('EMP33','PR03','STAFF'),('EMP34','PR03','STAFF');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guard`
--

DROP TABLE IF EXISTS `guard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guard` (
  `GuardID` varchar(4) NOT NULL,
  `FirstName` varchar(20) DEFAULT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Sex` char(1) DEFAULT NULL CHECK ( `Sex` IN ('M', 'F')),
  `Address` varchar(30) DEFAULT NULL,
  `PhoneNum` varchar(13) DEFAULT NULL,
  `empid` char(6) DEFAULT NULL,
  PRIMARY KEY (`GuardID`),
  KEY `empid` (`empid`),
  constraint `guard_ibfk_1` FOREIGN KEY (`empid`) REFERENCES `employees` (`empid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guard`
--

LOCK TABLES `guard` WRITE;
/*!40000 ALTER TABLE `guard` DISABLE KEYS */;
INSERT INTO `guard` VALUES ('GR01','Shayan','Zahid','1979-03-23','M','345, Johar, PK','0213-758-7455','EMP03'),('GR02','Hammad','Jamal','1980-04-22','M','456, Johar, PK','0213-298-9548','EMP04'),('GR03','FAKHAR','KHAN','2002-09-01','M','LIYARI','03121163817','EMP05'),('GR04','MUSTAFA','ZAHID','1899-01-04','M','JOHAR','03122235606','EMP06'),('GR05','John','Doe','1990-05-15','M','123 Elm Street','1234567890','EMP09'),('GR06','Emma','Smith','1993-12-28','F','456 Oak Avenue','9876543210','EMP10'),('GR07','Michael','Johnson','1988-07-10','M','789 Pine Road','5555555555','EMP11'),('GR08','Adam','Wilson','1992-03-20','M','123 Elm Street','1234567890','EMP16'),('GR09','Sophia','Thompson','1995-11-10','F','456 Oak Avenue','9876543210','EMP17'),('GR10','Daniel','Harris','1989-08-05','M','789 Pine Road','5555555555','EMP18'),('GR11','Olivia','Clark','1994-05-25','F','987 Cedar Lane','1234567890','EMP19'),('GR12','William','Davis','1991-09-15','M','654 Maple Court','9876543210','EMP20'),('GR13','Ethan','Anderson','1992-06-12','M','123 Elm Street','1234567890','EMP21'),('GR14','Olivia','Johnson','1995-09-25','F','456 Oak Avenue','9876543210','EMP22'),('GR15','Mason','Smith','1989-12-10','M','789 Pine Road','5555555555','EMP23'),('GR16','Sophia','Martinez','1994-03-15','F','987 Cedar Lane','1234567890','EMP24'),('GR17','Liam','Garcia','1991-08-20','M','654 Maple Court','9876543210','EMP25');
/*!40000 ALTER TABLE `guard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prison`
--

DROP TABLE IF EXISTS `prison`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prison` (
  `prisonID` varchar(20) NOT NULL,
  `PrisonName` varchar(20) DEFAULT NULL,
  `Address` varchar(30) DEFAULT NULL,
  `Capacity` char(3) DEFAULT NULL,
  `PhoneNum` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`prisonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prison`
--

LOCK TABLES `prison` WRITE;
/*!40000 ALTER TABLE `prison` DISABLE KEYS */;
INSERT INTO `prison` VALUES ('PR01','San Quentin','1 Main St, San Quentin, CA','300','0213-123-4567'),('PR02','Sing Sing','1000, River Road, Ossining, NY','400','0213-234-5678'),('PR03','SAN WANGO','FC AREA','200','0213-231-2321');
/*!40000 ALTER TABLE `prison` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prisoner`
--

DROP TABLE IF EXISTS `prisoner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prisoner` (
  `PrisonerID` varchar(5) NOT NULL,
  `FirstName` varchar(20) DEFAULT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  `DOB` char(10) DEFAULT NULL,
  `Sex` char(1) DEFAULT NULL   CHECK(`Sex` IN ('M', 'F')),
  `Address` varchar(40) DEFAULT NULL,
  `DateOfAdmission` char(10) DEFAULT NULL,
  `DateOfRelease` char(10) DEFAULT NULL,
  `Offense` varchar(30) DEFAULT NULL,
  `cellID` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`PrisonerID`),
  KEY `cellID` (`cellID`),
  CONSTRAINT `prisoner_ibfk_1` FOREIGN KEY (`cellID`) REFERENCES `cell` (`cellID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prisoner`
--

LOCK TABLES `prisoner` WRITE;
/*!40000 ALTER TABLE `prisoner` DISABLE KEYS */;
INSERT INTO `prisoner` VALUES ('PE01','John','Doe','1990-01-01','M','123 Main Street','2022-02-01','2023-01-31','THEFT','CE01'),('PE02','Ibrahim','Nazir','2000-05-06','M','789 Karachi','2021-11-22','2025-08-31','BATTERY','CE01'),('PE03','Zahid','David','2000-05-03','M','128 gulshan','2021-09-22','2025-07-31','HARASSMENT','CE02'),('PE04','Shawn','Michael','1985-04-03','M','','2011-09-22','2019-07-31','MURDER','CE01'),('PE05','Roman','Kane','1986-09-03','M','street 45','2019-09-22','2021-07-31','VIOLATION','CE02'),('PE06','AFIA','SIDDIQUI','1890-04-07','F','JOHAR MOR','2023-03-12','2025-01-01','FRAUD','CE02'),('PE07','SHAZIA','SIDDIQUI','1880-04-07','F','SINDBAD','2023-03-11','2025-01-02','KILLER','CE01'),('PE08','SHAZAIN','RAZA','1999-02-09','M','CREEK SOCIETY','2023-09-01','2027-08-07','THEFT','CE03'),('PE09','JAMAL','ADIL','2001-02-02','M','AL ASIF','2023-02-02','2024-02-02','HARASSMENT','CE04'),('PE10','John','Doe','1992-05-10','M','456 Elm Street','2022-07-15','2023-07-15','Burglary','CE02'),('PE11','Jane','Smith','1988-12-20','M','789 Oak Avenue','2022-09-03','2023-09-03','Fraud','CE02'),('PE12','Michael','Johnson','1990-07-08','M','321 Pine Road','2022-06-25','2023-06-25','Assault','CE02'),('PE13','Emily','Williams','1995-03-18','M','987 Cedar Lane','2022-11-11','2023-11-11','Drug Possession','CE02'),('PE14','David','Brown','1987-09-02','M','654 Maple Court','2022-08-07','2023-08-07','Forgery','CE02'),('PE15','Sarah','Anderson','1993-11-30','M','543 Birch Street','2022-10-19','2023-10-19','Embezzlement','CE02'),('PE16','Matthew','Taylor','1989-06-12','M','876 Spruce Avenue','2022-12-28','2023-12-28','Kidnapping','CE02'),('PE17','Olivia','Martinez','1994-04-25','M','234 Juniper Road','2022-07-31','2023-07-31','Robbery','CE02'),('PE18','Daniel','Garcia','1991-02-14','M','789 Pine Lane','2022-09-16','2023-09-16','Fraud','CE02'),('PE19','Sophia','Clark','1996-08-05','M','567 Oak Street','2022-11-04','2023-11-04','Drug Possession','CE02'),('PE20','Mark','Johnson','1993-08-12','M','789 Elm Street','2022-06-25','2023-06-25','Assault','CE01'),('PE21','Emma','Williams','1991-02-28','M','543 Oak Avenue','2022-08-10','2023-08-10','Forgery','CE01'),('PE22','Ryan','Smith','1989-11-02','M','456 Cedar Lane','2022-07-15','2023-07-15','Burglary','CE01'),('PE23','Sophie','Brown','1994-05-17','M','876 Pine Road','2022-09-03','2023-09-03','Fraud','CE01'),('PE24','Daniel','Anderson','1990-12-22','M','234 Maple Court','2022-06-30','2023-06-30','Kidnapping','CE01'),('PE25','Grace','Taylor','1995-03-10','M','987 Birch Street','2022-08-18','2023-08-18','Drug Possession','CE01'),('PE26','Andrew','Martinez','1988-09-05','M','321 Spruce Avenue','2022-07-07','2023-07-07','Robbery','CE01'),('PE27','Oliver','Garcia','1992-11-15','M','567 Pine Lane','2022-09-25','2023-09-25','Embezzlement','CE01'),('PE28','Nora','Clark','1996-01-08','M','789 Oak Street','2022-08-01','2023-08-01','Fraud','CE01'),('PE29','Liam','Davis','1993-06-20','M','654 Cedar Court','2022-10-10','2023-10-10','Harassment','CE01'),('PE30','Lucas','Smith','1990-04-15','M','456 Elm Street','2022-07-15','2023-07-15','Assault','CE03'),('PE31','Isabella','Brown','1995-01-25','M','789 Oak Avenue','2022-09-03','2023-09-03','Fraud','CE03'),('PE32','Logan','Johnson','1993-07-10','M','321 Pine Road','2022-06-25','2023-06-25','Burglary','CE03'),('PE33','Ava','Anderson','1988-11-18','M','987 Cedar Lane','2022-11-11','2023-11-11','Drug Possession','CE03'),('PE34','Mason','Williams','1992-09-02','M','654 Maple Court','2022-08-07','2023-08-07','Forgery','CE03'),('PE35','Harper','Martin','1997-02-28','M','543 Birch Street','2022-10-19','2023-10-19','Embezzlement','CE03'),('PE36','Ethan','Wilson','1994-06-12','M','876 Spruce Avenue','2022-12-28','2023-12-28','Kidnapping','CE03'),('PE37','Amelia','Taylor','1989-08-25','M','234 Juniper Road','2022-07-31','2023-07-31','Robbery','CE03'),('PE38','Benjamin','Davis','1991-03-14','M','789 Pine Lane','2022-09-16','2023-09-16','Fraud','CE03'),('PE39','Abigail','Miller','1996-07-05','M','567 Oak Street','2022-11-04','2023-11-04','Drug Possession','CE03'),('PE40','James','Garcia','1993-02-17','M','654 Cedar Court','2022-08-20','2023-08-20','Harassment','CE03'),('PE41','Charlotte','Jones','1987-12-30','M','876 Elm Street','2022-09-03','2023-09-03','Forgery','CE03'),('PE42','Henry','White','1994-05-08','M','543 Oak Avenue','2022-07-15','2023-07-15','Burglary','CE03'),('PE43','Emily','Lee','1990-10-18','M','987 Pine Road','2022-10-01','2023-10-01','Assault','CE03'),('PE44','Alexander','Allen','1995-06-22','M','321 Cedar Lane','2022-08-07','2023-08-07','Fraud','CE03'),('PE45','Grace','Scott','1993-11-10','M','654 Maple Court','2022-10-19','2023-10-19','Forgery','CE03'),('PE46','Samuel','Robinson','1988-09-05','M','876 Birch Street','2022-12-01','2023-12-01','Kidnapping','CE03'),('PE47','Chloe','Harris','1996-01-08','M','234 Spruce Avenue','2022-08-15','2023-08-15','Robbery','CE03'),('PE48','Joseph','Clark','1992-06-20','M','567 Pine Lane','2022-09-25','2023-09-25','Embezzlement','CE03'),('PE50','Oliver','Hernandez','1993-09-10','M','123 Elm Street','2022-07-01','2023-07-01','Assault','CE04'),('PE51','Sophia','Rodriguez','1996-05-18','M','456 Oak Avenue','2022-08-15','2023-08-15','Fraud','CE04'),('PE52','Mason','Lopez','1989-12-07','M','789 Pine Road','2022-06-20','2023-06-20','Burglary','CE04'),('PE53','Emma','Gonzalez','1994-02-22','M','987 Cedar Lane','2022-09-10','2023-09-10','Drug Possession','CE04'),('PE54','Ava','Gomez','1991-07-05','M','654 Maple Court','2022-08-01','2023-08-01','Forgery','CE04'),('PE55','Noah','Perez','1996-01-28','M','543 Birch Street','2022-10-18','2023-10-18','Embezzlement','CE04'),('PE56','Charlotte','Sanchez','1988-11-20','M','876 Spruce Avenue','2022-12-05','2023-12-05','Kidnapping','CE04'),('PE57','Sophie','Rivera','1993-03-14','M','234 Juniper Road','2022-07-25','2023-07-25','Robbery','CE04'),('PE58','Liam','Torres','1990-08-25','M','789 Pine Lane','2022-09-15','2023-09-15','Fraud','CE04'),('PE59','Isabella','Reyes','1995-04-11','M','567 Oak Street','2022-11-01','2023-11-01','Drug Possession','CE04'),('PE60','Lucas','Ramos','1992-10-30','M','654 Cedar Court','2022-08-10','2023-08-10','Harassment','CE04'),('PE61','Amelia','Ortega','1987-12-15','M','876 Elm Street','2022-09-05','2023-09-05','Forgery','CE04'),('PE62','Henry','Vargas','1994-06-08','M','543 Oak Avenue','2022-07-10','2023-07-10','Burglary','CE04'),('PE63','Ella','Morales','1991-10-25','M','987 Pine Road','2022-10-03','2023-10-03','Assault','CE04'),('PE64','Jackson','Castillo','1995-07-11','M','321 Cedar Lane','2022-08-20','2023-08-20','Fraud','CE04'),('PE65','Scarlett','Fernandez','1993-12-05','M','654 Maple Court','2022-10-15','2023-10-15','Forgery','CE04'),('PE66','Wyatt','Guerrero','1988-10-30','M','876 Birch Street','2022-12-10','2023-12-10','Kidnapping','CE04'),('PE67','Chloe','Cruz','1996-02-08','M','234 Spruce Avenue','2022-08-25','2023-08-25','Robbery','CE04'),('PE68','James','Mendoza','1992-07-20','M','567 Pine Lane','2022-09-20','2023-09-20','Embezzlement','CE04'),('PE69','Madison','Navarro','1997-04-05','M','789 Oak Street','2022-11-05','2023-11-05','Fraud','CE04'),('PE70','Elijah','Santos','1993-08-17','M','654 Cedar Court','2022-08-30','2023-08-30','Forgery','CE04');
/*!40000 ALTER TABLE `prisoner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `StaffID` int NOT NULL,
  `StartDate` date DEFAULT NULL,
  `Age` int DEFAULT NULL,
  `FirstName` varchar(30) DEFAULT NULL,
  `LastName` varchar(30) DEFAULT NULL,
  `Designation` varchar(30) DEFAULT NULL,
  `empid` char(6) DEFAULT NULL,
  PRIMARY KEY (`StaffID`),
  KEY `empid` (`empid`),
  CONSTRAINT `staff_ibfk_2` FOREIGN KEY (`empid`) REFERENCES `employees` (`empid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (100,'2020-05-07',48,'Jake ','Peralta','Warden','EMP01'),(101,'2020-06-14',40,'Mike ','Ross','Doctor','EMP02'),(103,'2000-02-01',49,'ZUBAIR','KHAN','INSPECTOR','EMP08'),(104,'2022-07-01',32,'Sarah','Wilson','Manager','EMP12'),(105,'2022-08-15',28,'Daniel','Thompson','Supervisor','EMP13'),(106,'2022-06-20',35,'Emily','Harris','Coordinator','EMP14'),(107,'2022-09-10',30,'Michael','Clark','Officer','EMP15'),(108,'2022-07-01',32,'Sophie','Wilson','Manager','EMP26'),(109,'2022-08-15',28,'Ethan','Thompson','Supervisor','EMP27'),(110,'2022-06-20',35,'Olivia','Harris','Coordinator','EMP28'),(111,'2022-09-10',30,'Liam','Clark','Officer','EMP29'),(112,'2022-07-01',32,'Oliver','Wilson','Manager','EMP30'),(113,'2022-08-15',28,'Emma','Thompson','Supervisor','EMP31'),(114,'2022-06-20',35,'William','Harris','Coordinator','EMP32'),(115,'2022-09-10',30,'Sophia','Clark','Officer','EMP33'),(116,'2022-10-05',29,'Henry','Garcia','Officer','EMP34');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitation`
--

DROP TABLE IF EXISTS `visitation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitation` (
  `VisitorID` int NOT NULL,
  `PrisonerID` varchar(5) NOT NULL,
  `VisitDate` date DEFAULT NULL,
  `Relation` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`VisitorID`,`PrisonerID`),
  KEY `PrisonerID` (`PrisonerID`),
  CONSTRAINT `visitation_ibfk_1` FOREIGN KEY (`PrisonerID`) REFERENCES `prisoner` (`PrisonerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitation`
--

LOCK TABLES `visitation` WRITE;
/*!40000 ALTER TABLE `visitation` DISABLE KEYS */;
INSERT INTO `visitation` VALUES (1,'PE01','2023-03-25','Father'),(2,'PE02','2022-12-31','Brother'),(3,'PE02','2023-09-09','FATHER'),(4,'PE02','2022-01-10','mother'),(5,'PE08','2021-09-01','Son');
/*!40000 ALTER TABLE `visitation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-16  2:45:12
