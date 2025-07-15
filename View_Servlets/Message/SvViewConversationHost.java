

package View_Servlets.Message;

import Models.Controladora_System;
import Models.Message;
import Models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SvViewConversationHost", urlPatterns = {"/SvViewConversationHost"})
public class SvViewConversationHost extends HttpServlet {

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

        int receptorId = Integer.parseInt(request.getParameter("idReceptor"));
        User receptor = control.getUser(receptorId);

        if (receptor == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Usuario receptor no encontrado.");
            return;
        }

        List<Message> conversation = control.getConversacion(currentUser, receptor);

        control.marcarComoLeido(currentUser, receptor);
        request.setAttribute("conversation", conversation);
        request.setAttribute("receptor", receptor);

        request.getRequestDispatcher("SvHostChatPanel").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet que muestra la conversación entre dos usuarios.";
    }
}
