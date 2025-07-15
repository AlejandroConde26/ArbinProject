
package View_Servlets.Message;

import Models.Controladora_System;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import persistencia.exceptions.NonexistentEntityException;

@WebServlet(name = "SvEliminarMensajeHost", urlPatterns = {"/SvEliminarMensajeHost"})
public class SvEliminarMensajeHost extends HttpServlet {

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

        try {
            int messageId = Integer.parseInt(request.getParameter("messageId"));
            int idReceptor = Integer.parseInt(request.getParameter("idReceptor"));

            control.eliminarMensaje(messageId);

            // Redirigir nuevamente a la conversación con el receptor
            response.sendRedirect("SvViewConversationHost?idReceptor=" + idReceptor);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parámetros inválidos.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al eliminar el mensaje.");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
