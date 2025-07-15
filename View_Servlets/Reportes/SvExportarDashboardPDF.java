/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package View_Servlets.Reportes;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;

import javax.servlet.annotation.WebServlet;
import java.io.*;
import java.util.Base64;

/**
 *
 * @author Desktop
 */
@WebServlet(name = "SvExportarDashboardPDF", urlPatterns = {"/SvExportarDashboardPDF"})
public class SvExportarDashboardPDF extends HttpServlet {

  
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SvExportarDashboardPDF</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SvExportarDashboardPDF at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String base64Image = request.getParameter("imageData");
            base64Image = base64Image.replace("data:image/png;base64,", "");
            byte[] imageBytes = Base64.getDecoder().decode(base64Image);

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"dashboard_reservas.pdf\"");
            OutputStream out = response.getOutputStream();

            Document document = new Document(PageSize.A4.rotate());
            PdfWriter.getInstance(document, out);
            document.open();

            Image chartImage = Image.getInstance(imageBytes);
            chartImage.scaleToFit(750, 500);
            chartImage.setAlignment(Element.ALIGN_CENTER);

            document.add(new Paragraph("Reporte de Reservas por Mes", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20)));
            document.add(Chunk.NEWLINE);
            document.add(chartImage);

            document.close();
            out.close();
        } catch (Exception e) {
            response.setContentType("text/plain");
            response.getWriter().println("Error al generar el PDF: " + e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
