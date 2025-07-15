/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package View_Servlets.Admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Models.Controladora_System;
import Models.Housing;

/**
 *
 * @author Alex
 */
@WebServlet(name = "SvAdminEditarHousing", urlPatterns = {"/SvAdminEditarHousing"})
public class SvAdminEditarHousing extends HttpServlet {

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

        int id = Integer.parseInt(request.getParameter("housingId"));
        String nombre = request.getParameter("commercialName");
        String direccion = request.getParameter("address");
        String ciudad = request.getParameter("city");
        String pais = request.getParameter("country");
        int habitaciones = Integer.parseInt(request.getParameter("numHabitaciones"));
        int estrellas = Integer.parseInt(request.getParameter("stars"));
        float precio = Float.parseFloat(request.getParameter("priceNight"));
        String estado = request.getParameter("status");

     
        Housing housing = control.getHousing(id);

        if (housing != null) {
            housing.setCommercialName(nombre);
            housing.setAddress(direccion);
            housing.setCity(ciudad);
            housing.setCountry(pais);
            housing.setNumHabitaciones(habitaciones);
            housing.setStars(estrellas);
            housing.setPriceNight(precio);
            housing.setStatus(estado);

            try {
                control.editarHousing(housing);
            } catch (Exception ex) {
                Logger.getLogger(SvAdminEditarHousing.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else{
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "No se encontró la vivienda con el ID proporcionado.");

        }

        // Redirigir a la lista para que veas los cambios
        response.sendRedirect("SvAdminHousings");
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
