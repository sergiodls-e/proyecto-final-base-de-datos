package mx.cua.uam.backend_app.client;

import java.util.Arrays;
import java.util.Scanner;

import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Service;

import mx.cua.uam.backend_app.querys.Consultas;
import mx.cua.uam.backend_app.store_procedures.Procedimientos;
// Asegúrate de que la ruta de tu Enum sea correcta según tu proyecto
import mx.cua.uam.backend_app.store_procedures.EstadosPedido; 

@Service
public class ConsolaPrincipal {
    private final Consultas consultas;
    private final Procedimientos procedimientos;

    public ConsolaPrincipal(Consultas consultas, Procedimientos procedimientos) {
        this.consultas = consultas;
        this.procedimientos = procedimientos;
    }

    @EventListener(ApplicationReadyEvent.class)
    public void iniciarConsola() {
        new Thread(this::ejecutarMenuInteractivo).start();
    }

    private void ejecutarMenuInteractivo() {
        try { Thread.sleep(1000); } catch (InterruptedException ignored) {}

        Scanner scanner = new Scanner(System.in);
        System.out.println("\n===================================================");
        System.out.println("  BIENVENIDO A LA CONSOLA DE BASE DE DATOS");
        System.out.println("===================================================");
        mostrarAyuda();

        while (true) {
            System.out.print("\ndb-admin> ");
            if (!scanner.hasNextLine()) {
                break; 
            }
            
            String input = scanner.nextLine().trim();
            String[] comandos = input.split(" ");

            if (comandos.length == 0 || comandos[0].isEmpty()) continue;

            String accion = comandos[0].toLowerCase();

            try {
                switch (accion) {
                    // ===============================================
                    //             COMANDOS DE CONSULTAS 
                    // ===============================================
                    case "productos":
                        System.out.println("Ejecutando consulta de Productos Disponibles...");
                        consultas.productosDisponibles();
                        break;
                        
                    case "pendientes":
                        System.out.println("Ejecutando consulta de Pedidos Pendientes...");
                        consultas.pedidosPendientes();
                        break;
                        
                    case "top5":
                        System.out.println("Ejecutando consulta del Top 5 Productos...");
                        consultas.productosTop5();
                        break;

                    case "consulta_libre":
                        if (comandos.length > 1) {
                            // Extrae todo lo que está después de la palabra "consulta_libre"
                            String sql = input.substring(accion.length()).trim();
                            System.out.println("Ejecutando consulta libre...");
                            consultas.generarConsulta(sql);
                        } else {
                            System.out.println("Uso: consulta_libre <sentencia_sql>");
                        }
                        break;

                    // ===============================================
                    //           COMANDOS DE PROCEDIMIENTOS 
                    // ===============================================
                    case "stock_bajo":
                        System.out.println("Llamando reporte de Stock Bajo...");
                        procedimientos.reporteStockBajo();
                        break;

                    case "registrar_pedido":
                        if (comandos.length == 4) {
                            int idCliente = Integer.parseInt(comandos[1]);
                            int idProducto = Integer.parseInt(comandos[2]);
                            int cantidad = Integer.parseInt(comandos[3]);
                            
                            procedimientos.registrarPedido(idCliente, idProducto, cantidad);
                            System.out.println("[Éxito]: Solicitud de registro enviada.");
                        } else {
                            System.out.println("Uso incorrecto. Ejemplo: registrar_pedido 1 5 10");
                        }
                        break;

                    case "actualizar_stock":
                        if (comandos.length == 3) {
                            int idProducto = Integer.parseInt(comandos[1]);
                            int cantRestar = Integer.parseInt(comandos[2]);
                            
                            procedimientos.actualizarStock(idProducto, cantRestar);
                            System.out.println("[Éxito]: Solicitud de actualización enviada.");
                        } else {
                            System.out.println("Uso incorrecto. Ejemplo: actualizar_stock 5 2");
                        }
                        break;

                    case "registrar_resena":
                        if (comandos.length >= 5) {
                            int idProducto = Integer.parseInt(comandos[1]);
                            int idCliente = Integer.parseInt(comandos[2]);
                            int calificacion = Integer.parseInt(comandos[3]);
                            // Une el resto de las palabras como un solo comentario
                            String comentario = String.join(" ", Arrays.copyOfRange(comandos, 4, comandos.length));
                            
                            procedimientos.registrarResena(idProducto, idCliente, calificacion, comentario);
                            System.out.println("[Éxito]: Reseña registrada correctamente.");
                        } else {
                            System.out.println("Uso incorrecto. Ejemplo: registrar_resena 1 2 5 Excelente producto muy rápido");
                        }
                        break;

                    case "cambiar_estado":
                        if (comandos.length == 3) {
                            int idPedido = Integer.parseInt(comandos[1]);
                            try {
                                // Convierte el String de la consola al Enum de Java
                                EstadosPedido estado = EstadosPedido.valueOf(comandos[2].toLowerCase());
                                procedimientos.cambiarEstadoPedido(idPedido, estado);
                                System.out.println("[Éxito]: Estado del pedido actualizado a " + estado);
                            } catch (IllegalArgumentException e) {
                                System.out.println("[Error]: Estado no válido. Usa: pendiente, enviado o entregado.");
                            }
                        } else {
                            System.out.println("Uso incorrecto. Ejemplo: cambiar_estado 10 enviado");
                        }
                        break;

                    case "eliminar_resenas":
                        if (comandos.length == 2) {
                            int idProducto = Integer.parseInt(comandos[1]);
                            procedimientos.eliminarResenasProducto(idProducto);
                            System.out.println("[Éxito]: Reseñas eliminadas para el producto " + idProducto);
                        } else {
                            System.out.println("Uso incorrecto. Ejemplo: eliminar_resenas 5");
                        }
                        break;

                    case "agregar_producto":
                        if (comandos.length == 6) {
                            int idCategoria = Integer.parseInt(comandos[1]);
                            // Reemplaza guiones bajos por espacios para soportar nombres largos
                            String nombre = comandos[2].replace("_", " ");
                            String descripcion = comandos[3].replace("_", " ");
                            float precio = Float.parseFloat(comandos[4]);
                            int stock = Integer.parseInt(comandos[5]);
                            
                            procedimientos.agregarProducto(idCategoria, nombre, descripcion, precio, stock);
                            System.out.println("[Éxito]: Producto '" + nombre + "' agregado a la base de datos.");
                        } else {
                            System.out.println("Uso incorrecto. Usa guiones bajos para espacios. Ejemplo: agregar_producto 1 Teclado_Mecanico Teclado_con_luces_RGB 1200.50 15");
                        }
                        break;

                    case "actualizar_cliente":
                        if (comandos.length >= 4) {
                            int idCliente = Integer.parseInt(comandos[1]);
                            String telefono = comandos[2];
                            // Une el resto de las palabras como la dirección
                            String direccion = String.join(" ", Arrays.copyOfRange(comandos, 3, comandos.length));
                            
                            procedimientos.actualizarCliente(idCliente, direccion, telefono);
                            System.out.println("[Éxito]: Datos del cliente " + idCliente + " actualizados.");
                        } else {
                            System.out.println("Uso incorrecto. Ejemplo: actualizar_cliente 3 5551234567 Calle Benito Juarez 123");
                        }
                        break;

                    case "procedimiento_libre":
                        if (comandos.length > 1) {
                            String spCall = input.substring(accion.length()).trim();
                            System.out.println("Ejecutando procedimiento libre...");
                            procedimientos.llamarProcedimiento(spCall);
                        } else {
                            System.out.println("Uso: procedimiento_libre {CALL sp_nombre(params)}");
                        }
                        break;

                    // ===============================================
                    //               COMANDOS GENERALES 
                    // ===============================================
                    case "ayuda":
                        mostrarAyuda();
                        break;
                        
                    case "salir":
                        System.out.println("Apagando la consola de DB... ¡Hasta pronto!");
                        scanner.close();
                        System.exit(0);
                        
                    default:
                        System.out.println("Comando no reconocido. Escribe 'ayuda' para ver las opciones.");
                }
            } catch (NumberFormatException e) {
                System.out.println("[Error]: Por favor ingresa valores numéricos válidos donde se requieran IDs, cantidades o precios.");
            } catch (Exception e) {
                System.out.println("[Error interno de ejecución]: " + e.getMessage());
            }
        }
    }

