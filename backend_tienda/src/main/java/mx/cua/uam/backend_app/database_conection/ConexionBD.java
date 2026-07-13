package mx.cua.uam.backend_app.database_conection;

import java.sql.Connection;
import java.sql.SQLException;
import javax.sql.DataSource;

import org.springframework.stereotype.Component;

@Component
public class ConexionBD {
    private final DataSource dataSource;
    private Connection conexion;

    public ConexionBD(DataSource ds){
        this.dataSource = ds;
    }

    public Connection getConexion() {
        return conexion;
    }

    public void conectar(){
        this.conexion = null;

        try {
            this.conexion = dataSource.getConnection();
            //System.out.println("Conexión exitosa a la base de datos...");
        } catch (SQLException e) {
            System.err.println("A ocurrido un error: "+e.getMessage());
        }

    }

    public void desconectar(){
        if(this.conexion != null){
            try {
                this.conexion.close();
            } catch (SQLException e) {
                System.err.println(e.getMessage());
            }
        }
    }
}
