USE tienda_electronica;

-- 1. Total de Ventas e Ingresos por Categoría
SELECT 
    c.nombre AS categoria,
    COUNT(dp.id_detalle) AS total_productos_vendidos,
    SUM(dp.cantidad * dp.precio_unitario) AS ingresos_totales
FROM Categorias c
JOIN Productos p ON c.id_categoria = p.id_categoria
JOIN Detalles_Pedido dp ON p.id_producto = dp.id_producto
JOIN Pedidos ped ON dp.id_pedido = ped.id_pedido
WHERE ped.estado != 'pendiente'
GROUP BY c.id_categoria, c.nombre
ORDER BY ingresos_totales DESC;

-- 2. Clientes (Top Compradores con gasto mayor a $15,000 MXN)
SELECT 
    cl.id_cliente,
    cl.nombre AS cliente,
    cl.correo,
    COUNT(DISTINCT p.id_pedido) AS total_pedidos,
    SUM(dp.cantidad * dp.precio_unitario) AS monto_total_gastado
FROM Clientes cl
JOIN Pedidos p ON cl.id_cliente = p.id_cliente
JOIN Detalles_Pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY cl.id_cliente, cl.nombre, cl.correo
HAVING monto_total_gastado > 15000.00
ORDER BY monto_total_gastado DESC;

-- 3. Promedio de Calificación y Popularidad de Productos
SELECT 
    p.id_producto,
    p.nombre AS producto,
    p.precio,
    COUNT(r.id_reseña) AS numero_de_reseñas,
    ROUND(AVG(r.calificacion), 1) AS calificacion_promedio
FROM Productos p
LEFT JOIN Reseñas r ON p.id_producto = r.id_producto
GROUP BY p.id_producto, p.nombre, p.precio
ORDER BY calificacion_promedio DESC, numero_de_reseñas DESC;

-- 4. Productos con Stock Crítico (Menor al Promedio General)
SELECT 
    id_producto,
    nombre,
    stock,
    precio
FROM Productos
WHERE stock < (SELECT AVG(stock) FROM Productos)
ORDER BY stock ASC;

-- 5. Historial Detallado de un Pedido Específico
SELECT 
    ped.id_pedido,
    cl.nombre AS comprador,
    ped.fecha_pedido,
    ped.estado,
    prod.nombre AS articulo,
    dp.cantidad,
    dp.precio_unitario,
    (dp.cantidad * dp.precio_unitario) AS subtotal
FROM Pedidos ped
JOIN Clientes cl ON ped.id_cliente = cl.id_cliente
JOIN Detalles_Pedido dp ON ped.id_pedido = dp.id_pedido
JOIN Productos prod ON dp.id_producto = prod.id_producto
WHERE ped.id_pedido = 1;
