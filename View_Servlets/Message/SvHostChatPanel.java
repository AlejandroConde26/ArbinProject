
package View_Servlets.Message;
import Models.Controladora_System;
import Models.Message;
import Models.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SvHostChatPanel", urlPatterns = {"/SvHostChatPanel"})
public class SvHostChatPanel extends HttpServlet {

    Controladora_System control = new Controladora_System();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Usuario no autenticado.");
            return;
        }

        // Paso 1: obtener lista de usuarios con los que ha conversado
        List<User> usuariosConConversacion = control.obtenerChatUser(currentUser);
        request.setAttribute("usuariosConConversacion", usuariosConConversacion);

        // Paso 2 (opcional): si se selecciona un receptor, cargar la conversación
        String idReceptorStr = request.getParameter("idReceptor");
        if (idReceptorStr != null && !idReceptorStr.isEmpty()) {
            try {
                int receptorId = Integer.parseInt(idReceptorStr);
                User receptor = control.getUser(receptorId);

                if (receptor != null) {
                    List<Message> conversation = control.getConversacion(currentUser, receptor);
                    control.marcarComoLeido(currentUser, receptor);

                    request.setAttribute("receptor", receptor);
                    request.setAttribute("conversation", conversation);
                }
            } catch (NumberFormatException e) {
                System.out.println("Error al parsear idReceptor: " + e.getMessage());
                // no se hace nada, solo se omite la conversación
            }
        }

        // Redirigir al nuevo JSP exclusivo del host
        request.getRequestDispatcher("hostChatPanel.jsp").forward(request, response);
    }

}

