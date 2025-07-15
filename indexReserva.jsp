<%-- 
    Document   : indexReserva
    Created on : 30 abr 2025
    Author     : Alex
--%>

<%@page import="Models.Housing"%>
<%@page import="Models.Reservation"%>
<%@page import="Models.Controladora_System"%>
<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Solicita Reservar</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="module" src="js/indexReserva.js"></script>
    <link rel="stylesheet" href="css/indexReserva.css">
</head>
<body class="p-4">
  <%
            HttpSession misession = request.getSession();
            User sessionUser =  (User)session.getAttribute("user");
            if(sessionUser==null){
            response.sendRedirect("login.jsp");
            }
        
    Reservation reserva = (Reservation) session.getAttribute("reservation");
    Housing housing = (Housing) session.getAttribute("housing");
  

    if (reserva == null || housing == null || sessionUser == null) {
%>
    <div class="container mt-5">
        <div class="alert alert-danger">Error: No se encontró información de la reserva.</div>
    </div>
<%
    } else {
        long dias = java.time.temporal.ChronoUnit.DAYS.between(reserva.getStartDate(), reserva.getEndDate());
        if (dias <= 0) dias = 1;
        float precioTotal = housing.getPriceNight()* dias;
%>

<div class="container main-container">
    <h3 class="fw-bold mb-4">Solicita reservar</h3>

    <form action="SvReservaDetalle" method="post">
        <input type="hidden" name="housingId" value="<%= housing.getHousingId() %>">

        <div class="row">
            <!-- Columna izquierda -->
            <div class="col-md-6">
                <div class="mb-4">
                    <p class="section-title mb-1">Tu viaje</p>
                    <div class="d-flex justify-content-between align-items-start position-relative">
                        <div>
                            <label class="fw-bold">Fechas</label>
                            <div class="text-muted mb-2">Selecciona el rango de fechas</div>
                            <input type="date" name="startDate" class="form-control mb-2" value="<%= reserva.getStartDate() %>" required>
                            <input type="date" name="endDate" class="form-control" value="<%= reserva.getEndDate() %>" required>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between align-items-start mt-3">
                        <div>
                            <label class="fw-bold">Huéspedes</label>
                            <div class="text-muted mb-2">Cantidad de adultos</div>
                            <input type="number" name="numberOfAdults" class="form-control" min="1" value="<%= reserva.getNumberOfAdults() %>" required>
                            <div class="text-muted mb-2">Cantidad de niños</div>
                            <input type="number" name="numberOfChildren" class="form-control" min="0" value="<%= reserva.getNumberOfChildren()%>" required>
                        </div>
                    </div>
                </div>
                      <!-- Datos de tarjeta -->
                <hr>
                <h5 class="fw-bold mb-2">Paga con</h5>
                <div class="border p-3 rounded bg-light">
                    <div class="mb-3">
                        <input type="text" name="cardNumber" class="form-control" placeholder="Número de tarjeta" required>
                    </div>
                    <div class="row mb-3">
                        <div class="col">
                            <input type="text" name="expiry" class="form-control" placeholder="Caducidad (MM/AA)" required>
                        </div>
                        <div class="col">
                            <input type="text" name="cvv" class="form-control" placeholder="Código CVV" required>
                        </div>
                    </div>
                    <h6 class="fw-bold">Dirección de facturación</h6>
                    <input type="text" name="billingAddress" class="form-control mb-2" placeholder="Dirección" required>
                    <input type="text" name="billingApartment" class="form-control mb-2" placeholder="Nro. apartamento o suite">
                    <input type="text" name="billingCity" class="form-control mb-2" placeholder="Ciudad" required>
                    <div class="row">
                        <div class="col">
                            <input type="text" name="billingState" class="form-control mb-2" placeholder="Departamento" required>
                        </div>
                        <div class="col">
                            <input type="text" name="billingZip" class="form-control mb-2" placeholder="Código postal" required>
                        </div>
                    </div>
                    <select name="billingCountry" class="form-select" required>
                        <option value="Perú" selected>Perú</option>
                        <option value="Chile">Chile</option>
                        <option value="Argentina">Argentina</option>
                        <option value="México">México</option>
                    </select>
                </div>

                <hr>
                <br><br>
                <div class="mb-4">
                    <h5 class="fw-bold mb-3">Requerido para tu viaje</h5>

                    <div class="mb-3">
                        <label class="fw-semibold">Mensaje para el anfitrión</label>
                        <textarea name="mensajeAnfitrion" class="form-control" rows="3" placeholder="¿Por qué eliges este alojamiento?"></textarea>
                    </div>

                    <div>
                        <label class="fw-semibold">Número de teléfono</label>
                        <input type="text" name="telefono" class="form-control" placeholder="Ej: +51 987654321">
                    </div>
                </div>

                <hr>

                <div class="mb-4">
                    <h5 class="fw-bold mb-2">Política de cancelación</h5>
                    <p class="text-muted small mb-0">
                        Esta reservación no es reembolsable. <a href="#" class="fw-semibold">Más información</a>
                    </p>
                </div>

                <hr>

                <div class="mb-4">
                    <h5 class="fw-bold mb-2">Reglas fundamentales</h5>
                    <ul class="text-muted small ps-3 mb-0">
                        <li>Sigue las reglas de la casa</li>
                        <li>Trata el alojamiento como si fuera tuyo</li>
                    </ul>
                </div>

                <hr>

                <div class="d-flex align-items-start gap-3 mb-4">
                    <div>
                        <svg xmlns="http://www.w3.org/2000/svg" class="text-danger" width="24" height="24" fill="currentColor" viewBox="0 0 16 16">
                            <path d="M8 1.5a6.5 6.5 0 1 0 0 13A6.5 6.5 0 0 0 8 1.5zM7.25 4a.75.75 0 0 1 1.5 0v3.25a.75.75 0 0 1-1.5 0V4zM8 11a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
                        </svg>
                    </div>
                    <div>
                        <p class="fw-semibold text-danger mb-1" style="font-size: 14px;">
                            No confirmaremos tu reservación hasta que el anfitrión acepte la solicitud (en un plazo de 24 horas).
                        </p>
                        <p class="text-muted small mb-0">No te haremos ningún cargo hasta entonces.</p>
                    </div>
                </div>

                <hr>

                <p class="text-muted small mb-4">
                    Al seleccionar el botón que aparece a continuación, aceptas nuestras políticas y términos. Daremos seguimiento según lo indicado.
                </p>

                <button type="submit" class="btn btn-danger w-auto rounded-pill px-4 py-2 fw-semibold" style="font-size: 16px;">
                    Solicita reservar
                </button>
            </div>

            <!-- Columna derecha -->
            <div class="col-md-6 d-flex justify-content-center">
                <div class="card-reserva border rounded-3 p-3 shadow-sm">
                    <div class="d-flex align-items-center mb-3">
                        <img src="<%= housing.getHousingImages().get(0).getImageUrl() %>" class="rounded-3 me-3 img-fluid imagen-cabana" alt="<%= housing.getHousingImages().get(0).getCaption() %>" width="120">
                        <div>
                            <strong><%= housing.getCommercialName() %></strong><br>
                            <span class="text-muted">Alojamiento entero: cabaña</span><br>
                            ⭐ <%= housing.getStars() %> (46 reseñas) • <span class="text-muted">Superanfitrión</span>
                        </div>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between">
                        <div>S/ <%= housing.getPriceNight()%> x <%= dias %> noches</div>
                        <div>S/ <%= precioTotal %></div>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between fw-bold">
                        <div>Total (PEN)</div>
                        <div>S/ <%= precioTotal %></div>
                    </div>
                    <div class="mt-2">
                        <a href="#" class="text-decoration-underline">Desglose del precio</a>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<%
    }
%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</body>
</html>
