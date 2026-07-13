-- MySQL dump 10.13  Distrib 8.4.10, for Linux (x86_64)
--
-- Host: localhost    Database: tienda_electronica
-- ------------------------------------------------------
-- Server version	8.4.10-0ubuntu0.26.04.1

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
-- Table structure for table `Categorias`
--

DROP TABLE IF EXISTS `Categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Categorias` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `UQ_Categoria_Nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Categorias`
--

LOCK TABLES `Categorias` WRITE;
/*!40000 ALTER TABLE `Categorias` DISABLE KEYS */;
INSERT INTO `Categorias` VALUES (1,'Celulares Premium','Smartphones de gama alta y flagship de las principales marcas.'),(2,'Celulares Gama Media','Teléfonos inteligentes con excelente relación calidad-precio.'),(3,'Tablets','Dispositivos portátiles de pantalla grande para productividad y consumo multimedia.'),(4,'Audífonos True Wireless','Auriculares inalámbricos de botón (In-ear) con estuche de carga.'),(5,'Audífonos Over-Ear','Auriculares de diadema con cancelación activa de ruido (ANC).'),(6,'Relojes Inteligentes','Smartwatches enfocados en deporte, salud y notificaciones.'),(7,'Pulseras de Actividad','Smartbands accesibles para monitoreo físico diario.'),(8,'Cargadores y Energía','Adaptadores de carga rápida, cargadores inalámbricos y powerbanks.'),(9,'Fundas y Protección','Carcasas oficiales y protectores de pantalla para dispositivos.'),(10,'Laptops y Convertibles','Equipos portátiles premium y dispositivos 2 en 1.');
/*!40000 ALTER TABLE `Categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Clientes`
--

DROP TABLE IF EXISTS `Clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` text,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `UQ_Cliente_Correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Clientes`
--

LOCK TABLES `Clientes` WRITE;
/*!40000 ALTER TABLE `Clientes` DISABLE KEYS */;
INSERT INTO `Clientes` VALUES (1,'Carlos Mendoza','carlos.mendoza@email.com','5512345678','Av. Reforma 123, CDMX'),(2,'Ana Rodríguez','ana.rod@email.com','5598765432','Calle Juárez 45, Guadalajara'),(3,'Sofía López','sofia.lopez@email.com','8111223344','Col. Centro, Monterrey'),(4,'Sergio De Luis','sergio.deluis@email.com','5544332211','Huixquilucan, Estado de México'),(5,'Andrea Sánchez','andrea.sanchez@email.com','5566778899','El Pedregal, CDMX'),(6,'Luis Fernando Gómez','luis.gomez@email.com','3344556677','Av. Vallarta 789, Guadalajara'),(7,'María Elena Cruz','maria.cruz@email.com','2299887766','Boca del Río, Veracruz'),(8,'Alejandro Ruiz','alex.ruiz@email.com','8188776655','San Pedro Garza García, NL'),(9,'Laura Flores','laura.flores@email.com','5522446688','Coyoacán, CDMX'),(10,'Ricardo Morales','ricardo.m@email.com','4422334455','Juriquilla, Querétaro'),(11,'Claudia Ortiz','claudia.o@email.com','7771112233','Cuernavaca, Morelos'),(12,'Javier Herrera','javier.h@email.com','9998887766','Mérida, Yucatán'),(13,'Gabriela Silva','gaby.silva@email.com','6641112233','Tijuana, Baja California'),(14,'Daniel Castro','daniel.c@email.com','4433221100','Morelia, Michoacán'),(15,'Patricia Méndez','paty.mendez@email.com','2281112233','Pacho Nuevo, Veracruz'),(16,'Cliente Extra 16','extra16@email.com','5511111111','Dirección 16'),(17,'Cliente Extra 17','extra17@email.com','5522222222','Dirección 17'),(18,'Cliente Extra 18','extra18@email.com','5533333333','Dirección 18'),(19,'Cliente Extra 19','extra19@email.com','5544444444','Dirección 19'),(20,'Cliente Extra 20','extra20@email.com','5555555555','Dirección 20');
/*!40000 ALTER TABLE `Clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Detalles_Pedido`
--

DROP TABLE IF EXISTS `Detalles_Pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Detalles_Pedido` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int unsigned NOT NULL DEFAULT '1',
  `precio_unitario` decimal(10,2) unsigned NOT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `FK_Detalles_Pedidos` (`id_pedido`),
  KEY `FK_Detalles_Productos` (`id_producto`),
  CONSTRAINT `FK_Detalles_Pedidos` FOREIGN KEY (`id_pedido`) REFERENCES `Pedidos` (`id_pedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Detalles_Productos` FOREIGN KEY (`id_producto`) REFERENCES `Productos` (`id_producto`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Detalles_Pedido`
--

LOCK TABLES `Detalles_Pedido` WRITE;
/*!40000 ALTER TABLE `Detalles_Pedido` DISABLE KEYS */;
INSERT INTO `Detalles_Pedido` VALUES (1,1,14,1,24999.00),(2,1,1,1,13499.00),(3,2,6,1,12999.00),(4,3,2,1,23999.00),(5,3,13,2,899.00),(6,4,11,1,5499.00),(7,4,8,1,2999.00),(8,5,4,1,6499.00),(9,6,15,1,31999.00),(10,7,3,1,17499.00),(11,8,5,1,7999.00),(12,8,12,1,2199.00),(13,9,9,1,2499.00),(14,10,13,4,899.00),(15,11,1,1,13499.00),(16,12,10,1,6999.00),(17,13,7,1,19999.00),(18,14,14,1,24999.00),(19,15,2,1,23999.00),(20,16,8,1,2999.00),(21,17,1,1,13499.00),(22,17,11,1,5499.00),(23,18,3,1,17499.00),(24,19,6,1,12999.00),(25,20,12,1,2199.00),(26,21,1,2,13499.00);
/*!40000 ALTER TABLE `Detalles_Pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pedidos`
--

DROP TABLE IF EXISTS `Pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pedidos` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `fecha_pedido` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` enum('pendiente','enviado','entregado') NOT NULL DEFAULT 'pendiente',
  PRIMARY KEY (`id_pedido`),
  KEY `FK_Pedidos_Clientes` (`id_cliente`),
  KEY `idx_pedidos_fecha_estado` (`fecha_pedido`,`estado`),
  CONSTRAINT `FK_Pedidos_Clientes` FOREIGN KEY (`id_cliente`) REFERENCES `Clientes` (`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pedidos`
--

LOCK TABLES `Pedidos` WRITE;
/*!40000 ALTER TABLE `Pedidos` DISABLE KEYS */;
INSERT INTO `Pedidos` VALUES (1,1,'2026-07-01 10:00:00','entregado'),(2,2,'2026-07-02 11:15:00','entregado'),(3,3,'2026-07-03 14:30:00','enviado'),(4,4,'2026-07-04 09:00:00','entregado'),(5,5,'2026-07-04 16:45:00','entregado'),(6,6,'2026-07-05 12:20:00','pendiente'),(7,7,'2026-07-05 18:10:00','entregado'),(8,8,'2026-07-06 08:00:00','enviado'),(9,9,'2026-07-06 15:35:00','pendiente'),(10,10,'2026-07-07 11:40:00','entregado'),(11,11,'2026-07-07 19:50:00','entregado'),(12,12,'2026-07-08 10:05:00','enviado'),(13,13,'2026-07-08 14:15:00','pendiente'),(14,14,'2026-07-09 09:30:00','entregado'),(15,15,'2026-07-09 17:00:00','entregado'),(16,1,'2026-07-10 13:22:00','pendiente'),(17,4,'2026-07-10 15:40:00','entregado'),(18,7,'2026-07-11 08:12:00','pendiente'),(19,10,'2026-07-11 10:00:00','enviado'),(20,2,'2026-07-11 11:30:00','pendiente'),(21,1,'2026-07-11 10:19:33','pendiente');
/*!40000 ALTER TABLE `Pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Productos`
--

DROP TABLE IF EXISTS `Productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Productos` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `id_categoria` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `precio` decimal(10,2) unsigned NOT NULL,
  `stock` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_producto`),
  KEY `FK_Productos_Categorias` (`id_categoria`),
  KEY `idx_productos_precio` (`precio`),
  CONSTRAINT `FK_Productos_Categorias` FOREIGN KEY (`id_categoria`) REFERENCES `Categorias` (`id_categoria`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Productos`
--

LOCK TABLES `Productos` WRITE;
/*!40000 ALTER TABLE `Productos` DISABLE KEYS */;
INSERT INTO `Productos` VALUES (1,1,'Samsung Galaxy S25 FE','Pantalla Dynamic AMOLED 2X, 128GB, Ecosistema Galaxy.',13499.00,23),(2,1,'Apple iPhone 15 Pro','Chasis de titanio, chip A17 Pro, 256GB de almacenamiento.',23999.00,10),(3,1,'Google Pixel 8 Pro','Cámara avanzada con IA de Google, 128GB, Android Puro.',17499.00,8),(4,2,'Xiaomi Redmi Note 13 Pro','Cámara de 200MP, carga rápida de 67W, 256GB.',6499.00,30),(5,2,'Motorola Edge 50 Neo','Pantalla pOLED, diseño estilizado, 256GB de almacenamiento.',7999.00,15),(6,3,'Apple iPad Air M2','Pantalla Liquid Retina de 11 pulgadas, 128GB, Wi-Fi.',12999.00,12),(7,3,'Huawei MatePad Pro 12.2','Pantalla Tandem OLED PaperMatte, ideal para diseño.',19999.00,7),(8,4,'OnePlus Buds Pro 3','Cancelación de ruido adaptativa dual, co-diseñados con Dynaudio.',2999.00,40),(9,4,'Oppo Enco X3','Audio de alta resolución, cancelación activa de ruido profunda.',2499.00,35),(10,5,'Sony WH-1000XM5','Audífonos premium de diadema con la mejor cancelación de ruido.',6999.00,20),(11,6,'Samsung Galaxy Watch 7','Monitoreo avanzado de salud, composición corporal y GPS dual.',5499.00,18),(12,6,'Honor Watch 4','Pantalla AMOLED de 1.75 pulgadas, batería de hasta 14 días.',2199.00,22),(13,7,'Xiaomi Smart Band 9','Pantalla AMOLED a 60Hz, monitoreo de ritmo cardíaco y sueño.',899.00,100),(14,10,'Lenovo ThinkPad X13 2-in-1','Intel Core Ultra 5, 32GB RAM, convertible ideal para desarrollo.',24999.00,14),(15,10,'Huawei MateBook X Pro','Ultra ligera, procesador Core Ultra 7, pantalla táctil 3.1K.',31999.00,5);
/*!40000 ALTER TABLE `Productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reseñas`
--

DROP TABLE IF EXISTS `Reseñas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reseñas` (
  `id_reseña` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `id_cliente` int NOT NULL,
  `calificacion` int unsigned NOT NULL,
  `comentario` text,
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_reseña`),
  KEY `FK_Reseñas_Clientes` (`id_cliente`),
  KEY `idx_reseñas_producto_fecha` (`id_producto`,`fecha`),
  CONSTRAINT `FK_Reseñas_Clientes` FOREIGN KEY (`id_cliente`) REFERENCES `Clientes` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Reseñas_Productos` FOREIGN KEY (`id_producto`) REFERENCES `Productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CK_Calificacion` CHECK ((`calificacion` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reseñas`
--

LOCK TABLES `Reseñas` WRITE;
/*!40000 ALTER TABLE `Reseñas` DISABLE KEYS */;
INSERT INTO `Reseñas` VALUES (1,14,1,5,'Excelente rendimiento en desarrollo. La pantalla táctil responde de maravilla.','2026-07-03 12:00:00'),(2,1,1,5,'El Galaxy S25 FE va sumamente fluido, la cámara y el tamaño son perfectos.','2026-07-03 12:05:00'),(3,6,2,4,'Excelente pantalla y muy ligera, el chip M2 responde de inmediato.','2026-07-04 15:00:00'),(4,2,3,5,'El titanio se siente muy premium y las fotos de noche son espectaculares.','2026-07-05 10:30:00'),(5,11,4,5,'Galaxy Watch 7 mide la composición corporal con precisión y el diseño es limpio.','2026-07-06 09:00:00'),(6,8,4,4,'Muy buena cancelación de ruido, los graves se escuchan potentes.','2026-07-06 09:15:00'),(7,4,5,4,'Por el precio que tiene, la cámara de 200MP y la carga rápida son imbatibles.','2026-07-06 11:00:00'),(8,3,7,5,'Fotografía computacional pura. El software de Google no decepciona.','2026-07-07 14:22:00'),(9,5,8,4,'El rendimiento del Edge 50 es muy balanceado y la pantalla pOLED destaca.','2026-07-08 16:40:00'),(10,12,8,4,'Sencillo, cómodo y la batería dura semanas. Gran reloj de Honor.','2026-07-08 16:45:00'),(11,13,10,5,'Increíble relación calidad-precio. La pantalla a 60Hz se nota muy suave.','2026-07-09 13:00:00'),(12,14,14,5,'El teclado de la ThinkPad sigue siendo el mejor para escribir código.','2026-07-10 11:10:00'),(13,2,15,5,'Cámara perfecta y excelente rendimiento con juegos pesados.','2026-07-10 18:00:00'),(14,1,4,5,'Gran integración con el ecosistema de pantallas y la suite de Samsung.','2026-07-11 09:00:00'),(15,10,12,5,'Cancelación de sonido de primer nivel, ideales para aislarse en la oficina.','2026-07-09 15:30:00'),(16,7,13,5,'La pantalla Tandem OLED de Huawei es una locura de brillo y colores.','2026-07-10 10:00:00'),(17,9,9,4,'Audio nítido y se conectan instantáneamente con mi teléfono Oppo.','2026-07-10 10:15:00'),(18,13,11,4,'Cómoda y ligera, perfecta para llevar el registro de pasos diario.','2026-07-09 11:00:00'),(19,1,17,5,'Una opción muy sólida y balanceada de Samsung.','2026-07-11 11:00:00'),(20,6,19,5,'El complemento perfecto si ya usas una computadora Apple.','2026-07-11 11:15:00'),(21,1,1,5,'Componentes premium y gran desempeño en Ubuntu.','2026-07-11 10:20:43');
/*!40000 ALTER TABLE `Reseñas` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Before_Insert_Reseña` BEFORE INSERT ON `Reseñas` FOR EACH ROW BEGIN
    DECLARE v_compras_existentes INT;

    -- Contar si el cliente tiene al menos un detalle de pedido con ese producto 
    -- y que el pedido no esté cancelado o simplemente pendiente si así lo deseas
    SELECT COUNT(*) INTO v_compras_existentes
    FROM Detalles_Pedido dp
    JOIN Pedidos p ON dp.id_pedido = p.id_pedido
    WHERE p.id_cliente = NEW.id_cliente 
      AND dp.id_producto = NEW.id_producto
      AND p.estado IN ('enviado', 'entregado'); -- Asegura que la compra ya se procesó

    -- Si el conteo es 0, significa que el cliente no ha comprado el producto
    IF v_compras_existentes = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error de integridad: No puedes dejar una reseña de un producto que no has comprado.';
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `After_Insert_Reseña` AFTER INSERT ON `Reseñas` FOR EACH ROW BEGIN
    -- Regla de negocio: Si la calificación es de 1 o 2 estrellas, se activa la lógica de alerta
    IF NEW.calificacion <= 2 THEN
        -- En entornos reales, aquí se insertaría un registro en una tabla 'Alertas_Soporte'
        -- o se llamaría a un componente externo.
        -- Como demostración, dejamos la estructura lógica condicional preparada:
        SET @alerta_servicio = CONCAT('¡Alerta! Reseña negativa detectada para el producto ID: ', NEW.id_producto);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'tienda_electronica'
--
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarPedido`(
    IN p_id_cliente INT,
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_stock_actual INT;
    DECLARE v_precio_producto DECIMAL(10,2);
    DECLARE v_id_pedido INT;

    -- 1. Obtener el stock y el precio actual del producto
    SELECT stock, precio INTO v_stock_actual, v_precio_producto
    FROM Productos
    WHERE id_producto = p_id_producto;

    -- 2. Verificar si hay stock suficiente
    IF v_stock_actual >= p_cantidad THEN
        -- Insertar el registro en la tabla madre (Pedidos)
        INSERT INTO Pedidos (id_cliente, fecha_pedido, estado)
        VALUES (p_id_cliente, NOW(), 'pendiente');
        
        -- Recuperar el ID asignado automáticamente al pedido
        SET v_id_pedido = LAST_INSERT_ID();

        -- Insertar el desglose en la tabla hija (Detalles_Pedido)
        INSERT INTO Detalles_Pedido (id_pedido, id_producto, cantidad, precio_unitario)
        VALUES (v_id_pedido, p_id_producto, p_cantidad, v_precio_producto);

        -- Disminuir el stock en la tabla Productos
        UPDATE Productos
        SET stock = stock - p_cantidad
        WHERE id_producto = p_id_producto;
        
        SELECT 'Pedido registrado exitosamente y stock actualizado.' AS Resultado;
    ELSE
        -- Lanzar una excepción controlada si no hay inventario suficiente
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Stock insuficiente para completar el pedido.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ReporteMensualVentas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ReporteMensualVentas`(
    IN p_anio INT,
    IN p_mes INT
)
BEGIN
    SELECT 
        COUNT(DISTINCT p.id_pedido) AS total_pedidos_procesados,
        IFNULL(SUM(dp.cantidad * dp.precio_unitario), 0.00) AS ingresos_netos_mes
    FROM Pedidos p
    JOIN Detalles_Pedido dp ON p.id_pedido = dp.id_pedido
    WHERE YEAR(p.fecha_pedido) = p_anio 
      AND MONTH(p.fecha_pedido) = p_mes
      AND p.estado != 'pendiente';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_ActualizarCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ActualizarCliente`(
    IN p_id_cliente INT,
    IN p_nueva_direccion TEXT,
    IN p_nuevo_telefono VARCHAR(20)
)
BEGIN
    UPDATE Clientes
    SET direccion = p_nueva_direccion, telefono = p_nuevo_telefono
    WHERE id_cliente = p_id_cliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_ActualizarStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ActualizarStock`(
    IN p_id_producto INT,
    IN p_cantidad_restar INT
)
BEGIN
    UPDATE Productos
    SET stock = stock - p_cantidad_restar
    WHERE id_producto = p_id_producto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_AgregarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_AgregarProducto`(
    IN p_id_categoria INT,
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_precio DECIMAL(10,2),
    IN p_stock INT
)
BEGIN
    DECLARE v_existe INT;

    SELECT COUNT(*) INTO v_existe
    FROM Productos
    WHERE nombre = p_nombre AND id_categoria = p_id_categoria;

    IF v_existe > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Ya existe un producto con ese nombre en esta categoría.';
    END IF;

    INSERT INTO Productos (id_categoria, nombre, descripcion, precio, stock)
    VALUES (p_id_categoria, p_nombre, p_descripcion, p_precio, p_stock);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_CambiarEstadoPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CambiarEstadoPedido`(
    IN p_id_pedido INT,
    IN p_nuevo_estado ENUM('pendiente', 'enviado', 'entregado')
)
BEGIN
    UPDATE Pedidos
    SET estado = p_nuevo_estado
    WHERE id_pedido = p_id_pedido;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_EliminarReseñasProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EliminarReseñasProducto`(
    IN p_id_producto INT
)
BEGIN
    -- Elimina las opiniones del artículo
    DELETE FROM Reseñas WHERE id_producto = p_id_producto;
    
    -- Nota: El promedio de calificaciones se calcula dinámicamente mediante 
    -- consultas SELECT en tiempo real, por lo que al borrarlas se actualiza automáticamente.
    SELECT 'Reseñas eliminadas. El promedio se ha actualizado.' AS Resultado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_RegistrarPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_RegistrarPedido`(
    IN p_id_cliente INT,
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_pedidos_pendientes INT;
    DECLARE v_stock_actual INT;
    DECLARE v_precio_unitario DECIMAL(10,2);
    DECLARE v_id_pedido INT;

    -- Verificar cantidad de pedidos pendientes del cliente
    SELECT COUNT(*) INTO v_pedidos_pendientes
    FROM Pedidos
    WHERE id_cliente = p_id_cliente AND estado = 'pendiente';

    IF v_pedidos_pendientes >= 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El cliente ya tiene el máximo de 5 pedidos pendientes.';
    END IF;

    -- Verificar stock y obtener precio
    SELECT stock, precio INTO v_stock_actual, v_precio_unitario
    FROM Productos WHERE id_producto = p_id_producto;

    IF v_stock_actual < p_cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Stock insuficiente para el producto solicitado.';
    END IF;

    -- Insertar Pedido
    INSERT INTO Pedidos (id_cliente, fecha_pedido, estado) VALUES (p_id_cliente, NOW(), 'pendiente');
    SET v_id_pedido = LAST_INSERT_ID();

    -- Insertar Detalle
    INSERT INTO Detalles_Pedido (id_pedido, id_producto, cantidad, precio_unitario)
    VALUES (v_id_pedido, p_id_producto, p_cantidad, v_precio_unitario);

    -- Actualizar Stock invocando el SP correspondiente (Modularidad)
    CALL SP_ActualizarStock(p_id_producto, p_cantidad);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_RegistrarReseña` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_RegistrarReseña`(
    IN p_id_producto INT,
    IN p_id_cliente INT,
    IN p_calificacion INT,
    IN p_comentario TEXT
)
BEGIN
    -- El Trigger 'Before_Insert_Reseña' validará automáticamente si lo compró o no
    INSERT INTO Reseñas (id_producto, id_cliente, calificacion, comentario, fecha)
    VALUES (p_id_producto, p_id_cliente, p_calificacion, p_comentario, NOW());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_ReporteStockBajo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ReporteStockBajo`()
BEGIN
    SELECT id_producto, nombre, stock, precio
    FROM Productos
    WHERE stock < 5
    ORDER BY stock ASC;
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

-- Dump completed on 2026-07-11 10:26:55
