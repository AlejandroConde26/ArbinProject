/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package View_Servlets.Host;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Models.Controladora_System;
import Models.Host;
import Models.Housing;
import Models.User;
import persistencia.exceptions.PreexistingEntityException;

/**
 *
 * @author Alex
 */
@WebServlet(name = "SvHost", urlPatterns = {"/SvHost"})
public class SvHost extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
 Controladora_System control = new Controladora_System();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
     
        
        // Verifica si el usuario ya es host
        Host hostExistente = control.buscarHostPorIdUser(user.getId_users());
        if (hostExistente != null) {
            List<Housing> listHousing = control.findHousingsByHostId(user.getHost_id().getId_Host());
            request.setAttribute("listHousing", listHousing);
            request.getRequestDispatcher("indexHosting.jsp").forward(request, response);

        } else {
            // No es host aún, mostrar formulario para convertirse en host
            response.sendRedirect("convertirHost.jsp"); // crea esta página con botón y términos
        }
    }
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Aquí puedes validar que aceptó los términos
        String aceptoTerminos = request.getParameter("aceptoTerminos");

        if ("on".equals(aceptoTerminos)) {
            // Crear el nuevo Host
            Host nuevoHost = new Host();
            nuevoHost.setId_user(user);

            try {
                control.crearHost(nuevoHost);
                response.sendRedirect("indexHosting.jsp");
            } catch (PreexistingEntityException ex) {
                Logger.getLogger(SvHost.class.getName()).log(Level.SEVERE, null, ex);
                response.sendRedirect("error.jsp"); // opcional
            }
        } else {
            // No aceptó términos, redirigir con error
            response.sendRedirect("convertirHost.jsp?error=debesAceptar");
        }
    }
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
