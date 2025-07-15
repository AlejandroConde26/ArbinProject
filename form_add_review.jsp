<%-- 
    Document   : form_add_review
    Created on : 25 may. 2025, 7:51:02 p. m.
    Author     : Desktop
--%>

<%@page import="Models.ReviewHousing"%>
<%@page import="Models.Controladora_System"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.Reservation"%>
<%@page import="Models.Housing"%>
<%
    int idReserva = Integer.parseInt(request.getParameter("reservationId"));
    Controladora_System control = new Controladora_System();
    Reservation reserva = control.getReserva(idReserva);
    Housing housing = (reserva != null) ? reserva.getHousingId() : null;
    ReviewHousing review = (reserva != null) ? reserva.getReviewHousing(): null;
%>

<% if (housing != null) { %>
    <h2>Añadir Reseña para la Reserva en <%= housing.getCity() %></h2>
<% } else { %>
    <p>Error: no se pudo obtener el alojamiento.</p>
<% } %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Añadir Reseña</title>
    <link rel="stylesheet" href="css/review.css">

</head>
<body>
<%
    if (reserva != null && housing != null) {
%>
    <form action="SvGuardarReviewFinal" method="post">
    <input type="hidden" name="reservationId" value="<%= reserva.getReservationId()%>">

    <div class="mb-3">
        <label for="description" class="form-label">Descripción</label>
        <textarea class="form-control" name="description" required></textarea>
    </div>

    <div class="mb-3">
        <label for="stadia_des" class="form-label">Detalles de la estadía</label>
        <input type="text" class="form-control" name="stadia_des" required />
    </div>

    <div class="mb-3">
        <label for="score" class="form-label">Puntaje (1 a 5)</label>
        <input type="number" class="form-control" name="score" min="1" max="5" required />
    </div>

    <button type="submit" class="btn btn-primary">Guardar Reseña</button>
    </form>
    <% if (review != null) { %>
    <form action="SvEliminarReview" method="post">
        <input type="hidden" name="idReview" value="<%= review.getId_reviewHousing()%>" />
        <button type="submit">Eliminar Reseña</button>
    </form>
    <% } %>
<%
    } else {
%>
    <h3>Error: No se encontró la reserva o el alojamiento.</h3>
<%
    }
%>
</body>
</html>


