<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dominio.TipoSeguro" %>
<%

    String nextId = (String) request.getAttribute("nextId");
    if (nextId == null) {
        nextId = "1";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Agregar Seguro - SegurosGroup</title>
</head>
<body>

    <nav>
        <a href="inicio.jsp">Inicio</a>
        <a href="AgregarSeguroServlet">Agregar Seguro</a>
        <a href="ListarSeguros.jsp">Listar Seguros</a>
    </nav>

    <h1>Agregar Seguros</h1>

    <form action="AgregarSeguroServlet" method="post" onsubmit="return validarFormulario()">
        <label for="idSeguro">Id Seguro:</label>
        <input type="text" id="idSeguro" name="idSeguro" value="<%= nextId %>" disabled>
        <br><br>

        <label for="descripcion">Descripción:</label><br>
        <textarea id="descripcion" name="descripcion" rows="4" cols="50"></textarea>
        <span id="errorDescripcion" style="color: red;"></span>
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
        
        <label for="sumaAsegurada">Costo Máximo Asegurado:</label>
        <input type="number" step="0.01" min="0" id="sumaAsegurada" name="sumaAsegurada" required>
        <span id="errorSuma" style="color: red;"></span>
        <br><br>
       
        <input type="submit" value="Aceptar">
        &nbsp;
        <input type="button" value="Aceptar" id="btnGuardarCostoMaximo">
        <span id="mensajeGuardado" style="color: green; margin-left: 5px;"></span>
    </form>

    <script>
 
        function validarFormulario() {

            const descripcionInput = document.getElementById("descripcion");
            const errorDescripcion = document.getElementById("errorDescripcion");
            const descripcion = descripcionInput.value.trim();

            if (descripcion === "") {
                errorDescripcion.textContent = "La descripción es obligatoria.";
                return false;
            } else {
                errorDescripcion.textContent = "";
            }


            const costoInput = document.getElementById("costo");
            const sumaInput = document.getElementById("sumaAsegurada");
            const errorSuma = document.getElementById("errorSuma");

            const costo = parseFloat(costoInput.value);
            const suma = parseFloat(sumaInput.value);

            if (isNaN(costo) || isNaN(suma)) {
                errorSuma.textContent = "";
                return true; 
            }

            if (suma < costo) {
                errorSuma.textContent = "El costo máximo asegurado no puede ser menor que el costo de contratación.";
                return false;
            }

            errorSuma.textContent = "";
            return true;
        }


        document.getElementById("btnGuardarCostoMaximo").addEventListener("click", function() {
            const sumaInput = document.getElementById("sumaAsegurada");
            const mensajeSpan = document.getElementById("mensajeGuardado");
            const valor = sumaInput.value.trim();

            if (valor === "" || isNaN(parseFloat(valor))) {
                mensajeSpan.textContent = "Ingrese un valor válido.";
                mensajeSpan.style.color = "red";
                return;
            }

            localStorage.setItem("costoMaximoAsegurado", valor);

            mensajeSpan.textContent = "Costo máximo guardado correctamente.";
            mensajeSpan.style.color = "green";
            setTimeout(function() {
                mensajeSpan.textContent = "";
            }, 3000);
        });
    </script>

</body>
</html>