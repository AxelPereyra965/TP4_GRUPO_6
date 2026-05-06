<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dominio.TipoSeguro" %>
<%@ page import="dominio.Seguro" %>
<%@ page import="datos.TipoSeguroDAO" %>
<%@ page import="datos.SeguroDAO" %>
<%

    ArrayList<TipoSeguro> listaTipos = new ArrayList<>();
    try {
        TipoSeguroDAO tipoDAO = new TipoSeguroDAO();
        listaTipos = tipoDAO.obtenerTodos();
    } catch (Exception e) {
        // queda vacío
    }


    String idTipoStr = request.getParameter("idTipo");
    Integer idTipoFiltro = null;
    if (idTipoStr != null && !idTipoStr.isEmpty()) {
        try {
            idTipoFiltro = Integer.parseInt(idTipoStr);
        } catch (NumberFormatException e) {
            idTipoFiltro = null;
        }
    }


    ArrayList<Seguro> listaSeguros = new ArrayList<>();
    try {
        SeguroDAO seguroDAO = new SeguroDAO();
        if (idTipoFiltro != null) {
            listaSeguros = seguroDAO.obtenerPorTipo(idTipoFiltro);
        } else {
            listaSeguros = seguroDAO.obtenerTodos();
        }
    } catch (Exception e) {

    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Listar Seguros - SegurosGroup</title>
    <style>
        table { border-collapse: collapse; margin-top: 10px; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>

    <nav>
        <a href="inicio.jsp">Inicio</a>
        <a href="AgregarSeguroServlet">Agregar Seguro</a>
        <a href="ListarSeguros.jsp">Listar Seguros</a>
    </nav>

    <h2>Tipo de seguros en la base de datos</h2>

    <form action="ListarSeguros.jsp" method="get">
        <label for="idTipo">Busqueda por tipo de seguros:</label>
        <select id="idTipo" name="idTipo">
            <%
                for (TipoSeguro tipo : listaTipos) {
                    String selected = "";
                    if (idTipoFiltro != null && idTipoFiltro.equals(tipo.getIdTipo())) {
                        selected = "selected";
                    }
            %>
                    <option value="<%= tipo.getIdTipo() %>" <%= selected %>><%= tipo.getDescripcion() %></option>
            <%
                }
            %>
        </select>
        <input type="submit" value="Filtrar">
    </form>


    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Descripción Seguro</th>
                <th>Descripción Tipo Seguro</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (listaSeguros.isEmpty()) {
            %>
                <tr>
                    <td colspan="3">Sin resultados</td>
                </tr>
            <%
                } else {
                    for (Seguro s : listaSeguros) {
                        String tipoDesc = "";
                        for (TipoSeguro t : listaTipos) {
                            if (t.getIdTipo() == s.getIdTipo()) {
                                tipoDesc = t.getDescripcion();
                                break;
                            }
                        }
            %>
                <tr>
                    <td><%= s.getId() %></td>
                    <td><%= s.getDescripcion() %></td>
                    <td><%= tipoDesc %></td>
                </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>

</body>
</html>