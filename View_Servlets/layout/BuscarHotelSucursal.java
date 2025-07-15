package View_Servlets.layout;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import Models.Controladora_System;
import Models.Housing;
import Models.Reservation;
import Models.User;

@WebServlet(name = "BuscarHotelSucursal", urlPatterns = {"/BuscarHotelSucursal"})
public class BuscarHotelSucursal extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final Controladora_System control = new Controladora_System();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ciudad = request.getParameter("ciudad");
        String llegadaStr = request.getParameter("llegada");
        String salidaStr = request.getParameter("salida");
        String personasStr = request.getParameter("personas");

        LocalDate llegada = null;
        LocalDate salida = null;
        int personas = 0;

        // Validación de fechas
        try {
            if (llegadaStr != null && !llegadaStr.isBlank()) {
                llegada = LocalDate.parse(llegadaStr);
            }
            if (salidaStr != null && !salidaStr.isBlank()) {
                salida = LocalDate.parse(salidaStr);
            }
        } catch (DateTimeParseException e) {
            request.setAttribute("mensaje", "Formato de fecha inválido.");
            redireccionarSegunUsuario(request, response);
            return;
        }

        // Validación de personas
        try {
            if (personasStr != null && !personasStr.isEmpty()) {
                personas = Integer.parseInt(personasStr);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("mensaje", "Cantidad de personas inválida.");
            redireccionarSegunUsuario(request, response);
            return;
        }

        List<Housing> listaFiltrada = control.getHousings();

        // Filtrar por ciudad
        if (ciudad != null && !ciudad.trim().isEmpty()) {
            listaFiltrada = listaFiltrada.stream()
                .filter(h -> h.getCity() != null &&
                             h.getCity().toLowerCase().contains(ciudad.toLowerCase()))
                .collect(Collectors.toList());
        }

     
        // Filtrar por disponibilidad en fechas
        if (llegada != null && salida != null) {
            if (!llegada.isBefore(salida)) {
                request.setAttribute("mensaje", "La fecha de llegada debe ser anterior a la fecha de salida.");
                redireccionarSegunUsuario(request, response);
                return;
            }

            final LocalDate finalLlegada = llegada;
            final LocalDate finalSalida = salida;

            listaFiltrada = listaFiltrada.stream()
                .filter(h -> {
                    List<Reservation> reservas = h.getReservations();
                    if (reservas == null || reservas.isEmpty()) return true;

                    return reservas.stream().noneMatch(res -> {
                        LocalDate checkIn = res.getStartDate();
                        LocalDate checkOut = res.getEndDate();

                        if (checkIn == null || checkOut == null) return false;

                        // No hay solapamiento si salida es antes de checkIn o llegada es después de checkOut
                        return !(finalSalida.isBefore(checkIn) || finalLlegada.isAfter(checkOut));
                    });
                })
                .collect(Collectors.toList());
        }

        if (listaFiltrada.isEmpty()) {
            request.setAttribute("mensaje", "No se encontraron hoteles con los filtros seleccionados.");
        }

        request.setAttribute("listahabitaciones", listaFiltrada);
        redireccionarSegunUsuario(request, response);
    }

    private void redireccionarSegunUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User usuario = (User) session.getAttribute("user");

        if (usuario == null) {
            request.getRequestDispatcher("indexInvitado.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("indexUser.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Reutiliza la lógica del GET
    }

    @Override
    public String getServletInfo() {
        return "Filtra hoteles por ciudad, capacidad y fechas.";
    }
}