package View_Servlets.Reportes;

import Models.IngresoMensual;

import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SvAdminIngresosxMes", urlPatterns = {"/SvAdminIngresosxMes"})
public class SvAdminIngresosxMes extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Leer el año desde el parámetro (puedes adaptar esto según tu lógica de selección)
        String anioParam = request.getParameter("anio");
        int anio = (anioParam != null) ? Integer.parseInt(anioParam) : 2025;

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
        EntityManager em = emf.createEntityManager();

        List<IngresoMensual> ingresosPorHost = new ArrayList<>();
        List<IngresoMensual> ingresosGenerales = new ArrayList<>();

        try {
            // ============================
            // Llamar a GetIngresosMensualesPorHost UWU
            // ============================
            Query query1 = em.createNativeQuery("CALL GetIngresosMensualesPorHost(?)");
            query1.setParameter(1, anio);
            List<Object[]> resultados1 = query1.getResultList();

            for (Object[] fila : resultados1) {
                IngresoMensual ingreso = new IngresoMensual(
                        fila[4] != null ? ((Number) fila[4]).intValue() : 0,       // mes
                        fila[5] != null ? ((Number) fila[5]).doubleValue() : 0.0,  // ingreso_total
                        fila[0] != null ? ((Number) fila[0]).intValue() : 0,       // idHost
                        fila[1] != null ? (String) fila[1] : "",                   // nombreHost
                        fila[2] != null ? ((Number) fila[2]).intValue() : 0,       // idHousing
                        fila[3] != null ? (String) fila[3] : ""                    // nombreHousing
                );
                ingresosPorHost.add(ingreso);
            }

            // ============================
            // Llamar a GetIngresosGeneralesMensuales UWUx2
            // ============================
            Query query2 = em.createNativeQuery("CALL GetIngresosGeneralesMensuales(?)");
            query2.setParameter(1, anio);
            List<Object[]> resultados2 = query2.getResultList();

            for (Object[] fila : resultados2) {
                IngresoMensual ingreso = new IngresoMensual(
                        fila[0] != null ? ((Number) fila[0]).intValue() : 0,       // mesesito
                        fila[1] != null ? ((Number) fila[1]).doubleValue() : 0.0   // ingreso total
                );
                ingresosGenerales.add(ingreso);
            }

            request.setAttribute("ingresosPorHost", ingresosPorHost);
            request.setAttribute("ingresosGenerales", ingresosGenerales);
            request.setAttribute("anioSeleccionado", anio);
            request.getRequestDispatcher("reporteIngresos.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().write("Error al obtener los ingresos: " + e.getMessage());
        } finally {
            em.close();
            emf.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}