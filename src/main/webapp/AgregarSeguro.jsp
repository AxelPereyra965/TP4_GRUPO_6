<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    </form>

</body>
</html>