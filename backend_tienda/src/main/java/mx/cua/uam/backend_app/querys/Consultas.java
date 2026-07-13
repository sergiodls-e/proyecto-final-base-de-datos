package mx.cua.uam.backend_app.querys;

import org.springframework.stereotype.Component;

@Component
public class Consultas {
    private final ControladorConsultas cc;

    public Consultas(ControladorConsultas cc) {
        this.cc = cc;
    } 
    
    public void productosDisponibles(){
        cc.executeStatement("""
                SELECT 
                p.id_producto ID_Producto,
                c.nombre Categoria,
                p.nombre Producto, 
                p.precio Precio, 
                p.stock Unidades_Disponibles
                FROM Productos p 
                JOIN Categorias c ON p.id_categoria = c.id_categoria 
                WHERE p.stock > 0
                ORDER BY c.nombre ASC, p.precio ASC
                """);
    }

    public void pedidosPendientes(){
        cc.executeStatement(""" 
                SELECT
                c.id_cliente,
                c.nombre Cliente,
                SUM(CASE WHEN p.estado = 'pendiente' THEN 1 ELSE 0 END) AS Pedidos_Pendientes,
                IFNULL(SUM(dp.cantidad * dp.precio_unitario), 0) AS Total_Historico_Compras
                FROM Clientes c
                JOIN Pedidos p ON c.id_cliente = p.id_cliente
                JOIN Detalles_Pedido dp ON p.id_pedido = dp.id_pedido
                GROUP BY c.id_cliente, c.nombre 
                HAVING Pedidos_Pendientes > 0
                """);
    }

    public void productosTop5(){
        cc.executeStatement("""
                SELECT
                p.id_producto,
                p.nombre AS Producto,
                ROUND(AVG(r.calificacion), 2) AS Calificacion_Promedio,
                COUNT(r.id_reseña) AS Total_Reseñas
                FROM Productos p
                JOIN Reseñas r ON p.id_producto = r.id_producto
                GROUP BY p.id_producto, p.nombre
                ORDER BY Calificacion_Promedio DESC, Total_Reseñas DESC 
                LIMIT 5;
                """);
    }

    public void generarConsulta(String sentenciaSql){
        cc.executeStatement(sentenciaSql);
    }
}
