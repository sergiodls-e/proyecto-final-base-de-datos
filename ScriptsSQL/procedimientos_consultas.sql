-- //Vistas// --

-- 1. Listar productos disponibles por categoría, ordenados por precio.
CREATE OR REPLACE VIEW Vista_Productos_Disponibles AS 
SELECT 
    c.id_producto ID_producto,
    c.nombre Categoria, 
    p.nombre Producto, 
    p.precio Precio, 
    p.stock Unidades_Disponibles
FROM Productos p
JOIN Categorias c ON p.id_categoria = c.id_categoria --> Se realiza un JOIN (INNER JOIN) para encontrar una 'coincidencia exacta' en ambas tablas. 
WHERE p.stock > 0 --> Filtramos para obtener solo productos con almenos 1 pieza en Stock.
ORDER BY c.nombre ASC, p.precio ASC; --> Ordenamos en sentido ascendente por el nombre del ciente y el precio del producto. 

-- 2. Mostrar clientes con pedidos pendientes y total de compras.
CREATE OR REPLACE VIEW Vista_Clientes_Pedidos_Pendientes AS
SELECT 
    c.id_cliente,
    c.nombre Cliente,
    --> Solo suma cuando el estado del pedido se encuentra 'pendiente'. 
    SUM(CASE WHEN p.estado = 'pendiente' THEN 1 ELSE 0 END) AS Pedidos_Pendientes,
    --> Comprobación para valores nulos, devuelve 0 si la suma de los productos (cantidad * precio_unitario) es NULL. 
    IFNULL(SUM(dp.cantidad * dp.precio_unitario), 0) AS Total_Historico_Compras
FROM Clientes c
JOIN Pedidos p ON c.id_cliente = p.id_cliente
JOIN Detalles_Pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY c.id_cliente, c.nombre --> Agrupamos según el ID de cliente y su nombre
HAVING Pedidos_Pendientes > 0; --> Filtramos solo aquellos que tienen almenos un pedido pendiente. 


-- 3. Reporte de los 5 productos con mejor calificación promedio en reseñas.
CREATE OR REPLACE VIEW Vista_Top5_Productos_Resenas AS
SELECT 
    p.id_producto, 
    p.nombre AS Producto, 
    --> Redondeamos el promedio de la calificación a dos decimales.
    ROUND(AVG(r.calificacion), 2) AS Calificacion_Promedio,
    --> Contamos el total de reseñas.  
    COUNT(r.id_reseña) AS Total_Reseñas
FROM Productos p
JOIN Reseñas r ON p.id_producto = r.id_producto
GROUP BY p.id_producto, p.nombre --> Agrupados por ID y nombre del producto 
ORDER BY Calificacion_Promedio DESC, Total_Reseñas DESC --> Ordenados por el promedio de calificación y el total de reseñas de forma descendente. 
LIMIT 5; --> Marcamos un límite de 5 productos a mostrar. 




-- //Procedimientos// --

