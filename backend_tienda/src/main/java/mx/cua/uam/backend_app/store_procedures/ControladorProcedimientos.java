package mx.cua.uam.backend_app.store_procedures;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import org.springframework.stereotype.Service;

import mx.cua.uam.backend_app.database_conection.ConexionBD;

@Service
public class ControladorProcedimientos {
    private final ConexionBD conexion;

    public ControladorProcedimientos(ConexionBD conexion) {
        this.conexion = conexion;
    }

    public void executeProcedure(String spCall){
        CallableStatement sentencia = null;
        ResultSet resultado = null;
        conexion.conectar();

        try {
            // Se prepara la llamada al procedimiento almacenado
            sentencia = conexion.getConexion().prepareCall(spCall);
            
            // execute() devuelve true si el procedimiento retorna un ResultSet (filas)
            // devuelve false si es una actualización (INSERT, UPDATE, DELETE) o no devuelve nada.
            boolean hasResults = sentencia.execute();
            
            if (hasResults) {
                resultado = sentencia.getResultSet();
                ResultSetMetaData rsmd = resultado.getMetaData();
                int columsNumber = rsmd.getColumnCount();
                
                for (int i = 1; i <= columsNumber; i++) {
                    System.out.print(rsmd.getColumnLabel(i)+ " | ");
                }
                System.out.println("\n ==========================");
                
                while (resultado.next()) {
                    for (int i = 1; i <= columsNumber; i++) {
                        if (i > 1) System.out.print(", ");
                        String columnValue = resultado.getString(i);
                        System.out.print(columnValue);
                    }
                    System.out.println("");
                }
            } else {
                System.out.println("El Stored Procedure se ejecutó correctamente (sin resultados de tabla).");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(resultado != null){
                    resultado.close();
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
            try {
                if(sentencia!=null){
                    sentencia.close();
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
            try {
                if (conexion!=null && conexion.getConexion() != null) {
                    conexion.getConexion().close();
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }

    public void executeProcedure(String spCall, Object... params){
        CallableStatement sentencia = null;
        ResultSet resultado = null;
        conexion.conectar();

        try {
            // Se prepara la llamada al procedimiento almacenado
            sentencia = conexion.getConexion().prepareCall(spCall);
            
            // execute() devuelve true si el procedimiento retorna un ResultSet (filas)
            // devuelve false si es una actualización (INSERT, UPDATE, DELETE) o no devuelve nada.
            boolean hasResults = sentencia.execute();
            
            if (hasResults) {
                resultado = sentencia.getResultSet();
                ResultSetMetaData rsmd = resultado.getMetaData();
                int columsNumber = rsmd.getColumnCount();
                
                for (int i = 1; i <= params.length; i++) {
                    System.out.print(rsmd.getColumnLabel(i)+ " | ");
                }
                System.out.println("\n ==========================");
                
                while (resultado.next()) {
                    for (int i = 1; i <= columsNumber; i++) {
                        if (i > 1) System.out.print(", ");
                        String columnValue = resultado.getString(i);
                        System.out.print(columnValue);
                    }
                    System.out.println("");
                }
            } else {
                System.out.println("El Stored Procedure se ejecutó correctamente (sin resultados de tabla).");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(resultado != null){
                    resultado.close();
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
            try {
                if(sentencia!=null){
                    sentencia.close();
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
            try {
                if (conexion!=null && conexion.getConexion() != null) {
                    conexion.getConexion().close();
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }
}
