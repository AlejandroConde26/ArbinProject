<%-- 
    Document   : indexHosting
    Created on : 11 may 2025, 19:10:14
    Author     : Alex
--%>

<%@page import="Models.Controladora_System"%>
<%@page import="Models.HousingImage"%>
<%@page import="java.util.List"%>
<%@page import="Models.Housing"%>
<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
   <!DOCTYPE html>
    <html lang="es">
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Tu anuncio</title>
    <link rel="stylesheet" href="css/dashboardHosting.css?v=<%= System.currentTimeMillis() %>"/>
    </head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <body>
        
    <%
        HttpSession misession = request.getSession();
        User sessionUser = (User) session.getAttribute("user");

         if (sessionUser == null) {
             response.sendRedirect("login.jsp");
             return;
         }
    %>
        
    <div class="container-navbar">
        <div class="navbar"> 
            <div class="logo"><img src="images/logo.png" alt="Logo"/></div>
      
            <div class="menu">
            <div class="menu-item">Hoy</div>
            <div class="menu-item">Calendario</div>
            <div class="menu-item">Anuncios</div>
            <div class="menu-item">
                        <a href="SvHostChatPanel">Mensajes</a>
            </div>
            
            <div class="menu-item" onclick="toggleDropdown()">
                Menú <i class="bi bi-caret-down"></i>
                <div class="dropdown" id="dropdownMenu">
                    <a href="#">Reservaciones</a>
                    <a href="#">Ingresos</a>
                    <a href="#">Info</a>
                    <a href="#">Crea un nuevo anuncio</a>
                    <hr />
                    <a href="#">Guías</a>
                    <a href="#">Descubre los recursos para anfitriones</a>
                    <a href="#">Conéctate con otros anfitriones de tu zona</a>
                </div>
            </div>
            </div>
        <%
            String profileImg = sessionUser.getUrl_img_perfile();
        %>
        <button class="user-profile" onclick="toggleDropdown_hosting()" style="cursor:pointer;">
            <% if (profileImg != null && !profileImg.isEmpty()) { %>
                <img src="<%= profileImg %>" alt="Perfil" class="navbar-profile-img" />
            <% } else { %>
                <%= sessionUser.getEmail().substring(0, 1).toUpperCase() %>
            <% } %>

            <div class="dropdown_hosting" id="dropdown_hosting">
                <a href="#">Perfil</a>
                <a class="dropdown-item" href="SvInfoCuenta">Mi Cuenta</a>
                <hr />
                <a href="SvCargarHousings">Cambiar a modo viajero</a>
                <a href="SvCerrarSesion">Cerrar sesión</a>
            </div>
        </button>

        </div>
    </div>

    <div class="search-bar" id="searchBar">
        <input type="text" placeholder="Buscar..." />
    </div>
  <div id="normalView" class="main">
      <div class="container-encabezado-hosting">
           <div class="encabezado-hosting">
               <div class="subtitle"> <h1>Tu hospedaje</h1></div>
               <div class="actions">
                 <button class="icon-button" onclick="toggleSearch()">
                           <i class="bi bi-search"></i>
                 </button>
                 <a  class="icon-button" href="agregarHousing.jsp">
                      <i class="bi bi-plus-lg"></i>
                 </a>        
             </div> 
           </div>
      </div>
     
   
    <div class="anuncios-grid">
        <%
        List<Housing> listaHousings = (List<Housing>) request.getAttribute("listHousing");
         if (listaHousings != null && !listaHousings.isEmpty()) {
             for (Housing housing : listaHousings) {
                 List<HousingImage> images = housing.getHousingImages();
                 String imagePath = (images != null && !images.isEmpty()) ? images.get(0).getImageUrl() : "img/default.jpg";
        %>
           <div class="anuncio">
                    <div class="anuncio-info">
                        <div class="anuncio-datos">
                            <div class="estado"><%= housing.getStatus() %></div>
                            <h2><%= housing.getCommercialName() %></h2>
                        </div>
                        <div class="anuncio-actions">
                            <a href="SveditarHousing?id=<%= housing.getHousingId() %>" class="btn-editar">Editar</a>
                            <a href="SvEditarFotosHousing?id=<%= housing.getHousingId() %>" class="btn-editar">Editar Imágenes</a>
                            <a href="SvManageHousingServices?id=<%= housing.getHousingId() %>" class="btn-editar">Servicios</a>
                            <form action="SvEliminarHousing" method="post" style="display:inline;">
                              <input type="hidden" name="id" value="<%= housing.getHousingId() %>">
                              <button class="btn-delete" type="submit" onclick="return confirm('¿Seguro que quieres eliminar este anuncio?')">Eliminar</button>
                            </form>
                        </div>
                    </div>
            

                <img src="<%= imagePath%>" alt="Imagen de <%= housing.getCommercialName()%>" class="anuncio-img" />
                <div class="anuncio-info">
                  <div class="info-col">
                    <p><strong>Dirección:</strong><br> <%= housing.getAddress() %>, <%= housing.getCity() %>, <%= housing.getCountry() %></p>
                    <p><strong>Precio por noche:</strong><br> $<%= housing.getPriceNight() %></p>
                  </div>
                  <div class="info-col">
                    <p><strong>Habitaciones:</strong><br> <%= housing.getNumHabitaciones() %></p>
                    <p><strong>Fecha de creación:</strong><br> <%= housing.getCreatedDate() %></p>
                  </div>
                </div>
            </div>

        <%
             }
         } else {
        %>
            <p>No tienes anuncios para mostrar.</p>
        <%
         }
        %>
    </div>
</div>
    


        <div id="gridView" class="grid-container" style="display: none;">
            <div class="anuncio-card">
            <div class="estado">En progreso</div>
            <div class="fecha">Empieza el 1 de mayo de 2025</div>
            </div>
            <div class="anuncio-card">
            <div class="estado">En progreso</div>
            <div class="fecha">Empieza el 3 de mayo de 2025</div>
            </div>
            <div class="anuncio-card">
            </div>
        </div>
    <script src="js/dashboardHosting.js"></script>
<script>
function toggleDropdown_hosting() {
    const dropdown = document.getElementById("dropdown_hosting");
    dropdown.classList.toggle("show-dropdown");
}
</script>

    </body>
    </html>