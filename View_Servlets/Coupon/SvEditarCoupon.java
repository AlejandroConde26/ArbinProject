/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package View_Servlets.Coupon;

import Controllers.DB;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.TimeZone;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Alex
 */
@WebServlet(name = "SvEditarCoupon", urlPatterns = {"/SvEditarCoupon"})
public class SvEditarCoupon extends HttpServlet {

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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       try (Connection con = DB.getConnection()) {
            CallableStatement stmt = con.prepareCall("{CALL sp_editar_coupon(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
            stmt.setInt(1, Integer.parseInt(request.getParameter("id")));
            stmt.setString(2, request.getParameter("code"));
            stmt.setString(3, request.getParameter("description"));
            stmt.setString(4, request.getParameter("discount_type"));
            stmt.setBigDecimal(5, new BigDecimal(request.getParameter("discount_value")));
            stmt.setInt(6, Integer.parseInt(request.getParameter("min_stay_nights")));
        
LocalDate validFrom = LocalDate.parse(request.getParameter("valid_from")).plusDays(1);
LocalDate validUntil = LocalDate.parse(request.getParameter("valid_until")).plusDays(1);

stmt.setDate(7, Date.valueOf(validFrom));
stmt.setDate(8, Date.valueOf(validUntil));
            
            stmt.setInt(9, Integer.parseInt(request.getParameter("usage_limit_per_coupon")));
            stmt.setInt(10, Integer.parseInt(request.getParameter("usage_limit_per_user")));
            
            String activeParam = request.getParameter("active");
            boolean isActive = activeParam != null && (activeParam.equals("true") || activeParam.equals("1"));
            stmt.setInt(11, isActive ? 1 : 0); // aquí va como TINYINT(1)
            
            stmt.execute();
            response.sendRedirect("SvCoupon");
        } catch (Exception e) {
            response.sendError(500, e.getMessage());
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
