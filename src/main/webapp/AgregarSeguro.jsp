<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dominio.TipoSeguro" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Agregar Seguro - SegurosGroup</title>
</head>
<body>

    <nav>
        <a href="inicio.jsp">Inicio</a>
        <a href="AgregarSeguro.jsp">Agregar Seguro</a>
        <a href="ListarSeguros.jsp">Listar Seguros</a>
    </nav>

    <h1>Agregar Seguros</h1>

    <form action="AgregarSeguroServlet" method="post">
        <label for="idSeguro">Id Seguro:</label>
        <input type="text" id="idSeguro" name="idSeguro" value="1" disabled>
        <br><br>

        <label for="descripcion">Descripción:</label><br>
        <textarea id="descripcion" name="descripcion" rows="4" cols="50"></textarea>
        <br><br>

        <label for="idTipo">Tipo de Seguro:</label>
        <select id="idTipo" name="idTipo">
            <%
                ArrayList<TipoSeguro> listaTipos = (ArrayList<TipoSeguro>) request.getAttribute("listaTipos");
                if (listaTipos != null) 
                {
                    for (TipoSeguro ts : listaTipos) 
                    {
            %>
                        <option value="<%= ts.getIdTipo() %>"><%= ts.getDescripcion() %></option>
            <%
                    }
                }
            %>
        </select>
        <br><br>
        
        <label for="costo">Costo contratación:</label>
		<input type="number" 
       			id="costo" 
       			name="txtCosto" 
       			step="0.01" 
       			min="0" 
       			placeholder="0.00" 
       			required>
		<br><br>
		
    </form>

</body>
</html>