-- 1. Registrar un nuevo pedido (verificando límite de 5 pendientes y stock).
DELIMITER //
DROP PROCEDURE IF EXISTS `SP_RegistrarPedido`// --> Comprobación general para evitar errores de creación (NOTA: Esto implicaría borrar un procedimento anterior para reemplazarlo con este)
CREATE PROCEDURE `SP_RegistrarPedido`(
    IN p_id_cliente INT,
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_pedidos_pendientes INT;
    DECLARE v_stock_actual INT;
    DECLARE v_precio_unitario DECIMAL(10,2);
    DECLARE v_id_pedido INT;

    --> Verifica la cantidad de pedidos pendientes del cliente.
    SELECT COUNT(*) INTO v_pedidos_pendientes
    FROM Pedidos
    WHERE id_cliente = p_id_cliente AND estado = 'pendiente';

    IF v_pedidos_pendientes >= 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El cliente ya tiene el máximo de 5 pedidos pendientes.';
    END IF;

    --> Verifica el stock y obtiene el precio del producto. 
    SELECT stock, precio INTO v_stock_actual, v_precio_unitario
    FROM Productos WHERE id_producto = p_id_producto;

    IF v_stock_actual < p_cantidad THEN
        --> Mensaje de error y señal de paro total para el sistema. 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Stock insuficiente para el producto solicitado.';
    END IF;

    --> Inserción del pedido
    INSERT INTO Pedidos (id_cliente, fecha_pedido, estado) VALUES (p_id_cliente, NOW(), 'pendiente');
    SET v_id_pedido = LAST_INSERT_ID();

    --> Inserción del detalle
    INSERT INTO Detalles_Pedido (id_pedido, id_producto, cantidad, precio_unitario)
    VALUES (v_id_pedido, p_id_producto, p_cantidad, v_precio_unitario);

    --> Se actualiza el stock mandando a llamar la Routine correpondiente. 
    CALL SP_ActualizarStock(p_id_producto, p_cantidad);
END //
DELIMITER ;


-- 2. Registrar una reseña.
DELIMITER //
DROP PROCEDURE IF EXISTS `SP_RegistrarReseña`//
CREATE PROCEDURE `SP_RegistrarReseña`(
    IN p_id_producto INT,
    IN p_id_cliente INT,
    IN p_calificacion INT,
    IN p_comentario TEXT
)
BEGIN
    INSERT INTO Reseñas (id_producto, id_cliente, calificacion, comentario, fecha)
    -- El Trigger 'Before_Insert_Reseña' validará automáticamente si el cliente compró el producto.
    -- Si no lo compró, el trigger abortará el INSERT automáticamente lanzando un error 45000.
    VALUES (p_id_producto, p_id_cliente, p_calificacion, p_comentario, NOW());
END //
DELIMITER ;


-- 3. Actualizar el stock de un producto después de un pedido.
DELIMITER //
DROP PROCEDURE IF EXISTS `SP_ActualizarStock`//
CREATE PROCEDURE `SP_ActualizarStock`(
    IN p_id_producto INT,
    IN p_cantidad_restar INT
)
BEGIN
    UPDATE Productos
    --> El Stock se reduce X cantidad según el pedido del producto realizado.
    SET stock = stock - p_cantidad_restar
    WHERE id_producto = p_id_producto;
END //
DELIMITER ;


-- 4. Cambiar el estado de un pedido.
DELIMITER //
DROP PROCEDURE IF EXISTS `SP_CambiarEstadoPedido`//
CREATE PROCEDURE `SP_CambiarEstadoPedido`(
    IN p_id_pedido INT,
    IN p_nuevo_estado ENUM('pendiente', 'enviado', 'entregado')
)
BEGIN
    UPDATE Pedidos
    --> Definimos el estado según sea el caso. 
    SET estado = p_nuevo_estado
    WHERE id_pedido = p_id_pedido;
END //
DELIMITER ;


-- 5. Eliminar reseñas de un producto específico.
DELIMITER //
DROP PROCEDURE IF EXISTS `SP_EliminarReseñasProducto`//
CREATE PROCEDURE `SP_EliminarReseñasProducto`(
    IN p_id_producto INT
)
BEGIN
    DELETE FROM Reseñas WHERE id_producto = p_id_producto;
    SELECT 'Reseñas eliminadas. El promedio se actualizará en las consultas dinámicas.' AS Resultado;
END //
DELIMITER ;


-- 6. Agregar un nuevo producto verificando duplicados.
DELIMITER //
DROP PROCEDURE IF EXISTS `SP_AgregarProducto`//
CREATE PROCEDURE `SP_AgregarProducto`(
    IN p_id_categoria INT,
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_precio DECIMAL(10,2),
    IN p_stock INT
)
BEGIN
    DECLARE v_existe INT;

    --> Se relaliza un conteo de productos para posteriormente validar si se intenta agregar un producto ya existente. 
    SELECT COUNT(*) INTO v_existe
    FROM Productos
    WHERE nombre = p_nombre AND id_categoria = p_id_categoria;

    --> Señal de error y paro total de la Routine si el producto existe. 
    IF v_existe > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Ya existe un producto con ese nombre en esta categoría.';
    END IF;

    --> Si no es el caso se realiza la inserción del producto. 
    INSERT INTO Productos (id_categoria, nombre, descripcion, precio, stock)
    VALUES (p_id_categoria, p_nombre, p_descripcion, p_precio, p_stock);
END //
DELIMITER ;


--7. Actualizar la información de un cliente.
DELIMITER //
DROP PROCEDURE IF EXISTS `SP_ActualizarCliente`//
CREATE PROCEDURE `SP_ActualizarCliente`(
    IN p_id_cliente INT,
    IN p_nueva_direccion TEXT,
    IN p_nuevo_telefono VARCHAR(20)
)
BEGIN
    UPDATE Clientes
    --> Actualizamos el nuevo valor de los atributos del cliente. 
    SET direccion = p_nueva_direccion, telefono = p_nuevo_telefono
    WHERE id_cliente = p_id_cliente;
END //
DELIMITER ;


-- 8. Generar un reporte de productos con stock bajo (< 5 unidades).
DELIMITER //
DROP PROCEDURE IF EXISTS `SP_ReporteStockBajo`//
CREATE PROCEDURE `SP_ReporteStockBajo`()
BEGIN
    --> Tomamos toda la información relevante del producto. 
    SELECT 
        id_producto, 
        nombre AS Producto, 
        stock AS Unidades_Disponibles, 
        precio
    FROM Productos
    --> Filtramos aquellos que tengan menos de 5 piezas en Stock. 
    WHERE stock < 5
    ORDER BY stock ASC;
END //
DELIMITER ;