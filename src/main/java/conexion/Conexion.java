package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion 
{

    // ── Datos de conexión ──────────────────────────────────────────────────
	
    private static final String URL    = "jdbc:mysql://localhost:3306/SegurosGroup";
    private static final String USUARIO = "root";
    private static final String CLAVE   = "";
    private static final String DRIVER  = "com.mysql.cj.jdbc.Driver";

    /**
     * Devuelve una conexión activa a la base de datos SegurosGroup.
     * Recordar cerrar la conexión después de usarla.
     */
    public static Connection getConexion() {
        Connection cn = null;
        try {
            Class.forName(DRIVER);
            cn = DriverManager.getConnection(URL, USUARIO, CLAVE);
            System.out.println("✔ Conexión exitosa a SegurosGroup");
        } catch (ClassNotFoundException e) {
            System.out.println("✘ Driver no encontrado: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("✘ Error de conexión SQL: " + e.getMessage());
        }
        return cn;
    }

    /**
     * Cierra una conexión de forma segura.
     */
    public static void cerrarConexion(Connection cn) {
        if (cn != null) {
            try {
                cn.close();
                System.out.println("✔ Conexión cerrada correctamente");
            } catch (SQLException e) {
                System.out.println("✘ Error al cerrar conexión: " + e.getMessage());
            }
        }
    }
}