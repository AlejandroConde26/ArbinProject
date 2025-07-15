<%-- 
    Document   : indexPerfilUser
    Created on : 23 may 2025, 17:43:59
    Author     : Alex
--%>

<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="Models.Document_type"%>
<%@page import="Models.Roles"%>
<%@page import="Models.Address"%>
<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>                  
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Mi perfil - Airbnb</title>
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

    Address address = user != null ? user.getAddress_id() : null;
    Roles role = user != null ? user.getRole_id() : null;
    Document_type docType = user != null ? user.getDocument_type_id() : null;
%>

   
  <!-- NAVBAR -->

  <nav class="navbar navbar-expand-lg bg-white">
    <div class="container-fluid">
      <a class="navbar-brand" href="SvCargarHousings">
            <img src="images/logo.png"/>
      </a>
  
        <div class="options-nav">
            <%
                if (user.getHost_id()!= null) {
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
                String profileImg = user.getUrl_img_perfile();
            %>
            <button class="user-profile">
              <% if (profileImg != null && !profileImg.isEmpty()) { %>
                  <img src="<%= profileImg %>" alt="Perfil" class="navbar-profile-img"/>
              <% } else { %>
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
                    <li> <a class="dropdown-item" href="SvCargarHousings">Modo viajero</a></li>
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
            <li>
            </li>
          </ul>
        </div>
    </div>
    <div class="container-info-perfile">
      <div class="title">Editar Perfil</div>
      <form action="SvInfoCuenta" method="post" enctype="multipart/form-data">
          <div class="profile-photo">
              <img id="profilePreview" src="<%= user.getUrl_img_perfile() != null ? user.getUrl_img_perfile() : "https://via.placeholder.com/150" %>" alt="Perfil"/>
              <br/><br/>
              <input type="file" name="url_img_perfile" accept="image/*" onchange="previewImage(event)">
          </div>

          <div class="form-section">
            <div class="form-group">
                <label>Nombre</label>
                <input type="text" name="full_name" value="<%= user.getFull_name() != null ? user.getFull_name() : "" %>">
            </div>

            <div class="form-group">
                <label>Apellido</label>
                <input type="text" name="last_name" value="<%= user.getLast_name() != null ? user.getLast_name() : "" %>">
            </div>

            <div class="form-group">
                <label>Email</label>
                <input type="email" class="readonly" readonly value="<%= user.getEmail() != null ? user.getEmail() : "" %>">
            </div>

            <div class="form-group">
                <label>Teléfono</label>
                <input type="tel" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>">
            </div>

            <div class="form-group">
                <label>Tipo de Documento</label>
                <select name="document_type">
                    <option value="1" <%= docType != null && docType.getDocument_type()== 1 ? "selected" : "" %>>DNI</option>
                    <option value="2" <%= docType != null && docType.getDocument_type() == 2 ? "selected" : "" %>>CE</option>
                    <option value="3" <%= docType != null && docType.getDocument_type() == 3 ? "selected" : "" %>>PAS</option>
                </select>
            </div>

            <div class="form-group">
                <label>Número de Documento</label>
                <input type="text" name="num_document" value="<%= user.getNum_document() != null ? user.getNum_document() : "" %>">
            </div>


            <div class="form-group">
                <label>Contacto de Emergencia</label>
                <input type="text" name="emergency_contact" value="<%= user.getEmergency_contact() != null ? user.getEmergency_contact() : "" %>">
            </div>
              <input type="submit" value="Guardar Cambios">
          </div>
      </form>
    </div>
   
</div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="js/indexPerfilUser.js?v=<%= System.currentTimeMillis() %>"></script>
</body>
</html>