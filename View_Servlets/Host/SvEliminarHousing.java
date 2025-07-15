/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */ 
package View_Servlets.Host;

import java.io.IOException;
import java.io.PrintWriter;
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


/**
 *
 * @author Alex
 */
@WebServlet(name = "SvEliminarHousing", urlPatterns = {"/SvEliminarHousing"})
public class SvEliminarHousing extends HttpServlet {

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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */    
    private static final long serialVersionUID = 1L;
    Controladora_System control = new Controladora_System(); 

  @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  
     int idHousing;

      HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
     try {
         idHousing = Integer.parseInt(request.getParameter("id"));
     } catch (NumberFormatException e) {
         Logger.getLogger(SvEliminarHousing.class.getName()).log(Level.SEVERE, "Parámetros inválidos", e);
         response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parámetros inválidos.");
         return;
     }

     Housing delHousing = control.getHousing(idHousing);

     if (delHousing == null) {
         Logger.getLogger(SvEliminarHousing.class.getName()).log(Level.WARNING, "No se encontró el housing con ID: " + idHousing);
         response.sendError(HttpServletResponse.SC_NOT_FOUND, "Housing no encontrado.");
         return;
     }

     try {
         control.eliminarHousing(idHousing);
     } catch (Exception ex) {
         Logger.getLogger(SvEliminarHousing.class.getName()).log(Level.SEVERE, "Error al eliminar housing", ex);
         response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "No se pudo eliminar el housing.");
         return;
     }
     
   List<Housing> listHousing = control.findHousingsByHostId(user.getHost_id().getId_Host());
            request.setAttribute("listHousing", listHousing);

            request.getRequestDispatcher("indexHosting.jsp").forward(request, response);
    
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
