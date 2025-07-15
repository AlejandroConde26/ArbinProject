/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package View_Servlets.Host;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Models.Controladora_System;
import Models.Housing;
import Models.HousingImage;
import Models.User;
import persistencia.exceptions.NonexistentEntityException;

/**
 *
 * @author Jofre
 */
@WebServlet(name = "SvDeleteImage", urlPatterns = {"/SvDeleteImage"})
public class SvDeleteImage extends HttpServlet {

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
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   
    Controladora_System control = new Controladora_System();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int imageId = Integer.parseInt(request.getParameter("housingImageId"));
            HousingImage img = control.getHousingImage(imageId);

            if (img != null) {
                int housingId = img.getHousingId().getHousingId(); // lo obtenemos ANTES de eliminar
                control.eliminarHousingImage(imageId); // eliminamos la imagen

                Housing updatedHousing = control.getHousing(housingId); // housing actualizado

                request.setAttribute("housing", updatedHousing); // lo mandamos al JSP
                request.getRequestDispatcher("indexHostingEditarFotos.jsp").forward(request, response); // redirige al mismo JSP
            } else {
                response.sendRedirect("indexHosting.jsp"); // en caso de error
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("indexHosting.jsp");
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


