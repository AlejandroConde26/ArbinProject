/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package View_Servlets.Admin;

import Controllers.PaymentJpaController;
import Controllers.PaymentMethodJpaController;
import Controllers.ReservationJpaController;
import Models.Payment;
import Models.PaymentMethod;
import Models.Reservation;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Desktop
 */
@WebServlet(name = "SvAdminPagos", urlPatterns = {"/SvAdminPagos"})
public class SvAdminPagos extends HttpServlet {

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

        HttpSession misession = request.getSession();
        User sessionUser = (User) misession.getAttribute("user");
        if (sessionUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        PaymentJpaController paymentController = new PaymentJpaController();
        PaymentMethodJpaController methodController = new PaymentMethodJpaController();
        ReservationJpaController reservationController = new ReservationJpaController();

        List<Payment> payments = paymentController.findPaymentEntities();
        List<PaymentMethod> paymentMethods = methodController.findPaymentMethodEntities();
        List<Reservation> reservations = reservationController.findReservationEntities();

      
        request.setAttribute("listapagos", payments);
        request.setAttribute("listapagosmetodos", paymentMethods);
        request.setAttribute("listareservaciones", reservations);


        request.getRequestDispatcher("indexAdminPayment.jsp").forward(request, response);
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
        processRequest(request, response);
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
