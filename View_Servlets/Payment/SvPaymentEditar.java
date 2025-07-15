package View_Servlets.Payment;

import Models.Controladora_System;
import Models.Payment;
import Models.PaymentMethod;
import Models.Reservation;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SvPaymentEditar", urlPatterns = {"/SvPaymentEditar"})
public class SvPaymentEditar extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Controladora_System consys = new Controladora_System();
            List<Payment> listapagos = consys.getPagos();
            List<PaymentMethod> listapagosmetodos = consys.getMetodosPago();
            List<Reservation> listareservaciones = consys.getReservas();

            request.setAttribute("listapagos", listapagos);
            request.setAttribute("listapagosmetodos", listapagosmetodos);
            request.setAttribute("listareservaciones", listareservaciones);
            request.getRequestDispatcher("indexAdminPayment.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error al cargar pagos: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Controladora_System consys = new Controladora_System();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            int id = Integer.parseInt(request.getParameter("paymentId"));
            float amount = Float.parseFloat(request.getParameter("amount"));
            String endDateStr = request.getParameter("endDate");
            String paymentDateStr = request.getParameter("paymentDate");
            String status = request.getParameter("paymentStatus");
            String paymentMethodIdStr = request.getParameter("paymentMethodId");

            // Obtener el objeto original
            Payment pago = consys.getPago(id);

            // Establecer valores editables
            pago.setAmount(amount);
            pago.setPaymentStatus(status);

            if (endDateStr != null && !endDateStr.isEmpty()) {
                pago.setEndDate(LocalDate.parse(endDateStr, formatter));
            }

            if (paymentDateStr != null && !paymentDateStr.isEmpty()) {
                pago.setPaymentDate(LocalDate.parse(paymentDateStr, formatter));
            }

            pago.setUpdatedDate(LocalDate.now());

            if (paymentMethodIdStr != null && !paymentMethodIdStr.isEmpty()) {
                int methodId = Integer.parseInt(paymentMethodIdStr);
                PaymentMethod metodo = consys.getMetodoPago(methodId);
                pago.setPaymentMethod(metodo);
            }

            // Solo si está implementado, opcional
            String reservationIdStr = request.getParameter("reservationId");
            if (reservationIdStr != null && !reservationIdStr.isEmpty()) {
                int reservaId = Integer.parseInt(reservationIdStr);
                Reservation reserva = consys.getReserva(reservaId);
                pago.setReservation(reserva);
            }

            // Editar pago
            consys.editarPago(pago);

                      response.sendRedirect("SvAdminPagos");


        } catch (Exception e) {
            e.printStackTrace();
            // Para evitar errores 404 si falta error.jsp, responde directamente con error 500
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al editar el pago: " + e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Edita un pago existente con valores actualizados.";
    }
}