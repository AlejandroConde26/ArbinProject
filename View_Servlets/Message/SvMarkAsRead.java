
package View_Servlets.Message;

import Models.Controladora_System;
import Models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "SvMarkAsRead", urlPatterns = {"/SvMarkAsRead"})
public class SvMarkAsRead extends HttpServlet {

    Controladora_System control = new Controladora_System();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No autenticado.");
            return;
        }

        int senderId = Integer.parseInt(request.getParameter("senderId"));
        User sender = control.encontrarUser(senderId); // Necesitas agregar este método si no lo tienes

        if (sender == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Usuario emisor no encontrado.");
            return;
        }

        try {
            control.marcarComoLeido(currentUser, sender);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al marcar mensajes como leídos.");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para marcar como leídos todos los mensajes de un usuario emisor.";
    }
}
