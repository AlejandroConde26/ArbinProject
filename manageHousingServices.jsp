<%--
    Document   : manageHousingServices
    Created on : 27-jun-2025, 17:00:00
    Author     : Tu Nombre
--%>

<%@page import="Models.Services"%>
<%@page import="Models.Housing"%>
<%@page import="Models.User"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestionar Servicios del Alojamiento</title>
    <link rel="stylesheet" href="css/dashboardHosting.css?v=<%= System.currentTimeMillis() %>"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <style>
        /* Estilos específicos para esta página */
        .services-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .services-container h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .service-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #fff;
        }
        .service-item input[type="checkbox"] {
            margin-right: 15px;
            transform: scale(1.3);
        }
        .service-item label {
            flex-grow: 1;
            font-size: 1.1em;
            color: #555;
            cursor: pointer;
        }
        .service-item p {
            font-size: 0.9em;
            color: #777;
            margin-top: 5px;
        }
        .form-actions {
            text-align: center;
            margin-top: 30px;
        }
        .form-actions button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }
        .form-actions button:hover {
            background-color: #0056b3;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <%-- Navbar (puedes incluir la misma que en indexHosting.jsp si lo deseas) --%>
    <div class="container-navbar">
        <div class="navbar">
            <div class="logo"><img src="images/logo.png" alt="Logo"/></div>
            <div class="menu">
                <div class="menu-item">Hoy</div>
                <div class="menu-item">Calendario</div>
                <div class="menu-item">Anuncios</div>
                <div class="menu-item">Mensajes</div>
                <div class="menu-item" onclick="toggleDropdown()">
                    Menú <i class="bi bi-caret-down"></i>
                    <div class="dropdown" id="dropdownMenu">
                        <a href="#">Reservaciones</a>
                        <a href="#">Ingresos</a>
                        <a href="#">Info</a>
                        <a href="agregarHousing.jsp">Crea un nuevo anuncio</a>
                        <hr />
                        <a href="#">Guías</a>
                        <a href="#">Descubre los recursos para anfitriones</a>
                        <a href="#">Conéctate con otros anfitriones de tu zona</a>
                    </div>
                </div>
            </div>
            <%
                User sessionUser = (User) session.getAttribute("user");
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
    <%-- Fin Navbar --%>

    <div class="services-container">
        <h1>Gestionar Servicios del Alojamiento #<%= request.getAttribute("housingId") %></h1>
        <form action="SvManageHousingServices" method="POST">
            <input type="hidden" name="housingId" value="<%= request.getAttribute("housingId") %>">

            <%
                List<Services> allServices = (List<Services>) request.getAttribute("allServices");
                List<Integer> associatedServiceIds = (List<Integer>) request.getAttribute("associatedServiceIds");

                if (allServices != null && !allServices.isEmpty()) {
                    for (Services service : allServices) {
            %>
                        <div class="service-item">
                            <input type="checkbox"
                                   id="service_<%= service.getId_service() %>"
                                   name="services"
                                   value="<%= service.getId_service() %>"
                                   <%= associatedServiceIds.contains(service.getId_service()) ? "checked" : "" %>>
                            <label for="service_<%= service.getId_service() %>">
                                <strong><%= service.getName_service() %></strong>
                                <p><%= service.getDescription() %></p>
                            </label>
                        </div>
            <%
                    }
                } else {
            %>
                    <p>No hay servicios registrados.</p>
            <%
                }
            %>

            <div class="form-actions">
                <button type="submit">Guardar Servicios</button>
            </div>
        </form>
        <a href="SvHost" class="back-link">Volver a mis anuncios</a>
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