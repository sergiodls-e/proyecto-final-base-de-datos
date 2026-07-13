package mx.cua.uam.backend_app.store_procedures;

import org.springframework.stereotype.Component;

@Component
public class Procedimientos {
    private final ControladorProcedimientos cp;

    public Procedimientos(ControladorProcedimientos cp) {
        this.cp = cp;
    }

    public void registrarPedido(int id_cliente, int id_producto, int cantidad){
        cp.executeProcedure("{CALL SP_RegistrarPedido(?, ?, ?)}", id_cliente, id_producto, cantidad);
    }

    public void registrarResena(int id_producto, int id_cliente, int calificacion, String comentario){
        cp.executeProcedure("{CALL SP_RegistrarReseña(?, ?, ?, ?)}", id_producto, id_cliente, calificacion, comentario);
    }

    public void actualizarStock(int id_producto, int cant_restar){
        cp.executeProcedure("{CALL SP_ActualizarStock(?, ?)}", id_producto, cant_restar);
    }

    public void cambiarEstadoPedido(int id_pedido, EstadosPedido estado){
    cp.executeProcedure("{CALL sp_actualizarEstadoPedido(?, ?)}", id_pedido, estado.name());
    }

    public void eliminarResenasProducto(int id_producto){
        cp.executeProcedure("{CALL SP_EliminarReseñasProducto(?)}", id_producto);
    }

    public void agregarProducto(int id_categoria, String nombre, String descripcion, float precio, int stock){
        cp.executeProcedure("{CALL SP_AgregarProducto(?, ?, ?, ?, ?)}", id_categoria, nombre, descripcion, precio, stock);
    }

    public void actualizarCliente(int id_cliente, String direccion, String telefono){
        cp.executeProcedure("{CALL SP_ActualizarCliente(?, ?, ?)}", id_cliente, direccion, telefono);
    }

    public void reporteStockBajo(){
        cp.executeProcedure("{CALL SP_ReporteStockBajo()}");
    }

    public void llamarProcedimiento(String sp_name){
        cp.executeProcedure(sp_name);
    }
}
