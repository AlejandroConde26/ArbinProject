

package View_Servlets.Message;

import Models.Controladora_System;
import Models.Message;
import Models.MessageStatus;
import Models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "SvSendMessage", urlPatterns = {"/SvSendMessage"})
public class SvSendMessage extends HttpServlet {

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
        String housingId = request.getParameter("housingId");

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

        // Crear y guardar el mensaje
        Message mensaje = new Message();
        mensaje.setContent(content);
        mensaje.setStatus(MessageStatus.UNREAD);
        mensaje.setSender(currentUser);
        mensaje.setReceiver(receptor);

        try {
            control.crearMensaje(mensaje);
            System.out.println("✅ Mensaje enviado correctamente.");
            response.sendRedirect("SvViewConversation?idReceptor=" + receptorId + "&housingId=" + housingId);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al enviar el mensaje.");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet que permite enviar un mensaje entre usuarios.";
    }
}

