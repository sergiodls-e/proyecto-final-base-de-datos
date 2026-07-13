USE tienda_electronica;

DELIMITER //

CREATE TRIGGER Before_Insert_Reseña 
BEFORE INSERT ON Reseñas 
FOR EACH ROW 
BEGIN
    DECLARE v_compras_existentes INT;

    SELECT COUNT(*) INTO v_compras_existentes
    FROM Detalles_Pedido dp
    JOIN Pedidos p ON dp.id_pedido = p.id_pedido
    WHERE p.id_cliente = NEW.id_cliente 
      AND dp.id_producto = NEW.id_producto
      AND p.estado IN ('enviado', 'entregado');

    IF v_compras_existentes = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error de integridad: No puedes dejar una reseña de un producto que no has comprado.';
    END IF;
END //

CREATE TRIGGER After_Insert_Reseña 
AFTER INSERT ON Reseñas 
FOR EACH ROW 
BEGIN
    IF NEW.calificacion <= 2 THEN
        SET @alerta_servicio = CONCAT('¡Alerta! Reseña negativa detectada para el producto ID: ', NEW.id_producto);
    END IF;
END //

CREATE PROCEDURE RegistrarPedido(
    IN p_id_cliente INT,
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_stock_actual INT;
    DECLARE v_precio_producto DECIMAL(10,2);
    DECLARE v_id_pedido INT;

    SELECT stock, precio INTO v_stock_actual, v_precio_producto
    FROM Productos
    WHERE id_producto = p_id_producto;

    IF v_stock_actual >= p_cantidad THEN
        INSERT INTO Pedidos (id_cliente, fecha_pedido, estado)
        VALUES (p_id_cliente, NOW(), 'pendiente');
        
        SET v_id_pedido = LAST_INSERT_ID();

        INSERT INTO Detalles_Pedido (id_pedido, id_producto, cantidad, precio_unitario)
        VALUES (v_id_pedido, p_id_producto, p_cantidad, v_precio_producto);

        UPDATE Productos
        SET stock = stock - p_cantidad
        WHERE id_producto = p_id_producto;
        
        SELECT 'Pedido registrado exitosamente y stock actualizado.' AS Resultado;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Stock insuficiente para completar el pedido.';
    END IF;
END //

CREATE PROCEDURE ReporteMensualVentas(
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
END //

CREATE PROCEDURE SP_ActualizarCliente(
    IN p_id_cliente INT,
    IN p_nueva_direccion TEXT,
    IN p_nuevo_telefono VARCHAR(20)
)
BEGIN
    UPDATE Clientes
    SET direccion = p_nueva_direccion, telefono = p_nuevo_telefono
    WHERE id_cliente = p_id_cliente;
END //

CREATE PROCEDURE SP_ActualizarStock(
    IN p_id_producto INT,
    IN p_cantidad_restar INT
)
BEGIN
    UPDATE Productos
    SET stock = stock - p_cantidad_restar
    WHERE id_producto = p_id_producto;
END //

CREATE PROCEDURE SP_AgregarProducto(
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
END //

CREATE PROCEDURE SP_CambiarEstadoPedido(
    IN p_id_pedido INT,
    IN p_nuevo_estado ENUM('pendiente', 'enviado', 'entregado')
)
BEGIN
    UPDATE Pedidos
    SET estado = p_nuevo_estado
    WHERE id_pedido = p_id_pedido;
END //

CREATE PROCEDURE SP_EliminarReseñasProducto(
    IN p_id_producto INT
)
BEGIN
    DELETE FROM Reseñas WHERE id_producto = p_id_producto;
    SELECT 'Reseñas eliminadas. El promedio se ha actualizado.' AS Resultado;
END //

CREATE PROCEDURE SP_RegistrarPedido(
    IN p_id_cliente INT,
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_pedidos_pendientes INT;
    DECLARE v_stock_actual INT;
    DECLARE v_precio_unitario DECIMAL(10,2);
    DECLARE v_id_pedido INT;

    SELECT COUNT(*) INTO v_pedidos_pendientes
    FROM Pedidos
    WHERE id_cliente = p_id_cliente AND estado = 'pendiente';

    IF v_pedidos_pendientes >= 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El cliente ya tiene el máximo de 5 pedidos pendientes.';
    END IF;

    SELECT stock, precio INTO v_stock_actual, v_precio_unitario
    FROM Productos WHERE id_producto = p_id_producto;

    IF v_stock_actual < p_cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Stock insuficiente para el producto solicitado.';
    END IF;

    INSERT INTO Pedidos (id_cliente, fecha_pedido, estado) VALUES (p_id_cliente, NOW(), 'pendiente');
    SET v_id_pedido = LAST_INSERT_ID();

    INSERT INTO Detalles_Pedido (id_pedido, id_producto, quantity, precio_unitario)
    VALUES (v_id_pedido, p_id_producto, p_cantidad, v_precio_unitario);

    CALL SP_ActualizarStock(p_id_producto, p_cantidad);
END //

CREATE PROCEDURE SP_RegistrarReseña(
    IN p_id_producto INT,
    IN p_id_cliente INT,
    IN p_calificacion INT,
    IN p_comentario TEXT
)
BEGIN
    INSERT INTO Reseñas (id_producto, id_cliente, calificacion, comentario, fecha)
    VALUES (p_id_producto, p_id_cliente, p_calificacion, p_comentario, NOW());
END //

CREATE PROCEDURE SP_ReporteStockBajo()
BEGIN
    SELECT id_producto, nombre, stock, precio
    FROM Productos
    WHERE stock < 5
    ORDER BY stock ASC;
END //

DELIMITER ;
