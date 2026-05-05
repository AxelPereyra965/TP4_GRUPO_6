package servlets;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.TipoSeguroDAO;
import dominio.TipoSeguro;


public class AgregarSeguroServlet extends HttpServlet 
{
    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        System.out.println(">>> Entré al AgregarSeguroServlet");
        
        TipoSeguroDAO dao = new TipoSeguroDAO();
        ArrayList<TipoSeguro> listaTipos = dao.traerTodos();
        request.setAttribute("listaTipos", listaTipos);
        request.getRequestDispatcher("AgregarSeguro.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        
        String costoStr = request.getParameter("txtCosto");
        double costoContratacion = 0.0;
        
        try {
            
            if (costoStr != null && !costoStr.isEmpty()) {
                costoContratacion = Double.parseDouble(costoStr);
            }

        } catch (NumberFormatException e) {
            
            System.out.println("Error: El valor recibido no es un número válido.");
        }
    }
}