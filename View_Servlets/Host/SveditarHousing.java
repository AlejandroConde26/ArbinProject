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
import Models.User;

/**
 *
 * @author Alex
 */
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 1024 * 1024 * 5,   // 5MB por imagen
    maxRequestSize = 1024 * 1024 * 20 // 20MB total
)
@WebServlet(name = "SveditarHousing", urlPatterns = {"/SveditarHousing"})
public class SveditarHousing extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
       
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
     Controladora_System control = new Controladora_System(); 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
        int id = Integer.parseInt(request.getParameter("id"));
        Housing housing = control.getHousing(id); // este método debe existir

        request.setAttribute("housing", housing); // Asegúrate que este nombre coincida en el JSP

        request.getRequestDispatcher("editarHousing.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */


private static final long serialVersionUID = 1L;
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        Housing housing = control.getHousing(id);
        
        housing.setCommercialName(request.getParameter("titulo"));
        housing.setDescription(request.getParameter("descripcion"));
        housing.setAddress(request.getParameter("direccion"));
        housing.setCity(request.getParameter("city"));
        housing.setCountry(request.getParameter("country"));
        housing.setCharacteristics(request.getParameter("caracteristicas"));
        housing.setLatitude(request.getParameter("latitude"));
        housing.setLongitude(request.getParameter("longitude"));
        housing.setNumHabitaciones(Integer.parseInt(request.getParameter("numHabitaciones")));
        housing.setId_housingcategory(control.getHousingCategory(Integer.parseInt(request.getParameter("categoria"))));
        housing.setStars(Integer.parseInt(request.getParameter("stars")));
        housing.setPriceNight(Float.parseFloat(request.getParameter("priceNight")));
        housing.setStatus(request.getParameter("status"));
        housing.setUpdatedDate(LocalDate.now());
        try {
            control.editarHousing(housing); 
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
                    img.setHousingId(control.getHousing(id));
                    img.setCaption("Imagen de " + request.getParameter("titulo"));
                    img.setImageUrl(imageUrl);
                    control.crearHousingImage(img);
                }
            }

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            List<Housing> listHousing = control.findHousingsByHostId(user.getHost_id().getId_Host());            
            request.setAttribute("listHousing", listHousing);
            request.getRequestDispatcher("indexHosting.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("agregarHousing.jsp?error=1");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("indexHousing.jsp");
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
