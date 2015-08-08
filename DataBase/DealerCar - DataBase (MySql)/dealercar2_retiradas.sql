-- MySQL dump 10.13  Distrib 5.6.24, for Win32 (x86)
--
-- Host: localhost    Database: dealercar2
-- ------------------------------------------------------
-- Server version	5.6.25-log

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
-- Table structure for table `retiradas`
--

DROP TABLE IF EXISTS `retiradas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retiradas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_retirada` date NOT NULL,
  `quilometragem` int(10) unsigned NOT NULL,
  `placa` char(7) NOT NULL,
  `id_cliente` int(10) unsigned NOT NULL,
  `id_funcionario` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_retiradas_clientes1_idx` (`id_cliente`),
  KEY `fk_retiradas_funcionarios1_idx` (`id_funcionario`),
  KEY `fk_retiradas_carros1_idx` (`placa`),
  CONSTRAINT `fk_retiradas_carros1` FOREIGN KEY (`placa`) REFERENCES `carros` (`placa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_retiradas_clientes1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_retiradas_funcionarios1` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retiradas`
--

LOCK TABLES `retiradas` WRITE;
/*!40000 ALTER TABLE `retiradas` DISABLE KEYS */;
/*!40000 ALTER TABLE `retiradas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-08-08 19:00:54
