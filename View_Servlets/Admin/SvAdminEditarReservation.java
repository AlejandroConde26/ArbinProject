/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package View_Servlets.Admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Models.Controladora_System;
import Models.Reservation;
import Models.ReservationStatus;

/**
 *
 * @author Alex
 */
@WebServlet(name = "SvAdminEditarReservation", urlPatterns = {"/SvAdminEditarReservation"})
public class SvAdminEditarReservation extends HttpServlet {

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
            Controladora_System control = new Controladora_System();

    @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        int reservationId = Integer.parseInt(request.getParameter("reservationId"));
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        float totalPrice = Float.parseFloat(request.getParameter("totalPrice"));
        int statusId = Integer.parseInt(request.getParameter("statusId"));

        try {
          
            Reservation reservation =control.getReserva(reservationId);

            if (reservation != null) {
                reservation.setStartDate(LocalDate.parse(startDate));
                reservation.setEndDate(LocalDate.parse(endDate));
                reservation.setTotalPrice(totalPrice);

                ReservationStatus status = new ReservationStatus();
                status.setReservationStatusId(statusId);
                reservation.setReservationStatusId(status);

                control.editarReserva(reservation);
            }

            response.sendRedirect("SvAdminReservations"); // Recarga la lista
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
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
