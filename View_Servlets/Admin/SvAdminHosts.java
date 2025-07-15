package View_Servlets.Admin;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Models.Address;
import Models.Controladora_System;
import Models.Document_type;
import Models.Host;
import Models.Housing;
import Models.HousingCategory;
import Models.Roles;
import Models.User;

@WebServlet(name = "SvAdminHosts", urlPatterns = {"/SvAdminHosts"})
public class SvAdminHosts extends HttpServlet {

    Controladora_System control = new Controladora_System();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        
        List<User> listausuarios = control.getUsers();
        List<Housing> listahoteles = control.getHousings();
        List<HousingCategory> listacategorias = control.getHousingCategories();
        List<Document_type> listatiposdocumento = control.getTiposDocumento();
        List<Address> listadirecciones = control.getAddress();
        List<Roles> listaroles = control.getRoles();
        List<Host> listahosts = control.getHosts();
        
        request.setAttribute("listatiposdocumento", listatiposdocumento);
        request.setAttribute("listadirecciones", listadirecciones);
        request.setAttribute("listaroles", listaroles);
        request.setAttribute("listausuarios", listausuarios);
        request.setAttribute("listhousings", listahoteles);
        request.setAttribute("listacategorias", listacategorias);      
        request.setAttribute("listahosts", listahosts);


        request.getRequestDispatcher("indexAdminHosts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Muestra todos los usuarios en la vista del admin.";
    }
}
