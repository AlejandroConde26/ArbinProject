<%-- 
    Document   : direccion
    Created on : 23 may 2025, 20:54:31
    Author     : Alex
--%>

<%@page import="Models.Document_type"%>
<%@page import="Models.Roles"%>
<%@page import="Models.User"%>
<%@page import="Models.Address"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dirección del Usuario</title>

   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/indexPerfilUser.css?v=<%= System.currentTimeMillis() %>" />
  <link rel="stylesheet" href="css/indexUser.css?v=<%= System.currentTimeMillis() %>"/>
  
</head>
<body>
 <%
     
    HttpSession misession = request.getSession();
            User user =  (User)session.getAttribute("user");
            if(user==null){
            response.sendRedirect("login.jsp");
            }
%>

   
  <!-- NAVBAR -->

  <nav class="navbar navbar-expand-lg bg-white">
    <div class="container-fluid">
      <a class="navbar-brand" href="SvCargarHousings">
            <img src="images/logo.png"/>
      </a>
  
        <div class="options-nav">
           <%
                if (user != null && user.getHost_id() != null) {
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
            String profileImg = null;
            if (user != null) {
                profileImg = user.getUrl_img_perfile();
            }
          %>
        <button class="user-profile">
            <% if (profileImg != null && !profileImg.isEmpty()) { %>
                <img src="<%= profileImg %>" alt="Perfil" class="navbar-profile-img"/>
            <% } else if (user != null) { %>
                <%= user.getEmail().substring(0, 1).toUpperCase() %>
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
            
           <div class="container">
    <div class="nav-options">
        <h2>Perfil</h2>
        <div class="options">
          <ul>
            <li>
              <a href="indexPerfilUser.jsp">Información sobre mí</a>
            </li>
            <li>
              <a href="direccion.jsp">Mi dirección</a>
            </li>
          </ul>
        </div>
    </div>
    <div class="container-info-perfile">
        <div class="container mt-4 w-100 d-flex flex-column">
            <h3>Dirección</h3>

            <form action="SvGuardarDireccion" method="post">
                <%
                    Address address = (Address) request.getAttribute("address");
                    // Si address existe, muestra los datos para editar, sino campos vacíos para agregar
                    String ciudad = "";
                    String country = "";
                    String address_postal = "";
                    String departament = "";
                    String code_postal = "";
                    String apartment_n = "";

                    if (address != null) {
                        ciudad = address.getCiudad() != null ? address.getCiudad() : "";
                        country = address.getCountry() != null ? address.getCountry() : "";
                        address_postal = address.getAddress_postal() != null ? address.getAddress_postal() : "";
                        departament = address.getDepartament() != null ? address.getDepartament() : "";
                        code_postal = address.getCode_postal() != null ? address.getCode_postal() : "";
                        apartment_n = address.getApartment_n() != null ? address.getApartment_n() : "";
                    }
                %>

                <div class="form-group mb-3">
                    <label>Ciudad</label>
                    <input type="text" name="ciudad" class="form-control" value="<%= ciudad %>" required>
                </div>
                <div class="form-group mb-3">
                    <label>País</label>
                    <input type="text" name="country" class="form-control" value="<%= country %>" required>
                </div>
                <div class="form-group mb-3">
                    <label>Dirección Postal</label>
                    <input type="text" name="address_postal" class="form-control" value="<%= address_postal %>" required>
                </div>
                <div class="form-group mb-3">
                    <label>Departamento</label>
                    <input type="text" name="departament" class="form-control" value="<%= departament %>" required>
                </div>
                <div class="form-group mb-3">
                    <label>Código Postal</label>
                    <input type="text" name="code_postal" class="form-control" value="<%= code_postal %>" required>
                </div>
                <div class="form-group mb-3">
                    <label>Número de Apartamento</label>
                    <input type="text" name="apartment_n" class="form-control" value="<%= apartment_n %>">
                </div>

                <button type="submit" class="btnSave btn btn-primary">
                    <%= (address != null) ? "Actualizar Dirección" : "Guardar Dirección" %>
                </button>
            </form>

        </div>
    </div>
</div>


  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>