/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package View_Servlets.Admin;

import Models.Controladora_System;
import Models.Services;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Alex
 */
@WebServlet(name = "SvAdminCreateService", urlPatterns = {"/SvAdminCreateService"})
public class SvAdminCreateService extends HttpServlet {

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
    
    Controladora_System controlLogica = new Controladora_System();
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
     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Ensure proper character encoding

        String serviceName = request.getParameter("name");
        String description = request.getParameter("description");
        // For boolean, checkbox value is "on" if checked, or null if not.
        // Or, if value attribute is set, it's that value.
    boolean status = Boolean.parseBoolean(request.getParameter("status"));

        if (serviceName == null || serviceName.trim().isEmpty() ||
            description == null || description.trim().isEmpty()) {
            // Handle missing fields, perhaps by redirecting back to the form with an error message
            request.setAttribute("errorMessage", "Service name and description are required.");
         
            return;
        }
        
        Services newService = new Services();
        newService.setName_service(serviceName);
        newService.setDescription(description);
        newService.setStatus(status);
      

        try {
            controlLogica.crearServicio(newService);
            response.sendRedirect("SvAdminServices"); 

        } catch (Exception e) {
            Logger.getLogger(SvAdminCreateService.class.getName()).log(Level.SEVERE, "Error creating service", e);
            // Set an error message and forward back to the creation form or an error page
            request.setAttribute("errorMessage", "Failed to create service: " + e.getMessage());
            // Ensure createService.jsp can display this error message
            request.getRequestDispatcher("adminPages/services/createService.jsp").forward(request, response);
            // Or redirect to a generic error page:
            // response.sendRedirect("errorPage.jsp?message=" + URLEncoder.encode(e.getMessage(), "UTF-8"));
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
