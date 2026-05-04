package dao;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import conexion.Conexion;
import dominio.TipoSeguro;
public class TipoSeguroDAO 
{
    public ArrayList<TipoSeguro> traerTodos() 
    {
        ArrayList<TipoSeguro> lista = new ArrayList<TipoSeguro>();
        Connection cn = null;
        try 
        {
            cn = Conexion.getConexion();
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery("SELECT idTipo, descripcion FROM tipoSeguros");
            while (rs.next()) 
            {
                TipoSeguro ts = new TipoSeguro();
                ts.setIdTipo(rs.getInt("idTipo"));
                ts.setDescripcion(rs.getString("descripcion"));
                lista.add(ts);
            }
        } 
        catch (Exception e) 
        {
            System.out.println("Error al traer tipos de seguro: " + e.getMessage());
            e.printStackTrace();
        } 
        finally 
        {
            Conexion.cerrarConexion(cn);
        }
        return lista;
    }
}