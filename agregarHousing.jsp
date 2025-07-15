<%-- 
    Document   : agregarHousing
    Created on : 1 may 2025, 05:24:05
    Author     : Alex
--%>      
<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Inicio Anuncios</title>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    <link rel="stylesheet" href="css/housingform.css?v=<%= System.currentTimeMillis() %>"/>  
</head>
<body>
  <%
            HttpSession misession = request.getSession();
            User sessionUser =  (User)session.getAttribute("user");
            if(sessionUser==null){
            response.sendRedirect("login.jsp");
            }
        %>

    <div class="container">

        <!-- FORMULARIO ENCIMA DE TODO -->
        <form action="SvagregarHousing" method="post" class="formulario-anuncio"  enctype="multipart/form-data">
        <h2>Publicar nuevo anuncio</h2>
        
        <label for="titulo">Nombre comercial:</label>
        <input type="text" id="titulo" name="titulo" required />

        <label for="descripcion">Descripción:</label>
        <textarea id="descripcion" name="descripcion" rows="4" required></textarea>

        <label for="direccion">Dirección:</label>
        <input type="text" id="direccion" name="direccion" required />

        <label for="city">Ciudad:</label>
        <input type="text" id="city" name="city" required />

        <label for="country">País:</label>
        <input type="text" id="country" name="country" required />
        
        <label for="categoria">Categoría:</label>
        <select id="categoria" name="categoria" required>
            <option value="">-- Selecciona una categoría --</option>
            <option value="1">Apartamentos</option>
            <option value="2">Hoteles</option>
            <option value="3">Casas de playas</option>
            <option value="4">Casas Familiares</option>
            <option value="5">Casas de Campo</option>
            <option value="6">Casas en la montaña</option>
            <option value="7">Restaurantes</option>
        </select>
        
        <label for="caracteristicas">Características:</label>
        <input type="text" id="caracteristicas" name="caracteristicas" placeholder="WiFi, TV, Cocina..." />

        <label for="latitude">Latitud:</label>
        <input type="text" id="latitude" name="latitude" placeholder="-12.0464" />

        <label for="longitude">Longitud:</label>
        <input type="text" id="longitude" name="longitude" placeholder="-77.0428" />

        <label for="precio">Precio por noche:</label>
        <input type="number" step="0.01" id="precio" name="precio" required />

        <label for="numHabit">Número de habitaciones:</label>
        <input type="number" id="numHabit" name="numHabit" required />



        <label for="estrellas">Estrellas:</label>
        <select id="estrellas" name="estrellas">
            <option value="1">1 estrella</option>
            <option value="2">2 estrellas</option>
            <option value="3">3 estrellas</option>
            <option value="4">4 estrellas</option>
            <option value="5">5 estrellas</option>
        </select>

        <label for="status">Estado:</label>
        <select id="status" name="status">
            <option value="activo">Activo</option>
            <option value="inactivo">Inactivo</option>
        </select>
        
        <h2 class="mb-4">Agregar Fotos a un Anuncio</h2>
        <label>Imágenes:</label>
        <input type="file" name="images" id="images" accept="image/*" multiple required><br><br>

        <!-- Contenedor de previsualización -->
        <div id="preview" style="display: flex; gap: 10px; flex-wrap: wrap;"></div>
        
        <button type="submit">Publicar anuncio</button>
    </form>
        
   
        <!-- CONTENIDO ORIGINAL -->
        <header class="top-bar">
            <div class="actions">
                <button>¿Alguna pregunta?</button>
                <button type="button" onclick="history.back()">Salir</button>
            </div>
        </header>
  <script>
    document.getElementById('images').addEventListener('change', function (event) {
        const preview = document.getElementById('preview');
        preview.innerHTML = ""; // Limpiar anteriores

        const files = event.target.files;
        Array.from(files).forEach(file => {
            if (file.type.startsWith('image/')) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.style.width = "150px";
                    img.style.height = "auto";
                    img.style.objectFit = "cover";
                    img.style.border = "1px solid #ccc";
                    img.style.borderRadius = "8px";
                    preview.appendChild(img);
                };
                reader.readAsDataURL(file);
            }
        });
    });    
  </script>
    </div>
</body>
</html>