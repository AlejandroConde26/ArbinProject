package View_Servlets.Host;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import Models.Controladora_System;
import Models.Housing;
import Models.HousingImage;

@WebServlet(name = "SvAgregarImagenHousing", urlPatterns = {"/SvAgregarImagenHousing"})
@MultipartConfig
public class SvAgregarImagenHousing extends HttpServlet {

    Controladora_System control = new Controladora_System();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int housingId = Integer.parseInt(request.getParameter("housingId"));
        Part filePart = request.getPart("image");

        // Guardamos en una carpeta del servidor (por simplicidad en webapp/img/)
        String uploadsDir = getServletContext().getRealPath("/") + "images/img-houses/";
        File uploadFolder = new File(uploadsDir);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        // Generamos nombre único para evitar conflictos
        String fileName = UUID.randomUUID().toString() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String filePath = uploadsDir + fileName;

        try {
            // Guardamos el archivo
            Files.copy(filePart.getInputStream(), Paths.get(filePath));

            // Creamos HousingImage
            Housing housing = control.getHousing(housingId);
            HousingImage nuevaImagen = new HousingImage();
            nuevaImagen.setHousingId(housing);
            nuevaImagen.setImageUrl("images/img-houses/" + fileName); // Ruta relativa al contexto web

            // Guardamos en la base de datos
            control.crearHousingImage(nuevaImagen);

            // Redirigimos para ver los cambios
            request.setAttribute("housing", control.getHousing(housingId));
            request.getRequestDispatcher("indexHostingEditarFotos.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("indexHosting.jsp");
        }
    }
}
