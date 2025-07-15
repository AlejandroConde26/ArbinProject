package View_Servlets.Message;

import Models.Controladora_System;
import Models.User;
import persistencia.exceptions.NonexistentEntityException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "SvDeleteMessage", urlPatterns = {"/SvDeleteMessage"})
public class SvDeleteMessage extends HttpServlet {

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

        int messageId = Integer.parseInt(request.getParameter("messageId"));
        String idReceptor = request.getParameter("idReceptor"); 
        String housingId = request.getParameter("housingId");  

        try {
            control.eliminarMensaje(messageId);

            
            response.sendRedirect("SvViewConversation?idReceptor=" + idReceptor + "&housingId=" + housingId);
        } catch (NonexistentEntityException e) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Mensaje no encontrado.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al eliminar el mensaje.");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet que elimina físicamente un mensaje por ID.";
    }
}
