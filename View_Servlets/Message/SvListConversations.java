
package View_Servlets.Message;

import Models.Controladora_System;
import Models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SvListConversations", urlPatterns = {"/SvListConversations"})
public class SvListConversations extends HttpServlet {

    Controladora_System control = new Controladora_System();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No autenticado.");
            return;
        }

        List<User> conversaciones = control.obtenerChatUser(currentUser);
        // Pasar la lista y una bandera para abrir el modal
        request.setAttribute("conversations", conversaciones);
        request.setAttribute("abrirModal", true);
        request.getRequestDispatcher("SvCargarHousings").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet que lista las conversaciones activas del usuario autenticado.";
    }
}
