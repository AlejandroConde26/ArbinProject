
package View_Servlets.Message;

import Models.Controladora_System;
import Models.Message;
import Models.MessageStatus;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SvSendMessageHost", urlPatterns = {"/SvSendMessageHost"})
public class SvSendMessageHost extends HttpServlet {

    Controladora_System control = new Controladora_System();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Usuario no autenticado.");
            return;
        }

        String content = request.getParameter("content");
        String receptorIdStr = request.getParameter("idReceptor");

        if (content == null || content.trim().isEmpty() || receptorIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Contenido o receptor inválido.");
            return;
        }

        int receptorId;
        try {
            receptorId = Integer.parseInt(receptorIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de receptor inválido.");
            return;
        }

        User receptor = control.getUser(receptorId);
        if (receptor == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Usuario receptor no encontrado.");
            return;
        }

        Message mensaje = new Message();
        mensaje.setContent(content);
        mensaje.setStatus(MessageStatus.UNREAD);
        mensaje.setSender(currentUser);
        mensaje.setReceiver(receptor);

        try {
            control.crearMensaje(mensaje);
            // Redirigir al panel de chat del host
            response.sendRedirect("SvHostChatPanel?idReceptor=" + receptorId);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al enviar el mensaje.");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
