CREATE DATABASE  IF NOT EXISTS `ecommerce` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ecommerce`;
-- MySQL dump 10.13  Distrib 8.4.2, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.37

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
  `IDCLIENTE` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(70) DEFAULT 'SIN_REGISTRO',
  `DNI` varchar(15) NOT NULL,
  `TELEFONO` varchar(15) NOT NULL,
  `CORREO` varchar(100) NOT NULL,
  `DIRECCION_DE_ENTREGA` varchar(100) NOT NULL,
  PRIMARY KEY (`IDCLIENTE`),
  UNIQUE KEY `CORREO` (`CORREO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `cliente_mail` BEFORE INSERT ON `cliente` FOR EACH ROW BEGIN
    DECLARE correo_count INT;
    
    SELECT COUNT(*) INTO correo_count
        FROM CLIENTE
    WHERE CORREO = NEW.CORREO;
    
    IF correo_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo ya fue registrado por otro usuario.';
    END IF;
END */;;
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `cliente_tel` AFTER INSERT ON `cliente` FOR EACH ROW BEGIN
    -- Verifición de que el campo de teléfono no quede null.
    IF NEW.telefono IS NULL OR NEW.telefono = '' THEN
        -- Dispara una alerta con lo que colocaremos a continuación.
        SIGNAL SQLSTATE '01000'
        SET MESSAGE_TEXT = 'El campo no puede quedar vacio.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `direcciones_facturacion`
--

