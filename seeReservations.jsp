<%-- 
    Document   : seeReservations
    Created on : 1 may 2025, 04:35:00
    Author     : Alex
--%>

<%@page import="Models.Reservation"%>
<%@page import="Models.User"%>
<%@page import="Models.Housing"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>    
<%@ page import="java.util.List" %>
<%@ page import="Models.Reservation" %>
<%@ page import="Models.Housing" %>
<!DOCTYPE html>        

<!DOCTYPE html>
<html lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Socio</title>
    <link rel="stylesheet" href="css/seeReservation.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous" />
<link rel="stylesheet" href="css/indexUser.css?v=<%= System.currentTimeMillis() %>"/>
     <link rel="stylesheet" href="css/seeReservation.css?v=<%= System.currentTimeMillis() %>"/>

      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 
</head>

<body>

    <%

        HttpSession misession = request.getSession();
            User sessionUser =  (User)session.getAttribute("user");
            if(sessionUser==null){
            response.sendRedirect("login.jsp");
            }
    %>

<!-- NAVBAR -->

  <nav class="navbar navbar-expand-lg bg-white">
    <div class="container-fluid">
      <a class="navbar-brand" href="SvCargarHousings">
            <img src="images/logo.png"/>
      </a>
        <form action="BuscarHotelSucursal" method="get">
            <div class="search-bar d-flex align-items-center bg-white rounded-pill px-4 py-2 gap-4">
            
            <!-- CAMPO CIUDAD -->
            <div class="flex-grow-1 border-end pe-3">
                <small class="fw-bold text-muted d-block">Dónde</small>
                <input type="text" name="ciudad" class="form-control border-0 p-0" placeholder="Explora destinos" value="<%= request.getParameter("ciudad") != null ? request.getParameter("ciudad") : "" %>">
            </div>

            <!-- Llegada (solo visual, opcional funcionalidad futura) -->
            <div class="flex-grow-1 border-end pe-3">
                <small class="fw-bold text-muted d-block">Llegada</small>
                <input type="date" name="llegada" class="form-control border-0 p-0 text-secondary" value="<%= request.getParameter("llegada") != null ? request.getParameter("llegada") : "" %>">
            </div>

            <!-- Salida (solo visual, opcional funcionalidad futura) -->
            <div class="flex-grow-1 border-end pe-3">
                <small class="fw-bold text-muted d-block">Salida</small>
                <input type="date" name="salida" class="form-control border-0 p-0 text-secondary" value="<%= request.getParameter("salida") != null ? request.getParameter("salida") : "" %>">
            </div>

            <!-- Cuántos (solo visual, opcional funcionalidad futura) -->
            <div class="flex-grow-1">
                <small class="fw-bold text-muted d-block">Quién</small>
                <input type="number" name="personas" class="form-control border-0 p-0 text-secondary" placeholder="¿Cuántos?" min="1" value="<%= request.getParameter("personas") != null ? request.getParameter("personas") : "" %>">
            </div>

            <!-- BOTÓN DE ENVÍO -->
            <button type="submit" class="btn btn-Dark rounded-circle d-flex align-items-center justify-content-center">
                <i class="bi bi-search"></i>
            </button>
            </div>
        </form>   
        <div class="options-nav">
            <%
                if (sessionUser.getHost_id()!= null) {
            %>
            <button class="btn-custom me-3" onclick="window.location.href='SvHost'">Modo Anfitrión</button>
            <%
            }   else {
            %>
            <button class="btn-custom me-3" onclick="window.location.href='SvHost'">Pon tu espacio en aquí</button>
            <%
                }
            %>
            <%
                String profileImg = sessionUser.getUrl_img_perfile();
            %>
            <button class="user-profile">
              <% if (profileImg != null && !profileImg.isEmpty()) { %>
                  <img src="<%= profileImg %>" alt="Perfil" class="navbar-profile-img"/>
              <% } else { %>
                  <%= sessionUser.getEmail().substring(0, 1).toUpperCase() %>
              <% } %>
            </button>
            <div class="dropdown">
                <button class="btn btn-outline-secondary d-flex align-items-center justify-content-center rounded-pill d-flex align-items-center" type="button" data-bs-toggle="dropdown">
                    <i class="bi bi-list"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="SvRegistroReservaciones">Viajes</a></li>
                     <li><a class="dropdown-item" href="SvInfoCuenta">Mi Cuenta</a></li>
                    <li><a class="dropdown-item" href="#">Favoritos</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="SvCerrarSesion">Cerrar sesión</a></li>
                </ul>
            </div>
        </div>
  </nav>
    
    <!-- titulo de bienvenida -->
    <div class="title-bnv text-center m-5">
        <h2><b>VIAJES</b></h2>
    </div>
    <div class="sub-title-bnv text-center">
        <p>Próximas reservas</p>
    </div>
    <!--Fotos-->

