<%-- 
    Document   : indexUser
    Created on : 15 abr 2025, 8:36:28 p.m.
    Author     : USER
--%>

<%@page import="Models.HousingImage"%>
<%@page import="Models.HousingCategory"%>
<%@page import="Models.Housing"%>
<%@page import="Models.User"%>

<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManagerFactory"%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Airbnb Replica</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/indexUser.css?v=<%= System.currentTimeMillis() %>"/>
</head>

<body>
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
  
            <button class="btn-custom me-3" onclick="window.location.href='login.jsp'">Pon tu espacio en aquí</button>
  
            <div class="dropdown">
                <button class="btn btn-outline-secondary d-flex align-items-center justify-content-center rounded-pill d-flex align-items-center" type="button" data-bs-toggle="dropdown">
                    <i class="bi bi-list"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="#">Recomendar un anfitrión</a></li>
                    <li><a class="dropdown-item" href="#">Coviértete en un afitrión</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="login.jsp">Iniciar sesión o Registrarse</a></li>
                </ul>
            </div>
        </div>
  </nav>

 <!-- CATEGORÍAS -->

  <div class="container-category-booking h-auto w-100">
      <div class="category-booking h-auto d-flex justify-content-between align-items-center flex-wrap">
            <a href="SvCargarCategoriasHousing?categoryId=1" class="item-category col-6 col-sm-4 col-md-3 col-lg-1 p-1 d-flex flex-column justify-content-center align-items-center text-center">
                <img src="images/icons-category/chalets-img.png" alt="">
                <p>Apartamentos</p>
            </a>

            <a  href="SvCargarCategoriasHousing?categoryId=2" class="item-category col-6 col-sm-4 col-md-3 col-lg-1 p-1 d-flex flex-column justify-content-center align-items-center text-center">
                <img src="images/icons-category/hotels-img.png" alt="">
                <p>Hoteles</p>
            </a>

            <a  href="SvCargarCategoriasHousing?categoryId=3" class="item-category col-6 col-sm-4 col-md-3 col-lg-1 p-1 d-flex flex-column justify-content-center align-items-center text-center">
                <img src="images/icons-category/it-stays.png" alt="">
                <p>Casas de playas</p>
            </a>

            <a  href="SvCargarCategoriasHousing?categoryId=4" class="item-category col-6 col-sm-4 col-md-3 col-lg-1 p-1 d-flex flex-column justify-content-center align-items-center text-center">
                <img src="images/icons-category/family.png" alt="">
                <p>Casas Familiares</p>
            </a>

            <a  href="SvCargarCategoriasHousing?categoryId=5" class="item-category col-6 col-sm-4 col-md-3 col-lg-1 p-1 d-flex flex-column justify-content-center align-items-center text-center">
                <img src="images/icons-category/nature.png" alt="">
                <p>Casas de Campo</p>
            </a>


            <a  href="SvCargarCategoriasHousing?categoryId=6" class="item-category col-6 col-sm-4 col-md-3 col-lg-1 p-1 d-flex flex-column justify-content-center align-items-center text-center">
                <img src="images/icons-category/montanas.png" alt="">
                <p>Casas en la montaña</p>
            </a>  
           <a  href="SvCargarCategoriasHousing?categoryId=7" class="item-category col-6 col-sm-4 col-md-3 col-lg-1 p-1 d-flex flex-column justify-content-center align-items-center text-center">
            <img src="images/icons-category/restaurant.png" alt="">
            <p>Restaurantes</p>
           </a>
      </div>
  </div>
  <!-- PROPIEDADES: Mensajes de información o error -->
<div class="container my-3">
  <% 
    String mensaje = (String) request.getAttribute("mensaje");
    if (mensaje != null) {
  %>
    <div class="alert alert-info">
      <%= mensaje %>
    </div>
  <% } %>
</div>
<!<!-- Alojamientos -->

<div class="container my-4 d-flex align-items-center justify-content-center">
  <div class="row g-3">
    <%
      List<Housing> listaHousings = (List<Housing>) request.getAttribute("listahabitaciones");
      if (listaHousings != null && !listaHousings.isEmpty()) {
        for (Housing housing : listaHousings) {
            HousingCategory categoria = housing.getId_housingcategory();
            List<HousingImage> img = housing.getHousingImages();
            String carouselId = "carousel" + housing.getHousingId();
    %>
      <div class="col-12 col-sm-6 col-md-4 col-lg-3">
        <div class="card border-0 shadow-sm h-100 rounded-4 housing-card">
          <a href="infoRoom.jsp?housingId=<%= housing.getHousingId() %>" class="text-decoration-none text-dark">
            <% if (img != null && !img.isEmpty()) { %>
              <div id="<%= carouselId %>" class="carousel slide rounded-top overflow-hidden" data-bs-ride="carousel">
                <div class="carousel-inner">
                  <% for (int i = 0; i < img.size(); i++) { %>
                    <div class="carousel-item <%= i == 0 ? "active" : "" %>">
                      <img src="<%= img.get(i).getImageUrl() %>" class="d-block w-100 object-fit-cover housing-img" alt="Imagen">
                    </div>
                  <% } %>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#<%= carouselId %>" data-bs-slide="prev" style="background: none; border: none;">
                  <span class="carousel-control-prev-icon" style="filter: invert(1);"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#<%= carouselId %>" data-bs-slide="next" style="background: none; border: none;">
                  <span class="carousel-control-next-icon" style="filter: invert(1);"></span>
                </button>
              </div>
            <% } else { %>
              <img src="img/no-image.jpg" class="card-img-top object-fit-cover housing-img" alt="Sin imagen disponible">
            <% } %>

            <div class="card-body px-3 py-2">
              <h6 class="fw-bold text-truncate mb-1"><%= housing.getCommercialName() %></h6>
              <div class="d-flex align-items-center mb-2" style="font-size: 0.9rem;">
                <span class="me-1">★</span>
                <strong><%= String.format("%.2f", (double) housing.getStars()) %></strong>
              </div>
              <p class="text-muted small mb-1 text-truncate"><%= housing.getCity() %> · <%= categoria.getCategoryName() %></p>
              <p class="text-muted small mb-2 text-truncate"><%= housing.getDescription() %></p>
              <p class="mb-0">
                <span class="text-muted text-decoration-line-through me-1">S/ <%= housing.getPriceNight() + 200 %></span>
                <span class="fw-bold text-primary">S/ <%= housing.getPriceNight() %></span>
                <span class="text-muted">por 7 noches</span>
              </p>
            </div>
          </a>
        </div>
      </div>
    <%
        }
      }
    %>
  </div>
</div>


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
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
