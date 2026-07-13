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

DELIMITER ;
