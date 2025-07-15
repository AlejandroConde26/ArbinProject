/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package View_Servlets.Host;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import Models.Controladora_System;
import Models.Host;
import Models.Housing;
import Models.HousingCategory;
import Models.HousingImage;
import Models.User;
import persistencia.exceptions.PreexistingEntityException;

/**
 *
 * @author Alex
 */

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
@WebServlet(name = "SvagregarHousing", urlPatterns = {"/SvagregarHousing"})
public class SvagregarHousing extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
      Controladora_System control = new Controladora_System(); 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener datos del formulario
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String direccion = request.getParameter("direccion");
        int categoryId = Integer.parseInt(request.getParameter("categoria"));
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        float precio = Float.parseFloat(request.getParameter("precio"));
        int numHabit = Integer.parseInt(request.getParameter("numHabit"));

        // Opcionales o extendidos
        String caracteristicas = request.getParameter("caracteristicas");
        String latitude = request.getParameter("latitude");
        String longitude = request.getParameter("longitude");


        // Validación de sesión y usuario
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp"); 
            return;
        }
     
        // Obtener categoría por defecto
        HousingCategory categoria = control.getHousingCategory(categoryId);

        // Crear objeto Housing
        Housing housing = new Housing();
        housing.setCommercialName(titulo);
        housing.setDescription(descripcion);
        housing.setAddress(direccion);
        housing.setCity(city); 
        housing.setCountry(country);
        housing.setPriceNight(precio);
        housing.setNumHabitaciones(numHabit);
        housing.setStars(0); // Por defecto

        housing.setCharacteristics(caracteristicas != null ? caracteristicas : "");
        housing.setLatitude(latitude != null ? latitude : "0.0");
        housing.setLongitude(longitude != null ? longitude : "0.0");

        housing.setStatus("activo");
        housing.setCreatedDate(LocalDate.now());
        housing.setUpdatedDate(LocalDate.now());

        housing.setId_housingcategory(categoria);
        housing.setHostId(user.getHost_id()); // Asignar usuario como anfitrión
        
        //subir fotos
 
    
       
        
        try {
            int id_housing = control.crearyRetornarId(housing);
            for (Part part : request.getParts()) {
                if (part.getName().equals("images") && part.getSize() > 0) {
                    String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    String uploadsDir = getServletContext().getRealPath("/") + "images/img-houses";
                    File dir = new File(uploadsDir);
                    if (!dir.exists()) dir.mkdirs();

                    String filePath = uploadsDir + File.separator + fileName;
                    part.write(filePath);

                    String imageUrl = "images/img-houses/" + fileName;
                    HousingImage img = new HousingImage();
                    img.setHousingId(control.getHousing(id_housing));
                    img.setCaption("Imagen de " + titulo);
                    img.setImageUrl(imageUrl);
                    control.crearHousingImage(img);
                }
            }

            List<Housing> listHousing = control.findHousingsByHostId(user.getHost_id().getId_Host());
            request.setAttribute("listHousing", listHousing);
            request.getRequestDispatcher("indexHosting.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("agregarHousing.jsp?error="+e);
        }
    }
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
