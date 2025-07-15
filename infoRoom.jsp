<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Models.Message"%>
<%@page import="Models.Services"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.Reservation"%>
<%@page import="Models.ReviewHousing"%>
<%@page import="Models.Address"%>
<%@page import="Models.HousingImage"%>
<%@page import="Models.Housing"%>
<%@page import="Models.User"%>
<%@page import="Models.Controladora_System"%>
<%@ page import="javax.persistence.*" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Aira</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="css/indexUser.css?v=<%= System.currentTimeMillis() %>"/>
<link rel="stylesheet" href="css/infoRoom.css?v=<%= System.currentTimeMillis() %>"/>

</head>

<body>
 
    
    
    <%
            Controladora_System control = new Controladora_System();
            List<Message> mensajes = (List<Message>) request.getAttribute("conversation");
            int housingIdParam = -1;

            String housingIdStr = request.getParameter("housingId");

            if (housingIdStr != null && !"null".equals(housingIdStr.trim()) && !housingIdStr.trim().isEmpty()) {
                housingIdParam = Integer.parseInt(housingIdStr);
            } else if (session.getAttribute("housingId") != null) {
                housingIdParam = Integer.parseInt((String) session.getAttribute("housingId"));
            } else {
                // Redirecciona o muestra error
                response.sendRedirect("SvCargarHousings");
                return;
            }
          
            User sessionUser = (User) session.getAttribute("user");
            Housing housing = control.getHousing(housingIdParam);
            User receptor = (User) request.getAttribute("receptor");
              List<Services> servicios = control.getHousingsServicios(housing.getHousingId());
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            List<ReviewHousing> listaReseñas = new ArrayList<>();
            for (Reservation reserva : housing.getReservations()) {
                ReviewHousing review = reserva.getReviewHousing();
                if (review != null) {
                    listaReseñas.add(review);
                }
            }

            if (housing != null) {
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
                 if (sessionUser != null && sessionUser.getHost_id() != null) {
            %>
            <button class="btn-custom me-3" onclick="window.location.href='SvHost'">Modo Anfitrión</button>
            <%
            }   else {
            %>
              <button class="btn-custom me-3" onclick="window.location.href='login.jsp'">Pon tu espacio en aquí</button>
            <%
                }
            %>
            <%
                if (sessionUser != null && sessionUser.getHost_id() != null) {
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
             <% } %>
        </div>
  </nav>
    
   
     
    <div class="container-info-housing">
        <div class="info-housing">

            <div class="title">
                   <h2> <%= housing.getCommercialName() %>,  <%= housing.getCity() %> </h2>
            </div>
              <%
           List<HousingImage> imagenes = housing.getHousingImages();
       %>
            <div class="container-gallery">
                <div class="gallery">
                    <% if (imagenes != null && !imagenes.isEmpty()) { %>

                        <!-- Imagen 0 -->
                        <img src="<%= imagenes.get(0).getImageUrl() %>" class="main-img" alt="<%= imagenes.get(0).getCaption() %>">

                        <!-- Imagen 1 (solo si existe) -->
                        <% if (imagenes.size() > 1) { %>
                            <img src="<%= imagenes.get(1).getImageUrl() %>" alt="<%= imagenes.get(1).getCaption() %>">
                        <% } %>

                        <!-- Imagen 2 en contenedor especial (solo si existe) -->
                        <% if (imagenes.size() > 2) { %>
                            <img src="<%= imagenes.get(2).getImageUrl() %>" alt="<%= imagenes.get(2).getCaption() %>">
                        <% } %>

                    <% } else { %>
                        <p>No hay imágenes disponibles.</p>
                    <% } %>
                </div>
            </div>

            <div class="container-data">
                 <div class="part-info">
                <div class="data-housing">
                    <div class="title">
                        <h2><%= housing.getCommercialName() %>,  <%= housing.getCity() %></h2>
                        <h5>4 huéspedes2 habitaciones3 camas2 baños <%= housing.getCharacteristics() %></h5>
                    </div>
                </div>
                <div class="table-host-resena">
                                <div class="item">Favorito entre huespedes</div>
                                <div class="text">
                                    Este alojamiento es uno de los favoritos de los huéspedes según valoraciones, reseñas y confiabilidad
                                </div>
                                <div class="item-stars">
                                    <div class="puntos">
                                        <%=housing.getStars() %>>
                                    </div>
                                    <div class="stars">*****</div>
                                </div>
                                <div class="num-resena">
                                    <div class="num">8</div>
                                    <div>Reseñas</div>
                                </div>
                </div>
                  <%
                        String urlImg = housing.getHostId().getId_user().getUrl_img_perfile();
                        String email = housing.getHostId().getId_user().getEmail();
                        String firstLetter = email != null && !email.isEmpty() ? email.substring(0, 1).toUpperCase() : "?";
                        boolean hasImage = urlImg != null && !urlImg.trim().isEmpty();
                    %>
                <div class="host">
                    <% if (hasImage) { %>
                        <img src="<%= urlImg %>" alt="Anfitrión">
                    <% } else { %>
                        <div class="profile-placeholder"><%= firstLetter %></div>
                    <% } %>

                    <div class="host-info">
                        <strong>Anfitrión: <%= housing.getHostId().getId_user().getFull_name() %> <%= housing.getHostId().getId_user().getLast_name() %></strong>
                        <small>Superanfitrión · 7 meses anfitrionando</small>
                    </div>
                </div>                <div class="divider"></div>          
                <!-- proximamente.... -->
                <div class="features">
                                <div class="feature">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 24px; width: 24px; fill: currentcolor;"><path d="M26 1a5 5 0 0 1 5 5c0 6.39-1.6 13.19-4 14.7V31h-2V20.7c-2.36-1.48-3.94-8.07-4-14.36v-.56A5 5 0 0 1 26 1zm-9 0v18.12c2.32.55 4 3 4 5.88 0 3.27-2.18 6-5 6s-5-2.73-5-6c0-2.87 1.68-5.33 4-5.88V1zM2 1h1c4.47 0 6.93 6.37 7 18.5V21H4v10H2zm14 20c-1.6 0-3 1.75-3 4s1.4 4 3 4 3-1.75 3-4-1.4-4-3-4zM4 3.24V19h4l-.02-.96-.03-.95C7.67 9.16 6.24 4.62 4.22 3.36L4.1 3.3zm19 2.58v.49c.05 4.32 1.03 9.13 2 11.39V3.17a3 3 0 0 0-2 2.65zm4-2.65V17.7c.99-2.31 2-7.3 2-11.7a3 3 0 0 0-2-2.83z"></path></svg>
                                <div class="text">
                                    <h4>Servicios para la vida diaria</h4>
                                    <p>El anfitrión equipó este alojamiento para estadías largas y cuenta con cocina, lavadora y secador de pelo.</p>
                                </div>
                                </div>
                                <div class="feature">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 24px; width: 24px; fill: currentcolor;"><path d="M24 26c.99 0 1.95.35 2.67 1 .3.29.71.45 1.14.5H28v2h-.23a3.96 3.96 0 0 1-2.44-1A1.98 1.98 0 0 0 24 28c-.5 0-.98.17-1.33.5a3.98 3.98 0 0 1-2.67 1 3.98 3.98 0 0 1-2.67-1A1.98 1.98 0 0 0 16 28c-.5 0-.98.17-1.33.5a3.98 3.98 0 0 1-2.67 1 3.98 3.98 0 0 1-2.67-1A1.98 1.98 0 0 0 8 28c-.5 0-.98.17-1.33.5a3.96 3.96 0 0 1-2.44 1H4v-2h.19a1.95 1.95 0 0 0 1.14-.5A3.98 3.98 0 0 1 8 26c.99 0 1.95.35 2.67 1 .35.33.83.5 1.33.5.5 0 .98-.17 1.33-.5A3.97 3.97 0 0 1 16 26c.99 0 1.95.35 2.67 1 .35.33.83.5 1.33.5.5 0 .98-.17 1.33-.5A3.98 3.98 0 0 1 24 26zm0-5c.99 0 1.95.35 2.67 1 .3.29.71.45 1.14.5H28v2h-.23a3.96 3.96 0 0 1-2.44-1A1.98 1.98 0 0 0 24 23c-.5 0-.98.17-1.33.5a3.98 3.98 0 0 1-2.67 1 3.98 3.98 0 0 1-2.67-1A1.98 1.98 0 0 0 16 23c-.5 0-.98.17-1.33.5a3.98 3.98 0 0 1-2.67 1 3.98 3.98 0 0 1-2.67-1A1.98 1.98 0 0 0 8 23c-.5 0-.98.17-1.33.5a3.96 3.96 0 0 1-2.44 1H4v-2h.19a1.95 1.95 0 0 0 1.14-.5A3.98 3.98 0 0 1 8 21c.99 0 1.95.35 2.67 1 .35.33.83.5 1.33.5.5 0 .98-.17 1.33-.5A3.97 3.97 0 0 1 16 21c.99 0 1.95.35 2.67 1 .35.33.83.5 1.33.5.5 0 .98-.17 1.33-.5A3.98 3.98 0 0 1 24 21zM20 3a4 4 0 0 1 4 3.8V9h4v2h-4v5a4 4 0 0 1 2.5.86l.17.15c.3.27.71.44 1.14.48l.19.01v2h-.23a3.96 3.96 0 0 1-2.44-1A1.98 1.98 0 0 0 24 18c-.5 0-.98.17-1.33.5a3.98 3.98 0 0 1-2.67 1 3.98 3.98 0 0 1-2.67-1A1.98 1.98 0 0 0 16 18c-.5 0-.98.17-1.33.5a3.98 3.98 0 0 1-2.67 1 3.98 3.98 0 0 1-2.67-1A1.98 1.98 0 0 0 8 18c-.5 0-.98.17-1.33.5a3.96 3.96 0 0 1-2.44 1H4v-2h.19a1.95 1.95 0 0 0 1.14-.5A3.98 3.98 0 0 1 8 16c.99 0 1.95.35 2.67 1 .35.33.83.5 1.33.5.5 0 .98-.17 1.33-.5a3.96 3.96 0 0 1 2.44-1H16v-5H4V9h12V7a2 2 0 0 0-4-.15V7h-2a4 4 0 0 1 7-2.65A3.98 3.98 0 0 1 20 3zm-2 13.52.46.31.21.18c.35.31.83.49 1.33.49a2 2 0 0 0 1.2-.38l.13-.11c.2-.19.43-.35.67-.49V11h-4zM20 5a2 2 0 0 0-2 1.85V9h4V7a2 2 0 0 0-2-2z"></path></svg>
                                <div class="text">
                                    <h4>Sumérgete</h4>
                                    <p>Este es uno de los pocos lugares en la zona con piscina.</p>
                                </div>
                                </div>
                                <div class="feature">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 24px; width: 24px; fill: currentcolor;"><path d="M16.84 27.16v-3.4l-.26.09c-.98.32-2.03.51-3.11.55h-.7A11.34 11.34 0 0 1 1.72 13.36v-.59A11.34 11.34 0 0 1 12.77 1.72h.59c6.03.16 10.89 5.02 11.04 11.05V13.45a11.3 11.3 0 0 1-.9 4.04l-.13.3 7.91 7.9v5.6H25.7l-4.13-4.13zM10.31 7.22a3.1 3.1 0 1 1 0 6.19 3.1 3.1 0 0 1 0-6.2zm0 2.06a1.03 1.03 0 1 0 0 2.06 1.03 1.03 0 0 0 0-2.06zM22.43 25.1l4.12 4.13h2.67v-2.67l-8.37-8.37.37-.68.16-.3c.56-1.15.9-2.42.96-3.77v-.64a9.28 9.28 0 0 0-9-9h-.55a9.28 9.28 0 0 0-9 9v.54a9.28 9.28 0 0 0 13.3 8.1l.3-.16 1.52-.8v4.62z"></path></svg>
                                <div class="text">
                                    <h4>Fabulosa experiencia de check-in</h4>
                                    <p>A los huéspedes recientes les encantó el buen comienzo de esta estadía.</p>
                                </div>
                                </div>
                </div>
                <div class="divider"></div>
                <div class="container">
                                    <div>
                                    <div class="card-body">
                                     

                                        <div id="desc" class="description-container">
                                             <%= housing.getDescription()%>
                                        </div>

                                        <button id="toggleBtnRead" class="read-more-btn">Leer más</button>

                                    </div>
                                    </div>
                </div>
                <div class="divider"></div>
                <!-- proximamente... -->
  <div class="container">
    <h4>Lo que este lugar ofrece</h4>
    <div class="row">
        <%
            if (servicios != null) {
                for (Models.Services servicio : servicios) {
                    String nombre = servicio.getName_service();
                    String icono = "https://cdn-icons-png.flaticon.com/512/5610/5610944.png"; 
        %>
        <div class="col-md-6">
            <div class="service-item">
                <img src="<%= icono %>" alt="<%= nombre %>" style="width: 30px; height: 30px;">
                <%= nombre %>
            </div>
        </div>
        <%
                } // end for
            } else {
        %>
        <div class="col-12">
            <p>No hay servicios disponibles para esta habitación.</p>
        </div>
        <% } %>
    </div>
</div>


            </div>
            <div class="part-reserva"> 
                 <%
                    if (sessionUser != null) {
                  %>
                <form action="SvReservation" method="post" class="reserva-card sticky-reserve">
                    <div class="precio">S/<span>3,265</span> mensual</div>
                    <input type="hidden" name="housingId" value="<%= housing.getHousingId()%>">
                    <div class="grid">
                        <div>
                            <label for="llegada">LLEGADA</label>
                        <input type="date"  id="llegada" name="llegada" required  value="2025-05-24">
                        </div>
                        <div>
                        <label>SALIDA</label>
                        <input type="date" id="salida" name="salida" required value="2025-06-23">
                        </div>
                    </div>

                    <div class="huespedes-container d-flex flex-column gap-4">
                        <label>HUÉSPEDES</label>
                      
                        <div class="d-flex flex-column gap-4"id="huespedes" name="huespedes" required">
                        <label class="d-flex align-items-center justify-content-between">Adultos
                            <input name="numberOfAdults" type="number" min="0" value="1">
                        </label>
                        <label class="d-flex align-items-center justify-content-between">Niños
                            <input  name="numberOfChildren" type="number" min="0" value="0">
                        </label>
                        </div>
                    </div>
                    <div class="error" id="errorMsg" style="display: none;">
                        ⚠️ Algo salió mal. Intenta con otras fechas.
                    </div>

                    <button type="submit" class="btn-reserva">Reserva</button>
                    <div class="info">No se hará ningún cargo por el momento</div>
                </form>
                     <%
                } else {
              %>
               <div class="text-center">
                  <p>Inicia sesión para reservar este alojamiento.</p>
                  <a href="login.jsp" class="btn btn-warning">Iniciar Sesión</a>
                </div>
              <%
                }
              %>
            </div> 
            </div
            <!-- proximamente.... -->
            <div class="title-review fw-bold">
                Reseñas
            </div>
                    <%    
                        if (listaReseñas != null && !listaReseñas.isEmpty()) {
                            for (ReviewHousing review : listaReseñas) {
                                String avatar = review.getReservation().getUserId().getUrl_img_perfile();
                                Address dir = review.getReservation().getUserId().getAddress_id();
                                String ciudad = (dir != null && dir.getCiudad() != null && !dir.getCiudad().isEmpty())
                                    ? dir.getCiudad()
                                    : "Ubicación no disponible";
                                String pais = (dir != null && dir.getCountry() != null) ? dir.getCountry() : "";
                                String location = ciudad + (pais.isEmpty() ? "" : ", " + pais);

                                String comentario = review.getDescription();
                                int estrellas = review.getScore();

                                java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("MMMM 'de' yyyy", new java.util.Locale("es", "ES"));
                                String fechaFormateada = "";
                                if (review.getCreatedDate() != null) {
                                    fechaFormateada = review.getCreatedDate().format(formatter);
                                }

                                String nombreUsuario = review.getReservation().getUserId().getFull_name();
                    %>
                    <div class="review">
                        <div class="review-header">
                            <img class="avatar" src="<%= avatar %>" alt="Avatar <%= nombreUsuario %>">
                            <div>
                                <div class="name"><%= nombreUsuario %></div>
                                <div class="location"><%= location %></div>
                            </div>
                        </div>
                        <div class="stars-date">
                            <%
                                for (int i = 0; i < estrellas; i++) { out.print("★"); }
                                for (int i = estrellas; i < 5; i++) { out.print("☆"); }
                            %>
                            · <%= fechaFormateada %> · Estadía de alrededor de una semana
                        </div>
                        <div class="review-text"><%= comentario %></div>
                        <div class="more">Mostrar más</div>
                    </div>
                    <%
                            }
                        } else {
                    %>
                        <p>No hay reseñas disponibles.</p>
                    <%
                        }
                    %>
             <div class="title-map container">
                <h2 class="fw-bold">A dónde irás</h2>
                <p>Miraflores, Provincia de Lima, Perú</p>
            </div>


            <div id="map-container" class="position-relative">
                      <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d108117.77400071874!2d-77.069029743872!3d-12.11495627353274!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105b8774b650185%3A0xa02048a97b828a56!2sHotel%20Monterrico%20Per%C3%BA!5e0!3m2!1ses-419!2spe!4v1744517203518!5m2!1ses-419!2spe" width="100%" height="550" style="border: 16px; margin-top: 16px;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
            </div>
            <div class="container container-host d-flex align-items-center justify-content-center">
        <div class="row  d-flex align-items-center justify-content-between">
            <div class="col-6">
                <div class="row">
                    <div class="col-9 w-100">
                        <div class="container"> 
                            <div class="d-flex justify-content-center align-items-center min-vh-100.1">
                                <a href="index.html" class="card shadow rounded-5 p-5" style="border: none; text-decoration: none; width: 100%">
                                    <div class="row g-5 align-items-center">
                                        <!-- Columna izquierda con foto y texto -->
                                       <%
                                            String imgUrl = housing.getHostId().getId_user().getUrl_img_perfile();
                                           boolean hasImg = imgUrl != null && !imgUrl.trim().isEmpty();
                                        %>

                                        <div class="col-md-6 text-center position-relative">
                                            <% if (hasImg) { %>
                                                <img src="<%= imgUrl %>" alt="Alejandro" class="rounded-circle mb-2"
                                                     style="width: 120px; height: 120px; object-fit: cover;"
                                                     onclick="window.location.href='inforHost.html'">
                                            <% } else { %>
                                                <div class="profile-placeholder mx-auto mb-2"
                                                     onclick="window.location.href='inforHost.html'">
                                                    <%= firstLetter %>
                                                </div>
                                            <% } %>

                                            <!-- Icono flotante de verificado -->
                                            <div class="position-absolute translate-middle" style="top: 55%; left: 75%;">
                                                <span class="bg-danger text-white rounded-circle p-2 shadow-sm">
                                                    <i class="bi bi-shield-check fs-6"></i>
                                                </span>
                                            </div>

                                            <h4 class="fw-bold mt-2 mb-1" style="font-size: 1.6rem;">
                                                <%= housing.getHostId().getId_user().getFull_name() %>
                                            </h4>
                                            <p class="text-muted mb-0" style="font-size: 0.8rem;">
                                                <i class="bi bi-trophy-fill me-1"></i>Superanfitrión
                                            </p>
                                        </div>


                                        <!-- Columna derecha con estadísticas -->
                                        <div class="col-md-6 d-flex flex-column justify-content-center border-start ps-3">
                                            <div class="mb-3 text-start">
                                                <p class="mb-0 fs-4 fw-bold">155</p>
                                                <small class="text-muted">Reseñas</small>
                                            </div>
                                            <div class="mb-3 text-start">
                                                <p class="mb-0 fs-4 fw-bold">4.67 ★</p>
                                                <small class="text-muted">Calificación</small>
                                            </div>
                                            <div class="text-start">
                                                <p class="mb-0 fs-4 fw-bold">6</p>
                                                <small class="text-muted">Años como anfitrión</small>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="container">
                            <div class="d-flex justify-content-center align-items-center min-vh-100.1 mt-5">
                                <div class="card rounded-5 p-4" style="max-width: 900px; border: solid; border-color: rgb(231, 231, 231);">
                                    <div class="row g-5 align-items-center">
                                        <h6 style="font-size: 23px;">Información confirmada de  <%= housing.getHostId().getId_user().getFull_name()%></h6>
                                        <ul class="list-unstyled mt-3">
                                            <li><i class="fas fa-check text-success m-t3" style="font-size: 23px;"></i>
                                                Identidad</li>
                                            <li><i class="fas fa-check text-success mt-3" style="font-size: 23px;"></i>
                                                 <%= housing.getHostId().getId_user().getEmail()%> </li>
                                            <li><i class="fas fa-check text-success mt-3" style="font-size: 23px;"></i>
                                                 <%= housing.getHostId().getId_user().getPhone()%> </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="w-100 d-flex align-items-center justify-content-center">
                            <a href="#" class="d-block mt-3 text-dark"><i class="bi bi-flag-fill"></i><b>Denuncia este
                                    perfil</b></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-6" style="margin-left: -7rem;">
                <div class="container">
                    <h4 class="fw-bold mb-4 fs-1">Acerca de  <%= housing.getHostId().getId_user().getFull_name()%></h4>
                    <!-- Fila de iconos y datos personales -->
                  
                    <!-- Descripción larga -->
                    <div class="mt-4">
                        <p>Estudié cocina y trabajé en cruceros. Durante mi tiempo en el mar conocí lugares como
                            Australia, Corea, Japón y Alaska.</p>
                        <p>Sin embargo, después de tantas aventuras, decidí regresar a mi querida Lima y cambiar de
                            rumbo profesional, dedicándome a la contabilidad. A pesar de este cambio, no he dejado de
                            lado mi amor por los viajes. Ahora, viajo por placer, explorando el mundo a mi propio ritmo
                            y disfrutando de cada nueva experiencia.</p>
                    </div>
                    <a href="SvViewConversation?idReceptor=<%= housing.getHostId().getId_user().getId_users()%>&housingId=<%= housing.getHousingId()%>" 
                               class="d-block mt-3 text-dark fs-2 text-decoration-none hover-effect">
                                <i class="fa-solid fa-comments me-2"></i> 
                                <b>¡Conversa conmigo!</b>
                            </a>
                </div>
              
            </div>
        </div>
    </div>
        </div>
    </div>

   <%
      } else {
  %>
    <div class="container text-center mt-5">
      <h2>Este alojamiento no existe.</h2>
    </div>
  <%
      }
  %>

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


  <!-- Bootstrap JS -->
  <script src="js/infoRoom.js?v=<%= System.currentTimeMillis() %>"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>