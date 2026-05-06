package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import conexion.Conexion;
import dominio.Seguro;

public class SeguroDAO {

    public void insertar(Seguro seguro) throws Exception {
        String sql = "INSERT INTO seguros (descripcion, idTipo, costoContratacion, costoAsegurado) VALUES (?, ?, ?, ?)";
        Connection cn = null;
        try {
            cn = Conexion.getConexion();
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, seguro.getDescripcion());
            ps.setInt(2, seguro.getIdTipo());
            ps.setDouble(3, seguro.getCostoContratacion());
            ps.setDouble(4, seguro.getCostoAsegurado());
            ps.executeUpdate();
        } finally {
            Conexion.cerrarConexion(cn);
        }
    }

    public ArrayList<Seguro> obtenerTodos() throws Exception {
        ArrayList<Seguro> lista = new ArrayList<>();
        String sql = "SELECT idSeguro, descripcion, idTipo, costoContratacion, costoAsegurado FROM seguros";
        Connection cn = null;
        try {
            cn = Conexion.getConexion();
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Seguro s = new Seguro(
                    rs.getInt("idSeguro"),
                    rs.getString("descripcion"),
                    rs.getInt("idTipo"),
                    rs.getDouble("costoContratacion"),
                    rs.getDouble("costoAsegurado")
                );
                lista.add(s);
            }
        } finally {
            Conexion.cerrarConexion(cn);
        }
        return lista;
    }

    public ArrayList<Seguro> obtenerPorTipo(int idTipo) throws Exception {
        ArrayList<Seguro> lista = new ArrayList<>();
        String sql = "SELECT idSeguro, descripcion, idTipo, costoContratacion, costoAsegurado FROM seguros WHERE idTipo = ?";
        Connection cn = null;
        try {
            cn = Conexion.getConexion();
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setInt(1, idTipo);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Seguro s = new Seguro(
                    rs.getInt("idSeguro"),
                    rs.getString("descripcion"),
                    rs.getInt("idTipo"),
                    rs.getDouble("costoContratacion"),
                    rs.getDouble("costoAsegurado")
                );
                lista.add(s);
            }
        } finally {
            Conexion.cerrarConexion(cn);
        }
        return lista;
    }

    public int obtenerMaximoId() throws Exception {
        String sql = "SELECT MAX(idSeguro) FROM seguros";
        Connection cn = null;
        try {
            cn = Conexion.getConexion();
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt(1); 
            }
        } finally {
            Conexion.cerrarConexion(cn);
        }
        return 0;
    }
}