DROP TABLE IF EXISTS `direcciones_facturacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direcciones_facturacion` (
  `IDDIRECCION_FACTURACION` int NOT NULL AUTO_INCREMENT,
  `IDCLIENTE` int DEFAULT NULL,
  `DIRECCION` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`IDDIRECCION_FACTURACION`),
  KEY `IDCLIENTE` (`IDCLIENTE`),
  CONSTRAINT `direcciones_facturacion_ibfk_1` FOREIGN KEY (`IDCLIENTE`) REFERENCES `cliente` (`IDCLIENTE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direcciones_facturacion`
--

LOCK TABLES `direcciones_facturacion` WRITE;
/*!40000 ALTER TABLE `direcciones_facturacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `direcciones_facturacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_stock`
--

DROP TABLE IF EXISTS `historial_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_stock` (
  `IDHISTORIAL_STOCK` int NOT NULL AUTO_INCREMENT,
  `IDPRODUCTO` int DEFAULT NULL,
  `CAMBIO` int DEFAULT NULL,
  `FECHA` datetime DEFAULT NULL,
  `RAZON` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`IDHISTORIAL_STOCK`),
  KEY `IDPRODUCTO` (`IDPRODUCTO`),
  CONSTRAINT `historial_stock_ibfk_1` FOREIGN KEY (`IDPRODUCTO`) REFERENCES `productos` (`IDPRODUCTO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_stock`
--

LOCK TABLES `historial_stock` WRITE;
/*!40000 ALTER TABLE `historial_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `historial_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `IDPEDIDORESERVA` int NOT NULL AUTO_INCREMENT,
  `IDCLIENTE` int DEFAULT NULL,
  `IDPRODUCTO` int DEFAULT NULL,
  `IDTIPOPEDIDORESERVA` int DEFAULT NULL,
  `IDSUCURSAL` int DEFAULT NULL,
  `FECHA` datetime DEFAULT NULL,
  `CANCELACION_PEDIDO` datetime DEFAULT NULL,
  PRIMARY KEY (`IDPEDIDORESERVA`),
  KEY `FK_PEDIDO_RESERVA_CLIENTE` (`IDCLIENTE`),
  KEY `FK_PEDIDO_PRODUCTO` (`IDPRODUCTO`),
  KEY `FK_TAKE_AWAY` (`IDSUCURSAL`),
  KEY `FK_PEDIDO_RESERVA` (`IDTIPOPEDIDORESERVA`),
  CONSTRAINT `FK_PEDIDO_PRODUCTO` FOREIGN KEY (`IDPRODUCTO`) REFERENCES `productos` (`IDPRODUCTO`),
  CONSTRAINT `FK_PEDIDO_RESERVA` FOREIGN KEY (`IDTIPOPEDIDORESERVA`) REFERENCES `tipopedidoreserva` (`IDTIPOPEDIDORESERVA`),
  CONSTRAINT `FK_PEDIDO_RESERVA_CLIENTE` FOREIGN KEY (`IDCLIENTE`) REFERENCES `cliente` (`IDCLIENTE`),
  CONSTRAINT `FK_TAKE_AWAY` FOREIGN KEY (`IDSUCURSAL`) REFERENCES `retirotakeaway` (`IDSUCURSAL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `IDPRODUCTO` int NOT NULL AUTO_INCREMENT,
  `MODELO` varchar(100) DEFAULT 'SIN_REGISTRO',
  `STOCK` varchar(100) DEFAULT 'SIN_STOCK',
  `PRECIO` int DEFAULT NULL,
  PRIMARY KEY (`IDPRODUCTO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resenas`
--

DROP TABLE IF EXISTS `resenas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resenas` (
  `IDRESENA` int NOT NULL AUTO_INCREMENT,
  `IDPRODUCTO` int DEFAULT NULL,
  `IDCLIENTE` int DEFAULT NULL,
  `CALIFICACION` int DEFAULT NULL,
  `COMENTARIO` text,
  `FECHA` datetime DEFAULT NULL,
  PRIMARY KEY (`IDRESENA`),
  KEY `IDPRODUCTO` (`IDPRODUCTO`),
  KEY `IDCLIENTE` (`IDCLIENTE`),
  CONSTRAINT `resenas_ibfk_1` FOREIGN KEY (`IDPRODUCTO`) REFERENCES `productos` (`IDPRODUCTO`),
  CONSTRAINT `resenas_ibfk_2` FOREIGN KEY (`IDCLIENTE`) REFERENCES `cliente` (`IDCLIENTE`),
  CONSTRAINT `resenas_chk_1` CHECK ((`CALIFICACION` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resenas`
--

LOCK TABLES `resenas` WRITE;
/*!40000 ALTER TABLE `resenas` DISABLE KEYS */;
/*!40000 ALTER TABLE `resenas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retirotakeaway`
--

DROP TABLE IF EXISTS `retirotakeaway`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retirotakeaway` (
  `IDSUCURSAL` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(100) DEFAULT NULL,
  `DIRECCION` varchar(150) DEFAULT NULL,
  `TELEFONO` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`IDSUCURSAL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retirotakeaway`
--

LOCK TABLES `retirotakeaway` WRITE;
/*!40000 ALTER TABLE `retirotakeaway` DISABLE KEYS */;
/*!40000 ALTER TABLE `retirotakeaway` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipopedidoreserva`
--

DROP TABLE IF EXISTS `tipopedidoreserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipopedidoreserva` (
  `IDTIPOPEDIDORESERVA` int NOT NULL AUTO_INCREMENT,
  `TIPO` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`IDTIPOPEDIDORESERVA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipopedidoreserva`
--

LOCK TABLES `tipopedidoreserva` WRITE;
/*!40000 ALTER TABLE `tipopedidoreserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipopedidoreserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `ventas_por_fecha`
--

DROP TABLE IF EXISTS `ventas_por_fecha`;
/*!50001 DROP VIEW IF EXISTS `ventas_por_fecha`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ventas_por_fecha` AS SELECT 
 1 AS `Fecha`,
 1 AS `Total_Compras`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_historial_stock`
--

DROP TABLE IF EXISTS `vista_historial_stock`;
/*!50001 DROP VIEW IF EXISTS `vista_historial_stock`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_historial_stock` AS SELECT 
 1 AS `IDHISTORIAL_STOCK`,
 1 AS `IDPRODUCTO`,
 1 AS `CAMBIO`,
 1 AS `FECHA`,
 1 AS `RAZON`,
 1 AS `MODELO`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vistaclientespedidos`
--

DROP TABLE IF EXISTS `vistaclientespedidos`;
/*!50001 DROP VIEW IF EXISTS `vistaclientespedidos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistaclientespedidos` AS SELECT 
 1 AS `IDCLIENTE`,
 1 AS `NOMBRE`,
 1 AS `DNI`,
 1 AS `TELEFONO`,
 1 AS `CORREO`,
 1 AS `DIRECCION_DE_ENTREGA`,
 1 AS `IDPEDIDORESERVA`,
 1 AS `IDPRODUCTO`,
 1 AS `IDTIPOPEDIDORESERVA`,
 1 AS `FECHA`,
 1 AS `CANCELACION_PEDIDO`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vistapedidoscancelados`
--

DROP TABLE IF EXISTS `vistapedidoscancelados`;
/*!50001 DROP VIEW IF EXISTS `vistapedidoscancelados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistapedidoscancelados` AS SELECT 
 1 AS `IDPEDIDORESERVA`,
 1 AS `CLIENTE_NOMBRE`,
 1 AS `PRODUCTO_MODELO`,
 1 AS `TIPO_PEDIDO`,
 1 AS `FECHA`,
 1 AS `CANCELACION_PEDIDO`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vistapedidosdetalles`
--

DROP TABLE IF EXISTS `vistapedidosdetalles`;
/*!50001 DROP VIEW IF EXISTS `vistapedidosdetalles`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistapedidosdetalles` AS SELECT 
 1 AS `IDPEDIDORESERVA`,
 1 AS `CLIENTE_NOMBRE`,
 1 AS `PRODUCTO_MODELO`,
 1 AS `TIPO_PEDIDO`,
 1 AS `SUCURSAL_NOMBRE`,
 1 AS `FECHA`,
 1 AS `CANCELACION_PEDIDO`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vistaproductosstock`
--

DROP TABLE IF EXISTS `vistaproductosstock`;
/*!50001 DROP VIEW IF EXISTS `vistaproductosstock`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistaproductosstock` AS SELECT 
 1 AS `IDPRODUCTO`,
 1 AS `MODELO`,
 1 AS `STOCK`,
 1 AS `PRECIO`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vistaresenas`
--

DROP TABLE IF EXISTS `vistaresenas`;
/*!50001 DROP VIEW IF EXISTS `vistaresenas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistaresenas` AS SELECT 
 1 AS `IDResena`,
 1 AS `Producto`,
 1 AS `Cliente`,
 1 AS `Calificacion`,
 1 AS `Comentario`,
 1 AS `Fecha`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `ventas_por_fecha`
--

/*!50001 DROP VIEW IF EXISTS `ventas_por_fecha`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ventas_por_fecha` AS select cast(`pedidos`.`FECHA` as date) AS `Fecha`,count(0) AS `Total_Compras` from `pedidos` group by cast(`pedidos`.`FECHA` as date) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_historial_stock`
--

/*!50001 DROP VIEW IF EXISTS `vista_historial_stock`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_historial_stock` AS select `hs`.`IDHISTORIAL_STOCK` AS `IDHISTORIAL_STOCK`,`hs`.`IDPRODUCTO` AS `IDPRODUCTO`,`hs`.`CAMBIO` AS `CAMBIO`,`hs`.`FECHA` AS `FECHA`,`hs`.`RAZON` AS `RAZON`,`p`.`MODELO` AS `MODELO` from (`historial_stock` `hs` join `productos` `p` on((`hs`.`IDPRODUCTO` = `p`.`IDPRODUCTO`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vistaclientespedidos`
--

/*!50001 DROP VIEW IF EXISTS `vistaclientespedidos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vistaclientespedidos` AS select `c`.`IDCLIENTE` AS `IDCLIENTE`,`c`.`NOMBRE` AS `NOMBRE`,`c`.`DNI` AS `DNI`,`c`.`TELEFONO` AS `TELEFONO`,`c`.`CORREO` AS `CORREO`,`c`.`DIRECCION_DE_ENTREGA` AS `DIRECCION_DE_ENTREGA`,`p`.`IDPEDIDORESERVA` AS `IDPEDIDORESERVA`,`p`.`IDPRODUCTO` AS `IDPRODUCTO`,`p`.`IDTIPOPEDIDORESERVA` AS `IDTIPOPEDIDORESERVA`,`p`.`FECHA` AS `FECHA`,`p`.`CANCELACION_PEDIDO` AS `CANCELACION_PEDIDO` from (`cliente` `c` left join `pedidos` `p` on((`c`.`IDCLIENTE` = `p`.`IDCLIENTE`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vistapedidoscancelados`
--

/*!50001 DROP VIEW IF EXISTS `vistapedidoscancelados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vistapedidoscancelados` AS select `p`.`IDPEDIDORESERVA` AS `IDPEDIDORESERVA`,`c`.`NOMBRE` AS `CLIENTE_NOMBRE`,`prod`.`MODELO` AS `PRODUCTO_MODELO`,`t`.`TIPO` AS `TIPO_PEDIDO`,`p`.`FECHA` AS `FECHA`,`p`.`CANCELACION_PEDIDO` AS `CANCELACION_PEDIDO` from (((`pedidos` `p` join `cliente` `c` on((`p`.`IDCLIENTE` = `c`.`IDCLIENTE`))) join `productos` `prod` on((`p`.`IDPRODUCTO` = `prod`.`IDPRODUCTO`))) join `tipopedidoreserva` `t` on((`p`.`IDTIPOPEDIDORESERVA` = `t`.`IDTIPOPEDIDORESERVA`))) where (`p`.`CANCELACION_PEDIDO` is not null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vistapedidosdetalles`
--

/*!50001 DROP VIEW IF EXISTS `vistapedidosdetalles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vistapedidosdetalles` AS select `p`.`IDPEDIDORESERVA` AS `IDPEDIDORESERVA`,`c`.`NOMBRE` AS `CLIENTE_NOMBRE`,`prod`.`MODELO` AS `PRODUCTO_MODELO`,`t`.`TIPO` AS `TIPO_PEDIDO`,`r`.`NOMBRE` AS `SUCURSAL_NOMBRE`,`p`.`FECHA` AS `FECHA`,`p`.`CANCELACION_PEDIDO` AS `CANCELACION_PEDIDO` from ((((`pedidos` `p` join `cliente` `c` on((`p`.`IDCLIENTE` = `c`.`IDCLIENTE`))) join `productos` `prod` on((`p`.`IDPRODUCTO` = `prod`.`IDPRODUCTO`))) join `tipopedidoreserva` `t` on((`p`.`IDTIPOPEDIDORESERVA` = `t`.`IDTIPOPEDIDORESERVA`))) left join `retirotakeaway` `r` on((`p`.`IDTIPOPEDIDORESERVA` = `r`.`IDSUCURSAL`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vistaproductosstock`
--

/*!50001 DROP VIEW IF EXISTS `vistaproductosstock`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vistaproductosstock` AS select `p`.`IDPRODUCTO` AS `IDPRODUCTO`,`p`.`MODELO` AS `MODELO`,`p`.`STOCK` AS `STOCK`,`p`.`PRECIO` AS `PRECIO` from `productos` `p` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vistaresenas`
--

/*!50001 DROP VIEW IF EXISTS `vistaresenas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vistaresenas` AS select `r`.`IDRESENA` AS `IDResena`,`p`.`MODELO` AS `Producto`,`c`.`NOMBRE` AS `Cliente`,`r`.`CALIFICACION` AS `Calificacion`,`r`.`COMENTARIO` AS `Comentario`,`r`.`FECHA` AS `Fecha` from ((`resenas` `r` join `productos` `p` on((`r`.`IDPRODUCTO` = `p`.`IDPRODUCTO`))) join `cliente` `c` on((`r`.`IDCLIENTE` = `c`.`IDCLIENTE`))) */;
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

-- Dump completed on 2024-08-30 13:13:52
