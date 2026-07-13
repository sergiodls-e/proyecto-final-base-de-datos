package mx.cua.uam.backend_app.querys;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import org.springframework.stereotype.Service;

import mx.cua.uam.backend_app.database_conection.ConexionBD;

@Service
public class ControladorConsultas {
	private final ConexionBD conexion;

	public ControladorConsultas(ConexionBD cbd) {
		this.conexion = cbd;
	}

    public void executeStatement(String sqlSentence){
        Statement sentencia = null;
        ResultSet resultado = null;
        conexion.conectar();

        try {
			sentencia = conexion.getConexion().createStatement();
			resultado = sentencia.executeQuery(sqlSentence);
            
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
				if (conexion!=null) {
					conexion.getConexion().close();
				}
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
    }
}

