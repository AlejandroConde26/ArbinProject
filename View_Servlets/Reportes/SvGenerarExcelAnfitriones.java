/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package View_Servlets.Reportes;


import Models.HostReportes; // Asegúrate que la ruta a tu modelo es correcta
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.List;
import org.apache.poi.ss.util.CellRangeAddress;
/**
 *
 * @author Desktop
 */
@WebServlet(name = "SvGenerarExcelAnfitriones", urlPatterns = {"/SvGenerarExcelAnfitriones"})
public class SvGenerarExcelAnfitriones extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SvGenerarExcelAnfitriones</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SvGenerarExcelAnfitriones at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        generarReporteExcelAnfitriones(request, response);
    }

    private void generarReporteExcelAnfitriones(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String chartImageBase64 = request.getParameter("chartImagePdf"); // o chartImageExcel
        List<HostReportes> lista = (List<HostReportes>) request.getSession().getAttribute("listaAnfitriones");
        if (chartImageBase64 != null && !chartImageBase64.isEmpty()) {
            System.out.println("Base64 Image (inicio): " + chartImageBase64.substring(0, Math.min(30, chartImageBase64.length())));
        } else {
            System.out.println("Base64 Image (inicio): null o vacía");
        }
        if (lista == null || lista.isEmpty()) {
            response.setContentType("text/plain");
            response.getWriter().write("No se encontraron datos de anfitriones para generar el reporte Excel.");
            return;
        }

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Reporte Anfitriones");

        // Estilos para el encabezado
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerFont.setColor(IndexedColors.WHITE.getIndex());

        CellStyle headerCellStyle = workbook.createCellStyle();
        headerCellStyle.setFont(headerFont);
        headerCellStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
        headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerCellStyle.setAlignment(HorizontalAlignment.CENTER);
        headerCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);

        Row titleRow = sheet.createRow(0);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("Reporte de Anfitriones por Alojamientos");
        titleCell.setCellStyle(headerCellStyle);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 7)); 

        int rowNum = 2;

        if (chartImageBase64 != null && !chartImageBase64.isEmpty()) {
            try {
                String base64Image = chartImageBase64.split(",")[1];
                byte[] imageBytes = Base64.getDecoder().decode(base64Image);

                int pictureIdx = workbook.addPicture(imageBytes, Workbook.PICTURE_TYPE_PNG);
                CreationHelper helper = workbook.getCreationHelper();
                Drawing<?> drawing = sheet.createDrawingPatriarch();

               
                ClientAnchor anchor = helper.createClientAnchor();
                anchor.setCol1(0); // Columna inicial para la imagen (ej. A)
                anchor.setRow1(rowNum); // Fila donde empieza la imagen
                anchor.setCol2(4); // Columna final para la imagen (ej. E, ocupará 5 columnas)
                anchor.setRow2(rowNum + 15); // Fila final (ej. ocupará 15 filas de alto)

                Picture pict = drawing.createPicture(anchor, pictureIdx);
                // pict.resize(); // descomenta si quieres que la imagen se ajuste a su tamaño original dentro del anchor

                // Avanza rowNum para dejar espacio después de la imagen
                rowNum += 17; // 15 filas de imagen + 2 de espacio
            } catch (Exception e) {
                System.err.println("ERROR (Excel Anfitriones): Error al procesar la imagen del gráfico: " + e.getMessage());
                e.printStackTrace();
            }
        }
        
        // Espacio entre la imagen y la tabla (opcional)
        rowNum++; 

        // Crear una fila para los encabezados de la tabla de datos
        Row headerDataRow = sheet.createRow(rowNum++);
        String[] headers = {"Nombre", "Correo", "Teléfono", "Total Alojamientos", "Precio Promedio", "Ciudades", "Activos", "Última Publicación"};
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerDataRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerCellStyle);
        }

        // Estilo para el contenido de la tabla
        CellStyle contentStyle = workbook.createCellStyle();
        contentStyle.setAlignment(HorizontalAlignment.CENTER);
        contentStyle.setVerticalAlignment(VerticalAlignment.CENTER);

        // Llenar los datos
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

        for (HostReportes anfitrion : lista) {
            Row row = sheet.createRow(rowNum++);

            row.createCell(0).setCellValue(anfitrion.getNombre());
            row.createCell(1).setCellValue(anfitrion.getCorreo());
            row.createCell(2).setCellValue(anfitrion.getTelefono());
            row.createCell(3).setCellValue(anfitrion.getTotal());
            row.createCell(4).setCellValue(String.format("S/ %.2f", anfitrion.getPrecioPromedio()));
            row.createCell(5).setCellValue(anfitrion.getCantidadCiudades());
            row.createCell(6).setCellValue(anfitrion.getAlojamientosActivos());

            Cell lastPubCell = row.createCell(7);
            if (anfitrion.getUltimaPublicacion() != null) {
                lastPubCell.setCellValue(dateFormat.format(anfitrion.getUltimaPublicacion()));
            } else {
                lastPubCell.setCellValue("-");
            }
        }

        // Ajustar el tamaño de las columnas automáticamente
        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
        }

        // Configurar la respuesta HTTP para la descarga del archivo
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"reporte_anfitriones.xlsx\"");

        // Escribir el libro de trabajo en el flujo de salida de la respuesta
        try (OutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
        } finally {
            workbook.close();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
