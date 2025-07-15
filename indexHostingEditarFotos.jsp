<%@page import="Models.HousingImage"%>
<%@page import="Models.Housing"%>
<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Fotos del Alojamiento</title>
    <link rel="stylesheet" href="css/indexHostingEditarFotos.css?v=<%= System.currentTimeMillis() %>"/>
</head>
<body>
<%
    HttpSession misession = request.getSession();
    User sessionUser = (User) session.getAttribute("user");

    if (sessionUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Housing housing = (Housing) request.getAttribute("housing");

    if (housing == null) {
        response.sendRedirect("indexHosting.jsp");
        return;
    }
%>

<h1>Galería de "<%= housing.getCommercialName() %>"</h1>

<div class="gallery">
    <% if (housing.getHousingImages() != null && !housing.getHousingImages().isEmpty()) { %>
        <% for (HousingImage img : housing.getHousingImages()) { %>
            <div class="image-container">
                <img src="<%= img.getImageUrl() %>" alt="Imagen de <%= housing.getCommercialName() %>" class="anuncio-img" />
                <form action="SvDeleteImage" method="post">
                    <input type="hidden" name="housingImageId" value="<%= img.getHousingImageId() %>">
                    <button class="btn-delete-image" type="submit" title="Eliminar imagen"
                            onclick="return confirm('¿Seguro que deseas eliminar esta imagen?')">✕</button>
                </form>
            </div>
        <% } %>
    <% } else { %>
        <p class="no-images">No hay imágenes disponibles.</p>
    <% } %>
</div>

<h2>Agregar nueva imagen</h2>
<form class="upload-form" action="SvAgregarImagenHousing" method="post" enctype="multipart/form-data">
    <input type="hidden" name="housingId" value="<%= housing.getHousingId() %>">
    <label for="image">Selecciona una imagen:</label>
    <input type="file" name="image" accept="image/*" required>
    <button type="submit">Subir Imagen</button>
</form>

<a href="SvHost" class="back-btn">⬅ Volver al panel de alojamientos</a>

</body>
</html>
