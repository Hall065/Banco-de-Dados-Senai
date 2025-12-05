-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: oficina
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nome_cliente` varchar(100) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `email_cliente` varchar(100) DEFAULT NULL,
  `telefone_cliente` varchar(15) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'João Mendes','123.456.789-00','joao@gmail.com','11987654321','Rua Alfa, 120',NULL),(2,'Carla Souza','987.654.321-00','carla@hotmail.com','11999887766','Av. Beta, 455',NULL),(3,'Marcos Silva','111.222.333-44','marcos@outlook.com','11988776655','Rua Gama, 80',NULL),(4,'João Vitor Francisco','390.390.390-39','joao.vitorf@gmail.com','19988854406','Rua Laranjas, 138 ',NULL),(5,'Marcos Almeida','335.345.767.12','marcos@email.com','(19)91233-8764','Condomínio Palmeiras - Balneário ',NULL);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;

--
-- Table structure for table `mecanico`
--

DROP TABLE IF EXISTS `mecanico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mecanico` (
  `id_mecanico` int NOT NULL AUTO_INCREMENT,
  `nome_mecanico` varchar(100) NOT NULL,
  `especialidade` varchar(150) DEFAULT NULL,
  `telefone_mecanico` varchar(15) DEFAULT NULL,
  `email_mecanico` varchar(100) DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_mecanico`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mecanico`
--

/*!40000 ALTER TABLE `mecanico` DISABLE KEYS */;
INSERT INTO `mecanico` VALUES (1,'Pedro Santos','Motor','11991234567','pedro@oficina.com',3200.00),(2,'Rafael Martins','Suspensão','11992345678','rafael@oficina.com',3000.00),(3,'André Costa','Elétrica','11993456789','andre@oficina.com',3500.00),(4,'Matheus Santos','Injeção Eletrônica','(19)95011-0983','matheusS@email.com',3239.00);
/*!40000 ALTER TABLE `mecanico` ENABLE KEYS */;

--
-- Table structure for table `ordemservico`
--

DROP TABLE IF EXISTS `ordemservico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordemservico` (
  `id_os` int NOT NULL AUTO_INCREMENT,
  `data_abertura` date DEFAULT NULL,
  `data_fechamento` date DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `observacoes` varchar(100) DEFAULT NULL,
  `id_veiculo` int DEFAULT NULL,
  PRIMARY KEY (`id_os`),
  KEY `idx_ordem_veiculo` (`id_veiculo`),
  CONSTRAINT `ordemservico_ibfk_1` FOREIGN KEY (`id_veiculo`) REFERENCES `veiculo` (`id_veiculo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordemservico`
--

/*!40000 ALTER TABLE `ordemservico` DISABLE KEYS */;
INSERT INTO `ordemservico` VALUES (1,'2025-11-01','2025-11-02','Concluída','Cliente pediu revisão geral.',1),(2,'2025-11-03','2025-11-30','Em andamento','Aguardando Peça',2),(3,'2025-11-05','2025-11-06','Concluída','Troca de bateria realizada.',4),(4,'2025-11-14','2025-11-21','Aberta','Revisão Completa.',5),(5,'2025-05-28','0025-06-01','Concluída','Manutenção em Dia.',6),(6,'2025-11-28','2025-11-30','Aberta','Limpeza Detalhada.',5);
/*!40000 ALTER TABLE `ordemservico` ENABLE KEYS */;

--
-- Table structure for table `os_mecanico`
--

DROP TABLE IF EXISTS `os_mecanico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `os_mecanico` (
  `id_os_mecanico` int NOT NULL AUTO_INCREMENT,
  `id_os` int NOT NULL,
  `id_mecanico` int NOT NULL,
  PRIMARY KEY (`id_os_mecanico`),
  KEY `id_os` (`id_os`),
  KEY `id_mecanico` (`id_mecanico`),
  CONSTRAINT `os_mecanico_ibfk_1` FOREIGN KEY (`id_os`) REFERENCES `ordemservico` (`id_os`),
  CONSTRAINT `os_mecanico_ibfk_2` FOREIGN KEY (`id_mecanico`) REFERENCES `mecanico` (`id_mecanico`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `os_mecanico`
--

/*!40000 ALTER TABLE `os_mecanico` DISABLE KEYS */;
INSERT INTO `os_mecanico` VALUES (1,1,1),(2,2,2),(3,3,3),(4,1,1),(5,2,2),(6,3,3),(7,1,1),(8,2,2),(9,3,3);
/*!40000 ALTER TABLE `os_mecanico` ENABLE KEYS */;

--
-- Table structure for table `os_pecas`
--

DROP TABLE IF EXISTS `os_pecas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `os_pecas` (
  `id_os_peca` int NOT NULL AUTO_INCREMENT,
  `id_os` int NOT NULL,
  `id_peca` int NOT NULL,
  `quantidade_usada` int NOT NULL,
  `preco_unitario_cobrado` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id_os_peca`),
  KEY `id_peca` (`id_peca`),
  KEY `idx_os_peca` (`id_os`,`id_peca`),
  CONSTRAINT `os_pecas_ibfk_1` FOREIGN KEY (`id_os`) REFERENCES `ordemservico` (`id_os`),
  CONSTRAINT `os_pecas_ibfk_2` FOREIGN KEY (`id_peca`) REFERENCES `peca` (`id_peca`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `os_pecas`
--

/*!40000 ALTER TABLE `os_pecas` DISABLE KEYS */;
INSERT INTO `os_pecas` VALUES (4,1,1,2,45.00),(5,1,3,1,320.00),(6,2,2,5,20.00),(7,3,4,1,10.00);
/*!40000 ALTER TABLE `os_pecas` ENABLE KEYS */;

--
-- Table structure for table `os_servico`
--

DROP TABLE IF EXISTS `os_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `os_servico` (
  `id_os_servico` int NOT NULL AUTO_INCREMENT,
  `preco_un` decimal(10,2) DEFAULT NULL,
  `quantidade` int DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `id_servico` int DEFAULT NULL,
  `id_os` int DEFAULT NULL,
  `id_mecanico` int DEFAULT NULL,
  PRIMARY KEY (`id_os_servico`),
  KEY `id_servico` (`id_servico`),
  KEY `id_os` (`id_os`),
  KEY `id_mecanico` (`id_mecanico`),
  CONSTRAINT `os_servico_ibfk_1` FOREIGN KEY (`id_servico`) REFERENCES `servico` (`id_servico`),
  CONSTRAINT `os_servico_ibfk_2` FOREIGN KEY (`id_os`) REFERENCES `ordemservico` (`id_os`),
  CONSTRAINT `os_servico_ibfk_3` FOREIGN KEY (`id_mecanico`) REFERENCES `mecanico` (`id_mecanico`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `os_servico`
--

/*!40000 ALTER TABLE `os_servico` DISABLE KEYS */;
INSERT INTO `os_servico` VALUES (1,120.00,1,120.00,1,1,1),(2,150.00,1,150.00,2,2,2),(3,80.00,1,80.00,3,3,3),(4,250.00,1,250.00,4,1,1);
/*!40000 ALTER TABLE `os_servico` ENABLE KEYS */;

--
-- Table structure for table `peca`
--

DROP TABLE IF EXISTS `peca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peca` (
  `id_peca` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `preco_custo` decimal(10,2) NOT NULL,
  `preco_venda` decimal(10,2) NOT NULL,
  `qtd_estoque` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_peca`),
  CONSTRAINT `chk_preco_venda` CHECK ((`preco_venda` >= `preco_custo`))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peca`
--

/*!40000 ALTER TABLE `peca` DISABLE KEYS */;
INSERT INTO `peca` VALUES (1,'Óleo 5W30','Óleo de motor sintético 5W30 1L',25.00,45.00,20),(2,'Filtro de óleo','Filtro para motores 1.0/1.6',10.00,20.00,15),(3,'Bateria 60Ah','Bateria automotiva 60Ah',201.00,320.00,4),(4,'Pano de limpeza','Pano de microfibra para limpeza',5.00,10.00,50),(5,'Pastilha de freio','Pastilha de freio dianteira',80.00,120.00,12);
/*!40000 ALTER TABLE `peca` ENABLE KEYS */;

--
-- Table structure for table `servico`
--

DROP TABLE IF EXISTS `servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servico` (
  `id_servico` int NOT NULL AUTO_INCREMENT,
  `tempo_estimado` time DEFAULT NULL,
  `codigo` int DEFAULT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `preco` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_servico`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico`
--

/*!40000 ALTER TABLE `servico` DISABLE KEYS */;
INSERT INTO `servico` VALUES (1,'01:00:00',101,'Revisão','Troca de óleo',120.00),(2,'02:00:00',202,'Suspensão','Alinhamento e balanceamento',150.00),(3,'00:45:00',303,'Elétrica','Verificação de bateria',80.00),(4,'03:00:00',404,'Motor','Limpeza de bicos injetores',250.00),(5,'05:00:00',505,'Completa','Revisão Completa',500.00),(6,'03:00:00',606,'Limpeza','Limpeza Completa.',400.00);
/*!40000 ALTER TABLE `servico` ENABLE KEYS */;

--
-- Table structure for table `veiculo`
--

DROP TABLE IF EXISTS `veiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veiculo` (
  `id_veiculo` int NOT NULL AUTO_INCREMENT,
  `modelo` varchar(20) DEFAULT NULL,
  `marca` varchar(20) DEFAULT NULL,
  `placa` varchar(8) DEFAULT NULL,
  `ano` int DEFAULT NULL,
  `id_cliente` int DEFAULT NULL,
  PRIMARY KEY (`id_veiculo`),
  UNIQUE KEY `placa` (`placa`),
  KEY `id_cliente` (`id_cliente`),
  KEY `idx_placa` (`placa`),
  CONSTRAINT `veiculo_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veiculo`
--

/*!40000 ALTER TABLE `veiculo` DISABLE KEYS */;
INSERT INTO `veiculo` VALUES (1,'Civic','Honda','ABC1A23',2018,1),(2,'Corolla','Toyota','XYZ9B88',2020,2),(3,'Gol','Volkswagen','DEF3C45',2012,1),(4,'Onix','Chevrolet','GHI4D67',2019,3),(5,'328i','Bmw','JVF5H22',2020,4),(6,'Fusion','Ford','FDM2987',2020,5);
/*!40000 ALTER TABLE `veiculo` ENABLE KEYS */;

--
-- Dumping routines for database 'oficina'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-05 15:00:39
