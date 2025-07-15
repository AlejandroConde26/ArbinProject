/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package View_Servlets.Reportes;

import Models.Controladora_System;
import Models.Reservation;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.LinkedHashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import javax.servlet.annotation.WebServlet;
import java.util.List;
import java.util.Map;
/**
 *
 * @author Desktop
 */
@WebServlet(name = "SvExportarDashboardExcel", urlPatterns = {"/SvExportarDashboardExcel"})
public class SvExportarDashboardExcel extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SvExportarDashboardExcel</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SvExportarDashboardExcel at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    Controladora_System cs = new Controladora_System();
    List<Reservation> todas = cs.getReservas();

    Map<String, Integer> conteoPorMesYHousing = new LinkedHashMap<>();
    Map<String, String> nombreAlojamientoPorClave = new HashMap<>();

    for (Reservation r : todas) {
        if (r.getStartDate() != null && r.getHousingId() != null) {
            int anio = r.getStartDate().getYear();
            int mes = r.getStartDate().getMonthValue();
            int housingId = r.getHousingId().getHousingId();
            String clave = mes + "-" + housingId;

            conteoPorMesYHousing.put(clave, conteoPorMesYHousing.getOrDefault(clave, 0) + 1);
            nombreAlojamientoPorClave.put(clave, r.getHousingId().getCommercialName());
        }
    }

    // Guardar en request
    request.setAttribute("conteoMesHousing", conteoPorMesYHousing);
    request.setAttribute("nombresHousing", nombreAlojamientoPorClave);

    request.getRequestDispatcher("dashboardReserva.jsp").forward(request, response);
}
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String yearStr = request.getParameter("excelYear");
            if (yearStr == null || yearStr.trim().isEmpty()) {
                response.setContentType("text/plain");
                response.getWriter().println("Año no proporcionado o inválido.");
                return;
            }
            int year = Integer.parseInt(yearStr);
            List<Reservation> reservas = new Controladora_System().getReservas();
            Map<String, Integer> conteoPorMesYHousing = new LinkedHashMap<>();
            Map<String, String> nombreAlojamientoPorClave = new HashMap<>();

            for (Reservation r : reservas) {
                if (r.getStartDate() != null && r.getHousingId() != null) {
                    int anio = r.getStartDate().getYear();
                    if (anio == year) {
                        int mes = r.getStartDate().getMonthValue();
                        int housingId = r.getHousingId().getHousingId();
                        String clave = mes + "-" + housingId;
                        conteoPorMesYHousing.put(clave, conteoPorMesYHousing.getOrDefault(clave, 0) + 1);
                        nombreAlojamientoPorClave.put(clave, r.getHousingId().getCommercialName());
                    }
                }
            }

            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Reservas por Mes");
            Row header = sheet.createRow(0);
            header.createCell(0).setCellValue("Mes");
            header.createCell(1).setCellValue("Alojamiento");
            header.createCell(2).setCellValue("Reservas Totales");

            int rowNum = 1;
            for (Map.Entry<String, Integer> entry : conteoPorMesYHousing.entrySet()) {
                String clave = entry.getKey();
                String[] partes = clave.split("-");
                int mes = Integer.parseInt(partes[0]);
                String nombre = nombreAlojamientoPorClave.get(clave);

                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(mes);
                row.createCell(1).setCellValue(nombre);
                row.createCell(2).setCellValue(entry.getValue());
            }

            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=\"dashboard_reservas.xlsx\"");
            workbook.write(response.getOutputStream());
            workbook.close();
        } catch (Exception e) {
            response.setContentType("text/plain");
            response.getWriter().println("Error al generar el Excel: " + e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

