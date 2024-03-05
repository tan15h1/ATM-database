-- MySQL dump 10.13  Distrib 8.0.33, for macos13 (arm64)
--
-- Host: 127.0.0.1    Database: banking_system
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `account_num` int NOT NULL AUTO_INCREMENT,
  `acct_type` enum('Savings','Checking') DEFAULT NULL,
  `acct_balance` decimal(10,2) DEFAULT NULL,
  `pin_num` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  PRIMARY KEY (`account_num`),
  KEY `fk_account_customer` (`customer_id`),
  CONSTRAINT `fk_account_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'Savings',1000.00,1234,3),(2,'Checking',2500.00,5678,5),(3,'Checking',500.00,9876,6),(4,'Savings',3500.00,4321,1),(5,'Checking',2000.00,2468,2),(6,'Savings',1500.00,1357,7),(7,'Checking',3000.00,8642,9),(8,'Savings',1200.00,9753,4),(9,'Checking',2800.00,3141,8),(10,'Savings',1800.00,5926,10),(11,'Savings',2200.00,5926,12),(12,'Checking',1800.00,8642,13),(13,'Savings',3500.00,2468,11),(14,'Savings',4100.00,5678,14),(15,'Checking',2900.00,1234,15);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `atm`
--

DROP TABLE IF EXISTS `atm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `atm` (
  `atm_id` varchar(10) NOT NULL,
  `branch_id` int DEFAULT NULL,
  `atm_address` varchar(100) DEFAULT NULL,
  `atm_zip` varchar(10) DEFAULT NULL,
  `atm_city` varchar(50) DEFAULT NULL,
  `atm_state` varchar(50) DEFAULT NULL,
  `operation_time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`atm_id`),
  KEY `fk_atm_branch` (`branch_id`),
  CONSTRAINT `fk_atm_branch` FOREIGN KEY (`branch_id`) REFERENCES `bank_branch` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atm`
--

LOCK TABLES `atm` WRITE;
/*!40000 ALTER TABLE `atm` DISABLE KEYS */;
INSERT INTO `atm` VALUES ('MA-0001',255249,'6 Tremont St','02108','Boston','MA','Hours vary'),('MA-0002',570400,'33 State St','02109','Boston','MA','Monday - Friday 8:30 AM - 5:00 PM'),('MA-0003',500171,'100 Franklin St','02110','Boston','MA','24 hours'),('MA-0004',440186,'621 Washington St','02111','Boston','MA','Monday - Friday 9:00 AM - 5:00 PM, Saturday 10:00 AM - 2:00 PM'),('MA-0005',193122,'260 Hanover St','02113','Boston','MA','Hours Vary'),('MA-0006',193351,'6 Francis St','02215','Boston','MA','24 hours'),('MA-0007',193351,'350 Longwood Avenue','02115','Boston','MA','Monday - Saturday 6:30 AM - 10:00 PM, Sunday 6:30 AM - 8:00 PM'),('MA-0008',193351,'400 The Fenway','02115','Boston','MA','N/A'),('MA-0009',193351,'121 Brookline Avenue','02215','Boston','MA','24 hours'),('MA-0010',42211,'279 Massachusetts Ave','02115','Boston','MA','Monday - Thursday 9:00 AM - 5:00 PM, Friday 9:00 AM - 6:00 PM, Saturday 9:00 AM - 1:00 PM'),('MA-0011',42211,'231 Massachusetts Ave','02115','Boston','MA','Monday - Sunday 7:00 AM - 10:00 PM'),('MA-0012',42211,'369 Huntington Avenue','02115','Boston','MA','24 hours'),('MA-0013',42211,'800 Boylston Street','02199','Boston','MA','Monday - Sunday 8:00 AM - 9:00 PM'),('MA-0014',621880,'280 Huntington Ave','02115','Boston','MA','Monday - Friday 9:00 AM - 5:00 PM, Saturday 9:00 AM - 1:00 PM'),('MA-0015',621880,'280 Huntington Ave','02115','Boston','MA','Monday - Friday 9:00 AM - 5:00 PM, Saturday 9:00 AM - 1:00 PM'),('MA-0016',621880,'280 Huntington Ave','02115','Boston','MA','Monday - Friday 9:00 AM - 5:00 PM, Saturday 9:00 AM - 1:00 PM'),('MA-0017',255236,'285 Huntington Ave','02115','Boston','MA','Hours Vary'),('MA-0018',575676,'491 Boylston St','02116','Boston','MA','Monday - Friday 9:00 AM - 4:00 PM, Saturday 9:00 AM - 12:00 PM'),('MA-0019',576428,'25 Stuart St','02116','Boston','MA','24 hours'),('MA-0020',258862,'3060 Washington Stree','02119','Boston','MA','24 hours'),('MA-0021',619407,'701 Centre St','02130','Boston','MA','24 hours'),('MA-0022',619407,'701 Centre St','02130','Boston','MA','24 hours');
/*!40000 ALTER TABLE `atm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_branch`
--

DROP TABLE IF EXISTS `bank_branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_branch` (
  `branch_id` int NOT NULL,
  `branch_name` varchar(100) DEFAULT NULL,
  `branch_company` int NOT NULL,
  `vault_cash` decimal(10,2) DEFAULT '0.00',
  `num_tellers` int DEFAULT '0',
  `branch_street` varchar(100) DEFAULT NULL,
  `branch_zip` varchar(10) DEFAULT NULL,
  `branch_city` varchar(100) DEFAULT NULL,
  `branch_state` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`branch_id`),
  KEY `fk_branch_company` (`branch_company`),
  CONSTRAINT `fk_branch_company` FOREIGN KEY (`branch_company`) REFERENCES `bank_company` (`company_fdic_cert_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_branch`
--

LOCK TABLES `bank_branch` WRITE;
/*!40000 ALTER TABLE `bank_branch` DISABLE KEYS */;
INSERT INTO `bank_branch` VALUES (6,'State Street Bank And Trust Company',14,1500000.00,5,'One Congress Street Suite 1','02114','Boston','MA'),(42211,'Mass Avenue Branch',29950,1700000.00,6,'279 Massachusetts Ave','02115','Boston','MA'),(193122,'North End Branch',3510,2000000.00,7,'260 Hanover St','02113','Boston','MA'),(193351,'Boston - Brigham Circle Branch',29950,2800000.00,9,'6 Francis St','02215','Boston','MA'),(255236,'Huntington Avenue Branch',3510,1600000.00,5,'285 Huntington Ave','02115','Boston','MA'),(255249,'Tremont Street Branch',3510,2500000.00,8,'6 Tremont St','02108','Boston','MA'),(258862,'Boston-Egleston Square Branch',29950,1400000.00,5,'3060 Washington St','02119','Boston','MA'),(290976,'Brigham Circle Branch',57957,2700000.00,8,'1628 Tremont St','02120','Boston','MA'),(440186,'Boston Branch',18503,3000000.00,10,'621 Washington St','02111','Boston','MA'),(500171,'Boston Branch',18221,1000000.00,3,'100 Franklin St','02110','Boston','MA'),(541133,'Clarendon Street Branch',17798,2300000.00,7,'131 Clarendon St','02116','Boston','MA'),(570400,'State Street Branch',17798,1200000.00,4,'33 State St','02109','Boston','MA'),(575676,'Copley Square Branch',18221,1100000.00,4,'491 Boylston St','02116','Boston','MA'),(576428,'Chinatown Branch',18221,2600000.00,9,'25 Stuart St','02116','Boston','MA'),(619407,'Jamaica Plain',628,1300000.00,4,'701 Centre St','02130','Boston','MA'),(621880,'Huntington Ave Branch',628,2200000.00,8,'280 Huntington Ave','02115','Boston','MA'),(629684,'Mass Ave Branch',57957,900000.00,3,'183 Massachusetts Ave','02115','Boston','MA');
/*!40000 ALTER TABLE `bank_branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_company`
--

DROP TABLE IF EXISTS `bank_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_company` (
  `company_fdic_cert_num` int NOT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `company_address` varchar(100) DEFAULT NULL,
  `company_zip` varchar(10) DEFAULT NULL,
  `company_city` varchar(100) DEFAULT NULL,
  `company_state` varchar(2) DEFAULT NULL,
  `tot_loans` decimal(12,2) DEFAULT '0.00',
  `tot_deposits` decimal(12,2) DEFAULT '0.00',
  PRIMARY KEY (`company_fdic_cert_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_company`
--

LOCK TABLES `bank_company` WRITE;
/*!40000 ALTER TABLE `bank_company` DISABLE KEYS */;
INSERT INTO `bank_company` VALUES (14,'State Street Bank and Trust Company','One Congress Street Suite 1','02114','Boston','MA',312000.00,47891000.00),(628,'JPMorgan Chase Bank, National Association','1111 Polaris Pkwy','43240','Columbus','OH',5237000.00,987456000.00),(3510,'Bank of America, National Association','100 N Tryon St','28202','Charlotte','NC',3547000.00,512789000.00),(17534,'KeyBank National Association','127 Public Sq','44114','Cleveland','OH',24593000.00,3785000000.00),(17798,'Brookline Bank','2 Harvard St','02445','Brookline','MA',752000.00,123987000.00),(18221,'Webster Bank, National Association','1959 Summer St','06905','Stamford','CT',4896000.00,789231000.00),(18342,'Boston Trust Walden Company','1 Beacon St','02108','Boston','MA',19413000.00,2987000000.00),(18503,'Cathay Bank','777 N Broadway','90012','Los Angeles','CA',8435000.00,1287000000.00),(29950,'Santander Bank, N.A.','824 N Market St Ste 100','19801','Wilmington','DE',9126000.00,1532000000.00),(57957,'Citizens Bank, National Association','1 Citizens Plz','02903','Providence','RI',6872000.00,1098000000.00);
/*!40000 ALTER TABLE `bank_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `preferred_lang` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'John','Doe','English'),(2,'Jane','Smith','Spanish'),(3,'Michael','Johnson','English'),(4,'Emma','Williams','French'),(5,'David','Brown','English'),(6,'Sophia','Miller','German'),(7,'Matthew','Anderson','English'),(8,'Olivia','Martinez','Spanish'),(9,'James','Taylor','English'),(10,'Ava','Garcia','Spanish'),(11,'Laura','Alexander','Portuguese'),(12,'Joe','Graham','English'),(13,'Oliver','Zhang','Spanish'),(14,'Sanya','Singh','English'),(15,'Alison','Cooper','Spanish');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teller`
--

DROP TABLE IF EXISTS `teller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teller` (
  `teller_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `branch_id` int NOT NULL,
  `bank_address` varchar(100) DEFAULT NULL,
  `bank_zip` varchar(10) DEFAULT NULL,
  `bank_city` varchar(100) DEFAULT NULL,
  `bank_state` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`teller_id`),
  KEY `fk_teller_branch` (`branch_id`),
  CONSTRAINT `fk_teller_branch` FOREIGN KEY (`branch_id`) REFERENCES `bank_branch` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teller`
--

LOCK TABLES `teller` WRITE;
/*!40000 ALTER TABLE `teller` DISABLE KEYS */;
INSERT INTO `teller` VALUES (1,'Tassadit','Bellal','6174889352',255249,'6 Tremont St','02108','Boston','MA'),(2,'Mehtab','Ahmed','6172264444',570400,'33 State St','02109','Boston','MA'),(3,'MacKenson','Masse','6177176850',500171,'100 Franklin St','02110','Boston','MA'),(4,'Dong','Mai','6173382700',440186,'621 Washington St','02111','Boston','MA'),(5,'Hannah','Peters','6177231905',193122,'260 Hanover St','02113','Boston','MA'),(6,'Xiao','Chen','6177231906',193122,'261 Hanover St','02114','Boston','MA'),(7,'Chad','Smith','6177863001',6,'One Congress Street Suite 1','02114','Boston','MA'),(8,'Will','Keller','6177863002',6,'One Congress Street Suite 1','02115','Boston','MA'),(9,'Brad','Willson','6177863003',6,'One Congress Street Suite 1','02116','Boston','MA'),(10,'Jason','Tapia','6172775826',193351,'6 Francis St','02215','Boston','MA'),(11,'Dylan','Souter','8446837848',42211,'279 Massachusetts Ave','02115','Boston','MA'),(12,'Danny','Jordan','6175985860',629684,'183 Massachusetts Ave','02115','Boston','MA'),(13,'Jason','Bell','6172170462',621880,'280 Huntington Ave','02115','Boston','MA'),(14,'Sam','Schultz','6172170463',621880,'280 Huntington Ave','02115','Boston','MA'),(15,'Jay','Troy','6174370233',255236,'285 Huntington Ave','02115','Boston','MA'),(16,'Alicia','Diamond','6174254650',541133,'131 Clarendon St','02116','Boston','MA'),(17,'Sasha','Belcro','6178674190',575676,'491 Boylston St','02116','Boston','MA'),(18,'Maddie','Shenizer','6178674191',575676,'492 Boylston St','02117','Boston','MA'),(19,'En Min','Chen','6178674192',576428,'25 Stuart St','02116','Boston','MA'),(20,'Brian','Kelly','6175240025',258862,'3060 Washington St','02119','Boston','MA'),(21,'Sarah','Cox','6175668076',290976,'1628 Tremont St','02120','Boston','MA'),(22,'Max','Modi','6173902441',619407,'701 Centre St','02130','Boston','MA'),(23,'Winston','Kane','6173902442',619407,'702 Centre St','02131','Boston','MA'),(24,'Ramon','Moss','6173902443',619407,'703 Centre St','02132','Boston','MA');
/*!40000 ALTER TABLE `teller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transac_id` int DEFAULT NULL,
  `transac_type` varchar(10) DEFAULT NULL,
  `money_sent` decimal(10,2) DEFAULT NULL,
  `money_received` decimal(10,2) DEFAULT NULL,
  `atm_id` varchar(10) DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  KEY `fk_transactions_atm` (`atm_id`),
  KEY `fk_transactions_customer` (`customer_id`),
  CONSTRAINT `fk_transactions_atm` FOREIGN KEY (`atm_id`) REFERENCES `atm` (`atm_id`),
  CONSTRAINT `fk_transactions_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1001,'Savings',1000.00,3850.00,'MA-0003',1),(1002,'Checking',2500.00,1175.00,'MA-0003',2),(1003,'Checking',500.00,2670.00,'MA-0010',3),(1004,'Savings',3500.00,4900.00,'MA-0020',4),(1005,'Checking',2000.00,1985.00,'MA-0005',5),(1006,'Savings',1500.00,1470.00,'MA-0012',6),(1007,'Checking',3000.00,620.00,'MA-0003',7),(1008,'Savings',1200.00,4100.00,'MA-0020',8),(1009,'Checking',2800.00,750.00,'MA-0004',9),(1010,'Savings',1800.00,2930.00,'MA-0006',10),(1011,'Savings',2200.00,1650.00,'MA-0016',11),(1012,'Checking',1800.00,3480.00,'MA-0014',12),(1013,'Savings',3500.00,825.00,'MA-0018',13),(1014,'Savings',4100.00,2560.00,'MA-0002',14),(1015,'Checking',2900.00,1375.00,'MA-0007',15),(1016,'Savings',1200.00,2130.00,'MA-0017',1),(1017,'Checking',2800.00,920.00,'MA-0022',2),(1018,'Savings',1800.00,410.00,'MA-0021',3),(1019,'Savings',2200.00,3160.00,'MA-0013',4),(1020,'Checking',1800.00,1950.00,'MA-0001',5);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `UpdateTotalDeposits` AFTER INSERT ON `transactions` FOR EACH ROW BEGIN
  DECLARE branchCompany INT;
  
  -- Get the branch company of the customer
  SELECT branch_company INTO branchCompany
  FROM bank_branch
  WHERE branch_company = (
    SELECT branch_company
    FROM teller
    WHERE teller_id = (
      SELECT branch_id
      FROM atm
      WHERE atm_id = NEW.atm_id
    )
  );
  
  -- Update the total deposits of the branch
  UPDATE bank_company
  SET tot_deposits = tot_deposits + NEW.money_received
  WHERE company_fdic_cert_num = branchCompany;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'banking_system'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `GenerateMonthlyStatementEvent` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `GenerateMonthlyStatementEvent` ON SCHEDULE EVERY 1 MONTH STARTS '2023-06-22 01:28:46' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
        DECLARE last_day_of_month DATE;

        SET last_day_of_month = LAST_DAY(@current_date);

        INSERT INTO monthly_statements (customer_id, statement_date)
        SELECT customer_id, last_day_of_month
        FROM account;
    END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'banking_system'
--
/*!50003 DROP FUNCTION IF EXISTS `CalculateTotalLoans` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculateTotalLoans`(companyId INT) RETURNS decimal(12,2)
    DETERMINISTIC
BEGIN
  DECLARE totalLoans DECIMAL(12, 2);
  SELECT tot_loans INTO totalLoans
  FROM bank_company
  WHERE company_fdic_cert_num = companyId;
  RETURN totalLoans;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `GetCustomerName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GetCustomerName`(customerId INT) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
  DECLARE fullName VARCHAR(100);
  SELECT CONCAT(first_name, ' ', last_name) INTO fullName
  FROM customer
  WHERE customer_id = customerId;
  RETURN fullName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddNewCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddNewCustomer`(
  IN firstName VARCHAR(50),
  IN lastName VARCHAR(50),
  IN preferredLang VARCHAR(50),
  OUT customer_id INT
)
BEGIN
  INSERT INTO customer (first_name, last_name, preferred_lang)
  VALUES (firstName, lastName, preferredLang);
  SET customer_id =  LAST_INSERT_ID();
  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CalculateAccountBalance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CalculateAccountBalance`(IN accountNumber INT, OUT balance DECIMAL(10, 2))
BEGIN
  SELECT acct_balance INTO balance
  FROM account
  WHERE account_num = accountNumber;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateNewAcct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateNewAcct`(
  IN acct_type VARCHAR(50),
  IN acct_balance DECIMAL(10, 2),
  IN pin_num INT,
  IN customer_id INT,
  OUT account_num INT
)
BEGIN
  INSERT INTO account (acct_type, acct_balance, pin_num, customer_id)
  VALUES (acct_type, acct_balance, pin_num, customer_id);
  SET account_num = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-22  1:33:49
