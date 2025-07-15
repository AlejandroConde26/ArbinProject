<%@page import="Models.User"%>
<%@page import="Models.Housing"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Housing housing = (Housing) request.getAttribute("housing");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Alojamiento</title>
    <link rel="stylesheet" href="css/housingform.css"/>
</head>
<body>
  <%
            HttpSession misession = request.getSession();
            User sessionUser =  (User)session.getAttribute("user");
            if(sessionUser==null){
            response.sendRedirect("login.jsp");
            }
        %>
<form action="SveditarHousing" method="post" enctype="multipart/form-data" class="formulario-anuncio">
    <h2>Editar Alojamiento</h2>
    
    <input type="hidden" name="id" value="<%= housing.getHousingId() %>" />
    
    <label>Nombre comercial:</label>
    <input type="text" name="titulo" value="<%= housing.getCommercialName() %>" required>
    
    <label>Descripción:</label>
    <textarea name="descripcion" rows="4" required><%= housing.getDescription() %></textarea>
    
    <label>Dirección:</label>
    <input type="text" name="direccion" value="<%= housing.getAddress() %>" required>

    <label>Ciudad:</label>
    <input type="text" name="city" value="<%= housing.getCity() %>" required>
    
    <label>País:</label>
    <input type="text" name="country" value="<%= housing.getCountry() %>" required>
    
    <label for="categoria">Categoría:</label>
    <select id="categoria" name="categoria" required>
        <option value="">-- Selecciona una categoría --</option>
        <option value="1" <%= (housing.getId_housingcategory() != null && housing.getId_housingcategory().getCategoryId() == 1) ? "selected" : "" %>>Apartamentos</option>
        <option value="2" <%= (housing.getId_housingcategory() != null && housing.getId_housingcategory().getCategoryId() == 2) ? "selected" : "" %>>Hoteles</option>
        <option value="3" <%= (housing.getId_housingcategory() != null && housing.getId_housingcategory().getCategoryId() == 3) ? "selected" : "" %>>Casas de playas</option>
        <option value="4" <%= (housing.getId_housingcategory() != null && housing.getId_housingcategory().getCategoryId() == 4) ? "selected" : "" %>>Casas Familiares</option>
        <option value="5" <%= (housing.getId_housingcategory() != null && housing.getId_housingcategory().getCategoryId() == 5) ? "selected" : "" %>>Casas de Campo</option>
        <option value="6" <%= (housing.getId_housingcategory() != null && housing.getId_housingcategory().getCategoryId() == 6) ? "selected" : "" %>>Casas en la montaña</option>
        <option value="7" <%= (housing.getId_housingcategory() != null && housing.getId_housingcategory().getCategoryId() == 7) ? "selected" : "" %>>Restaurantes</option>
    </select>


   
        
    <label>Características:</label>
    <input type="text" name="caracteristicas" value="<%= housing.getCharacteristics() %>" />
    
    <label>Latitud:</label>
    <input type="text" name="latitude" value="<%= housing.getLatitude() %>" />
    
    <label>Longitud:</label>
    <input type="text" name="longitude" value="<%= housing.getLongitude() %>" />
    
    <label>Número de habitaciones:</label>
    <input type="number" name="numHabitaciones" value="<%= housing.getNumHabitaciones() %>" required>
    
    <label>Estrellas:</label>
    <input type="number" name="stars" value="<%= housing.getStars() %>" required>
    
    <label>Precio por noche:</label>
    <input type="number" step="0.01" name="priceNight" value="<%= housing.getPriceNight() %>" required>
    
    <label>Estado:</label>
    <input type="text" name="status" value="<%= housing.getStatus() %>" />

    <br>
    <button type="submit">Guardar Cambios</button>
    <button type="button" onclick="history.back()">Cancelar</button>
</form>

</body>
</html>