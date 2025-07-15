package View_Servlets.Reportes;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Base64;
import org.apache.poi.ss.util.CellRangeAddress;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/SvGenerarExcelReporte")
public class SvGenerarExcelReporte extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"reporte_ganancias_anfitrion.xlsx\"");

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Reporte Ganancias");

            // Crear estilos de celda
            CellStyle headerStyle = workbook.createCellStyle();
            headerStyle.setFillForegroundColor(IndexedColors.BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);
            headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            Font headerFont = workbook.createFont();
            headerFont.setColor(IndexedColors.WHITE.getIndex());
            headerFont.setBold(true);
            headerStyle.setFont(headerFont);

            CellStyle contentStyle = workbook.createCellStyle();
            contentStyle.setAlignment(HorizontalAlignment.CENTER);
            contentStyle.setVerticalAlignment(VerticalAlignment.CENTER);

            //obtener parámetros del JSP
            String hostId = request.getParameter("hostId");
            String gananciaTotal = request.getParameter("gananciaTotal");
            String resumenReservasJson = request.getParameter("resumenReservasData");
            String detalleReservasJson = request.getParameter("detalleReservasData");

            int rowNum = 0;
            Row row = sheet.createRow(rowNum++);

        
            Cell cellTitle = row.createCell(0);
            cellTitle.setCellValue("Reporte de Ganancias por Anfitrión");
            cellTitle.setCellStyle(headerStyle);
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 2));

            // Información general
            row = sheet.createRow(rowNum++);
            Cell cellHostId = row.createCell(0);
            cellHostId.setCellValue("ID de Anfitrión Seleccionado:");
            Cell cellHostIdValue = row.createCell(1);
            cellHostIdValue.setCellValue(hostId.isEmpty() ? "No seleccionado" : hostId);

            row = sheet.createRow(rowNum++);
            Cell cellGananciaTotal = row.createCell(0);
            cellGananciaTotal.setCellValue("Ganancia Total:");
            Cell cellGananciaTotalValue = row.createCell(1);
            cellGananciaTotalValue.setCellValue(gananciaTotal.isEmpty() ? "0.00" : gananciaTotal);

            // Resumen de Reservas
            if (resumenReservasJson != null && !resumenReservasJson.isEmpty()) {
                JSONArray resumenArray = new JSONArray(resumenReservasJson);
                if (resumenArray.length() > 0) {
                    row = sheet.createRow(rowNum++);
                    Cell cellResumenTitle = row.createCell(0);
                    cellResumenTitle.setCellValue("Resumen de Reservas");
                    cellResumenTitle.setCellStyle(headerStyle);

                    // Headers
                    row = sheet.createRow(rowNum++);
                    String[] headersResumen = {"Nombre", "Email", "Cantidad de Reservas"};
                    for (int i = 0; i < headersResumen.length; i++) {
                        Cell cellHeader = row.createCell(i);
                        cellHeader.setCellValue(headersResumen[i]);
                        cellHeader.setCellStyle(headerStyle);
                    }

                    // Data
                    for (int i = 0; i < resumenArray.length(); i++) {
                        JSONObject jsonObject = resumenArray.getJSONObject(i);
                        row = sheet.createRow(rowNum++);
                        Cell cellNombre = row.createCell(0);
                        cellNombre.setCellValue(jsonObject.getString("nombre"));
                        cellNombre.setCellStyle(contentStyle);
                        Cell cellEmail = row.createCell(1);
                        cellEmail.setCellValue(jsonObject.getString("email"));
                        cellEmail.setCellStyle(contentStyle);
                        Cell cellCantidadReservas = row.createCell(2);
                        cellCantidadReservas.setCellValue(jsonObject.getInt("cantidadReservas"));
                        cellCantidadReservas.setCellStyle(contentStyle);
                    }
                }
            }

            // Detalle de Reservas
            if (detalleReservasJson != null && !detalleReservasJson.isEmpty()) {
                JSONArray detalleArray = new JSONArray(detalleReservasJson);
                if (detalleArray.length() > 0) {
                    row = sheet.createRow(rowNum++);
                    Cell cellDetalleTitle = row.createCell(0);
                    cellDetalleTitle.setCellValue("Detalle de Reservas");
                    cellDetalleTitle.setCellStyle(headerStyle);

                    // Headers
                    row = sheet.createRow(rowNum++);
                    String[] headersDetalle = {"Nombre", "Email", "Alojamiento", "Inicio", "Fin", "Total Pagado"};
                    for (int i = 0; i < headersDetalle.length; i++) {
                        Cell cellHeader = row.createCell(i);
                        cellHeader.setCellValue(headersDetalle[i]);
                        cellHeader.setCellStyle(headerStyle);
                    }

                    // Data
                    for (int i = 0; i < detalleArray.length(); i++) {
                        JSONObject jsonObject = detalleArray.getJSONObject(i);
                        row = sheet.createRow(rowNum++);
                        Cell cellNombre = row.createCell(0);
                        cellNombre.setCellValue(jsonObject.getString("nombre"));
                        cellNombre.setCellStyle(contentStyle);
                        Cell cellEmail = row.createCell(1);
                        cellEmail.setCellValue(jsonObject.getString("email"));
                        cellEmail.setCellStyle(contentStyle);
                        Cell cellAlojamiento = row.createCell(2);
                        cellAlojamiento.setCellValue(jsonObject.getString("alojamiento"));
                        cellAlojamiento.setCellStyle(contentStyle);
                        Cell cellInicio = row.createCell(3);
                        cellInicio.setCellValue(jsonObject.getString("inicio"));
                        cellInicio.setCellStyle(contentStyle);
                        Cell cellFin = row.createCell(4);
                        cellFin.setCellValue(jsonObject.getString("fin"));
                        cellFin.setCellStyle(contentStyle);
                        Cell cellTotalPagado = row.createCell(5);
                        cellTotalPagado.setCellValue(jsonObject.getDouble("totalPagado"));
                        cellTotalPagado.setCellStyle(contentStyle);
                    }
                }
            }
            String chartImageBase64 = request.getParameter("chartImage");

            if (chartImageBase64 != null && !chartImageBase64.isEmpty()) {
                try {
                    // Limpiar base64 si viene con prefijo
                    String base64Image = chartImageBase64.split(",")[1];
                    byte[] imageBytes = Base64.getDecoder().decode(base64Image);

                    int pictureIdx = workbook.addPicture(imageBytes, Workbook.PICTURE_TYPE_PNG);
                    CreationHelper helper = workbook.getCreationHelper();
                    Drawing<?> drawing = sheet.createDrawingPatriarch();

                    // Posición de la imagen en el Excel
                    ClientAnchor anchor = helper.createClientAnchor();
                    anchor.setCol1(1); // columna inicial
                    anchor.setRow1(rowNum + 2); // fila donde insertar la imagen

                    Picture pict = drawing.createPicture(anchor, pictureIdx);

                    // Redimensionar automáticamente para ajustarse a la imagen
                    pict.resize();
                } catch (Exception e) {
                    e.printStackTrace(); // o loggear el error
                }
            }
            // Escribir el workbook en el OutputStream de la respuesta
            workbook.write(response.getOutputStream());

        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("Error al generar el reporte Excel: " + e.getMessage(), e);
        }
    }
}