    private void mostrarAyuda() {
        System.out.println("\n=== Comandos de Consulta ===");
        System.out.println("  productos                  -> Muestra los productos con stock disponible.");
        System.out.println("  pendientes                 -> Muestra los clientes con pedidos pendientes.");
        System.out.println("  top5                       -> Muestra los 5 productos mejor calificados.");
        System.out.println("  consulta_libre <sql>       -> Ejecuta cualquier consulta SQL (ej. consulta_libre SELECT * FROM Clientes).");
        
        System.out.println("\n=== Comandos de Procedimientos ===");
        System.out.println("  stock_bajo                 -> Ejecuta el reporte de productos con poco stock.");
        System.out.println("  registrar_pedido <idCliente> <idProducto> <cantidad>          -> Crea un nuevo pedido.");
        System.out.println("  actualizar_stock <idProducto> <cantRestar>                    -> Resta stock a un producto.");
        System.out.println("  registrar_resena <idProducto> <idCliente> <calif> <comentario>-> Crea una reseña (el comentario puede tener espacios).");
        System.out.println("  cambiar_estado <idPedido> <estado>                            -> Cambia estado (pendiente, enviado, entregado).");
        System.out.println("  eliminar_resenas <idProducto>                                 -> Borra todas las reseñas de un producto.");
        System.out.println("  agregar_producto <idCat> <nombre> <descripción> <precio> <stock> -> (NOTA: Usa guiones bajos '_' en lugar de espacios para nombre y descripción).");
        System.out.println("  actualizar_cliente <idCliente> <telefono> <direccion_completa>-> Actualiza los datos (la dirección puede tener espacios).");
        System.out.println("  procedimiento_libre <llamada>                                 -> Ejecuta SP crudo (ej. procedimiento_libre {CALL SP_Algo()}).");
        
        System.out.println("\n=== Comandos de Sistema ===");
        System.out.println("  ayuda                      -> Muestra este menú.");
        System.out.println("  salir                      -> Cierra la consola y apaga la aplicación.");
    }
}