<%
    List<Reservation> reservas = (List<Reservation>) request.getAttribute("listaReservaciones");
    if (reservas != null && !reservas.isEmpty()) {
%>
<div class="container mt-4 d-flex align-items-center justify-content-center">
    <div class="row g-4" style="margin: 4vh;">
<%
        for (Reservation r : reservas) {
            Housing h = r.getHousingId();
%>
        <div class="col-md-6">
    <div class="card-reservation d-flex gap-4 position-relative">
        <div class="left">
            <h5><%= h.getCity() %></h5>
            <small>
                <%= h.getId_housingcategory().getCategoryName() %> en: <%= h.getAddress() %>, anfitrión: <%= h.getHostId().getId_user().getFull_name() %>
            </small>
            <div class="date-range">
                <%= r.getStartDate() %> – <%= r.getEndDate() %>
            </div>
            <div class="mt-3">
                <form action="form_add_review.jsp" method="get">
                    <input type="hidden" name="reservationId" value="<%= r.getReservationId()%>">
                    <button type="submit" class="btn btn-outline-primary btn-sm">
                        Añadir reseña
                    </button>
                </form>
            </div>
        </div>
        <div class="right position-relative">
            <img src="<%= h.getHousingImages().isEmpty() ? "images/default.jpg" : h.getHousingImages().get(0).getImageUrl() %>"
                alt="Imagen vivienda" />
            <div class="badge-status">Reservado</div>
        </div>
    </div>
</div>
<%
        }
%>
    </div>
</div>
<%
    } else {
%>
<div class="text-center mt-5">
    <h4>No tienes reservaciones aún.</h4>
</div>
<%
    }
%>


    <!--Segundo apartado-->
    <div class="sub-title-bnv text-center">
        <p>Donde has estado</p>
    </div>
    <!--apartado de ultima reserva-->
    <div class="card mb-3" style="max-width: 540px; margin-left:98px">
        <div class="row g-0">
            <div class="col-md-4">
                <img src="images/turkeldesign-tetonmountainhome-01.jpg" class="img-fluid rounded-start" alt="foto">
            </div>
            <div class="col-md-8">
                <div class="card-body">
                    <h5 class="card-title">El Salvador</h5>
                    <p class="card-text">Anfitrión: Erick Gonzales</p>
                    <p class="card-text"><small class="text-body-secondary">20/03/2005 - 30/03/2005</small></p>
                </div>
            </div>
        </div>
    </div>

    <!--Pie de página-->
    <footer class="bg-light text-dark pt-5 pb-4 mt-5">
        <h5 style="margin-left: 100px; font-size: 12px;">¿No encuentras tu reserva aquí? <a href="#">Visita el centro de
                ayuda</a></h5>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq"
        crossorigin="anonymous"></script>
</body>
<footer class="footer bg-black text-light h-100 position-relative overflow-hidden p-5">
  <div class="footer-content">
    <div class="column">
      <p>Asistencia</p>
      <ul>
        <li><a href="" class="text-white-50">Centro de ayuda</a></li>
        <li><a href="" class="text-white-50">AirCover</a></li>
        <li><a href="" class="text-white-50">Antidiscriminación</a></li>
        <li><a href="" class="text-white-50">Apoyo para discapacitados</a></li>
        <li><a href="" class="text-white-50">Opciones de cancelación</a></li>
        <li><a href="" class="text-white-50">Problemas en el vecindario</a></li>
      </ul>
    </div>
    <div class="column">
      <p>Modo anfitrión</p>
      <ul>
        <li><a href="" class="text-white-50">Pon tu espacio en Airbnb</a></li>
        <li><a href="" class="text-white-50">AirCover para anfitriones</a></li>
        <li><a href="" class="text-white-50">Recursos para anfitrionar</a></li>
        <li><a href="" class="text-white-50">Foro comunitario</a></li>
        <li><a href="" class="text-white-50">Anfitriona con responsabilidad</a></li>
        <li><a href="" class="text-white-50">Súmate a una clase gratuita sobre la actividad de los anfitriones</a></li>
        <li><a href="" class="text-white-50">Buscar un coanfitrión</a></li>
      </ul>
    </div>
    <div class="column">
      <p>Cоня</p>
      <ul>
        <li><a href="" class="text-white-50">Sala de prensa</a></li>
        <li><a href="" class="text-white-50">Funciones nuevas</a></li>
        <li><a href="" class="text-white-50">Carreras</a></li>
        <li><a href="" class="text-white-50">Inversionistas</a></li>
        <li><a href="" class="text-white-50">Espacios en соня.org</a></li>
      </ul>
    </div>
    <div class="column"></div>
  </div>
  <div class="all-rights-reserved w-100 d-flex align-items-center justify-content-evenly mt-5">
    © 2025 соня, Inc.
    <ul class="d-flex align-items-center w-50 justify-content-evenly">
      <li>Privacidad</li>
      <li>Términos</li>
      <li>Mapa del sitio</li>
    </ul>
  </div>
  <div class="signature-container">
    <div class="signature">соня</div>
  </div>
</footer>
</html>