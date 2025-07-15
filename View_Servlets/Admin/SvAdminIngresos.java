package View_Servlets.Admin;

import Models.HostReportes;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet(name = "SvAdminIngresos", urlPatterns = {"/SvAdminIngresos"})
public class SvAdminIngresos extends HttpServlet {

    @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

            EntityManagerFactory emf = Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
            EntityManager em = emf.createEntityManager();
            List<HostReportes> lista = new ArrayList<>();

            try {
                Query query = em.createNativeQuery("CALL sp_hosts_mas_alojamientos()");
                List<Object[]> resultados = query.getResultList();

                for (Object[] fila : resultados) {
                    HostReportes h = new HostReportes(
                        (String) fila[0],
                        (String) fila[1], 
                        (String) fila[2],
                        fila[3] != null ? ((Number) fila[3]).intValue() : 0,
                        fila[4] != null ? ((Number) fila[4]).doubleValue() : 0.0,
                        fila[5] != null ? ((Number) fila[5]).intValue() : 0,
                        fila[6] != null ? ((Number) fila[6]).intValue() : 0,
                        fila[7] != null ? (Date) fila[7] : null
                    );
                    lista.add(h);
                }

                request.setAttribute("listaAnfitriones", lista);
                request.getRequestDispatcher("reportesAnfitrion.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                response.setContentType("text/plain");
                response.getWriter().write("Error al obtener el reporte: " + e.getMessage());
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